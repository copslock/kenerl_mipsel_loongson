Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2SGPuj09181
	for linux-mips-outgoing; Wed, 28 Mar 2001 08:25:56 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2SGMFM09079
	for <linux-mips@oss.sgi.com>; Wed, 28 Mar 2001 08:22:23 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA01783;
	Wed, 28 Mar 2001 18:09:38 +0200 (MET DST)
Date: Wed, 28 Mar 2001 18:09:37 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Keith M Wesolowski <wesolows@foobazco.org>
cc: Brady Brown <bbrown@ti.com>, SGI news group <linux-mips@oss.sgi.com>
Subject: Re: Tools miss-compile old kernel
In-Reply-To: <20010322164659.A6068@foobazco.org>
Message-ID: <Pine.GSO.3.96.1010328175514.917A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 22 Mar 2001, Keith M Wesolowski wrote:

> Upgrade to CVS binutils.  The one Maciej has on his site is apparently
> broken.  If you want a toolchain that is known to work at least in
> some cases, you can pull it from
> ftp://oss.sgi.com/pub/linux/mips/mips-linux/simple/crossdev/.  That is
> the toolchain I use to build kernels -and- userland (yes, I know,
> everyone says it can't be done, but...) and thus it Works For Me (TM).

 Weird, I've always used tools I packaged for both kernel and userland
builds and I had no troubles.  The latest 2.10.91 version available at my
site should be fine.  I've only tested it with an R3k, though.

 I'm actually going to upgrade it to 2.11 ASAP, but I won't do it until I
track down a weird kernel bug which is reproducibly triggered by a native
mipsel-linux build -- the kernel crashes completely and silently after sed
is invoked in a specific place upon running the libtool script in the ld
directory.  I suspect a corruption bug as the crash disappears if the
script is modified a bit (e.g. some white space is added), so I'm actually
glad I got bitten by the bug.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
