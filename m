Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Apr 2014 00:04:02 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:32964 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816635AbaDFWEAiK5gP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Apr 2014 00:04:00 +0200
Date:   Sun, 6 Apr 2014 23:04:00 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH] DEC: Add self as the maintainer
Message-ID: <alpine.LFD.2.11.1404062256450.15266@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39673
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

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
Ralf,

 I think it makes sense, I've been doing this for years anyway (with a 
varying intensity), so let's ask people to pester me directly so that I 
don't miss things.  Let me know if you suggest amending this entry 
somehow.

  Maciej

linux-dec-maintainer.patch
Index: linux-20140404-4maxp64/MAINTAINERS
===================================================================
--- linux-20140404-4maxp64.orig/MAINTAINERS
+++ linux-20140404-4maxp64/MAINTAINERS
@@ -2645,6 +2645,15 @@ S:	Orphan
 F:	Documentation/networking/decnet.txt
 F:	net/decnet/
 
+DECSTATION PLATFORM SUPPORT
+M:	"Maciej W. Rozycki" <macro@linux-mips.org>
+L:	linux-mips@linux-mips.org
+W:	http://www.linux-mips.org/wiki/DECstation
+S:	Maintained
+F:	arch/mips/dec/
+F:	arch/mips/include/asm/dec/
+F:	arch/mips/include/asm/mach-dec/
+
 DEFXX FDDI NETWORK DRIVER
 M:	"Maciej W. Rozycki" <macro@linux-mips.org>
 S:	Maintained
