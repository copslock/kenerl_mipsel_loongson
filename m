Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jul 2004 10:54:36 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:45003 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225215AbUGNJya>; Wed, 14 Jul 2004 10:54:30 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id CC97447B41; Wed, 14 Jul 2004 11:54:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id C0E4647AAC; Wed, 14 Jul 2004 11:54:23 +0200 (CEST)
Date: Wed, 14 Jul 2004 11:54:23 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Collin Baillie <collin@xorotude.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Help with MOP network boot install on DECstation 5000/240
In-Reply-To: <000e01c4696f$f65cf4f0$0a9913ac@swift>
Message-ID: <Pine.LNX.4.55.0407141058480.4513@jurand.ds.pg.gda.pl>
References: <BAY2-F21njXXBARdkfw0003b0c8@hotmail.com> <20040710100412.GA23624@linux-mips.org>
 <00ba01c46823$3729b200$0deca8c0@Ulysses> <20040713003317.GA26715@linux-mips.org>
 <000701c468ae$141c3e50$0a9913ac@swift> <20040713080320.GC18841@lug-owl.de>
 <000e01c4696f$f65cf4f0$0a9913ac@swift>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 14 Jul 2004, Collin Baillie wrote:

> > So it seems to try to get a file some times and gives up on it.
> 
> Oh.. I think it asks for the file, but the mopd server is not sending it. I
> am only guessing though.

 It looks so.  You may try to verify with `tcpdump', too.

> > By the way, which mopd are you using? There are several of them around,
> > some quite unuseable...
> 
> Umm.. 2.5.3. I downloaded one from linux-mips.org, and applied all the
> patches in the order listed in the spec file, but it doesn't compile. So I

 Hmm, there's no mopd at linux-mips.org.  Do you refer to one at my site,
i.e. "ftp://ftp.ds2.pg.gda.pl/pub/macro/"?  If so, then please report
compiler errors to me.

> compiled another 2.5.3 (79k as opposed to the 48k tgz file I got from
> linux-mips.org) and it compiles and responds, but still no file transfer. (I
> am compiling/running on i386 arch, so I am wondering if all those patches
> are necessary...)

 They are.  They are not processor-dependent.

> I've read that MOP images usually have some special header in them (NetBSD
> website) and someone mentioned that mopd-linux will fudge those headers if
> the kernel doesn't have them... or something...

 You've been misled.  The MOP protocol sends raw data annotated with
addresses.  It's up to the MOP server to obtain both of them.  For example
they can be retrieved from ordinary ELF images.

> I am perservering with it, and will eventually get there... but for now, I
> just thought someone might have more of a clue than I do.

 Try running `mopchk <your-image-file>' to check if it's interpreted 
correctly.

  Maciej
