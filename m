Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jul 2007 13:31:24 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:30885 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023578AbXGJMbV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Jul 2007 13:31:21 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6ACKkED002000;
	Tue, 10 Jul 2007 13:20:46 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6A8GWeg024963;
	Tue, 10 Jul 2007 09:16:32 +0100
Date:	Tue, 10 Jul 2007 09:16:32 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sam Ravnborg <sam@ravnborg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [KBUILD] Whitelist references from __dbe_table to .init
Message-ID: <20070710081632.GA10559@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15664
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

This is needed on MIPS where the same mechanism as get_user() is used to
intercept bus error exceptions for some hardware probes.  Without this
patch modpost will throw spurious warnings:

  LD      vmlinux
  SYSMAP  System.map
  SYSMAP  .tmp_System.map
  MODPOST vmlinux
WARNING: arch/mips/sgi-ip22/built-in.o(__dbe_table+0x0): Section mismatch: reference to .init.text:

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 3645e98..c337246 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1047,6 +1047,7 @@ static int init_section_ref_ok(const char *name)
 		".pdr",
 		"__param",
 		"__ex_table",
+		"__dbe_table",
 		".fixup",
 		".smp_locks",
 		".plt",  /* seen on ARCH=um build on x86_64. Harmless */
