//
//  main.swift
//  StaticStringInterop
//
//  Created by Pedro Rojas on 10/12/24.
//

import Foundation

func logMessage(_ message: StaticString) {
    /* Convert StaticString to UnsafePointer<CChar>
     
     Why doing this?
     To work with low-level memory, such as passing string data to C functions that expect a const char*
     
     This pointer (message.utf8Start) points to the beginning of the string's data in memory (UnsafeRawPointer).
     
     withMemoryRebound temporarily reinterprets the memory at the pointer as another type, in this case, CChar (the C-compatible character type).
     
     The closure receives the reinterpreted pointer (UnsafePointer<CChar>), which can now be safely passed to the C function.
     */
    message.utf8Start.withMemoryRebound(to: CChar.self, capacity: message.utf8CodeUnitCount) { pointer in
        ClogMessage(pointer)
    }
}


let message: StaticString = "Follow me! at @swiftandtips"
logMessage(message)

