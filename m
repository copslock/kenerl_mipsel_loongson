Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5RA6RnC008342
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 27 Jun 2002 03:06:27 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5RA6Rj5008341
	for linux-mips-outgoing; Thu, 27 Jun 2002 03:06:27 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from cool2.coventive.com ([202.145.60.220])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5RA6BnC008338
	for <linux-mips@oss.sgi.com>; Thu, 27 Jun 2002 03:06:22 -0700
Received: from jefflee ([202.145.53.89])
	by cool2.coventive.com (8.12.4/8.12.4) with SMTP id g5RA8Xv8026916;
	Thu, 27 Jun 2002 18:08:35 +0800
From: "jeff" <jeff_lee@coventive.com>
To: <linux-mips@oss.sgi.com>
Cc: "jeff_lee" <jeff_lee@coventive.com>
Subject: FIR problem
Date: Thu, 27 Jun 2002 18:14:18 +0800
Message-ID: <LPECIADMAHLPOFOIEEFNEEHPCHAA.jeff_lee@coventive.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
In-Reply-To: <20020627014620.A1484@dea.linux-mips.net>
Importance: Normal
X-MailScanner: Found to be clean
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by oss.sgi.com id g5RA6PnC008339
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Dear All,
    Is there anybody know how to use the DMA on Vr4131?
We want to drive the High Point 371 HDD driver and wnat
to enable DMA. Base on the specfication, Vr4131 has the
I/O <-> Memory DMA channel.
    Now the PIO mode is running good, but speed is too slow.

Thanks and best regs,

Jeff
