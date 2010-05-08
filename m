Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 May 2010 22:12:45 +0200 (CEST)
Received: from anti.mobis.co.kr ([211.217.52.67]:55237 "HELO
        sniper.mobis.co.kr" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S1492162Ab0EHUMl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 May 2010 22:12:41 +0200
Received: (snipe 13005 invoked by uid 0); 9 May 2010 05:12:29 +0900
Received: from gurumurthy.gowdar@gmobis.com with  Spamsniper 2.94.22 (Processed in 0.034502 secs);
Received: from unknown (HELO msmobiweb.mobis.co.kr) (10.240.100.165)
  by unknown with SMTP; 9 May 2010 05:12:29 +0900
X-RCPTTO: linux-mips@linux-mips.org
Received: from mkegmal01.global.mobis.co.kr ([10.240.200.82]) by msmobiweb.mobis.co.kr with Microsoft SMTPSVC(6.0.3790.3959);
         Sun, 9 May 2010 05:12:30 +0900
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Exception in serial_init MIPS32
Date:   Sun, 9 May 2010 05:12:29 +0900
Message-ID: <5858DE952C53A441BDA3408A0524130104CCE0AA@mkegmal01>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Exception in serial_init MIPS32
Thread-Index: Acru6skf+FuImQx+SNqjUkEZaaPOww==
From:   =?iso-8859-1?Q?=A0Gurumurthy_G_M?= <Gurumurthy.Gowdar@gmobis.com>
To:     <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 08 May 2010 20:12:30.0140 (UTC) FILETIME=[C95AA7C0:01CAEEEA]
Return-Path: <Gurumurthy.Gowdar@gmobis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26646
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Gurumurthy.Gowdar@gmobis.com
Precedence: bulk
X-list: linux-mips


Hi All,
       I am getting a exception in board.c , at the end of serial_init function i.e. when i access to stack pointer (SP).

The return address register ra value is not correct.

I am porting U-boot-2010.03 for MIPS32 Au1350 processor.

board specs:-

CPU Frequency - 396 MHz
System Bus Frequency - 198 MHz
SDRAM (DDR2) Frequency - 198 MHz

SDRAM Base address is  - 0x80000000
SP offset is  - 0x400000

I am able to read and write DDR2 SDRAM from BDI3000, but how to check whether my DDR2 SDRAM Configuration is working or not from U-Boot.

below is the error log file:-

Au1350>bi 0xbfc195c0
Breakpoint identification is 0
Au1350>go
- TARGET: core #0 has entered debug mode
Au1350>info
    Core number       : 0
    Core state        : Debug Mode
    Debug entry cause : exception
    Current PC        : 0xbfc195c0
    Current SR        : 0x00400000
    Current LR  (r31) : 0xbfc195bc
    Current SP  (r29) : 0x803fff90
    Current EPC       : 0x18222521
Au1350>ti
    Core number       : 0
    Core state        : Debug Mode
    Debug entry cause : single step
    Current PC        : 0xbfc195c4
    Current SR        : 0x00400000
    Current LR  (r31) : 0x440c0050
    Current SP  (r29) : 0x803fff90
Au1350>ti
    Core number       : 0
    Core state        : Debug Mode
    Debug entry cause : single step
    Current PC        : 0xbfc195c8
    Current SR        : 0x00400000
    Current LR  (r31) : 0x440c0050
    Current SP  (r29) : 0x803fff90
Au1350>ti
    Core number       : 0
    Core state        : Debug Mode
    Debug entry cause : single step
    Current PC        : 0x440c0050
    Current SR        : 0x00400000
    Current LR  (r31) : 0x440c0050
    Current SP  (r29) : 0x803fffb0
Au1350>ti
    Core number       : 0
    Core state        : Debug Mode
    Debug entry cause : single step
    Current PC        : 0xbfc00200
    Current SR        : 0x00400002
    Current LR  (r31) : 0x440c0050
    Current SP  (r29) : 0x803fffb0
Au1350>

please let me know whether SDRAM DDR2 configuration is wrong or am missing something. why am not able to access SP from U-boot.

Also SDRAM initialzation in YAMON and U-boot is totally different. please let me know which one is working fine.

With Thanks and Regards,
Gurumurthy Gowdar
KPIT Cummins Infosystems Pvt Ltd
