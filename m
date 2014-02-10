Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Feb 2014 02:12:53 +0100 (CET)
Received: from mailout2.samsung.com ([203.254.224.25]:20749 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822672AbaBJBMuCiMYV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Feb 2014 02:12:50 +0100
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0R000EQA139160@mailout2.samsung.com>; Mon,
 10 Feb 2014 10:12:39 +0900 (KST)
Received: from epcpsbgm2.samsung.com ( [203.254.230.49])
        by epcpsbgr5.samsung.com (EPCPMTA) with SMTP id F4.DD.14803.78728F25; Mon,
 10 Feb 2014 10:12:39 +0900 (KST)
X-AuditID: cbfee691-b7efc6d0000039d3-ea-52f827879770
Received: from epmmp2 ( [203.254.227.17])       by epcpsbgm2.samsung.com (EPCPMTA)
 with SMTP id 6D.96.28157.78728F25; Mon, 10 Feb 2014 10:12:39 +0900 (KST)
Received: from DOJG1HAN03 ([12.23.120.99])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0N0R00FXXA128L50@mmp2.samsung.com>; Mon,
 10 Feb 2014 10:12:38 +0900 (KST)
From:   Jingoo Han <jg1.han@samsung.com>
To:     'Ralf Baechle' <ralf@linux-mips.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        'Jingoo Han' <jg1.han@samsung.com>,
        'Lars-Peter Clausen' <lars@metafoo.de>
References: <003901cf25fc$73002790$590076b0$%han@samsung.com>
In-reply-to: <003901cf25fc$73002790$590076b0$%han@samsung.com>
Subject: [PATCH 4/7] MIPS: jz4740: don't select HAVE_PWM
Date:   Mon, 10 Feb 2014 10:12:38 +0900
Message-id: <003d01cf25fd$309c58a0$91d509e0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-index: Ac8l/GYGhOsBgXmsQoSPhLhnprg0iAAAIq5w
Content-language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsVy+t8zQ9129R9BBt+/S1hcXniJ1WLJ5Pms
        Fpd3zWGzmDB1ErvFpT0qDqweR1euZfJY8uYQq0ffllWMHp83yQWwRHHZpKTmZJalFunbJXBl
        dFycyl6wjrXi9tUelgbGtSxdjBwcEgImEqeeqHQxcgKZYhIX7q1n62Lk4hASWMYoMeHyIzaI
        hInEl3mXWSAS0xklei58har6xSix41cbK0gVm4CaxJcvh9lBbBEBDYmzB1vBipgFOhklFv/+
        BJYQErCVmNuwH8zmFLCTmLf0G1izsICFxIf7K8DWsQioSmy9+gUszgtUP+3WVhYIW1Dix+R7
        YDazgJbE+p3HmSBseYnNa94yQ7yjLvHory6IKSJgJPHltThEhYjEvhfvGEHOkRC4xC7x/fcq
        FohVAhLfJh+ChoSsxKYDzBAPS0ocXHGDZQKjxCwki2chWTwLyeJZSFYsYGRZxSiaWpBcUJyU
        XmSqV5yYW1yal66XnJ+7iRESnRN3MN4/YH2IMRlo/URmKdHkfGB055XEGxqbGVmYmpgaG5lb
        mpEmrCTOm/4oKUhIID2xJDU7NbUgtSi+qDQntfgQIxMHp1QDoynbsVUH/vH+PRvxWvfSPo0t
        f2Nq285+M/xbMCuGTebNrK/vXm7ImdeUrlGj4fvmUWDbrDVP9X/JPxHU1mS56LBdNM0jmN18
        7qpOgy5O48YpQvHifnK1p7efcHQsK9eeMr8ldsF6+6VtTb9W8fsxVRfOTTix/FUCa/vKWcv/
        mE6OT898U+H/RImlOCPRUIu5qDgRAMk23InkAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsVy+t9jQd129R9BBmvmi1pcXniJ1WLJ5Pms
        Fpd3zWGzmDB1ErvFpT0qDqweR1euZfJY8uYQq0ffllWMHp83yQWwRDUw2mSkJqakFimk5iXn
        p2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA7VVSKEvMKQUKBSQWFyvp22Ga
        EBripmsB0xih6xsSBNdjZIAGEtYxZnRcnMpesI614vbVHpYGxrUsXYycHBICJhJf5l2GssUk
        Ltxbz9bFyMUhJDCdUaLnwlco5xejxI5fbawgVWwCahJfvhxmB7FFBDQkzh5sBStiFuhklFj8
        +xNYQkjAVmJuw34wm1PATmLe0m9gzcICFhIf7q9gA7FZBFQltl79AhbnBaqfdmsrC4QtKPFj
        8j0wm1lAS2L9zuNMELa8xOY1b5m7GDmATlWXePRXF8QUETCS+PJaHKJCRGLfi3eMExiFZiEZ
        NAvJoFlIBs1C0rKAkWUVo2hqQXJBcVJ6rpFecWJucWleul5yfu4mRnD0P5PewbiqweIQowAH
        oxIP744/34OEWBPLiitzDzFKcDArifC+vAsU4k1JrKxKLcqPLyrNSS0+xJgM9OdEZinR5Hxg
        YsoriTc0NjEzsjQyszAyMTcnTVhJnPdgq3WgkEB6YklqdmpqQWoRzBYmDk6pBka2sklTb9w9
        rpX598nyti8TTujOKNnDbmXikPNE6VWbr3ZooZ/hTkHn6LbU4/mGM6S3x6a6xir9eeq2quqR
        1NS74d/FeqdrPTK/3X2Xgf3mNVv/XwcYH2V39iY9+SI2v5r7k13PrRUudRvbK/8eve7w8ZHF
        xG/NaxcUvD5mG1Z09adCiJdL5xolluKMREMt5qLiRAB00v/3QgMAAA==
DLP-Filter: Pass
X-MTR:  20000000000000000@CPGS
X-CFilter-Loop: Reflected
Return-Path: <jg1.han@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39261
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jg1.han@samsung.com
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

The HAVE_PWM symbol is only for legacy platforms that provide
the PWM API without using the generic framework. The jz4740
platform uses the generic PWM framework, after the commit "f6b8a57
pwm: Add Ingenic JZ4740 support".

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 arch/mips/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index dcae3a7..d132603 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -235,7 +235,6 @@ config MACH_JZ4740
 	select IRQ_CPU
 	select ARCH_REQUIRE_GPIOLIB
 	select SYS_HAS_EARLY_PRINTK
-	select HAVE_PWM
 	select HAVE_CLK
 	select GENERIC_IRQ_CHIP
 
-- 
1.7.10.4
