Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Dec 2004 20:24:34 +0000 (GMT)
Received: from ntfw.echelon.com ([IPv6:::ffff:205.229.50.10]:1556 "EHLO
	[205.229.50.10]") by linux-mips.org with ESMTP id <S8225227AbUL1UY2>;
	Tue, 28 Dec 2004 20:24:28 +0000
Received: from miles.echelon.com by [205.229.50.10]
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with ESMTP; Tue, 28 Dec 2004 12:24:28 -0800
Received: by miles.echelon.com with Internet Mail Service (5.5.2653.19)
	id <ZK16SX9S>; Tue, 28 Dec 2004 12:24:16 -0800
Message-ID: <5375D9FB1CC3994D9DCBC47C344EEB59016543D9@miles.echelon.com>
From: Prashant Viswanathan <vprashant@echelon.com>
To: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: defconfig for dbAu1550 (Cabarnet) and problems booting kernel
Date: Tue, 28 Dec 2004 12:24:03 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Return-Path: <vprashant@echelon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6779
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vprashant@echelon.com
Precedence: bulk
X-list: linux-mips


Hi All,

I am trying to get Linux up and running on the DbAu1550 (Cabarnet) using the
latest code from linux-mips.org.  I was wondering if somebody would have a
default config file for building the kernel.

Also, when I try to boot the kernel from Yamon, I don't see anything
happening. Any ideas on what could be wrong?
YAMON> go . console=ttyS0,115200
<< nothing happens after this >>

Thanks for any pointers/help.

Prashant 
