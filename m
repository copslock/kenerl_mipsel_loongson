Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jul 2004 16:09:03 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:56022 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225002AbUGPPIt>; Fri, 16 Jul 2004 16:08:49 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id BE80047855; Fri, 16 Jul 2004 17:08:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id B2D7E47392; Fri, 16 Jul 2004 17:08:42 +0200 (CEST)
Date: Fri, 16 Jul 2004 17:08:42 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Collin Baillie <collin@xorotude.com>
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-mips@linux-mips.org
Subject: Re: Help with MOP network boot install on DECstation 5000/240
In-Reply-To: <000c01c46b42$fd6f9b60$0a9913ac@swift>
Message-ID: <Pine.LNX.4.55.0407161644440.6227@jurand.ds.pg.gda.pl>
References: <BAY2-F21njXXBARdkfw0003b0c8@hotmail.com> <20040710100412.GA23624@linux-mips.org>
 <00ba01c46823$3729b200$0deca8c0@Ulysses> <20040713003317.GA26715@linux-mips.org>
 <000701c468ae$141c3e50$0a9913ac@swift> <20040713080320.GC18841@lug-owl.de>
 <000e01c4696f$f65cf4f0$0a9913ac@swift> <20040714124318.GQ2019@lug-owl.de>
 <000c01c46b42$fd6f9b60$0a9913ac@swift>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 16 Jul 2004, Collin Baillie wrote:

> Ok, I found a 4.5MB boot.img file which is supposed to be the netboot debian
> installer for r3k-kn03 mipsel. mopd doesn't seem to like it's a.out-ness.
> mopchk gives (I named it DEBIAN.SYS for the purpose of mop booting):
> 
> Checking: DEBIAN.SYS
> Some failure in GetAOutFileInfo
> 
> Does mopd work with a.out files? I read somewhere it doesn't. Is this the
> install image you speak of? There doesn't seem to be a cd-rom version. I
> really have difficulties with Debian's site. Any help you guys could offer
> me would be appreciated.

 This is supposedly an ECOFF image for booting with TFTP.  If you can't 
get the ELF image it was converted from, you may try converting it back to 
ELF like this:

$ mipsel-linux-objcopy -O elf32-tradlittlemips boot.img DEBIAN.SYS

I have never used that, though, so I can't say if it works.  Actually
objcopy from more or less current binutils emits a bogus warning when 
executing the above command.

  Maciej
