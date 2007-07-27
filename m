Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jul 2007 10:46:42 +0100 (BST)
Received: from sicnat3.emn.fr ([193.54.76.194]:6285 "EHLO ron.emn.fr")
	by ftp.linux-mips.org with ESMTP id S20022359AbXG0Jqj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 27 Jul 2007 10:46:39 +0100
Received: from scaneleve.eleve.emn.fr (IDENT:0@scaneleve.eleve.emn.fr [193.54.77.118])
          by ron.emn.fr (8.9.3/jtpda-5.3.1) with ESMTP id LAA22581
          ; Fri, 27 Jul 2007 11:44:42 +0200 (CEST)
Received: from ifs.emn.fr (ifs.emn.fr [193.54.76.100])
	by scaneleve.eleve.emn.fr (8.13.8/8.12.1) with ESMTP id l6R9imDD021030;
	Fri, 27 Jul 2007 11:44:48 +0200
Received: from localhost.localdomain (pad@dhcp82.rech18.emn.fr [192.168.18.82])
          by ifs.emn.fr (8.9.3/jtpda-5.1) with ESMTP id LAA17237
          ; Fri, 27 Jul 2007 11:45:01 +0200 (MEST)
Date:	Fri, 27 Jul 2007 11:45:00 +0200 (MEST)
Message-Id: <200707270945.LAA17237@ifs.emn.fr>
To:	kernel-janitors@vger.kernel.org
Subject: [PATCH 10/68] 0 -> NULL, for arch/mips
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org
From:	Yoann Padioleau <padator@wanadoo.fr>
X-Virus-Scanned: ClamAV 0.91.1/3779/Thu Jul 26 21:33:22 2007 on scaneleve.eleve.emn.fr
X-Virus-Status:	Clean
Return-Path: <padator@wanadoo.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: padator@wanadoo.fr
Precedence: bulk
X-list: linux-mips


When comparing a pointer, it's clearer to compare it to NULL than to 0.

Here is an excerpt of the semantic patch: 

@@
expression *E;
@@

  E ==
- 0
+ NULL

@@
expression *E;
@@

  E !=
- 0
+ NULL

Signed-off-by: Yoann Padioleau <padator@wanadoo.fr>
Cc: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Cc: akpm@linux-foundation.org
---

 ops-emma2rh.c |    2 +-
 ops-pnx8550.c |   12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/pci/ops-emma2rh.c b/arch/mips/pci/ops-emma2rh.c
index 38f1816..d31bfc6 100644
--- a/arch/mips/pci/ops-emma2rh.c
+++ b/arch/mips/pci/ops-emma2rh.c
@@ -45,7 +45,7 @@ static int check_args(struct pci_bus *bu
 	/* check if the bus is top-level */
 	if (bus->parent != NULL) {
 		*bus_num = bus->number;
-		db_assert(bus_num != 0);
+		db_assert(bus_num != NULL);
 	} else
 		*bus_num = 0;
 
diff --git a/arch/mips/pci/ops-pnx8550.c b/arch/mips/pci/ops-pnx8550.c
index f556b7a..d610646 100644
--- a/arch/mips/pci/ops-pnx8550.c
+++ b/arch/mips/pci/ops-pnx8550.c
@@ -117,7 +117,7 @@ read_config_byte(struct pci_bus *bus, un
 	unsigned int data = 0;
 	int err;
 
-	if (bus == 0)
+	if (bus == NULL)
 		return -1;
 
 	err = config_access(PCI_CMD_CONFIG_READ, bus, devfn, where, ~(1 << (where & 3)), &data);
@@ -145,7 +145,7 @@ read_config_word(struct pci_bus *bus, un
 	unsigned int data = 0;
 	int err;
 
-	if (bus == 0)
+	if (bus == NULL)
 		return -1;
 
 	if (where & 0x01)
@@ -168,7 +168,7 @@ static int
 read_config_dword(struct pci_bus *bus, unsigned int devfn, int where, u32 * val)
 {
 	int err;
-	if (bus == 0)
+	if (bus == NULL)
 		return -1;
 
 	if (where & 0x03)
@@ -185,7 +185,7 @@ write_config_byte(struct pci_bus *bus, u
 	unsigned int data = (unsigned int)val;
 	int err;
 
-	if (bus == 0)
+	if (bus == NULL)
 		return -1;
 
 	switch (where & 0x03) {
@@ -213,7 +213,7 @@ write_config_word(struct pci_bus *bus, u
 	unsigned int data = (unsigned int)val;
 	int err;
 
-	if (bus == 0)
+	if (bus == NULL)
 		return -1;
 
 	if (where & 0x01)
@@ -235,7 +235,7 @@ static int
 write_config_dword(struct pci_bus *bus, unsigned int devfn, int where, u32 val)
 {
 	int err;
-	if (bus == 0)
+	if (bus == NULL)
 		return -1;
 
 	if (where & 0x03)
