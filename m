Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Nov 2005 20:22:09 +0000 (GMT)
Received: from wproxy.gmail.com ([64.233.184.203]:46457 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133879AbVKLUVu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 12 Nov 2005 20:21:50 +0000
Received: by wproxy.gmail.com with SMTP id i5so483974wra
        for <linux-mips@linux-mips.org>; Sat, 12 Nov 2005 12:23:33 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=SSEquN8kYvWmOpu/4Q42CPHuVlM9shqEgLyjgaFVFivFwA8HrU7z/NPE2GUCaZy8FBmitO9nW4NJcPzISmpp2v2YtjfracRIAF8i+nGLdmyBXyrgEqOckx9ts8NAlOTmdEOtFKhZiZLcWWE2aQFujL3P30jZyZl/HXgNUgELrwU=
Received: by 10.65.233.6 with SMTP id k6mr3899417qbr;
        Sat, 12 Nov 2005 12:23:33 -0800 (PST)
Received: from gmail.com ( [217.10.38.130])
        by mx.gmail.com with ESMTP id e15sm762466qba.2005.11.12.12.23.30;
        Sat, 12 Nov 2005 12:23:32 -0800 (PST)
Received: by gmail.com (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	adobriyan@gmail.com; Sat, 12 Nov 2005 23:37:14 +0300 (MSK)
Date:	Sat, 12 Nov 2005 23:37:11 +0300
From:	Alexey Dobriyan <adobriyan@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@osdl.org>
Cc:	Domen Puncer <domen@coderock.org>, linux-mips@linux-mips.org
Subject: [PATCH] Remove include/asm-mips/mipsprom.h
Message-ID: <20051112203711.GE19876@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Return-Path: <adobriyan@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adobriyan@gmail.com
Precedence: bulk
X-list: linux-mips

From: Domen Puncer <domen@coderock.org>

Remove nowhere referenced file ("grep mipsrom -r ." didn't find anything).

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Index: linux-kj/include/asm-mips/mipsprom.h
===================================================================
--- linux-kj.orig/include/asm-mips/mipsprom.h	2005-11-12 15:38:00.000000000 +0300
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,74 +0,0 @@
-#ifndef __ASM_MIPS_PROM_H
-#define __ASM_MIPS_PROM_H
-
-#define PROM_RESET		0
-#define PROM_EXEC		1
-#define PROM_RESTART		2
-#define PROM_REINIT		3
-#define PROM_REBOOT		4
-#define PROM_AUTOBOOT		5
-#define PROM_OPEN		6
-#define PROM_READ		7
-#define PROM_WRITE		8
-#define PROM_IOCTL		9
-#define PROM_CLOSE		10
-#define PROM_GETCHAR		11
-#define PROM_PUTCHAR		12
-#define PROM_SHOWCHAR		13	/* XXX */
-#define PROM_GETS		14	/* XXX */
-#define PROM_PUTS		15	/* XXX */
-#define PROM_PRINTF		16	/* XXX */
-
-/* What are these for? */
-#define PROM_INITPROTO		17	/* XXX */
-#define PROM_PROTOENABLE	18	/* XXX */
-#define PROM_PROTODISABLE	19	/* XXX */
-#define PROM_GETPKT		20	/* XXX */
-#define PROM_PUTPKT		21	/* XXX */
-
-/* More PROM shit.  Probably has to do with VME RMW cycles??? */
-#define PROM_ORW_RMW		22	/* XXX */
-#define PROM_ORH_RMW		23	/* XXX */
-#define PROM_ORB_RMW		24	/* XXX */
-#define PROM_ANDW_RMW		25	/* XXX */
-#define PROM_ANDH_RMW		26	/* XXX */
-#define PROM_ANDB_RMW		27	/* XXX */
-
-/* Cache handling stuff */
-#define PROM_FLUSHCACHE		28	/* XXX */
-#define PROM_CLEARCACHE		29	/* XXX */
-
-/* Libc alike stuff */
-#define PROM_SETJMP		30	/* XXX */
-#define PROM_LONGJMP		31	/* XXX */
-#define PROM_BEVUTLB		32	/* XXX */
-#define PROM_GETENV		33	/* XXX */
-#define PROM_SETENV		34	/* XXX */
-#define PROM_ATOB		35	/* XXX */
-#define PROM_STRCMP		36	/* XXX */
-#define PROM_STRLEN		37	/* XXX */
-#define PROM_STRCPY		38	/* XXX */
-#define PROM_STRCAT		39	/* XXX */
-
-/* Misc stuff */
-#define PROM_PARSER		40	/* XXX */
-#define PROM_RANGE		41	/* XXX */
-#define PROM_ARGVIZE		42	/* XXX */
-#define PROM_HELP		43	/* XXX */
-
-/* Entry points for some PROM commands */
-#define PROM_DUMPCMD		44	/* XXX */
-#define PROM_SETENVCMD		45	/* XXX */
-#define PROM_UNSETENVCMD	46	/* XXX */
-#define PROM_PRINTENVCMD	47	/* XXX */
-#define PROM_BEVEXCEPT		48	/* XXX */
-#define PROM_ENABLECMD		49	/* XXX */
-#define PROM_DISABLECMD		50	/* XXX */
-
-#define PROM_CLEARNOFAULT	51	/* XXX */
-#define PROM_NOTIMPLEMENT	52	/* XXX */
-
-#define PROM_NV_GET		53	/* XXX */
-#define PROM_NV_SET		54	/* XXX */
-
-#endif /* __ASM_MIPS_PROM_H */
