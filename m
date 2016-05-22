Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 May 2016 11:06:47 +0200 (CEST)
Received: from baptiste.telenet-ops.be ([195.130.132.51]:49922 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27031019AbcEVJGpqqzH6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 22 May 2016 11:06:45 +0200
Received: from ayla.of.borg ([84.195.107.21])
        by baptiste.telenet-ops.be with bizsmtp
        id xM6l1s0080TjorY01M6lnu; Sun, 22 May 2016 11:06:45 +0200
Received: from ramsan.of.borg ([192.168.97.29] helo=ramsan)
        by ayla.of.borg with esmtp (Exim 4.82)
        (envelope-from <geert@linux-m68k.org>)
        id 1b4PLR-0006Nq-67; Sun, 22 May 2016 11:06:45 +0200
Received: from geert by ramsan with local (Exim 4.82)
        (envelope-from <geert@linux-m68k.org>)
        id 1b4PLU-00025w-RQ; Sun, 22 May 2016 11:06:48 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org
Subject: [PATCH 08/54] MAINTAINERS: Add file patterns for mips brcm device tree bindings
Date:   Sun, 22 May 2016 11:05:45 +0200
Message-Id: <1463907991-7916-9-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
References: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53604
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
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Rafał Miłecki <zajec5@gmail.com>
Cc: linux-mips@linux-mips.org
---
Please apply this patch directly if you want to be involved in device
tree binding documentation for your subsystem.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d92b26da80747622..63833fe6c6cee985 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2512,6 +2512,7 @@ M:	Hauke Mehrtens <hauke@hauke-m.de>
 M:	Rafał Miłecki <zajec5@gmail.com>
 L:	linux-mips@linux-mips.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/mips/brcm/
 F:	arch/mips/bcm47xx/*
 F:	arch/mips/include/asm/mach-bcm47xx/*
 
-- 
1.9.1
