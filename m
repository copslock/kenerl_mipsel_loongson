Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2008 09:01:57 +0100 (BST)
Received: from smtp.movial.fi ([62.236.91.34]:20879 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S28575367AbYGPIBz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2008 09:01:55 +0100
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id AC76DC80EA;
	Wed, 16 Jul 2008 11:01:49 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id w93JOI1xRdDw; Wed, 16 Jul 2008 11:01:49 +0300 (EEST)
Received: from sd048.hel.movial.fi (sd048.hel.movial.fi [172.17.49.48])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id 9115CC8084;
	Wed, 16 Jul 2008 11:01:49 +0300 (EEST)
Received: by sd048.hel.movial.fi (Postfix, from userid 30120)
	id 734BDB4046; Wed, 16 Jul 2008 11:01:49 +0300 (EEST)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3 part 2] [MIPS] make the pcibios_max_latency variable static
Date:	Wed, 16 Jul 2008 11:01:49 +0300
Message-Id: <1216195309-13069-1-git-send-email-dmitri.vorobiev@movial.fi>
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1216141052-28005-2-git-send-email-dmitri.vorobiev@movial.fi>
References: <1216141052-28005-2-git-send-email-dmitri.vorobiev@movial.fi>
Return-Path: <dvorobye@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

Along with making the pcibios_max_latency variable static,
its declaration needs to be removed from the header file.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
---

Hi Ralf,

Forgot about this one yesterday, sorry.

Dmitri

 include/asm-mips/pci.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/asm-mips/pci.h b/include/asm-mips/pci.h
index d3be834..c205875 100644
--- a/include/asm-mips/pci.h
+++ b/include/asm-mips/pci.h
@@ -173,6 +173,5 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 }
 
 extern int pci_probe_only;
-extern unsigned int pcibios_max_latency;
 
 #endif /* _ASM_PCI_H */
-- 
1.5.6
