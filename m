Return-Path: <SRS0=nL/W=S5=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D385C43218
	for <linux-mips@archiver.kernel.org>; Sat, 27 Apr 2019 12:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3794A2087C
	for <linux-mips@archiver.kernel.org>; Sat, 27 Apr 2019 12:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfD0MxH (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:53:07 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:60007 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfD0MxH (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 27 Apr 2019 08:53:07 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MWRZr-1hIx843db1-00XpY8; Sat, 27 Apr 2019 14:52:44 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, andrew@aj.id.au,
        andriy.shevchenko@linux.intel.com, macro@linux-mips.org,
        vz@mleia.com, slemieux.tyco@gmail.com, khilman@baylibre.com,
        liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com, davem@davemloft.net, jacmet@sunsite.dk,
        linux@prisktech.co.nz, matthias.bgg@gmail.com,
        linux-mips@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: [PATCH 12/41] drivers: tty: serial: uartlite: use dev_dbg() instead of pr_debug()
Date:   Sat, 27 Apr 2019 14:51:53 +0200
Message-Id: <1556369542-13247-13-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:iKlivJb6BzLykaezfbMDcQZdn+ix2ooVfsC6tW0pEhl98LAPDeE
 JRRVgVcfczmetBZDaIj6bTxrIsuLJZWRq491LJqAx+h9NbgwnoIDbHxcrTYcX/2PcSRokum
 actVckV0OuFGgmAK7gUuP0HXW1/BSfc94DTxmg7pJbcD5SZVKeVCxYgAJklKBryYGvN1CJo
 ibF50Jd1+Py/n87SQbwsQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u5P2g8JRH2I=:qGaH8ryqR7sUqOGrLtEnq0
 2WfUNdHCnLg10s1ecEg65pn/njtDsMqOeP8gNEpxCMTzcWsLT9VA4DU3CEBVa3HCzjiKJcfHG
 eTHURytwvHGp7s9jZVE5iai0hKZDLmT9tnCMG0O5bDybrILrbz2OaCok/sor106qS90eCocZA
 WHMkOGw0j1qJeCv0leK1Z4fuVANM96a4sKdqYlnLL2v1g0Yy7Qv2BA/TyHUBS+K7r2RGhcM93
 TQCZfinRHziPPxnqY8q6GJipcuPVsuiLqzJC0H8npIwN2FnPLLAPYV/vgXo00WkXMfxjp7mWe
 s9cDM9K+72I9v9RY2NCSZ4HlPW78uNjLRoKXH9UI6yEUBsHch/+0OxFFZTB2NnEgI5hM4CxaA
 aW2LQCsOERK9kjsOnJFUi/mvk0axc5fq8TDylOAwQOSe0Nkpla45hTAsiHS221ZrBXCbrV5zA
 vp2fnOF01p7Eyj5ee/bkdEt+KrcA0YHPLrsTPFX/ReZeKT0iqAavOA1IICkPrbO/J9OgpkqPM
 +e5kU1Y2uDllo5BJ52L6yldoO9jgsv77olPmdDGKDcAfFx4RUBuMjYer7MOaRBSCwUzPaMwsD
 tgJ7G6LdN06zK0oIyp9V0oKzUCmMe1VTLSZaAIbSfUawtMPghR9Z49rdDsyfAYZ2DohkJIPTF
 xQn1Ht0ha1HyECC5uOoj7J38mbBQIygbj3uOhqVZj78SrVH8ls26OFebX6TDxvvF5GTZrl2n3
 rnTYYYquT1fzWtIJQj/tIvkv4pDPeDZLTev6ZQ==
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Using dev_dbg() instead of pr_debg() for more consistent output.
(prints device name, etc).

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/uartlite.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index b8b912b..44d65bd 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -352,7 +352,8 @@ static int ulite_request_port(struct uart_port *port)
 	struct uartlite_data *pdata = port->private_data;
 	int ret;
 
-	pr_debug("ulite console: port=%p; port->mapbase=%llx\n",
+	dev_dbg(port->dev,
+		"ulite console: port=%p; port->mapbase=%llx\n",
 		 port, (unsigned long long) port->mapbase);
 
 	if (!request_mem_region(port->mapbase, ULITE_REGION, "uartlite")) {
@@ -519,7 +520,8 @@ static int ulite_console_setup(struct console *co, char *options)
 
 	/* Has the device been initialized yet? */
 	if (!port->mapbase) {
-		pr_debug("console on ttyUL%i not present\n", co->index);
+		dev_dbg(port->dev, "console on ttyUL%i not present\n",
+			co->index);
 		return -ENODEV;
 	}
 
-- 
1.9.1

