Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Dec 2015 23:48:48 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:35377 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013568AbbLMWsq4-Eb9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 13 Dec 2015 23:48:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=siQmuM3eHbRzCulytnp1hHpTAt5xygjNxTBLBl5KsdM=;
        b=D/SduZquoRVCIIT9mDpo3IQc7xvz7HzlcT0PbHaabOvidn3rNb0311MDzh+n4RgxVyB4cSHJIPt4W5SoMpFVNit1zFYqtP+QNnTwuaLqvLZbBZiP68HvcfXxOcX+OyXa8FQPnDAHRSrtCHWCP2BeVNvX6orZVXhd7VpBm4q+Z0+MjjWSQbFvMMROMpYyGRFuu1/wSzaRQYwrq/91WQfwjTrPCjwb/tbNjUVPSz2HVEQHk/TizT7HEPGnyyF6iyDDUcfkldvYHP/53Hj2bZlttmKO+lcHZS485DTTPpfz+C5Cay3rLwzbTNNNUO8aiZrVI4TKwedWbI2JP1aDpuD+Hg==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:44499 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a8FRd-0003xH-F6 (Exim); Sun, 13 Dec 2015 22:48:46 +0000
Subject: [PATCH linux-next v4 05/11] MIPS: bcm963xx: Update bcm_tag field
 image_sequence
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
Message-ID: <566DF5CC.20908@simon.arlott.org.uk>
Date:   Sun, 13 Dec 2015 22:48:44 +0000
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
X-archive-position: 50577
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

The "dual_image" and "inactive_flag" fields should be merged into a single
"image_sequence" field.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
v4: New patch.

 include/linux/bcm963xx_tag.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/bcm963xx_tag.h b/include/linux/bcm963xx_tag.h
index 08e0133..161c7b3 100644
--- a/include/linux/bcm963xx_tag.h
+++ b/include/linux/bcm963xx_tag.h
@@ -12,8 +12,7 @@
 #define CHIPID_LEN		6	/* Chip Id Length */
 #define IMAGE_LEN		10	/* Length of Length Field */
 #define ADDRESS_LEN		12	/* Length of Address field */
-#define DUALFLAG_LEN		2	/* Dual Image flag Length */
-#define INACTIVEFLAG_LEN	2	/* Inactie Flag Length */
+#define IMAGE_SEQUENCE_LEN	4	/* Image sequence Length */
 #define RSASIG_LEN		20	/* Length of RSA Signature in tag */
 #define TAGINFO1_LEN		30	/* Length of vendor information field1 in tag */
 #define FLASHLAYOUTVER_LEN	4	/* Length of Flash Layout Version String tag */
@@ -72,10 +71,10 @@ struct bcm_tag {
 	char kernel_address[ADDRESS_LEN];
 	/* 128-137: Size of kernel */
 	char kernel_length[IMAGE_LEN];
-	/* 138-139: Unused at the moment */
-	char dual_image[DUALFLAG_LEN];
-	/* 140-141: Unused at the moment */
-	char inactive_flag[INACTIVEFLAG_LEN];
+	/* 138-141: Image sequence number
+	 * (to be incremented when flashed with a new image)
+	 */
+	char image_sequence[IMAGE_SEQUENCE_LEN];
 	/* 142-161: RSA Signature (not used; some vendors may use this) */
 	char rsa_signature[RSASIG_LEN];
 	/* 162-191: Compilation and related information (not used in OpenWrt) */
-- 
2.1.4

-- 
Simon Arlott
