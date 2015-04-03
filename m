Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:23:48 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025220AbbDCWXesd-jG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:23:34 +0200
Date:   Fri, 3 Apr 2015 23:23:34 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 01/48] doc: kernel-parameters.txt: Mark `nofpu' for MIPS
 too
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504030101460.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

The MIPS port has supported this option since forever, long before SH 
was even in plans.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-nofpu.diff
Index: linux/Documentation/kernel-parameters.txt
===================================================================
--- linux.orig/Documentation/kernel-parameters.txt	2015-04-02 20:27:51.263153000 +0100
+++ linux/Documentation/kernel-parameters.txt	2015-04-02 20:27:51.477157000 +0100
@@ -2321,7 +2321,7 @@ bytes respectively. Such letter suffixes
 			noexec32=off: disable non-executable mappings
 				read implies executable mappings
 
-	nofpu		[SH] Disable hardware FPU at boot time.
+	nofpu		[MIPS,SH] Disable hardware FPU at boot time.
 
 	nofxsr		[BUGS=X86-32] Disables x86 floating point extended
 			register save and restore. The kernel will only save
