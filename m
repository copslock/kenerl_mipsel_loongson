Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Mar 2009 14:38:00 +0000 (GMT)
Received: from mailsqr.mstarsemi.com ([59.120.57.249]:52304 "EHLO
	mailsqr2.mstarsemi.com") by ftp.linux-mips.org with ESMTP
	id S28573926AbZCYOhw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Mar 2009 14:37:52 +0000
Received: from msnb6444 ([172.16.90.126])
	(authenticated bits=0)
	by mailsqr2.mstarsemi.com with ESMTP id n2PEbgtV045406
	for <linux-mips@linux-mips.org>; Wed, 25 Mar 2009 22:37:45 +0800 (CST)
	(envelope-from alan.wu@mstarsemi.com)
From:	"Alan Wu" <alan.wu@mstarsemi.com>
To:	<linux-mips@linux-mips.org>
Subject: VPE loader support on 34K
Date:	Wed, 25 Mar 2009 22:37:20 +0800
Message-ID: <B34CE01D80AD4D309E259934BA1361AA@mstarsemi.com.tw>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcmtVzQaBnE1LxaMQbqqLxMU5qXbtQ==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
X-MAIL:	mailsqr2.mstarsemi.com n2PEbgtV045406
Return-Path: <alan.wu@mstarsemi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22140
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan.wu@mstarsemi.com
Precedence: bulk
X-list: linux-mips


Hello,

I'm porting 2.6.26 Linux on the platform of MIPS 34K. Currently, the uni-processor 
kernel model(1 VPE) and SMP model (2 VPE) are up and work perfectly.

Now, I need to port the AP/SP model on a normal Linux uniprocessor kernel model. 
I'd like to load an application program (ELF ?) into kernel space where this 
application will run on a Secondary VPE undisturbed by the Linux kernel.

After I enabled the MIPS_VPE_LOADER [=y] in .config , the kernel is up without
any error/warning message.

Please help :

1. How to load the application into VPE1 from VPE0 ? (cat XYZapp >/dev/vpe1 ?)
2. Is there any sample "Hello World" application for this ? 
3. Any specific tool chain needed ?

Thanks.
