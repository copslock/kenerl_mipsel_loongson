Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g79DBfRw006073
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 9 Aug 2002 06:11:41 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g79DBftu006072
	for linux-mips-outgoing; Fri, 9 Aug 2002 06:11:41 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g79DBZRw006062
	for <linux-mips@oss.sgi.com>; Fri, 9 Aug 2002 06:11:36 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA05529;
	Fri, 9 Aug 2002 15:14:08 +0200 (MET DST)
Date: Fri, 9 Aug 2002 15:14:07 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Guido Guenther <agx@sigxcpu.org>
cc: linux-mips@oss.sgi.com
Subject: Re: ip22 build fix
In-Reply-To: <20020809124745.GA32507@bogon.ms20.nix>
Message-ID: <Pine.GSO.3.96.1020809150817.3290A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 9 Aug 2002, Guido Guenther wrote:

> I need the attached patch against arch/mips/arc/Makefile to
> get current CVS (linux_2_4) to build on IP22. Otherwise prom_meminit
> is undefined. Please apply.
[...]
> -obj-y				+= cmdline.o console.o env.o file.o \
> +obj-y				+= cmdline.o console.o env.o file.o memory.o \
>  				   identify.o init.o misc.o time.o tree.o
>  
>  obj-$(CONFIG_ARC_MEMORY)	+= memory.o

 Well, $(CONFIG_ARC_MEMORY) equals to "y" for IP22, so please check you
haven't got your configuration messed up.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
