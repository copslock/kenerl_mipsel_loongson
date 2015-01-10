Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Jan 2015 03:35:51 +0100 (CET)
Received: from mail-oi0-f47.google.com ([209.85.218.47]:60293 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011116AbbAJCfhGFWm7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Jan 2015 03:35:37 +0100
Received: by mail-oi0-f47.google.com with SMTP id v63so14490990oia.6;
        Fri, 09 Jan 2015 18:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1j+43v7TjWiAbaalF0tC3wqSIp5qiU51nqZ2oBIU0ms=;
        b=keXJc0JcKvRodQ8rLQHaKcVSFB/Ty7uJc6YE2V/dVD37MH5YuQhsszdfOyTmVovK0Y
         EuIkFJAxuKbjfXFWL6AqW6gJ4aGmSVSCnPWIfDfA+O5Mm/EnTb7be1cjkGNUZBGBDhJf
         KVAo8BrbOyKdUy0MA3Xb0MK9sVjeNLhmOtCIJbXJLHWBAZPBd44x41rSGQz2aLY6+bcl
         KQUte3sOllItXTYFYjzM7w7Pd/nRKfm05zqD/VCNEw0FoCN2M/3ISnx5G7fLZOjD7ezu
         chYMW95gtP9ACVqr1BhXyL9fFxGhyKRWjLNmZ8klwtkD5YjDFBdruae+P9khbfzNHehX
         qFxQ==
X-Received: by 10.202.108.14 with SMTP id h14mr10737253oic.3.1420857330717;
        Fri, 09 Jan 2015 18:35:30 -0800 (PST)
Received: from rob-laptop.herring.priv (72-48-98-129.dyn.grandenetworks.net. [72.48.98.129])
        by mx.google.com with ESMTPSA id b192sm5326257oih.4.2015.01.09.18.35.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Jan 2015 18:35:29 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 02/16] mips: add struct pci_ops member names to initialization
Date:   Fri,  9 Jan 2015 20:34:36 -0600
Message-Id: <1420857290-8373-3-git-send-email-robh@kernel.org>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1420857290-8373-1-git-send-email-robh@kernel.org>
References: <1420857290-8373-1-git-send-email-robh@kernel.org>
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45049
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

Some instances of pci_ops initialization rely on the read/write members'
location in the struct. This is fragile and may break when adding new
members to the beginning of the struct.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/pci/pci-bcm1480.c |  4 ++--
 arch/mips/pci/pci-octeon.c  |  4 ++--
 arch/mips/pci/pcie-octeon.c | 12 ++++++------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/mips/pci/pci-bcm1480.c b/arch/mips/pci/pci-bcm1480.c
index 5ec2a7b..f2355e3 100644
--- a/arch/mips/pci/pci-bcm1480.c
+++ b/arch/mips/pci/pci-bcm1480.c
@@ -173,8 +173,8 @@ static int bcm1480_pcibios_write(struct pci_bus *bus, unsigned int devfn,
 }
 
 struct pci_ops bcm1480_pci_ops = {
-	bcm1480_pcibios_read,
-	bcm1480_pcibios_write,
+	.read = bcm1480_pcibios_read,
+	.write = bcm1480_pcibios_write,
 };
 
 static struct resource bcm1480_mem_resource = {
diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index d07e041..bedb72b 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -327,8 +327,8 @@ static int octeon_write_config(struct pci_bus *bus, unsigned int devfn,
 
 
 static struct pci_ops octeon_pci_ops = {
-	octeon_read_config,
-	octeon_write_config,
+	.read = octeon_read_config,
+	.write = octeon_write_config,
 };
 
 static struct resource octeon_pci_mem_resource = {
diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
index 5e36c33..eb4a17b 100644
--- a/arch/mips/pci/pcie-octeon.c
+++ b/arch/mips/pci/pcie-octeon.c
@@ -1792,8 +1792,8 @@ static int octeon_dummy_write_config(struct pci_bus *bus, unsigned int devfn,
 }
 
 static struct pci_ops octeon_pcie0_ops = {
-	octeon_pcie0_read_config,
-	octeon_pcie0_write_config,
+	.read = octeon_pcie0_read_config,
+	.write = octeon_pcie0_write_config,
 };
 
 static struct resource octeon_pcie0_mem_resource = {
@@ -1813,8 +1813,8 @@ static struct pci_controller octeon_pcie0_controller = {
 };
 
 static struct pci_ops octeon_pcie1_ops = {
-	octeon_pcie1_read_config,
-	octeon_pcie1_write_config,
+	.read = octeon_pcie1_read_config,
+	.write = octeon_pcie1_write_config,
 };
 
 static struct resource octeon_pcie1_mem_resource = {
@@ -1834,8 +1834,8 @@ static struct pci_controller octeon_pcie1_controller = {
 };
 
 static struct pci_ops octeon_dummy_ops = {
-	octeon_dummy_read_config,
-	octeon_dummy_write_config,
+	.read = octeon_dummy_read_config,
+	.write = octeon_dummy_write_config,
 };
 
 static struct resource octeon_dummy_mem_resource = {
-- 
2.1.0
