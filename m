Received:  by oss.sgi.com id <S305169AbQDSOGd>;
	Wed, 19 Apr 2000 07:06:33 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:55871 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305163AbQDSOGW>;
	Wed, 19 Apr 2000 07:06:22 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id HAA14805; Wed, 19 Apr 2000 07:01:37 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA20470
	for linux-list;
	Wed, 19 Apr 2000 06:55:14 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA29560
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 19 Apr 2000 06:55:11 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA07979
	for <linux@cthulhu.engr.sgi.com>; Wed, 19 Apr 2000 06:55:05 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id CAF37877; Wed, 19 Apr 2000 15:55:04 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 3970D8FC4; Wed, 19 Apr 2000 15:50:21 +0200 (CEST)
Date:   Wed, 19 Apr 2000 15:50:21 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Subject: depmod segfault / cause / egcs/binutils bug ?
Message-ID: <20000419155021.G7793@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Hi,
i just got this mail because i opened a Bug in the Debian BTS
concerning a segfault in depmod.

I used egcs 1.0.3a and binutils 2.8.1 + mips patches to 
create the kernel + modules ... Might there be a bug in
egcs and/or binutils ?


----- Forwarded message from Keith Owens <kaos@ocs.com.au> -----

From: Keith Owens <kaos@ocs.com.au>
To: Florian Lohoff <flo@rfc822.org>
Subject: Re: Bug#62617: depmod segfaults on mips/mipsel 
Message-ID: <3565.956140102@ocs3.ocs-net>

The problem is some input objects that do not conform to the ELF
specification that modutils is using, modutils is written to Elf 1.1.

Several of your modules have a mismatch between a field in the section
headers and the data.  In a section with type SHT_SYMTAB, the sh_info
field should contain "One greater than the symbol table index of the
last local symbol (binding STB_LOCAL)", obj_load uses sh_info to
allocate the local symbol table.  In st.o the symtab section has an
sh_info of 10 but there are a lot more than 10 local symbols.  This
overflowed the local_symtab array, overwrote the next malloc area and
broke free().

This patch lists the offending symbols instead of getting SEGV.  I will
include it in modutils 2.3.11 as a sanity check.  However it drops the
extra local symbols so the module may not load anyway.

Are you using an unusual set of binutils?  I think the next step is to
pass this info to the MIPS binutils people and get them to check the
format of your st.o object, with particular reference to the number of
local symbols.

for i in `find /lib/modules/2.3.99-pre3/ -name '*.o'`; do echo $i ; /sbin/depmod -ne $i ; done

lists a lot of local symbol table overflows.

Index: modutils-2.3.10/obj/obj_common.c
--- modutils-2.3.10/obj/obj_common.c Thu, 13 Apr 2000 18:17:59 +1000 kaos (modutils-2.3/23_obj_common 1.3 644)
+++ modutils-2.3.10/obj/obj_common.c Wed, 19 Apr 2000 20:02:17 +1000 kaos (modutils-2.3/23_obj_common 1.3 644)
@@ -167,8 +167,13 @@
   f->symtab[hash] = sym;
   sym->ksymidx = -1;
 
-  if (ELFW(ST_BIND)(info) == STB_LOCAL && symidx != -1)
-    f->local_symtab[symidx] = sym;
+  if (ELFW(ST_BIND)(info) == STB_LOCAL && symidx != -1) {
+    if (symidx >= f->local_symtab_size)
+      error("local symbol %s with index %ld exceeds local_symtab_size %ld",
+        name, (long) symidx, (long) f->local_symtab_size);
+    else
+      f->local_symtab[symidx] = sym;
+  }
 
 found:
   sym->name = name;



----- End forwarded message -----

-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
