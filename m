Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Dec 2010 17:15:22 +0100 (CET)
Received: from p02c12o147.mxlogic.net ([208.65.145.80]:49218 "EHLO
        p02c12o147.mxlogic.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493242Ab0LBQPP convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Dec 2010 17:15:15 +0100
Received: from unknown [76.164.174.81]
        by p02c12o147.mxlogic.net(mxl_mta-6.8.0-0)
        with SMTP id 016c7fc4.0.19668.00-326.45958.p02c12o147.mxlogic.net (envelope-from <andy.kennedy@adtran.com>);
        Thu, 02 Dec 2010 09:15:14 -0700 (MST)
X-MXL-Hash: 4cf7c6126834398f-c61c2af4c688db07a175be72adc7d11ef9bf9fa4
Received: from corp-exfr2.corp.adtran.com (172.23.101.22) by
 ex-hc1.corp.adtran.com (172.22.50.71) with Microsoft SMTP Server id
 14.1.255.0; Thu, 2 Dec 2010 10:15:01 -0600
Received: from EXV1.corp.adtran.com ([172.22.48.215]) by
 corp-exfr2.corp.adtran.com with Microsoft SMTPSVC(6.0.3790.3959);       Thu, 2 Dec
 2010 10:15:00 -0600
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Issues attempting to boot vmlinuz
Date:   Thu, 2 Dec 2010 10:15:39 -0600
Message-ID: <9AC3F0E75060224C8BBC5BA2DDC8853A1E4E035F@EXV1.corp.adtran.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Issues attempting to boot vmlinuz
Thread-Index: AcuSPCk1yeKNcWT/Q4Srhj6LbAm64w==
From:   ANDY KENNEDY <ANDY.KENNEDY@adtran.com>
To:     <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 02 Dec 2010 16:15:00.0725 (UTC) FILETIME=[11F67A50:01CB923C]
X-Spam: [F=0.2000000000; CM=0.500; S=0.200(2010120101)]
X-MAIL-FROM: <andy.kennedy@adtran.com>
X-SOURCE-IP: [(unknown)]
X-AnalysisOut: [v=1.0 c=1 a=PjMH8U03xLAA:10 a=BLceEmwcHowA:10 a=kj9zAlcOel]
X-AnalysisOut: [0A:10 a=0XgpNN2/4a34ymu16SVwsQ==:17 a=zTZC_Sm-60neGbu33w8A]
X-AnalysisOut: [:9 a=N288De-YdjTRnJcXb0sA:7 a=7aqQGRpnWVA6h7vrVcxRLJbpmdUA]
X-AnalysisOut: [:4 a=CjuIK1q_8ugA:10]
Return-Path: <andy.kennedy@adtran.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28602
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ANDY.KENNEDY@adtran.com
Precedence: bulk
X-list: linux-mips

I create a vmlinux kernel and boot it just fine.  The boot loader loads
the kernel to 0x80404210 and I can execute from there.  I next attempted
to adjust the Kconfig files to allow me to build a vmlinuz.  The boot
loader puts the kernel image at 0x8075e8b0 which is the computed
location of where the zipped kernel should go (I think).  What happens
next is an exception is returned to the boot loader and I end up back at
the boot loader prompt:

* Exception 0x0a (user) : Reserved instruction *

* in address: 8075e8b0

__initcall_pm_qos_power_init7+0x48054:

[8075e8b0] 9cda39f9 lwu         r26,0x39f9(r6)


So, I'm attempting now to hack around this issue, though I don't really
know where to begin (I've been working with mips for about 4 wks now).
I did find that the boot loader is configuring itself as the exception
handler and it catches 0x0a (Reserved instruction exception - according
to the mips documentation).  But what does this mean?

Any help you provide would be greatly appreciated.

Thanks,
Andy
