Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jun 2003 05:20:44 +0100 (BST)
Received: from 12-234-207-60.client.attbi.com ([IPv6:::ffff:12.234.207.60]:36489
	"HELO gateway.total-knowledge.com") by linux-mips.org with SMTP
	id <S8225244AbTFDEUm>; Wed, 4 Jun 2003 05:20:42 +0100
Received: (qmail 15856 invoked by uid 502); 4 Jun 2003 04:20:38 -0000
Date: Tue, 3 Jun 2003 21:20:38 -0700
From: ilya@theIlya.com
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: [PATCH] vmlinux.lds.S
Message-ID: <20030604042037.GD7624@gateway.total-knowledge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <ilya@gateway.total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2511
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theIlya.com
Precedence: bulk
X-list: linux-mips

Without this generated image is weired, and cannot be loaded.

Index: arch/mips64/vmlinux.lds.S
===================================================================
RCS file: /home/cvs/linux/arch/mips64/vmlinux.lds.S,v
retrieving revision 1.11
diff -u -r1.11 vmlinux.lds.S
--- arch/mips64/vmlinux.lds.S   3 Jun 2003 17:04:11 -0000       1.11
+++ arch/mips64/vmlinux.lds.S   4 Jun 2003 04:18:05 -0000
@@ -46,6 +46,7 @@
   __kallsyms : { *(__kallsyms) }
   __stop___kallsyms = .;
 
+  RODATA
   . = ALIGN(64);
 
   /* writeable */
