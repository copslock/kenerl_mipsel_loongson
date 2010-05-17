Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 May 2010 21:28:44 +0200 (CEST)
Received: from anti.mobis.co.kr ([211.217.52.67]:54148 "HELO
        sniper.mobis.co.kr" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S1491901Ab0EQT2g convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 May 2010 21:28:36 +0200
Received: (snipe 12218 invoked by uid 0); 18 May 2010 04:28:20 +0900
Received: from gurumurthy.gowdar@gmobis.com with  Spamsniper 2.94.22 (Processed in 0.008584 secs);
Received: from unknown (HELO msmobiweb.mobis.co.kr) (10.240.100.165)
  by unknown with SMTP; 18 May 2010 04:28:20 +0900
X-RCPTTO: linux-mips@linux-mips.org,
        linux-mips@fnet.fr
Received: from mkegmal01.global.mobis.co.kr ([10.240.200.82]) by msmobiweb.mobis.co.kr with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 18 May 2010 04:28:20 +0900
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: U-boot Hangs for MIPS32 Au1350 Processor
Date:   Tue, 18 May 2010 04:28:20 +0900
Message-ID: <5858DE952C53A441BDA3408A0524130104CCE0BF@mkegmal01>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: U-boot Hangs for MIPS32 Au1350 Processor
Thread-Index: Acr19xttlHejiGOoSQqzBQ6qu++/Yg==
From:   =?iso-8859-1?Q?=A0Gurumurthy_G_M?= <Gurumurthy.Gowdar@gmobis.com>
To:     <linux-mips@linux-mips.org>
Cc:     <linux-mips@fnet.fr>
X-OriginalArrivalTime: 17 May 2010 19:28:20.0503 (UTC) FILETIME=[1BC3E270:01CAF5F7]
Return-Path: <Gurumurthy.Gowdar@gmobis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Gurumurthy.Gowdar@gmobis.com
Precedence: bulk
X-list: linux-mips



Hi All,
       Am able to get some messages on serial port but it is hanging after DRAM initialization i.e. during relocate_code function, below is the debug messages on serial port.

I tried configuring SDRAM (DDR2) for 256 and 128 MB, but still the problem is same.

I am facing one typical problem in u-boot i.e. whenever i power on the board I will get below debug messages on serial port after 5 to 8 seconds and hangs at stack pointer.


U-Boot 2010.03 (May 14 2010 - 16:41:46)
Linux Advanced AVN Platform
CPU: Au1350, id: 0x80, rev: 0x01
DRAM:  256 MB
Address value =90000000Top of RAM usable for U-Boot at: 90000000
Reserving 161k for U-Boot at: 8ffd4000
Reserving 192k for malloc() at: 8ffa4000
Reserving 36 Bytes for Board Info at: 8ffa3fdc
Reserving 36 Bytes for Global Data at: 8ffa3fb8
Reserving 128k for boot params() at: 8ff83fb8
Stack Pointer at: 8ff83f98


U-Boot 2010.03 (May 14 2010 - 16:49:00)
Linux Advanced AVN Platform
CPU: Au1350, id: 0x80, rev: 0x01
DRAM:  128 MB
Address value =88000000Top of RAM usable for U-Boot at: 88000000
Reserving 161k for U-Boot at: 87fd4000
Reserving 192k for malloc() at: 87fa4000
Reserving 36 Bytes for Board Info at: 87fa3fdc
Reserving 36 Bytes for Global Data at: 87fa3fb8
Reserving 128k for boot params() at: 87f83fb8
Stack Pointer at: 87f83f98


U-Boot 2010.03 (May 14 2010 - 16:53:58)
Linux Advanced AVN Platform
CPU: Au1350, id: 0x80, rev: 0x01
DRAM:  256 MB
Address value =90000000Top of RAM usable for U-Boot at: 90000000
Reserving 161k for U-Boot at: 8ffd4000
Reserving 192k for malloc() at: 8ffa4000
Reserving 36 Bytes for Board Info at: 8ffa3fdc
Reserving 36 Bytes for Global Data at: 8ffa3fb8
Reserving 128k for boot params() at: 8ff83fb8
Stack Pointer at: 8ff83f98

Can you please share me your board config file and lowlevel_init.S file which you have ported u-boot for Au1550. I need it for the reference.

I am doing DDR2 initialization in u-boot as per YAMON source code that will create any problem?

please help me out to resolve the above issues.

Thanks in Advance

Regards,
Gurumurthy Gowdar
KPIT Cummins Infosystems Pvt Ltd
