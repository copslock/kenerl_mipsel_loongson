Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7NGpBV31530
	for linux-mips-outgoing; Thu, 23 Aug 2001 09:51:11 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7NGp6d31527
	for <linux-mips@oss.sgi.com>; Thu, 23 Aug 2001 09:51:07 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA23857;
	Thu, 23 Aug 2001 18:52:45 +0200 (MET DST)
Date: Thu, 23 Aug 2001 18:52:45 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Keith Owens <kaos@ocs.com.au>
cc: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.5: __dbe_table iteration #2 
In-Reply-To: <19339.998531393@kao2.melbourne.sgi.com>
Message-ID: <Pine.GSO.3.96.1010823164555.21718C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 23 Aug 2001, Keith Owens wrote:

> The definition of struct archdata in kernel and modutils can be
> different, a new kernel layout with an old modutils is legal but fatal
> unless you code for it.  The correct test for archdata is
> 
> if (!mod_member_present(mp, archdata_start) ||
>     (mp->archdata_end - mp->archdata_start) <=
>      offsetof(struct archdata, dbe_table_end))
> 	continue;
> 
> Do not use archdata unless it is at least large enough to contain
> dbe_table_end.  That test also takes care of NULL pointers, end - start
> == 0 for NULL.

 Hmm, your suggested code checks if the passed struct is long enough for
dbe_table_start only -- what about dbe_table_end?  The following code: 

ap = (struct archdata *)(mod->archdata_start);
if (!mod_member_present(mp, archdata_start) ||
    (mp->archdata_end - mp->archdata_start) <
     offsetof(struct archdata, dbe_table_end) + sizeof(ap->dbe_table_end))
      continue;

should be stricter.  While modutils as released won't ever pass a smaller
struct, someone may modify them or use another program to invoke
init_module(), so we need to protect the kernel against bogus data. 

> The rest of the code looks OK, except it needs a global change of
> arch_init_module: to module_arch_init: to match the macro name.

 OK, I'll do it.  It should have been done for ia64 in the first place.
Or should it be changed into "<arch>_init_module" to match functions' real
names?

> Do you have the corresponding modutils patch or shall I do it? 

 I've send it to you separately just after the kernel patch.  Should I
resend it? 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
