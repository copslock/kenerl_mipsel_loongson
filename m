Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5JHDXnC031682
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 19 Jun 2002 10:13:33 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5JHDXEO031681
	for linux-mips-outgoing; Wed, 19 Jun 2002 10:13:33 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5JHDQnC031678;
	Wed, 19 Jun 2002 10:13:27 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA25860;
	Wed, 19 Jun 2002 19:16:42 +0200 (MET DST)
Date: Wed, 19 Jun 2002 19:16:41 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>, linux-mips@oss.sgi.com
Subject: Re: system.h asm fixes
In-Reply-To: <20020618025204.A28165@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1020619191304.15094U-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 18 Jun 2002, Ralf Baechle wrote:

> > How can this work? A grep shows many instances of $1 usage,
> 
> Uses by assembler code only, not gcc.  Therefoe we don't need to protect
> C code against use of $at.

 Moreover, gcc assumes ".set at" is always in effect and includes macros
in its output that are known to clobber $1 and don't work with ".set
noat". 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
