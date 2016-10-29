Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Oct 2016 21:56:54 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:49278 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992087AbcJ2T4Y1O7fh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 29 Oct 2016 21:56:24 +0200
X-IronPort-AV: E=Sophos;i="5.31,565,1473112800"; 
   d="scan'208";a="242872221"
Received: from palace.lip6.fr (HELO localhost.localdomain) ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA256; 29 Oct 2016 21:56:18 +0200
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     kernel-janitors@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/15] MIPS: TXx9: 7segled: use permission-specific DEVICE_ATTR variants
Date:   Sat, 29 Oct 2016 21:36:59 +0200
Message-Id: <1477769829-22230-6-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1477769829-22230-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1477769829-22230-1-git-send-email-Julia.Lawall@lip6.fr>
Return-Path: <Julia.Lawall@lip6.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Julia.Lawall@lip6.fr
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

Use DEVICE_ATTR_WO for write only attributes.  This simplifies the
source code, improves readbility, and reduces the chance of
inconsistencies.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@wo@
declarer name DEVICE_ATTR;
identifier x,x_store;
@@

DEVICE_ATTR(x, \(0200\|S_IWUSR\), NULL, x_store);

@script:ocaml@
x << wo.x;
x_store << wo.x_store;
@@

if not (x^"_store" = x_store) then Coccilib.include_match false

@@
declarer name DEVICE_ATTR_WO;
identifier wo.x,wo.x_store;
@@

- DEVICE_ATTR(x, \(0200\|S_IWUSR\), NULL, x_store);
+ DEVICE_ATTR_WO(x);
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 arch/mips/txx9/generic/7segled.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/txx9/generic/7segled.c b/arch/mips/txx9/generic/7segled.c
index 566c58b..2203c25 100644
--- a/arch/mips/txx9/generic/7segled.c
+++ b/arch/mips/txx9/generic/7segled.c
@@ -55,8 +55,8 @@ static ssize_t raw_store(struct device *dev,
 	return size;
 }
 
-static DEVICE_ATTR(ascii, 0200, NULL, ascii_store);
-static DEVICE_ATTR(raw, 0200, NULL, raw_store);
+static DEVICE_ATTR_WO(ascii);
+static DEVICE_ATTR_WO(raw);
 
 static ssize_t map_seg7_show(struct device *dev,
 			     struct device_attribute *attr,
