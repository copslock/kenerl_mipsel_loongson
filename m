Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Feb 2005 19:42:51 +0000 (GMT)
Received: from host101-161.pool80181.interbusiness.it ([IPv6:::ffff:80.181.161.101]:22266
	"EHLO localhost.localdomain") by linux-mips.org with ESMTP
	id <S8225347AbVBSTmg>; Sat, 19 Feb 2005 19:42:36 +0000
Received: by localhost.localdomain (Postfix, from userid 501)
	id 83C2710F0A9; Sat, 19 Feb 2005 21:41:31 +0100 (CET)
Subject: Origin-2000 networking problem !
From:	Michele Carla` <goldfinger@member.fsf.org>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Sat, 19 Feb 2005 21:41:31 +0100
Message-Id: <1108845691.3061.15.camel@trogo>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Return-Path: <goldfinger@member.fsf.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: goldfinger@member.fsf.org
Precedence: bulk
X-list: linux-mips

Hello... I have some problem with an Origin-2000

I have succesfully booted a kernel trhough tftp.
After this, the kernel mount correctly the root file system, that is
located on a scsi drive (it is a debian-sargge).

...everithing seams to be correct, but networking doesn't want to work.

I have configured eth0 trough ifconfig (setting MAC handly, if not it is
setted to 00:00:00:00...), but if I try to ping another computer, any
packet is sent, and the packet counter (ifconfig) doesn't progress.
Also the interrupt counter (/dev/interrupt) doesn't progress.

this is the log of the boot: http://www.hackbloc.net/~goldfinger/boot

any idea ???

Thanks for any help...

sorry for my English...

Michele Carla`
goldfinger@member.fsf.org
