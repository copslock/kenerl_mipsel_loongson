Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jul 2004 07:58:46 +0100 (BST)
Received: from eezi.conceptual.net.au ([IPv6:::ffff:203.190.192.22]:61588 "EHLO
	eezi.net.au") by linux-mips.org with ESMTP id <S8225195AbUGNG6m>;
	Wed, 14 Jul 2004 07:58:42 +0100
Received: from swift (203-190-195-081.dial.usertools.net [::ffff:203.190.195.81])
  by eezi.net.au with esmtp; Wed, 14 Jul 2004 14:58:26 +0800
Message-ID: <000e01c4696f$f65cf4f0$0a9913ac@swift>
From: "Collin Baillie" <collin@xorotude.com>
To: linux-mips@linux-mips.org
References: <BAY2-F21njXXBARdkfw0003b0c8@hotmail.com> <20040710100412.GA23624@linux-mips.org> <00ba01c46823$3729b200$0deca8c0@Ulysses> <20040713003317.GA26715@linux-mips.org> <000701c468ae$141c3e50$0a9913ac@swift> <20040713080320.GC18841@lug-owl.de>
Subject: Re: Help with MOP network boot install on DECstation 5000/240
Date: Wed, 14 Jul 2004 14:57:52 +0800
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
X-archive-position: 5465
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: collin@xorotude.com
Precedence: bulk
X-list: linux-mips

> [Thanks for *not* hijacking threads]

Sorry *blush*

> So it seems to try to get a file some times and gives up on it.

Oh.. I think it asks for the file, but the mopd server is not sending it. I
am only guessing though.

> Maybe you'd try Debian's install image?

Maybe, but on a _shared_ 31.2k dialup link, it takes a while to download...
and other people tend to get upset... I am using jigdo to get the 4 - 6 ISO
images.. if there's a better (smaller / faster to download) method, I'd love
to hear about it. I really would like to get to know Debian as I'm a
Slackware man and have had to use RedHat at work.. Debian would be another
nice addition to my Linux skillset.

> By the way, which mopd are you using? There are several of them around,
> some quite unuseable...

Umm.. 2.5.3. I downloaded one from linux-mips.org, and applied all the
patches in the order listed in the spec file, but it doesn't compile. So I
compiled another 2.5.3 (79k as opposed to the 48k tgz file I got from
linux-mips.org) and it compiles and responds, but still no file transfer. (I
am compiling/running on i386 arch, so I am wondering if all those patches
are necessary...)

I've read that MOP images usually have some special header in them (NetBSD
website) and someone mentioned that mopd-linux will fudge those headers if
the kernel doesn't have them... or something...

I am perservering with it, and will eventually get there... but for now, I
just thought someone might have more of a clue than I do.

Thanks,

Collin Baillie
