Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Nov 2009 18:56:31 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:58912 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492974AbZKERzn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 5 Nov 2009 18:55:43 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA5Hv7Kf024945;
	Thu, 5 Nov 2009 18:57:07 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA5Hv7Xm024944;
	Thu, 5 Nov 2009 18:57:07 +0100
Message-Id: <20091105152702.035396736@linux-mips.org>
User-Agent: quilt/0.47-1
Date:	Thu, 05 Nov 2009 16:25:57 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Linus Torvalds <torvalds@linux-foundation.org>
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: [PATCH 1/6] Staging: Octeon: Fix compile error in drivers/staging/octeon/ethernet-mdio.c
References: <20091105152555.227009519@linux-mips.org>
Content-Disposition: inline; filename=0002.patch
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24701
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

From: David Daney <ddaney@caviumnetworks.com>

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: devel@driverdev.osuosl.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: netdev@vger.kernel.org
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 drivers/staging/octeon/ethernet-mdio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: upstream-linus/drivers/staging/octeon/ethernet-mdio.c
===================================================================
--- upstream-linus.orig/drivers/staging/octeon/ethernet-mdio.c
+++ upstream-linus/drivers/staging/octeon/ethernet-mdio.c
@@ -170,7 +170,7 @@ static u32 cvm_oct_get_link(struct net_d
 	return ret;
 }
 
-struct const ethtool_ops cvm_oct_ethtool_ops = {
+const struct ethtool_ops cvm_oct_ethtool_ops = {
 	.get_drvinfo = cvm_oct_get_drvinfo,
 	.get_settings = cvm_oct_get_settings,
 	.set_settings = cvm_oct_set_settings,
