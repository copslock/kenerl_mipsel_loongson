Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBHEDdO12775
	for linux-mips-outgoing; Mon, 17 Dec 2001 06:13:39 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBHEDXo12762
	for <linux-mips@oss.sgi.com>; Mon, 17 Dec 2001 06:13:34 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA19984;
	Mon, 17 Dec 2001 14:12:44 +0100 (MET)
Date: Mon, 17 Dec 2001 14:12:44 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Keith Owens <kaos@melbourne.sgi.com>
cc: Karsten Merker <karsten@excalibur.cologne.de>, linux-mips@oss.sgi.com
Subject: Re: No bzImage target for MIPS 
In-Reply-To: <20472.1008407699@ocs3.intra.ocs.com.au>
Message-ID: <Pine.GSO.3.96.1011217140621.19523A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 15 Dec 2001, Keith Owens wrote:

> AFAICT ecoff is only used on mips but, since ecoff is not an arch
> specific object format, it makes sense to make it a generic kbuild
> target, like elf, srec and bin.  To that end, I looked at moving
> elf2ecoff and addinitrd to an arch independent directory so everybody
> could use those tools, alas both contain mips specific code.  Any idea
> how much work is required to make elf2ecoff and addinitrd into generic
> utilities?  Is it worth the effort or should they stay as mips only?

 Elf2ecoff is probably going not to be used one day anymore, i.e. once
binutils are fixed.  Right now there is a problem in marking ELF
executables impure (non-paged).  Ultimately either objcopy or even ld
directly is going to be used for ECOFF binary creation. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
