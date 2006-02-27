Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Feb 2006 22:26:45 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:42508 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133466AbWB0W0f (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Feb 2006 22:26:35 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 876F464D3F; Mon, 27 Feb 2006 22:34:12 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id D514A8FD8; Mon, 27 Feb 2006 23:34:01 +0100 (CET)
Date:	Mon, 27 Feb 2006 22:34:01 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:	Jordan Crouse <jordan.crouse@amd.com>
Subject: Re: Diff between Linus' and linux-mips git: trivial changes
Message-ID: <20060227223401.GA7986@deprecation.cyrius.com>
References: <20060219234318.GA16311@deprecation.cyrius.com> <20060219234757.GW10266@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060219234757.GW10266@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

[IDE] au1xxx_ide.h: Remove redefinition of drive_list_entry

The mips tree (but not mainline) contains a definition of
drive_list_entry in include/asm-mips/mach-au1x00/au1xxx_ide.h which
leads to a compilation failure if CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
is set.  Remove this bogus redefinition, thereby bringing the driver
in sync with mainline and into a compilable form.

  CC      drivers/ide/mips/au1xxx-ide.o
In file included from drivers/ide/mips/au1xxx-ide.c:53:
include/asm/mach-au1x00/au1xxx_ide.h:87: error: redefinition of ‘struct drive_list_entry’

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


--- mips.git/include/asm-mips/mach-au1x00/au1xxx_ide.h	2006-02-23 22:06:13.000000000 +0000
+++ linux-2.6.git/include/asm-mips/mach-au1x00/au1xxx_ide.h	2006-02-03 03:07:30.000000000 +0000
@@ -84,11 +84,6 @@
 } _auide_hwif;
 
 #ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
-struct drive_list_entry {
-	const char *id_model;
-	const char *id_firmware;
-};
-
 /* HD white list */
 static const struct drive_list_entry dma_white_list [] = {
 /*

-- 
Martin Michlmayr
http://www.cyrius.com/
