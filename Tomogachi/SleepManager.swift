//
//  SleepManager.swift
//  Tomogachi
//
//  Created by Aayan Asif on 2026-01-11.
//


import Foundation
import SwiftUI
import Combine

@MainActor
final class SleepManager: ObservableObject {

    @Published var isSleepModeActive = false
    @Published var sleepStartTime: Date?
    @Published var sleepEndTime: Date?
    @Published var remainingTime: TimeInterval = 0

    let bedtimeHour = 23   // 11 PM
    let wakeHour = 13     // 7 AM

    private var timerCancellable: AnyCancellable?


    func isWithinSleepWindow(_ date: Date = Date()) -> Bool {
        let hour = Calendar.current.component(.hour, from: date)
        return hour >= bedtimeHour || hour < wakeHour
    }


    func startSleep() {

        let now = Date()
        sleepStartTime = now
        sleepEndTime = calculateWakeTime(from: now)
        isSleepModeActive = true

        startTimer()
    }

    func wakeUp(reason: String) {
        stopTimer()

        isSleepModeActive = false
        sleepStartTime = nil
        sleepEndTime = nil
        remainingTime = 0

        print("Tomogachi woke up:", reason)
        applyPenalty()
    }

    private func completeSleep() {
        stopTimer()

        isSleepModeActive = false
        sleepStartTime = nil
        sleepEndTime = nil
        remainingTime = 0

        print("Tomogachi woke up happy!")
        rewardSleep()
    }


    private func startTimer() {
        updateRemainingTime()

        timerCancellable = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self else { return }
                self.updateRemainingTime()
            }
    }

    private func stopTimer() {
        timerCancellable?.cancel()
        timerCancellable = nil
    }

    private func updateRemainingTime() {

        guard let end = sleepEndTime else { return }

        let remaining = end.timeIntervalSinceNow
        remainingTime = max(remaining, 0)

        if remaining <= 0 {
            completeSleep()
        }
    }

    private func calculateWakeTime(from start: Date) -> Date {
        var components = Calendar.current.dateComponents(
            [.year, .month, .day],
            from: start
        )
        components.hour = wakeHour
        components.minute = 0
        components.second = 0

        let candidate = Calendar.current.date(from: components)!

        if candidate <= start {
            return Calendar.current.date(byAdding: .day, value: 1, to: candidate)!
        }

        return candidate
    }

    private func applyPenalty() {
        print("Sleep broken — penalty applied")
    }

    private func rewardSleep() {
        print("Sleep completed — reward applied")
    }
}

