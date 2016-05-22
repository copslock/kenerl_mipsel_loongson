Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 May 2016 11:07:05 +0200 (CEST)
Received: from albert.telenet-ops.be ([195.130.137.90]:57861 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27032919AbcEVJGqVwUV6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 22 May 2016 11:06:46 +0200
Received: from ayla.of.borg ([84.195.107.21])
        by albert.telenet-ops.be with bizsmtp
        id xM6l1s0180TjorY06M6l8f; Sun, 22 May 2016 11:06:46 +0200
Received: from ramsan.of.borg ([192.168.97.29] helo=ramsan)
        by ayla.of.borg with esmtp (Exim 4.82)
        (envelope-from <geert@linux-m68k.org>)
        id 1b4PLR-0006PI-OS; Sun, 22 May 2016 11:06:45 +0200
Received: from geert by ramsan with local (Exim 4.82)
        (envelope-from <geert@linux-m68k.org>)
        id 1b4PLV-00028F-Ch; Sun, 22 May 2016 11:06:49 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 30/54] MAINTAINERS: Add file patterns for mips device tree bindings
Date:   Sun, 22 May 2016 11:06:07 +0200
Message-Id: <1463907991-7916-31-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
References: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53605
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

Submitters of device tree binding documentation may forget to CC
the subsystem maintainer if this is missing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
Please apply this patch directly if you want to be involved in device
tree binding documentation for your subsystem.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 48ef0bd805968787..c1e413b2c61a9746 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7536,6 +7536,7 @@ W:	http://www.linux-mips.org/
 T:	git git://git.linux-mips.org/pub/scm/ralf/linux.git
 Q:	http://patchwork.linux-mips.org/project/linux-mips/list/
 S:	Supported
+F:	Documentation/devicetree/bindings/mips/
 F:	Documentation/mips/
 F:	arch/mips/
 
-- 
1.9.1
