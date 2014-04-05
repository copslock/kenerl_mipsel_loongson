Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Apr 2014 14:48:15 +0200 (CEST)
Received: from forward19.mail.yandex.net ([95.108.253.144]:39543 "EHLO
        forward19.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816786AbaDEMsMVScnD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Apr 2014 14:48:12 +0200
Received: from web14j.yandex.ru (web14j.yandex.ru [5.45.198.55])
        by forward19.mail.yandex.net (Yandex) with ESMTP id 1995C11203B4
        for <linux-mips@linux-mips.org>; Sat,  5 Apr 2014 16:47:45 +0400 (MSK)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        by web14j.yandex.ru (Yandex) with ESMTP id C665228A004B;
        Sat,  5 Apr 2014 16:47:44 +0400 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1396702064; bh=1776xZbJIhfzhKUQbjPxoma+Cgdgp9MjBzbKb+N2CEE=;
        h=From:To:Subject:Date;
        b=Wj3sjWPHz6Wz3IuMfjNCf7ioO9lJE8Z9m5kCghfYfe+xlmZ+IRATq4lbrcpwRN2p1
         Vn8GpDQJAoBjv8TChsGeV3ptuXHWeYcj+XhpuSfr+VEL84+CrOmyklxdUVHir3kGxI
         xIWu1SGeexMCoO464jL6Kh6CfAwY4x7nv2lSuvXc=
Received: from ppp83-237-37-145.pppoe.mtu-net.ru (ppp83-237-37-145.pppoe.mtu-net.ru [83.237.37.145]) by web14j.yandex.ru with HTTP;
        Sat, 05 Apr 2014 16:47:44 +0400
From:   kr kr <kr-jiffy@yandex.ru>
To:     linux-mips@linux-mips.org
Subject: [MIPS Malta 5kc] Re-flashing using BDI 2000 problem.
MIME-Version: 1.0
Message-Id: <6183191396702064@web14j.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sat, 05 Apr 2014 16:47:44 +0400
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Return-Path: <kr-jiffy@yandex.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kr-jiffy@yandex.ru
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hello,

I've been trying to re-flash mips malta 5kc board (the real board,  not quemu) with a yamon image, using Abatron bdi 2000. No success yet.
JP1 jumper (MFWR) on the board is closed, S5 switch is set to: 1 - "open", 2 - "closed" (BE mode),  3 - "open", 4 - "open". On board display shows "Power on".

From the user manual for Malta board:
"Note: Address 1FC0.0010 is “special”, in the sense that when the software read this address it is overridden and does NOT decode to an address in Flash, but rather to register address REVISION. This is done to ensure future compatibility - all MIPS Technologies boards will be able to identify their hardware environment and configure themselves accordingly. Reads from address 1E00.0010 will decode to an address in Flash."

So, I assume, that 0x1fc00010 should be writeable, but no, it's not:

BDI>erase 0x1fc00000 0x10000 2
Erasing flash at 0x1fc00000
Erasing flash at 0x1fc10000
Erasing flash passed
BDI>md 0x1fc00000
000000001fc00000 : ffffffffffffffff ffffffffffffffff  ................
000000001fc00010 : 00010520ffffffff ffffffffffffffff  ... ............
000000001fc00020 : ffffffffffffffff ffffffffffffffff  ................
000000001fc00030 : ffffffffffffffff ffffffffffffffff  ................
000000001fc00040 : ffffffffffffffff ffffffffffffffff  ................
000000001fc00050 : ffffffffffffffff ffffffffffffffff  ................
000000001fc00060 : ffffffffffffffff ffffffffffffffff  ................
000000001fc00070 : ffffffffffffffff ffffffffffffffff  ................
000000001fc00080 : ffffffffffffffff ffffffffffffffff  ................
000000001fc00090 : ffffffffffffffff ffffffffffffffff  ................
000000001fc000a0 : ffffffffffffffff ffffffffffffffff  ................
000000001fc000b0 : ffffffffffffffff ffffffffffffffff  ................
000000001fc000c0 : ffffffffffffffff ffffffffffffffff  ................
000000001fc000d0 : ffffffffffffffff ffffffffffffffff  ................
000000001fc000e0 : ffffffffffffffff ffffffffffffffff  ................
000000001fc000f0 : ffffffffffffffff ffffffffffffffff  ................

BDI>md 0x1e000000
000000001e000000 : ffffffffffffffff ffffffffffffffff  ................
000000001e000010 : ffffffffffffffff ffffffffffffffff  ................
000000001e000020 : ffffffffffffffff ffffffffffffffff  ................
000000001e000030 : ffffffffffffffff ffffffffffffffff  ................
000000001e000040 : ffffffffffffffff ffffffffffffffff  ................
000000001e000050 : ffffffffffffffff ffffffffffffffff  ................
000000001e000060 : ffffffffffffffff ffffffffffffffff  ................
000000001e000070 : ffffffffffffffff ffffffffffffffff  ................
000000001e000080 : ffffffffffffffff ffffffffffffffff  ................
000000001e000090 : ffffffffffffffff ffffffffffffffff  ................
000000001e0000a0 : ffffffffffffffff ffffffffffffffff  ................
000000001e0000b0 : ffffffffffffffff ffffffffffffffff  ................
000000001e0000c0 : ffffffffffffffff ffffffffffffffff  ................
000000001e0000d0 : ffffffffffffffff ffffffffffffffff  ................
000000001e0000e0 : ffffffffffffffff ffffffffffffffff  ................
000000001e0000f0 : ffffffffffffffff ffffffffffffffff  ................

Well, yes - 0x1fc00010 decodes to REVISION register and the read of the 0x1e000010 decodes to the flash contents as manual states. Great.
Let's try to write something to the flash:

BDI>prog 0x1fc00000 yamon-02.22.fl bin
Programming yamon-02.22.fl , please wait ....
# Programming flash memory failed at 0x1fc00010

BDI>erase 0x1fc00000 0x10000 2        
Erasing flash at 0x1fc00000
Erasing flash at 0x1fc10000
Erasing flash passed

The same for:

BDI>prog 0xbfc00000 yamon-02.22.fl bin
Programming yamon-02.22.fl , please wait ....
# Programming flash memory failed at 0xbfc00010

BDI>erase 0x1e000000 0x10000 2
Erasing flash at 0x1e000000
Erasing flash at 0x1e010000
Erasing flash passed

BDI>prog 0x1e000000 yamon-02.22.fl bin
Programming yamon-02.22.fl , please wait ....
# Programming flash memory failed at 0x1e000000

Basically, I *can* write all the other areas of malta's monitor flash (4Mb, starting at 0xbfc00000)

Any suggestion, what it could be?..

Here is the BDI config:

BDI>config
    BDI Firmware: 1.03
    BDI MAC     : 00-0c-01-11-37-84
    BDI IP      : 172.17.177.3
    BDI Subnet  : 255.255.255.0
    BDI Gateway : 172.17.177.1
    Config IP   : 172.17.177.1
    Config File : bdi2k/malta_mon-be.cfg

$ sudo ./bdisetup -v -p/dev/ttyS0 -b57
[sudo] password for koivu:
BDI Type : BDI2000 Rev.C (SN: 11378420)
Loader   : V1.06
Firmware : V1.03 bdiGDB for MIPS64
Logic    : V1.00 MIPS32/MIPS64
MAC      : 00-0c-01-11-37-84
IP Addr  : 172.17.177.3
Subnet   : 255.255.255.0
Gateway  : 172.17.177.1
Host IP  : 172.17.177.1
Config   : bdi2k/malta_mon-be.cfg

$ cat malta_mon-be.cfg
; bdiGDB configuration file for MIPS Malta 5Kc board
; --------------------------------------------------
;
; This configuration uses the YAMON monitor setup the board
;
[INIT]
;
WM32    0xBF000700  0x000000C7  ;Enable write to system flash
;
; Setup TLB
WTLB    0x00000600              0x01E00017  ;Monitor Flash 2 x 4MB, uncached DVG
WTLB    0xC000000c_0x10000600   0x01E00017  ;Monitor Flash 2 x 4MB, uncached DVG
WTLB    0x40000004_0x20000600   0x01E00017  ;Monitor Flash 2 x 4MB, uncached DVG
WTLB    0x00000005_0x30000600   0x01E00017  ;Monitor Flash 2 x 4MB, uncached DVG
;
; Invalidate Caches
IVIC                            ;Invalidate IC
IVDC                            ;Invalidate DC


[TARGET]
;CPUTYPE     M5KC               ;the used target CPU type
CPUTYPE     M5KC 32BIT          ;the used target CPU type
JTAGCLOCK   0                   ;use 16 MHz JTAG clock
SCANPRED    0 0                 ;JTAG devices connected before this core
SCANSUCC    0 0                 ;JTAG devices connected after this core
;ENDIAN      LITTLE              ;target is little endian
ENDIAN      BIG                 ;target is big endian
STARTUP     STOP 4000           ;STOP mode is used to let the monitor init the system
WORKSPACE   0xA0000080          ;workspace in target RAM for fast download
BREAKMODE   SOFT                ;SOFT or HARD, HARD uses PPC hardware breakpoints
STEPMODE    JTAG                ;JTAG, HWBP or SWBP
VECTOR      CATCH               ;catch unhandled exceptions
;REGLIST     STD CP0


[HOST]
IP          172.17.177.1
FILE        E:\cygwin\home\demo\mips64\fibo.x
FORMAT      ELF
;FILE        E:\cygwin\home\bdidemo\mips\vmlinus.mips
;FORMAT      BIN 0xA0200000
;FILE        E:\temp\malta_mon.bin
;FORMAT      BIN 0xA0400000
LOAD        MANUAL      ;load code MANUAL or AUTO after reset


[FLASH]
;WORKSPACE   0xa0000800  ;workspace in target RAM for fast programming algorithm
CHIPTYPE    I28BX16     ;Flash type (AM29F | AM29BX8 | AM29BX16 | I28BX8 | I28BX16)
CHIPSIZE    0x200000    ;The size of one flash chip in bytes (e.g. AM29F040 = 0x80000)
BUSWIDTH    32          ;The width of the flash memory bus in bits (8 | 16 | 32 | 64)
FILE        bdi2k/malta_mon.cfg
FORMAT      BIN 0xbfe00000
;FILE        E:\cygwin\home\bdidemo\mips64\yamon_02_04_off.bin
FILE        yamon-02.22.fl
FORMAT      BIN 0xbfc00018  ; *** skip REVISION at 0xbfc00010 ***
ERASE       0xbfc00000  ;erase sector 0
ERASE       0xbfc20000  ;erase sector 1
ERASE       0xbfc40000  ;erase sector 2
ERASE       0xbfc60000  ;erase sector 3
ERASE       0xbfc80000  ;erase sector 4
ERASE       0xbfca0000  ;erase sector 5
ERASE       0xbfcc0000  ;erase sector 6
ERASE       0xbfce0000  ;erase sector 7
ERASE       0xbfd00000  ;erase sector 8
ERASE       0xbfd20000  ;erase sector 9
ERASE       0xbfd40000  ;erase sector 10
ERASE       0xbfd60000  ;erase sector 11
ERASE       0xbfd80000  ;erase sector 12
ERASE       0xbfda0000  ;erase sector 13
ERASE       0xbfdc0000  ;erase sector 14
ERASE       0xbfde0000  ;erase sector 15
ERASE       0xbfe00000  ;erase sector 16
ERASE       0xbfe20000  ;erase sector 17
ERASE       0xbfe40000  ;erase sector 18
ERASE       0xbfe60000  ;erase sector 19
ERASE       0xbfe80000  ;erase sector 20
ERASE       0xbfea0000  ;erase sector 21
ERASE       0xbfec0000  ;erase sector 22
ERASE       0xbfee0000  ;erase sector 23
ERASE       0xbff00000  ;erase sector 24
ERASE       0xbff20000  ;erase sector 25
ERASE       0xbff40000  ;erase sector 26
ERASE       0xbff60000  ;erase sector 27
ERASE       0xbff80000  ;erase sector 28
ERASE       0xbffa0000  ;erase sector 29
ERASE       0xbffc0000  ;erase sector 30
ERASE       0xbffe0000  ;erase sector 31

[REGS]
DMM1    0xFF300000      ;DSU base address
DMM2    0xBF000000      ;Memory mapped registers
FILE    bdi2k/reg5kc.def

TIA,
Yuri
