Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Nov 2017 00:56:16 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34138 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991258AbdKFXyRUVJwf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Nov 2017 00:54:17 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1eBrDV-0008Ty-Ke; Mon, 06 Nov 2017 23:54:09 +0000
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1eBrDT-000143-TY; Mon, 06 Nov 2017 23:54:07 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Atsushi Nemoto" <anemo@mba.ocn.ne.jp>,
        linux-mips@linux-mips.org, "Ralf Baechle" <ralf@linux-mips.org>,
        "Arnd Bergmann" <arnd@arndb.de>
Date:   Mon, 06 Nov 2017 23:03:02 +0000
Message-ID: <lsq.1510009382.155143478@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 283/294] MIPS: TXx9: Delete an unused variable in
 tx4927_pcibios_setup
In-Reply-To: <lsq.1510009377.526284287@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.50-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

commit 1bc2d3e38e5bf90af4e9d64e1696f2d39757355a upstream.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/7216/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/pci/ops-tx4927.c | 2 --
 1 file changed, 2 deletions(-)

--- a/arch/mips/pci/ops-tx4927.c
+++ b/arch/mips/pci/ops-tx4927.c
@@ -199,8 +199,6 @@ static struct {
 
 char *tx4927_pcibios_setup(char *str)
 {
-	unsigned long val;
-
 	if (!strncmp(str, "trdyto=", 7)) {
 		u8 val = 0;
 		if (kstrtou8(str + 7, 0, &val) == 0)
