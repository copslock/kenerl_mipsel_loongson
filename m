Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3FFVu8d029089
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 15 Apr 2002 08:31:56 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3FFVuwa029088
	for linux-mips-outgoing; Mon, 15 Apr 2002 08:31:56 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3FFVq8d029082
	for <linux-mips@oss.sgi.com>; Mon, 15 Apr 2002 08:31:53 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA25171;
	Mon, 15 Apr 2002 17:32:55 +0200 (MET DST)
Date: Mon, 15 Apr 2002 17:32:54 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Keith Owens <kaos@sgi.com>
cc: "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Can modules be stripped? 
In-Reply-To: <7082.1018882200@ocs3.intra.ocs.com.au>
Message-ID: <Pine.GSO.3.96.1020415171522.19735N-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 16 Apr 2002, Keith Owens wrote:

> Exporting static symbols has always been allowed.  Exported symbols are
> the module equivalent of lazy binding, which is logically no different
> from passing the address of a static symbol via a structure to a
> registration function.  In either case the static symbol can be
> accessed from outside the object, without being marked as global.

 Well, if you make a symbol available to other modules it becomes global
implicitly as they may refer to it by its name (by means of relocations)
and not an address known from elsewhere.  So keeping the symbol marked
local in the module's symbol table is against a run-time linker's usual
behaviour.  One may expect to perform `ld -rx' on a module and have it
still work as it's what happens for every other relocatable. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
