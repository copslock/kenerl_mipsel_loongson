Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2017 16:23:43 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.187]:50157 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993906AbdAQPVOHpgdd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jan 2017 16:21:14 +0100
Received: from wuerfel.lan ([78.43.21.235]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0M0Y1e-1chSyQ43vK-00upn9; Tue, 17 Jan 2017 16:20:21 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
        John Crispin <john@phrozen.org>,
        Tobias Wolf <dev-NTEO@vplace.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] MIPS: ralink: fix request_mem_region error handling
Date:   Tue, 17 Jan 2017 16:18:42 +0100
Message-Id: <20170117151911.4109452-8-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20170117151911.4109452-1-arnd@arndb.de>
References: <20170117151911.4109452-1-arnd@arndb.de>
X-Provags-ID: V03:K0:xjoINC8OR0Q/0pvqU5eSELCuZNwI2rA7+AQlg9ol/lpSHeG286Z
 MBB8L1+eK527j+Xy/ifynkc/YufW5SnXB4A07qUFOMcDLeGIWPBbZ0PHMVPYRpbpVnqI8rO
 T8ociXorA9CkEpTSpuYDHqxy4dzf98hcXQcIvO7vM/9QyGgaUvky+qIyTh+LTlSymSW5Tub
 LX8cGf7LWr5ZpHMObxNlw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uKbl62U9zeI=:N1Cm94mBSWcnQFtBAmjUrI
 3vPXt1s7aSrGd3acfX1Mc1u/SO01sTjsgRw65CZwIOMbeto7EiAK5Nnh8hplF6JGG5WtUk7lB
 lbtG3mEmwwmMed+w4rsmDKiVjUp5b3qytXap4fzvs/4Vr3nJVf4L3q/Q7Kez5454GW9UcX9mo
 /m+LUNQowzQ4cCaOsumCfvJtaSUbyihifnKmRBNfXjKKsud5QgsaseMkOlT1D7CPPACHTlBIG
 blaMkDUecBbHg6zx+jsp5B/lNToSFsRkshpil1lMY19NQhsCOyfYSdqq52B7aSHNh8BXYVawq
 PJg7hW3tEtDIq+tKFdToSoTh8QlaPf4b2wjH9Awria4FM+Jycq1tErsfv8SJ/8lyFlpRqXJGs
 kNd075RjHyGdIz4jzqNfkjUlICRAb4/45+YX9Pqy3TMdsVh3YSosXNP4sOen5QCl13eua4cPq
 y6SHEi+GvKkNTWHnJKJLJMMmBbG9VDfWN9uYw8FHLpjH2eh12sllEBer7BBJGkfnkSxYyEEL+
 enuxHUvSo1hmNcVPRJBhVIZCRupwt+LF5DzYuUmWZsybVJsDhMUD6A2RtjwVQDwtfuj05NFFc
 AsT4BNtgh7KgHruc4wXWSl0VLTuU7RZlTzbRmHLL4kyzBFVgcu627AowbBPrzGaE7k7jQwkLb
 xXDH+8cV0pm2TMyxBmrj7KthCRbo6cKI23e+SA7cBZZXbaDbZXWumrMSVDMfFlWpPw+U=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56351
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

request_mem_region returns a NULL pointer on error, comparing it
against a number results in a warning:

arch/mips/ralink/of.c: In function 'plat_of_remap_node':
arch/mips/ralink/of.c:45:15: error: ordered comparison of pointer with integer zero [-Werror=extra]
arch/mips/ralink/irq.c: In function 'intc_of_init':
arch/mips/ralink/irq.c:167:15: error: ordered comparison of pointer with integer zero [-Werror=extra]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/ralink/irq.c | 4 ++--
 arch/mips/ralink/of.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/ralink/irq.c b/arch/mips/ralink/irq.c
index 4911c1445f1a..9b478c95aaf5 100644
--- a/arch/mips/ralink/irq.c
+++ b/arch/mips/ralink/irq.c
@@ -163,8 +163,8 @@ static int __init intc_of_init(struct device_node *node,
 	if (of_address_to_resource(node, 0, &res))
 		panic("Failed to get intc memory range");
 
-	if (request_mem_region(res.start, resource_size(&res),
-				res.name) < 0)
+	if (!request_mem_region(res.start, resource_size(&res),
+				res.name))
 		pr_err("Failed to request intc memory");
 
 	rt_intc_membase = ioremap_nocache(res.start,
diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
index 4c843e039b96..1ada8492733b 100644
--- a/arch/mips/ralink/of.c
+++ b/arch/mips/ralink/of.c
@@ -40,9 +40,9 @@ __iomem void *plat_of_remap_node(const char *node)
 	if (of_address_to_resource(np, 0, &res))
 		panic("Failed to get resource for %s", node);
 
-	if ((request_mem_region(res.start,
+	if (!request_mem_region(res.start,
 				resource_size(&res),
-				res.name) < 0))
+				res.name))
 		panic("Failed to request resources for %s", node);
 
 	return ioremap_nocache(res.start, resource_size(&res));
-- 
2.9.0
