Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jun 2003 16:27:36 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:26024 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225211AbTFIP1e>; Mon, 9 Jun 2003 16:27:34 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA05464;
	Mon, 9 Jun 2003 17:28:18 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Mon, 9 Jun 2003 17:28:18 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: David Kesselring <dkesselr@mmc.atmel.com>
cc: linux-mips@linux-mips.org
Subject: Re: state of 64 bit support
In-Reply-To: <Pine.GSO.4.44.0306061234410.4045-100000@hydra.mmc.atmel.com>
Message-ID: <Pine.GSO.3.96.1030609164009.2806n-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 6 Jun 2003, David Kesselring wrote:

> I've been trying to get a 64 bit compiler working for a 5kc/5kf core,
> searching the net for info, and following this list for the last couple of
> weeks. I have not been able to get some basic questions answered and I
> hope that some of you can help me.

 With the above statement I assume you want to have a compiler suitable
for a kernel build only (which is easier to get running) and you do not
need to do 64-bit userland builds (which is tougher).  And that you want a
cross-compiler.

> First what is the current status of mips 5k 64bit little-endian support
> for gcc? Do I have to use 2.95/2.96? I don't think there is a linux binary
> but if you know of one I'd love the link. I have been unsuccessful getting
> this built.

 There are a few gcc 2.95.x i386/Linux LE binary RPM packages available at
my site, but they have preliminary R4k workarounds applied which have
disadvantageous side effects for later processors.  Your best bet is to
get an RPM source package, disable R4k patches and rebuild. 

> On the web, there is a howto to build a mipsel gcc 3.2. Does 3.2 support
> 64 bit mips? Has anyone gotten it to work?

 If going for version 3.x, you probably want to get 3.3.  I can't say if
it supports MIPS64/Linux without patching -- probably yes.

> Also linux. From my understanding, kernel 2.4.20 has the latest patches
> for mips32 and mips64. Is that a valid codebase?

 Up till now most development was done based on 2.4.x, but Ralf has just
finished updating 2.5.x, so you can select the version that suits you
best.

> It seems that some info in the howto regarding building a compiler with
> egcs on linux-mips.org is somewhat dated, is that true?

 The rules on building a compiler haven't changed much if at all for a
long time.  You should be able to verify it with documentation coming with
gcc.

> I really appreciate any guidance. I've been trying to follow the
> instructions that are out there but I keep running into problems.
> For example, as I try to build gcc 3.2 for mips64el, I can't come up with
> a correct include directory. Does anyone have one?

 You need to get installed headers from a C library.  Glibc is the usual
choice, although there are alternatives.  I have a set of suitable headers
available at my site.  It's a bit dated as it's from glibc 2.2.5, but for
kernel builds it doesn't really matter.

 HTH,

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
