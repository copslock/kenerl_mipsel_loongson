Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Dec 2011 01:49:42 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:14337 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903632Ab1LFAth (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Dec 2011 01:49:37 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4edd66f80000>; Mon, 05 Dec 2011 16:51:04 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 5 Dec 2011 16:49:36 -0800
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 5 Dec 2011 16:49:35 -0800
Message-ID: <4EDD669F.30207@cavium.com>
Date:   Mon, 05 Dec 2011 16:49:35 -0800
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     binutils <binutils@sourceware.org>
CC:     linux-mips <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Debian MIPS <debian-mips@lists.debian.org>
Subject: [Patch]: Fix ld pr11138 FAILures on mips*.
Content-Type: multipart/mixed;
 boundary="------------080709040708040308010506"
X-OriginalArrivalTime: 06 Dec 2011 00:49:35.0825 (UTC) FILETIME=[ECF8DC10:01CCB3B0]
X-archive-position: 32041
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3970

This is a multi-part message in MIME format.
--------------080709040708040308010506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The pr11138 testcase links an executable with a version script.  On 
mips64-linux the presence of a version script was causing the 
MIPS_RLD_MAP dynamic tag to be populated with a NULL value.  When such 
an executable was run ld.so would try to dereference this and receive 
SIGSEGV, thus killing the process.

The root cause of this is that the mips linker synthesizes a special 
symbol "__RLD_MAP", and then sets MIPS_RLD_MAP to point to it.  When a 
version script is present, this symbol gets versioned along with all the 
rest, and when it is time to take its address, the symbol can no longer 
be found as it has had version information appended to its name.

Since "__RLD_MAP" is really part of the ABI, we want to exclude it from 
symbol versioning.  To this end, I introduced a new symbol flag 
'no_sym_version' to tag this type of symbol.  When the "__RLD_MAP" 
symbol is created, we set this flag.

In _bfd_elf_link_assign_sym_version, we then skip all symbols that have 
'no_sym_version' set, and everything now works.

This problem has also been reported in the wild when linking the firefox 
executable.

Tested on mips64-linux-gnu and x86_64-linux-gnu

Ok to commit?

2011-12-05  David Daney  <david.daney@cavium.com>

	* elf-bfd.h (elf_link_hash_entry): Add no_sym_version field.
	* elflink.c (_bfd_elf_link_assign_sym_version): Don't assign a
	version if no_sym_version is set.
	* elfxx-mips.c (_bfd_mips_elf_create_dynamic_sections): Set
	no_sym_version for "__RLD_MAP".

--------------080709040708040308010506
Content-Type: text/plain;
 name="dd-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dd-2.patch"

Index: bfd/elf-bfd.h
===================================================================
RCS file: /cvs/src/src/bfd/elf-bfd.h,v
retrieving revision 1.329
diff -u -p -r1.329 elf-bfd.h
--- bfd/elf-bfd.h	17 Aug 2011 00:39:38 -0000	1.329
+++ bfd/elf-bfd.h	5 Dec 2011 20:15:49 -0000
@@ -198,6 +198,8 @@ struct elf_link_hash_entry
   unsigned int pointer_equality_needed : 1;
   /* Symbol is a unique global symbol.  */
   unsigned int unique_global : 1;
+  /* Symbol should not be versioned.  It is part of the ABI */
+  unsigned int no_sym_version : 1;
 
   /* String table index in .dynstr if this is a dynamic symbol.  */
   unsigned long dynstr_index;
Index: bfd/elflink.c
===================================================================
RCS file: /cvs/src/src/bfd/elflink.c,v
retrieving revision 1.430
diff -u -p -r1.430 elflink.c
--- bfd/elflink.c	15 Nov 2011 11:33:57 -0000	1.430
+++ bfd/elflink.c	5 Dec 2011 20:15:50 -0000
@@ -1946,6 +1946,9 @@ _bfd_elf_link_assign_sym_version (struct
   if (!h->def_regular)
     return TRUE;
 
+  if (h->no_sym_version)
+    return TRUE;
+
   bed = get_elf_backend_data (info->output_bfd);
   p = strchr (h->root.root.string, ELF_VER_CHR);
   if (p != NULL && h->verinfo.vertree == NULL)
Index: bfd/elfxx-mips.c
===================================================================
RCS file: /cvs/src/src/bfd/elfxx-mips.c,v
retrieving revision 1.296
diff -u -p -r1.296 elfxx-mips.c
--- bfd/elfxx-mips.c	29 Nov 2011 20:28:54 -0000	1.296
+++ bfd/elfxx-mips.c	5 Dec 2011 20:15:50 -0000
@@ -7260,6 +7260,7 @@ _bfd_mips_elf_create_dynamic_sections (b
 	  h = (struct elf_link_hash_entry *) bh;
 	  h->non_elf = 0;
 	  h->def_regular = 1;
+	  h->no_sym_version = 1;
 	  h->type = STT_OBJECT;
 
 	  if (! bfd_elf_link_record_dynamic_symbol (info, h))

--------------080709040708040308010506--
