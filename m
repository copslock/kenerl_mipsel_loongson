Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5JGFCnC029939
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 19 Jun 2002 09:15:12 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5JGFC92029938
	for linux-mips-outgoing; Wed, 19 Jun 2002 09:15:12 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5JGF6nC029935
	for <linux-mips@oss.sgi.com>; Wed, 19 Jun 2002 09:15:07 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA24293;
	Wed, 19 Jun 2002 18:18:05 +0200 (MET DST)
Date: Wed, 19 Jun 2002 18:18:03 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Justin Carlson <justin@cs.cmu.edu>
cc: "Bradley D. LaRonde" <brad@ltc.com>,
   Balakrishnan Ananthanarayanan <balakris_ananth@email.com>,
   linux-mips@oss.sgi.com
Subject: Re: Code error - why?
In-Reply-To: <1024416849.1182.10.camel@xyzzy.rlson.org>
Message-ID: <Pine.GSO.3.96.1020619181453.15094P-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On 18 Jun 2002, Justin Carlson wrote:

> After preprocessing, the assembler needs to see $<number> as 
> register specifiers, so typically your choices are to do either:
> 
> #define a0 $4  // See include/asm-mips/regdef.h for these
> #define v0 $2
> 
> ...
> 
> 	la a0, quest
> 	li v0, 4

 Well, the usual choice is to put "#include <asm/regdef.h>" instead of
copying definitions.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
