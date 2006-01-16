Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2006 14:45:44 +0000 (GMT)
Received: from mail.ivivity.com ([64.238.111.98]:3913 "EHLO thoth.ivivity.com")
	by ftp.linux-mips.org with ESMTP id S8126497AbWAPOp0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Jan 2006 14:45:26 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: how to emdedded ramdisk.gz in vmlinux for linux-2.6.14?
Date:	Mon, 16 Jan 2006 09:48:52 -0500
Message-ID: <0F31272A2BCBBE4FA01344C6E69DBF501EAB1B@thoth.ivivity.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: how to emdedded ramdisk.gz in vmlinux for linux-2.6.14?
Thread-Index: AcYaBp5cvCKPBJABTCiDdTHIotWWwgApSvdA
From:	"Marc Karasek" <marck@ivivity.com>
To:	"zhuzhenhua" <zzh.hust@gmail.com>,
	"linux-mips" <linux-mips@linux-mips.org>
Return-Path: <marck@ivivity.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9888
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marck@ivivity.com
Precedence: bulk
X-list: linux-mips

Look under arch/mips/ramdisk (I think).  This is where you should put the ramdisk.gz image and the compiler will pick it up and put it into the vmlinux image for you.  

Any content within this email is provided "AS IS" for informational purposes only. No contract will be formed between the parties by virtue of this email.
<**************************>
Marc Karasek
System Lead Technical Engineer
iVivity Inc.
PH: 678-990-1550 x238
Fax: 678-990-1551
<**************************>



-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org]On Behalf Of zhuzhenhua
Sent: Saturday, January 14, 2006 11:22 PM
To: linux-mips
Subject: how to emdedded ramdisk.gz in vmlinux for linux-2.6.14?


I download the kernel from linux-mips, and select to embedded
ramdisk.gz into vmlinux.
but  i can't find where to place the ramdisk.gz.
I try to put ramdisk.gz  under top dir, or arch/mips/boot/, but it
does not work.
 can someone give any hints?


Best regards

zhuzhenhua
