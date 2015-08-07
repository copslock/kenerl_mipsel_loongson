Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2015 10:00:36 +0200 (CEST)
Received: from mailout1.w1.samsung.com ([210.118.77.11]:21592 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011165AbbHGIAcbS4xz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Aug 2015 10:00:32 +0200
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NSP0024MCWPQD40@mailout1.w1.samsung.com>; Fri,
 07 Aug 2015 09:00:25 +0100 (BST)
X-AuditID: cbfec7f5-f794b6d000001495-d0-55c465994abc
Received: from eusync2.samsung.com ( [203.254.199.212])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id A3.09.05269.99564C55; Fri,
 7 Aug 2015 09:00:25 +0100 (BST)
Received: from AMDC1061.digital.local ([106.116.147.88])
 by eusync2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0NSP0013BCW67E10@eusync2.samsung.com>; Fri,
 07 Aug 2015 09:00:25 +0100 (BST)
From:   Andrzej Hajda <a.hajda@samsung.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 04/31] arch/mips/bcm47xx: use kmemdup rather than duplicating
 its implementation
Date:   Fri, 07 Aug 2015 09:59:10 +0200
Message-id: <1438934377-4922-5-git-send-email-a.hajda@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1438934377-4922-1-git-send-email-a.hajda@samsung.com>
References: <1438934377-4922-1-git-send-email-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOLMWRmVeSWpSXmKPExsVy+t/xK7ozU4+EGhzcwGdxa905VouNM9az
        Wlx5GWpxedccNosJUyexW6w9cpfd4tIeFYs1J1MdODx2zrrL7nH/6T5mj6Mr1zJ59G1Zxejx
        eZNcAGsUl01Kak5mWWqRvl0CV8bnt7fYCg6xV8ya0s/WwLiLrYuRk0NCwETi6KdWKFtM4sK9
        9UA2F4eQwFJGiZ4HOxkhnCYmiVt7bjCDVLEJaEr83XwTrENEIFFi68/VrCBFzAJvGSVWLrwN
        lhAWSJK4+3MuWAOLgKrE0779TCA2r4CTxKept1kg1slJnDw2mRXE5hRwlljZPRPMFgKqedN3
        gXkCI+8CRoZVjKKppckFxUnpuUZ6xYm5xaV56XrJ+bmbGCHB9XUH49JjVocYBTgYlXh4E/4d
        DhViTSwrrsw9xCjBwawkwvtQHyjEm5JYWZValB9fVJqTWnyIUZqDRUmcd+au9yFCAumJJanZ
        qakFqUUwWSYOTqkGxqkX/7z6ndxYl1c3P2ozW4uVuHx/1CTTgt6P28UPWuudWVd6VlFjfT4b
        Qza/UBL7Z9X0U/cWxhfsWtb5uSn58PXm7Mo91z2kmDgezTj4W/48g6Tt2Vc/rFgFOpjPcLVt
        O6WlzbM5b44Ns8a6J1zrvh/esv6Kx46vrNPNePOTWK5+eiTsLcHfpsRSnJFoqMVcVJwIAN7E
        xsEqAgAA
Return-Path: <a.hajda@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.hajda@samsung.com
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

The patch was generated using fixed coccinelle semantic patch
scripts/coccinelle/api/memdup.cocci [1].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2014320

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 arch/mips/bcm47xx/buttons.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/bcm47xx/buttons.c b/arch/mips/bcm47xx/buttons.c
index 08a4abf..52caa75 100644
--- a/arch/mips/bcm47xx/buttons.c
+++ b/arch/mips/bcm47xx/buttons.c
@@ -396,10 +396,9 @@ static int __init bcm47xx_buttons_copy(const struct gpio_keys_button *buttons,
 {
 	size_t size = nbuttons * sizeof(*buttons);
 
-	bcm47xx_button_pdata.buttons = kmalloc(size, GFP_KERNEL);
+	bcm47xx_button_pdata.buttons = kmemdup(buttons, size, GFP_KERNEL);
 	if (!bcm47xx_button_pdata.buttons)
 		return -ENOMEM;
-	memcpy(bcm47xx_button_pdata.buttons, buttons, size);
 	bcm47xx_button_pdata.nbuttons = nbuttons;
 
 	return 0;
-- 
1.9.1
