Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jul 2010 17:18:20 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:48051 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492048Ab0GFPSR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Jul 2010 17:18:17 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o66FIChP004878;
        Tue, 6 Jul 2010 16:18:12 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o66FIB74004876;
        Tue, 6 Jul 2010 16:18:11 +0100
Date:   Tue, 6 Jul 2010 16:18:11 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     linux-mips@linux-mips.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: NET: SB1250: Initialize .owner
Message-ID: <20100706151811.GA4829@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 drivers/net/sb1250-mac.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/net/sb1250-mac.c b/drivers/net/sb1250-mac.c
index 1f3acc3..79eee30 100644
--- a/drivers/net/sb1250-mac.c
+++ b/drivers/net/sb1250-mac.c
@@ -2671,6 +2671,7 @@ static struct platform_driver sbmac_driver = {
 	.remove = __exit_p(sbmac_remove),
 	.driver = {
 		.name = sbmac_string,
+		.owner  = THIS_MODULE,
 	},
 };
 
