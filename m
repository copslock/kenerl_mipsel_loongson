Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Jun 2003 09:11:49 +0100 (BST)
Received: from p508B6D44.dip.t-dialin.net ([IPv6:::ffff:80.139.109.68]:47001
	"EHLO p508B6D44.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225206AbTFBILr>; Mon, 2 Jun 2003 09:11:47 +0100
Received: from [IPv6:::ffff:204.94.215.101] ([IPv6:::ffff:204.94.215.101]:20109
	"EHLO zok.sgi.com") by linux-mips.net with ESMTP id <S868871AbTFBEuW>;
	Mon, 2 Jun 2003 06:50:22 +0200
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by zok.sgi.com (8.12.9/8.12.2/linux-outbound_gateway-1.2) with SMTP id h523pTtm029876;
	Sun, 1 Jun 2003 20:51:29 -0700
Received: from kao2.melbourne.sgi.com (kao2.melbourne.sgi.com [134.14.55.180]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id OAA13174; Mon, 2 Jun 2003 14:49:30 +1000
Received: by kao2.melbourne.sgi.com (Postfix, from userid 16331)
	id D9F1AD8F46; Mon,  2 Jun 2003 14:49:29 +1000 (EST)
Received: from kao2.melbourne.sgi.com (localhost [127.0.0.1])
	by kao2.melbourne.sgi.com (Postfix) with ESMTP
	id D728D91336; Mon,  2 Jun 2003 14:49:29 +1000 (EST)
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: ilya@theIlya.com
Cc: wesolows@foobazco.org, linux-mips@linux-mips.org
Subject: Re: Yet another fix 
In-reply-to: Your message of "Sun, 01 Jun 2003 21:14:24 MST."
             <20030602041424.GG3035@gateway.total-knowledge.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 02 Jun 2003 14:49:24 +1000
Message-ID: <13249.1054529364@kao2.melbourne.sgi.com>
Return-Path: <kaos@sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2492
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaos@sgi.com
Precedence: bulk
X-list: linux-mips

On Sun, 1 Jun 2003 21:14:24 -0700, 
ilya@theIlya.com wrote:
>I am not sure this is correct solution to a problem. Or rather, I'm pretty
>sure it is incorrect one.. There is a reference to module_map somewhere, however
>it is not inculded if modules are disabled. Here is sorta fix
>
>Index: include/asm-mips64/module.h
>===================================================================
>RCS file: /home/cvs/linux/include/asm-mips64/module.h,v
>retrieving revision 1.5
>diff -u -r1.5 module.h
>--- include/asm-mips64/module.h 1 Jun 2003 00:39:15 -0000       1.5
>+++ include/asm-mips64/module.h 2 Jun 2003 03:59:23 -0000
>@@ -11,4 +11,8 @@
> #define Elf_Sym Elf32_Sym
> #define Elf_Ehdr Elf32_Ehdr
> 
>+#ifndef CONFIG_MODULES
>+#define module_map(x) vmalloc(x)
>+#endif
>+
> #endif /* _ASM_MODULE_H */

That fix is incorrect.  There should be no references to module_map
when CONFIG_MODULES=n.  Please find out where module_map is being
incorrectly used and fix that code.
