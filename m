Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2003 23:45:40 +0100 (BST)
Received: from mail.ocs.com.au ([IPv6:::ffff:203.34.97.2]:29446 "HELO
	mail.ocs.com.au") by linux-mips.org with SMTP id <S8225202AbTDDWpj>;
	Fri, 4 Apr 2003 23:45:39 +0100
Received: (qmail 21067 invoked from network); 4 Apr 2003 22:45:27 -0000
Received: from ocs3.intra.ocs.com.au (192.168.255.3)
  by mail.ocs.com.au with SMTP; 4 Apr 2003 22:45:27 -0000
Received: by ocs3.intra.ocs.com.au (Postfix, from userid 16331)
	id 228F43000B8; Sat,  5 Apr 2003 08:45:24 +1000 (EST)
Received: from ocs3.intra.ocs.com.au (localhost [127.0.0.1])
	by ocs3.intra.ocs.com.au (Postfix) with ESMTP
	id 9968C178; Sat,  5 Apr 2003 08:45:24 +1000 (EST)
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alvaro Martinez Echevarria <alvarom@cisco.com>
Cc: linux-mips@linux-mips.org
Subject: Re: problem with modutils under mips 
In-reply-to: Your message of "Fri, 04 Apr 2003 14:26:34 PST."
             <Pine.LNX.4.44.0304041414020.15408-100000@alvarom-lnx.cisco.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 05 Apr 2003 08:45:18 +1000
Message-ID: <27004.1049496318@ocs3.intra.ocs.com.au>
Return-Path: <kaos@ocs.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1930
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaos@ocs.com.au
Precedence: bulk
X-list: linux-mips

On Fri, 4 Apr 2003 14:26:34 -0800 (PST), 
Alvaro Martinez Echevarria <alvarom@cisco.com> wrote:
>We are having some modutils trouble under mips, when
>compiling modules with gcc-3.2 and debugging information. It
>turns out gcc is generating debug sections in DWARF format, i.e.,
>with elf section type SHT_MIPS_DWARF. That results in an error in
>obj/obj_mips.c:arch_load_proc_section(), as follows:
>
>foo.o: Unhandled section header type: 7000001e
>foo.o: Unknown section header type: 7000001e
>
>This is the simple fix I have:
>
>---------------------------------------------------------------------------=
>----
>--- obj_mips.c.OLD  2002-02-28 16:39:06.000000000 -0800
>+++ obj_mips.c    2003-04-02 18:34:44.000000000 -0800
>@@ -74,6 +74,7 @@
>     {
>     case SHT_MIPS_DEBUG:
>     case SHT_MIPS_REGINFO:
>+    case SHT_MIPS_DWARF:
>       /* Actually these two sections are as useless as something can be ..=
>=2E  */
>       sec->contents =3D NULL;
>       break;
>@@ -83,7 +84,6 @@
>     case SHT_MIPS_GPTAB:
>     case SHT_MIPS_UCODE:
>     case SHT_MIPS_OPTIONS:
>-    case SHT_MIPS_DWARF:
>     case SHT_MIPS_EVENTS:
>       /* These shouldn't ever be in a module file.  */
>       error("Unhandled section header type: %08x", sec->header.sh_type);
>---------------------------------------------------------------------------=
>
>At the same time, maybe there should be something after the
>"Unhandled" message for all those types, so the execution doesn't
>skip over to the default: case and return -1, but I don't know
>that much.

Thanks, this is what went into my tree, patch is against modutils 2.4.25.

Index: 26.1/obj/obj_mips.c
--- 26.1/obj/obj_mips.c Fri, 01 Mar 2002 11:39:06 +1100 kaos (modutils-2.4/c/10_obj_mips.c 1.4 644)
+++ 26.1(w)/obj/obj_mips.c Sat, 05 Apr 2003 08:36:33 +1000 kaos (modutils-2.4/c/10_obj_mips.c 1.4 644)
@@ -74,7 +74,8 @@ arch_load_proc_section(struct obj_sectio
     {
     case SHT_MIPS_DEBUG:
     case SHT_MIPS_REGINFO:
-      /* Actually these two sections are as useless as something can be ...  */
+    case SHT_MIPS_DWARF:
+      /* Ignore debugging sections  */
       sec->contents = NULL;
       break;
 
@@ -83,10 +84,10 @@ arch_load_proc_section(struct obj_sectio
     case SHT_MIPS_GPTAB:
     case SHT_MIPS_UCODE:
     case SHT_MIPS_OPTIONS:
-    case SHT_MIPS_DWARF:
     case SHT_MIPS_EVENTS:
       /* These shouldn't ever be in a module file.  */
       error("Unhandled section header type: %08x", sec->header.sh_type);
+      return -1;
 
     default:
       /* We don't even know the type.  This time it might as well be a
