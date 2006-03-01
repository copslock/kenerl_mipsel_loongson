Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Mar 2006 01:47:36 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:18182 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133654AbWCABr2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Mar 2006 01:47:28 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 19BB964D3D; Wed,  1 Mar 2006 01:55:14 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 1B7AE81F5; Wed,  1 Mar 2006 02:55:06 +0100 (CET)
Date:	Wed, 1 Mar 2006 01:55:05 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] Mention Broadcom part number for BigSur board
Message-ID: <20060301015505.GA16567@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10689
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

[PATCH] Mention Broadcom part number for BigSur board

Mention the Broadcom part number for the BigSur board (BCM91480B)
in Kconfig, just like it's done for other Broadcom boards.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -599,7 +599,7 @@ config SGI_IP32
 	  If you want this kernel to run on SGI O2 workstation, say Y here.
 
 config SIBYTE_BIGSUR
-	bool "Support for Sibyte BigSur"
+	bool "Support for Sibyte BCM91480B-BigSur"
 	select BOOT_ELF32
 	select DMA_COHERENT
 	select PCI_DOMAINS

-- 
Martin Michlmayr
http://www.cyrius.com/
