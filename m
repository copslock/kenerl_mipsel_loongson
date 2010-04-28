Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Apr 2010 21:56:00 +0200 (CEST)
Received: from anti.mobis.co.kr ([211.217.52.67]:58244 "HELO
        sniper.mobis.co.kr" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S1492218Ab0D1Tzx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Apr 2010 21:55:53 +0200
Received: (snipe 21412 invoked by uid 0); 29 Apr 2010 04:55:39 +0900
Received: from gurumurthy.gowdar@gmobis.com with  Spamsniper 2.94.22 (Processed in 0.007224 secs);
Received: from unknown (HELO msmobiweb.mobis.co.kr) (10.240.100.165)
  by unknown with SMTP; 29 Apr 2010 04:55:39 +0900
X-RCPTTO: linux-mips@linux-mips.org
Received: from mkegmal01.global.mobis.co.kr ([10.240.200.82]) by msmobiweb.mobis.co.kr with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 29 Apr 2010 04:55:39 +0900
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Facing problems U-boot Porting on MIPS32 Au1350
Date:   Thu, 29 Apr 2010 04:55:39 +0900
Message-ID: <5858DE952C53A441BDA3408A0524130104CCE0A1@mkegmal01>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Facing problems U-boot Porting on MIPS32 Au1350
Thread-Index: AcrnDMaslQ9rCmqHSRm4/mM5M2aSmw==
From:   =?iso-8859-1?Q?=A0Gurumurthy_G_M?= <Gurumurthy.Gowdar@gmobis.com>
To:     <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 28 Apr 2010 19:55:39.0784 (UTC) FILETIME=[C7011080:01CAE70C]
Return-Path: <Gurumurthy.Gowdar@gmobis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26506
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Gurumurthy.Gowdar@gmobis.com
Precedence: bulk
X-list: linux-mips



Hi,
   i have one doubt regarding the configuring and working on serial port. In Free scale processors I used to #define the console write to smc or scc ( mpc8280 uart ports) .

But here i don't think console write or console debug messages are configured to UART2 ( Debug Port) of Au1350. If not then how console port UART2 is taken though serial_init will initialize UART2.

my concern is how output of printf or puts or debug messages is displayed on MIPS au1350 console( uart2 is debug port).

If am right by defining configs/dbau1x00.h it will just initialize the serial port and baud rate.

need help if am missing something regarding debug console.

Regards,
Gurumurthy
