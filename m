Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jul 2004 15:41:48 +0100 (BST)
Received: from eezi.conceptual.net.au ([IPv6:::ffff:203.190.192.22]:55991 "EHLO
	eezi.net.au") by linux-mips.org with ESMTP id <S8225002AbUGPOlo>;
	Fri, 16 Jul 2004 15:41:44 +0100
Received: from swift (203-190-199-165.dial.usertools.net [::ffff:203.190.199.165])
  by eezi.net.au with esmtp; Fri, 16 Jul 2004 22:41:34 +0800
Message-ID: <000c01c46b42$fd6f9b60$0a9913ac@swift>
From: "Collin Baillie" <collin@xorotude.com>
To: "Jan-Benedict Glaw" <jbglaw@lug-owl.de>
Cc: linux-mips@linux-mips.org
References: <BAY2-F21njXXBARdkfw0003b0c8@hotmail.com> <20040710100412.GA23624@linux-mips.org> <00ba01c46823$3729b200$0deca8c0@Ulysses> <20040713003317.GA26715@linux-mips.org> <000701c468ae$141c3e50$0a9913ac@swift> <20040713080320.GC18841@lug-owl.de> <000e01c4696f$f65cf4f0$0a9913ac@swift> <20040714124318.GQ2019@lug-owl.de>
Subject: Re: Help with MOP network boot install on DECstation 5000/240
Date: Fri, 16 Jul 2004 22:41:01 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Return-Path: <collin@xorotude.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: collin@xorotude.com
Precedence: bulk
X-list: linux-mips

> > > Maybe you'd try Debian's install image?
> > Maybe, but on a _shared_ 31.2k dialup link, it takes a while to
download...
> It's only a couple of megabytes, not a number of CD images.

Ok, I found a 4.5MB boot.img file which is supposed to be the netboot debian
installer for r3k-kn03 mipsel. mopd doesn't seem to like it's a.out-ness.
mopchk gives (I named it DEBIAN.SYS for the purpose of mop booting):

Checking: DEBIAN.SYS
Some failure in GetAOutFileInfo

Does mopd work with a.out files? I read somewhere it doesn't. Is this the
install image you speak of? There doesn't seem to be a cd-rom version. I
really have difficulties with Debian's site. Any help you guys could offer
me would be appreciated.

Cheers,

Collin
