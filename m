Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 00:23:28 +0000 (GMT)
Received: from harrier.mail.pas.earthlink.net ([IPv6:::ffff:207.217.120.12]:18343
	"EHLO harrier.mail.pas.earthlink.net") by linux-mips.org with ESMTP
	id <S8225199AbTCMAX1>; Thu, 13 Mar 2003 00:23:27 +0000
Received: from sdn-ap-007masprip0443.dialsprint.net ([63.186.129.189] helo=lahoo.priv)
	by harrier.mail.pas.earthlink.net with esmtp (Exim 3.33 #1)
	id 18tGVG-0005NT-00; Wed, 12 Mar 2003 16:23:23 -0800
Received: from prefect.priv ([10.1.1.102] helo=prefect)
	by lahoo.priv with smtp (Exim 3.36 #1 (Debian))
	id 18tGEM-000588-00; Wed, 12 Mar 2003 19:05:54 -0500
Message-ID: <01fe01c2e8f6$c41451a0$6601010a@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "Hilik Stein" <hilik@netvision.net.il>
Cc: <linux-mips@linux-mips.org>
References: <438113fe62.3fe6243811@netvision.net.il>
Subject: Re: allocating a large memory area
Date: Wed, 12 Mar 2003 19:23:26 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Return-Path: <brad@ltc.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1706
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brad@ltc.com
Precedence: bulk
X-list: linux-mips

----- Original Message -----
From: "Hilik Stein" <hilik@netvision.net.il>
To: <linux-mips@linux-mips.org>
Sent: Wednesday, March 12, 2003 6:28 AM
Subject: allocating a large memory area


> i need to allocate a large memory region for my data (32MB), which is far
> beyond what kmalloc can provide for me.
> i do not want to use vmalloc, since it will allocate the memory out of
> KSEG2, which is too slow and will generate too many exceptions when i
> have to access my data randomly.
> i was thinking of limiting the linux from accessing the highest physical
> 32MB by using "mem=224M" kernel command line parameter. this was i
> can access my data using 0x8e000000 through KSEG1.

Or put it below the kernel load point.

Or... I've used this trick - define a large array and let the linker make
space for it in .bss.  This is convenient since now the kernel has no
special requirement about load address or memory limit and the address can
just be a pointer to the array.

Regards,
Brad
