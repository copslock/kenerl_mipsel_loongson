Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Mar 2003 23:24:20 +0000 (GMT)
Received: from smtp-send.myrealbox.com ([IPv6:::ffff:192.108.102.143]:57514
	"EHLO smtp-send.myrealbox.com") by linux-mips.org with ESMTP
	id <S8225219AbTCXXYS> convert rfc822-to-8bit; Mon, 24 Mar 2003 23:24:18 +0000
Received: from yaelgilad [194.90.64.161] by myrealbox.com
	with NetMail ModWeb Module; Mon, 24 Mar 2003 07:11:15 +0000
Subject: Second Embedded Ramdisk
From: "Gilad Benjamini" <yaelgilad@myrealbox.com>
To: kernelnewbies@nl.linux.org, linux-mips@linux-mips.org
Date: Mon, 24 Mar 2003 07:11:15 +0000
X-Mailer: NetMail ModWeb Module
X-Sender: yaelgilad
MIME-Version: 1.0
Message-ID: <1048489875.74c25880yaelgilad@myrealbox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <yaelgilad@myrealbox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yaelgilad@myrealbox.com
Precedence: bulk
X-list: linux-mips

Hi,
I am compiling a linux-mips kernel with an 
embedded ramdisk as the root file system.
The file system include modules which are inserted
and not used later on. I've increased the 
ramdisk accordingly, but this is wasted memory
after module insertion.

How can I avoid this waste ?
Can I embed a second ramdisk into the kernel 
image and later unmount it ?

TIA
