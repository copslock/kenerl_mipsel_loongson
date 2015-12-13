Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Dec 2015 23:51:41 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:35447 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013502AbbLMWvjIlW29 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 13 Dec 2015 23:51:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=ymMl2NVuu6BOqDif52k51Zqo7WOE2AYRBEcJXLhpu2k=;
        b=HOyXB25I+oiSuylWhngCGRl1mcZtyGq+vof8AQOqK3W0J1004FbK+EsnM2IH6coJSiqBvUwG38EesTe1Iayf7Ev1BC7rIfxvHbBkBn6MNAzeFCurUrMHSd6VpBGso6fYWmQHVNqo147f0bvsvq6JHb6CEnWhhqvHQdgfSfOr0IXcO0YRvZaYfIVPitr/0e1NoA+XQ140GnABAYFS4mnYgVmR0qHAtXgj2WQpC4QluyEbx8YCUFPgacykP5weW5g4h4fIzPHPbs2f5EH5RxjbLvDUzQ597P+hHunxIZmIX2YZeNynxsw2RQqcHEU99/gbprtzuAkJ1Wg9nliu7qBAgg==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:44506 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a8FUQ-00046j-BX (Exim); Sun, 13 Dec 2015 22:51:38 +0000
Subject: [PATCH linux-next v4 09/11] mtd: bcm63xxpart: Null terminate and
 validate conversion of flash strings
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jogo@openwrt.org>
References: <566DF43B.5010400@simon.arlott.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>
From:   Simon Arlott <simon@fire.lp0.eu>
Message-ID: <566DF679.5040309@simon.arlott.org.uk>
Date:   Sun, 13 Dec 2015 22:51:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <566DF43B.5010400@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50581
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: simon@fire.lp0.eu
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

Strings read from flash could be missing null termination characters, or
not contain valid integers.

Null terminate the strings and check for errors when converting them to
integers.

Also validate that the addresses are at least BCM963XX_EXTENDED_SIZE
because this will be subtracted from them.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
v4: New patch.

 drivers/mtd/bcm63xxpart.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/bcm63xxpart.c b/drivers/mtd/bcm63xxpart.c
index eafbf52..41aa202 100644
--- a/drivers/mtd/bcm63xxpart.c
+++ b/drivers/mtd/bcm63xxpart.c
@@ -169,10 +169,39 @@ static int bcm63xx_parse_cfe_partitions(struct mtd_info *master,
 	/* Get the tag */
 	ret = bcm63xx_read_image_tag(master, "rootfs", cfelen, buf);
 	if (!ret) {
-		sscanf(buf->flash_image_start, "%u", &rootfsaddr);
-		sscanf(buf->kernel_address, "%u", &kerneladdr);
-		sscanf(buf->kernel_length, "%u", &kernellen);
-		sscanf(buf->total_length, "%u", &totallen);
+		STR_NULL_TERMINATE(buf->flash_image_start);
+		if (kstrtouint(buf->flash_image_start, 10, &rootfsaddr) ||
+				rootfsaddr < BCM963XX_EXTENDED_SIZE) {
+			pr_err("invalid rootfs address: %*ph\n",
+				sizeof(buf->flash_image_start),
+				buf->flash_image_start);
+			goto invalid_tag;
+		}
+
+		STR_NULL_TERMINATE(buf->kernel_address);
+		if (kstrtouint(buf->kernel_address, 10, &kerneladdr) ||
+				kerneladdr < BCM963XX_EXTENDED_SIZE) {
+			pr_err("invalid kernel address: %*ph\n",
+				sizeof(buf->kernel_address),
+				buf->kernel_address);
+			goto invalid_tag;
+		}
+
+		STR_NULL_TERMINATE(buf->kernel_length);
+		if (kstrtouint(buf->kernel_length, 10, &kernellen)) {
+			pr_err("invalid kernel length: %*ph\n",
+				sizeof(buf->kernel_length),
+				buf->kernel_length);
+			goto invalid_tag;
+		}
+
+		STR_NULL_TERMINATE(buf->total_length);
+		if (kstrtouint(buf->total_length, 10, &totallen)) {
+			pr_err("invalid total length: %*ph\n",
+				sizeof(buf->total_length),
+				buf->total_length);
+			goto invalid_tag;
+		}
 
 		kerneladdr = kerneladdr - BCM963XX_EXTENDED_SIZE;
 		rootfsaddr = rootfsaddr - BCM963XX_EXTENDED_SIZE;
@@ -188,6 +217,7 @@ static int bcm63xx_parse_cfe_partitions(struct mtd_info *master,
 			rootfslen = spareaddr - rootfsaddr;
 		}
 	} else if (ret > 0) {
+invalid_tag:
 		kernellen = 0;
 		rootfslen = 0;
 		rootfsaddr = 0;
-- 
2.1.4

-- 
Simon Arlott
