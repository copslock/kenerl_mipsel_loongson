Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Nov 2009 18:57:16 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:58911 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493001AbZKERzn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 5 Nov 2009 18:55:43 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA5Hv7bx024941;
	Thu, 5 Nov 2009 18:57:07 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA5Hv7gg024940;
	Thu, 5 Nov 2009 18:57:07 +0100
Message-Id: <20091105152702.125802957@linux-mips.org>
User-Agent: quilt/0.47-1
Date:	Thu, 05 Nov 2009 16:25:58 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Linus Torvalds <torvalds@linux-foundation.org>
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: [PATCH 2/6] Staging: Octeon: Use symbolic values for irq numbers.
References: <20091105152555.227009519@linux-mips.org>
Content-Disposition: inline; filename=0003.patch
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24703
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

From: David Daney <ddaney@caviumnetworks.com>

In addition to being magic numbers, the irq number passed to free_irq
is incorrect.  We need to use the correct symbolic value instead.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: devel@driverdev.osuosl.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: netdev@vger.kernel.org
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 drivers/staging/octeon/ethernet-spi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: upstream-linus/drivers/staging/octeon/ethernet-spi.c
===================================================================
--- upstream-linus.orig/drivers/staging/octeon/ethernet-spi.c
+++ upstream-linus/drivers/staging/octeon/ethernet-spi.c
@@ -317,6 +317,6 @@ void cvm_oct_spi_uninit(struct net_devic
 			cvmx_write_csr(CVMX_SPXX_INT_MSK(interface), 0);
 			cvmx_write_csr(CVMX_STXX_INT_MSK(interface), 0);
 		}
-		free_irq(8 + 46, &number_spi_ports);
+		free_irq(OCTEON_IRQ_RML, &number_spi_ports);
 	}
 }
