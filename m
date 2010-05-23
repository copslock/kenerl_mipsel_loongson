Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 May 2010 21:56:12 +0200 (CEST)
Received: from fg-out-1718.google.com ([72.14.220.154]:49186 "EHLO
        fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491968Ab0EWTwb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 May 2010 21:52:31 +0200
Received: by fg-out-1718.google.com with SMTP id 16so812537fgg.6
        for <multiple recipients>; Sun, 23 May 2010 12:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=KllbWyKQZVom0cbrCwGFv+BavmhILqbP3OBYTyXI32U=;
        b=BjFG+a7gvbLSA9wEqMP4sor8YRXjsnDeKuu/1fRefQ0eNjS6uf75rOq2oNcrzpC0cw
         r9uFg2LyYrQFvJ/3HofKr7km/4HQRaK7f/WpMWfUMKCn4jisYnyGipYhp0Fzs/liNphX
         9JsfWdDl2Tt1Ho+DVJ0eiAgxEMWkc5w6NWBuA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=PWv2eqxdJrvcVQ4zIzOu6a9OIF41/MZDb07gh2EvBC4JPkrtPCmvZW5NB96v1Bxyve
         R3IfQ4zxuMQQAOJqkQZFQ0uyNwkhLJKMGrcTzHKprbEyKMeXbSGKtrEW1mLLCewM6K1i
         1qt2RAHaCRY/lbXRFac5BNgLNzJDLzhxS71Vc=
Received: by 10.87.50.37 with SMTP id c37mr7158107fgk.68.1274644351322;
        Sun, 23 May 2010 12:52:31 -0700 (PDT)
Received: from localhost.localdomain (net-93-145-200-9.t2.dsl.vodafone.it [93.145.200.9])
        by mx.google.com with ESMTPS id d6sm6081796fga.3.2010.05.23.12.52.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 12:52:30 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     Ralf Baechle <ralf@linux-mips.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux-foundation.org>,
        linux-mips@linux-mips.org
Subject: [PATCH 170/199] arch/mips/pci/ops-titan-ht.c: Checkpatch cleanup
Date:   Sun, 23 May 2010 21:52:11 +0200
Message-Id: <1274644332-23964-10-git-send-email-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 1.7.1.251.gf80a2
In-Reply-To: <1274644332-23964-1-git-send-email-andrea.gelmini@gelma.net>
References: <1274644332-23964-1-git-send-email-andrea.gelmini@gelma.net>
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26816
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrea.gelmini@gelma.net
Precedence: bulk
X-list: linux-mips

arch/mips/pci/ops-titan-ht.c:36: ERROR: "foo * bar" should be "foo *bar"
arch/mips/pci/ops-titan-ht.c:68: ERROR: "foo * bar" should be "foo *bar"

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/mips/pci/ops-titan-ht.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pci/ops-titan-ht.c b/arch/mips/pci/ops-titan-ht.c
index 46c636c..924e45e 100644
--- a/arch/mips/pci/ops-titan-ht.c
+++ b/arch/mips/pci/ops-titan-ht.c
@@ -33,7 +33,7 @@
 #include <asm/titan_dep.h>
 
 static int titan_ht_config_read_dword(struct pci_bus *bus, unsigned int devfn,
-	int offset, u32 * val)
+	int offset, u32 *val)
 {
 	volatile uint32_t address;
 	int busno;
@@ -65,7 +65,7 @@ static int titan_ht_config_read_dword(struct pci_bus *bus, unsigned int devfn,
 }
 
 static int titan_ht_config_read(struct pci_bus *bus, unsigned int devfn,
-	int offset, int size, u32 * val)
+	int offset, int size, u32 *val)
 {
 	uint32_t dword;
 
-- 
1.7.1.251.gf80a2
