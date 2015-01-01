Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jan 2015 16:29:11 +0100 (CET)
Received: from mail-wi0-f181.google.com ([209.85.212.181]:36830 "EHLO
        mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006810AbbAAP3KfIsgM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Jan 2015 16:29:10 +0100
Received: by mail-wi0-f181.google.com with SMTP id r20so26775863wiv.2
        for <linux-mips@linux-mips.org>; Thu, 01 Jan 2015 07:29:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vs+kVXD4XsvCohGvljdm6/kQYNaltA7ikxqT463H5rQ=;
        b=kxP4YTETJpRtzIkp3JC7gdr5g+cDnRXRgnkdvkUErjQtLlQdJy2RZJwgyxHftab13Q
         cm5BPS9wzjRrRLhhblQt5USZYPkI552Emd2GupcSCiGk2taxKCGg+8O5mAu00suv5eo5
         gnEjR4qNKpAxx1TN8/fH7PdEQapPm65HZCCYncRln9TD+RpQcBfcKZlBAOGewWIiS2qA
         /y1rLpvqk8vV+M/xyxOl8vQp1KASHyqZWMsf8VxtqrnAvxkc+MO3RzmHP5YdFF+axcF6
         jwtAfWDlPRYPmfLavInh3P7HtUWrvbxqbwytXqbAnONDvLS3cc4tBlomGHcyP30q0E1C
         Clpg==
X-Gm-Message-State: ALoCoQnob2g+2dMZxBFMUa3MRI/JSKZX3V0iXKeS9KnCs06ftUmP7njz6Uw/Hp3Z5zaZpdZbqz3z
X-Received: by 10.194.77.73 with SMTP id q9mr116182879wjw.24.1420126145278;
        Thu, 01 Jan 2015 07:29:05 -0800 (PST)
Received: from localhost.localdomain (h-246-111.a218.priv.bahnhof.se. [85.24.246.111])
        by mx.google.com with ESMTPSA id pl1sm51004127wic.16.2015.01.01.07.29.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jan 2015 07:29:04 -0800 (PST)
From:   Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
        John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arch: mips: pci: pci-ip27.c:  Remove unused function
Date:   Thu,  1 Jan 2015 16:32:06 +0100
Message-Id: <1420126326-27198-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <rickard.strandqvist@spctrm.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rickard_strandqvist@spectrumdigital.se
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

Remove the function pci_enable_swapping() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/mips/pci/pci-ip27.c |   11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/mips/pci/pci-ip27.c b/arch/mips/pci/pci-ip27.c
index 0f09eaf..55e3332 100644
--- a/arch/mips/pci/pci-ip27.c
+++ b/arch/mips/pci/pci-ip27.c
@@ -200,17 +200,6 @@ static inline void pci_disable_swapping(struct pci_dev *dev)
 	bridge->b_widget.w_tflush;	/* Flush */
 }
 
-static inline void pci_enable_swapping(struct pci_dev *dev)
-{
-	struct bridge_controller *bc = BRIDGE_CONTROLLER(dev->bus);
-	bridge_t *bridge = bc->base;
-	int slot = PCI_SLOT(dev->devfn);
-
-	/* Turn on byte swapping */
-	bridge->b_device[slot].reg |= BRIDGE_DEV_SWAP_DIR;
-	bridge->b_widget.w_tflush;	/* Flush */
-}
-
 static void pci_fixup_ioc3(struct pci_dev *d)
 {
 	pci_disable_swapping(d);
-- 
1.7.10.4
