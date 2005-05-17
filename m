Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2005 08:13:30 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.186]:39151
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8226027AbVEQHNO>; Tue, 17 May 2005 08:13:14 +0100
Received: from [213.39.254.68] (helo=tuxator.satorlaser-intern.com)
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0MKwpI-1DXwGN1nCm-0005LH; Tue, 17 May 2005 09:13:11 +0200
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Re: crosscompiler
Date:	Tue, 17 May 2005 09:14:48 +0200
User-Agent: KMail/1.7.2
References: <20050515125247.7596.fh034.wm@smtp.sc0.cp.net>
In-Reply-To: <20050515125247.7596.fh034.wm@smtp.sc0.cp.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505170914.48879.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

neoxx@canada.com wrote:
> I wanna set up a crosscompiler on my intel machine (
> using debian woody ) in order to cross-compile a
> self-written kernel ( no Linux/Mips ) for a MIPS 4kc (
> little endian ) CPU.

I'm using Debian/testing here and roughly followed
http://people.debian.org/~debacle/cross.html in order to get a working system. 
Almost no problems encountered.

> Can I alternatively use
> the mipsel-linux-gcc for the kernel ( I'm not quite
> sure what sort of compiler that is... )

mips= for MIPS
el= endianess little

IOW, this is precisely what I got from installing the crosscompiler and 
probably what you want. In order to compile non-Linux programs (i.e. programs 
launched directly from YAMON) I used these 
  CFLAGS += -Wall -mips32 -fno-builtin -mno-abicalls -fno-pic -GO -O2
though some of them might be redundant/unnecessary - I just tried combinations 
until it worked.

hth

Uli
