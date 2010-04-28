Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Apr 2010 14:47:37 +0200 (CEST)
Received: from anti.mobis.co.kr ([211.217.52.67]:35305 "HELO
        sniper.mobis.co.kr" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S1492148Ab0D1Mrc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Apr 2010 14:47:32 +0200
Received: (snipe 26345 invoked by uid 0); 28 Apr 2010 21:47:19 +0900
Received: from gurumurthy.gowdar@gmobis.com with  Spamsniper 2.94.22 (Processed in 0.069998 secs);
Received: from unknown (HELO msmobiweb.mobis.co.kr) (10.240.100.165)
  by unknown with SMTP; 28 Apr 2010 21:47:19 +0900
X-RCPTTO: linux-mips@linux-mips.org
Received: from mkegmal01.global.mobis.co.kr ([10.240.200.82]) by msmobiweb.mobis.co.kr with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 28 Apr 2010 21:47:20 +0900
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: MIPS ROM Exception Handler Error
Date:   Wed, 28 Apr 2010 21:47:20 +0900
Message-ID: <5858DE952C53A441BDA3408A0524130104CCE09C@mkegmal01>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: MIPS ROM Exception Handler Error
Thread-Index: Acrm0PD7TjuMeXpsSp+LA6xj2BvWfg==
From:   =?iso-8859-1?Q?=A0Gurumurthy_G_M?= <Gurumurthy.Gowdar@gmobis.com>
To:     <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 28 Apr 2010 12:47:20.0855 (UTC) FILETIME=[F13FB270:01CAE6D0]
Return-Path: <Gurumurthy.Gowdar@gmobis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Gurumurthy.Gowdar@gmobis.com
Precedence: bulk
X-list: linux-mips



Hi all,
       I am porting U-boot-2010.03 on MIPS32 Architecture ( au1350 processor). u-boot is compiled for little endian and downloaded the u-boot.bin file to NOR Flash.After reset followed by go command , I observe that cpu hangs at 0xbfc00570 (ROM Exception Handler).

we are using BDI3000 debugger and bdiGDB for programming.

please let me know where is the problem? whether I am missing something.

Regards,
Gurumurthy
