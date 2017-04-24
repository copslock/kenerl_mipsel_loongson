Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Apr 2017 20:45:20 +0200 (CEST)
Received: from mail-by2nam03on0086.outbound.protection.outlook.com ([104.47.42.86]:64592
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993907AbdDXSo3iB2Vm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Apr 2017 20:44:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Mfua8lLlEZucrhx7JmpXg2HO1ZM8DAM8Wb/H0liMCN8=;
 b=nE3qHYwWw4CRUirzg8I3qQeMiMliQawc1dNmASRff6znmF0Yb0xiJYQ2s39IRuflazQg5pqHj6m5QzvmEO7hAErmFyphRLpDp6TWmLxvlvdmZ68OghbOX+iMCG/d9AVj0SEemLcc+2CFCceyghSnsZSU+gpqm/FPbUwgC4dBJYM=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=cavium.com;
Received: from black.inter.net (50.82.184.123) by
 CY4PR07MB3206.namprd07.prod.outlook.com (10.172.115.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1047.13; Mon, 24 Apr 2017 18:44:15 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     David Daney <david.daney@cavium.com>,
        Jan Glauber <jglauber@cavium.com>, linux-mmc@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] mmc: core: Export API to allow hosts to get the card address
Date:   Mon, 24 Apr 2017 13:41:55 -0500
Message-Id: <1493059318-767-2-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1493059318-767-1-git-send-email-steven.hill@cavium.com>
References: <1493059318-767-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.82.184.123]
X-ClientProxiedBy: BY2PR07CA044.namprd07.prod.outlook.com (10.141.251.19) To
 CY4PR07MB3206.namprd07.prod.outlook.com (10.172.115.148)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72acd3e7-104c-4dfe-6591-08d48b41e927
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:CY4PR07MB3206;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;3:BPTlSIM7MmyBDcWA0jWHsAtGW3Mckp5v7lfeN/1aLoTDtvuAW/Lr2FzsgyxTdwx5S2Vgpd+nPOriUk+UK2rxUfsu8yvghrrlWZqhhPFrJZ0lngE9NYv4DErn9c0Yr2CrqHiBCvJKry2oIpt3kFOOJHPF8WMxgY/VDHitqDAjoQPyzoi8YplvZ6wYEQZgD/PgJ38rDEKZXZESNFeh4JO/MUWdjW7ijMd9dYUaqFKVrR6oVVY2tklf2dBluokC1jTQKrHQKz2mb8MIqOBEl/InnoxQ0JklKHZcZfTMygYFRO2Z/1/hhnoay6giNCAT9jkc8qyvP6Kvaifuk1+Ygae6JA==;25:q4O84DUmR2qGt9ccfxw3j13ZV0x2m04RTaRlYwJXJWvDdIjf8X/94tU6bQ5/Pv4TCJEf9VFV1IDCIC1QmubE8Q7aAnEK5S7bsbzY535Rt9OfmBv6lRM0VMoRCrJoux+lmZXFMYHZv0RqrJQhNx5djJPTn/UJPMFAv69WsQErkLxgZx+7FlosuCcpeMvvRJ3dq83EQSroIeV5Im08ZY4qYzYK4LX1s2zR9cO845PRqARSSy6GZPgqiJaqnxapYvidodJCPJiQQMwfqXUqR27OFGNQIH23CZ2of7bDmaWdy3M0dIod0l0tu/FceOPB1XtdhbdNrudvb/t6u+rSEj2mTVbHl2591ZbTCbGo6cAroEEeI5iSnb6VCgifN1hmkdQ462+U+8K81ng6DpgMEbe0HNWlhwb6rcHRky4JMV7a2n0DLfQZzQR9xVXmkqONUPs9tX5vmeS1KQWo61a6Jv7cKQ==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;31:ymu6cOPqVrxu7C+6bZ89Uhs9Ls1h5dHE+97LlyOrkC6oK5kJPttV5NLtlo9I9PuVv5CCW+X4+nTMKHLwHEx9I9CWCjzHhWNwzkmoMIH5DNQME8hvszBQcfo5H307PP6N5fk9yzJ9f+8wWwsgu9plKnxKHM/SrA3Qg/UNyHROrsxWfEYEeHJjLcoZ3IYa4WPuwomxnwkJVck230F5i68D8ZscolhcQvNM5Sb4aqEyze3pEROo++wFcHiD8Bm5KC9J;20:fb26m+e0123daQFlV1BQzvbkbAiP3lwzZar4Cc5S4zHV80Y7k0Bf5TtZAq+y8MmHScuA9EFQcBU0XYwhC6Ti9NPiN0CIjauK/EKHiC90Abb9piaF54MYzgyGcF0qSbtZ4MjLH/tFsa+G05aCD2kSfXVX/mYRHMpYU7+eKN2nQp91x4nbKzL5g4KWKj+hs5F6r+NCSO61SqXklrctk6SSI6Qa79ItSL/THi8lJccD9UfAnVnRwbHOuh+0E2tFnNZuWAPW7cgfHHCh73YbKxqJ7AnJaEhz2nXWopCbaM7ZppHPy2zfl41Ha/Qjpx4xAFLVEZPNUI+6bnucEfK5gx66bBY7Tn+7Ewb8GG76YkeD5TelgCR6Bfheh5wYjPjH7Q5LBQVVnk6ZaPXlG7cX2eA9ylQMBJhD2FeHuCrEzdUhKqzcCm7XdF+00EWZ/bIw14S/zjfZNaBNhaH23bL6bNGTNJGjdZUL45pMZG5uacFNv/osxMfKgkn6UbzuPLKoOq2y
X-Microsoft-Antispam-PRVS: <CY4PR07MB3206650B381609DD19CB40F4801F0@CY4PR07MB3206.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(601004)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(6041248)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(20161123560025)(20161123555025)(20161123564025)(6072148);SRVR:CY4PR07MB3206;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3206;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;4:R+UkimknPb0xWpndt+aWnuTouYL9dGV1pyZA84xCNm5g7JFTj8wHBodMniBeNobxEUzs/y3UbWzvdkCeOy0lUADj3SsSKck2XAfI2M6C6zoC4MdLdaNl+eh/Td1gMqLNYncMOnqUZPu/bMt9m1gd00KKTiNzgp1uxNbcJAqChULLy+h651sXuGx2KC5lp7hWl5x3r7c/W92PpTnGly2irbNUFNNEpqrWpFUf2Cp/an5jJgtPWZCiabrVn9V/6O6YGkTrPMezFV6Azn+NTVfNPO4Z4DjTRKawKlDk0ZfizbOKoO4Q0cjDxmrnhC+IbLSVGTLh2MWbXo/Hn74VNmHwt69rjtDoZlMSgIyOQ4blC3CKy3DOpiYaq19PAPfm5ZXSH/s8B6rc+KkgVfctnGPaf4CbGx7JH05PW8lUI+YQe749Ttcsh9AmXSk1mLpdkT8X6FsUAY4c5QU8HCHr83Z9+7f17K8nm9O7INGU2GHVS9Bg0v1QJUcBe2RZTdW8oSnRdsxbVGbBoJcbbP1OavCcpCC+sZjIhfwSp9IzaCHsgWPLCm0s4wWATCNOsGwicOVfSt+bw/81kExU2U/hV8ddamopTfhWcpb/Cg7qmIotyZdG+5aDy0SP7vWvaKLuas1bY/yxxyPVdk3PE5C6UuNZt6mLpNBeBaLiUH6nTtLJzEYZgAo0kJLRUIUx+12F3Of+ps8w4vGDkRmuuU9kh6lxFRMnJ66NshftYoRlVSwUpBU=
X-Forefront-PRVS: 0287BBA78D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39850400002)(39410400002)(39450400003)(39840400002)(39400400002)(4326008)(110136004)(6116002)(54906002)(2906002)(50986999)(3846002)(6486002)(6506006)(76176999)(189998001)(53416004)(50466002)(66066001)(47776003)(38730400002)(48376002)(42186005)(25786009)(305945005)(575784001)(5003940100001)(50226002)(7736002)(81166006)(8676002)(5660300001)(6916009)(86362001)(36756003)(53936002)(6512007)(6666003)(33646002)(2950100002)(15583001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3206;H:black.inter.net;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3206;23:C5GXkpnctA2dr4+drsd3rI+cbB29IIl0a0rbR2Dwo?=
 =?us-ascii?Q?i2KdYYhbGwKqB/r9vFzzrlkLuAtFK2oTWv9/igQlg/mwYH6pYVZADVoEtW4F?=
 =?us-ascii?Q?dDSq/yvmPyTyKKn4LZFyCBiGQZE+2cKDOmio5LocxWVOVhZgugOrobVaXbRP?=
 =?us-ascii?Q?nuFglf+wKYMNrM066LC65bM5qHnlCrNha3BD4VXWl5iYr7gERZbHHdAe34fh?=
 =?us-ascii?Q?AdkM3p0vjsTntMT/5faKeY/HWwe+RDx2A4VDy3Evuow3vx3DgatxpVj7zty+?=
 =?us-ascii?Q?uzImwJuz/+LmHjEnY0Q2XwTsuqZOvAKbWs4r88pPHWW/eVsgPkcwCmBeUbMJ?=
 =?us-ascii?Q?33DFlTOHluNI8U5W12uV6EFhlO9NgjItRrw215CQGM/V8IooC9tzr7nkNtyy?=
 =?us-ascii?Q?ZWFsH55lSP1f0d1GPg2LjhaYpMFFg/7NWLzwZxqY4/GN8k1Cz9JZDcX0sQmq?=
 =?us-ascii?Q?dszvqwGqXoMgxkGoBGQV5kjYGj6X9CuyqqYv0Lv4lDCrRqPvgZOmAKRFursL?=
 =?us-ascii?Q?se+7dHutXW0ZL9LIGRGCGMwmbuZdI7nMWC21V/vQ0hYSmZ8UFx3PBhFkiqu9?=
 =?us-ascii?Q?bvGvGtYTMvPbhzpqlM4vy2vZ3TpYZj6iBb53Mgu6FZvB7arX4/3xE8GYPdxb?=
 =?us-ascii?Q?Voa8HsHl1DGAhGwX8DbhDXmV37zBf00+jgeUUMqH5MP44jTwWZjNoFxUGtWu?=
 =?us-ascii?Q?MrVwUg9vAwtx/qIOfTaH9DpmZ472DtTu7abnJn5GYmgTxiqVtyZ8DzVMf+Fl?=
 =?us-ascii?Q?gP5/OnxmT/bj1ntXjCeZ2OB7VBJ0HX+OMqI3bFoOb2se/Xjxit11BWi/ViRo?=
 =?us-ascii?Q?zfRCNEEojl3Jz6ovPQkOYh1clOxnzZqiO/d5FF3cR3OgiiMExw1CxU0P27oE?=
 =?us-ascii?Q?jffzREehUX7wy+Ggf32FF2m7W6j4vhG3cb4uKuq3QxIkUq6XBJRMpfr+5xMv?=
 =?us-ascii?Q?hAL25NpuOWY39LcMCyjiAdwqerAuN4SzEADAoH/cmVfoJLa2KHmxtdb1qQNB?=
 =?us-ascii?Q?ltHXK5OpnUvZFgNUYh9EdByEHLiCttK+oZZ1EFmoc/4F1UynUBeHPBSN+Dzu?=
 =?us-ascii?Q?2XprgBPH6bDay1I7woJRjwueHEbtyQPO94LBZ8ADLMsoRF5Yg=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;6:Uxlz7AXSB+RLnFzRwi4qrCF7hSf88Ge5y7Zvrk6pXm+ZGbJz7VKlic6LU2/h4IW6Y8KkVTn1MaZ164bY8fkPGiG7ewAxHyx8vkUs9UKXkAbXIQBsoYrMFAgIT2f7e+Omnt6pkQQR1F7JZxrLRtyxWZS1+DaQc5r33sOeO9mABIjAWLLUiCACmTK7eVQ7N3/xRUMo69mLYsiFFXQotrzxycvCp7Nqatmy3TaX9EfulGElNfSlM/A7JfO/of8L0IYC0Unod9QfWeQc4cGSWGp9Zj6OoTdyYcKHpKmMacSNnznhEAIJgW5+wN5fze9bFHa2DVDx0ou9bd1BnuEtXfI1LSqpWPKkxldMFSn7OA2RAsY03idZsi/a63Bwjtm3hjoU7N6FevLXOLowViKRx62av2YEo+wV2BWzLN38TtKWCVkciL5QrslkYpVyZdFlGG4Pw4C4VmV4B8zNb0NR75B8s+WpO6NeMLhurkXwL/EqhE6mMaNgzEVXde4ZwTN8T/l9FA5r7QtTunc2qul1bDn6IQ==;5:nc4p1wMaok57+h0+jwL6kMDMXpiT4+WdN8VXqSvymDyNKBoFaZjN5RjDMCBkzCgwfavcokq5F9rBg/4rkpKz5kT7gwB+/EmI8ELPmIPTbcJQ7YZTHzB0EPRL2KpsTYfmlE8c5RWQTjadSzN8LbC0p9bhYSnh3WLGOLE1OFJeTGk=;24:3w1ZCcxUlTcFqwl3NAbRkGSUF0pMzXv0s7Yp1DYVH1XEL1eI6kNsqn9tQT7e5CIy02HMN3NH+RH6puFdjvYONce47iLi/9GmfQqnPq4Vv/o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;7:octj7cppIwX6R1EJJC10yuFjtH1Bv36AhHG8s3O3RJslJYybykXvFqNfyjMM+XYAYM8Q4zj3Lhw2toyiGZo8cTnFqymjHvXHMC7tf8bQPeEOzks+EzCUbIVHx5GBoX9WJ6zqqqfvSpqPu5E2DvfF0tKJkr8ilZ6niFNsY6MYNHRKGxWi6InK9caEFzGgtDfzQ81jEWb36AwJ5wKIES8X/gdKhqVK3YuiaqQhwNiBsaqFNPEF1qlrVwuTGyheDoUvjvgrGDxXJZtxaSJPxqbvPfA4QjJWclKbGok782zKRM8qlp/B92hx6cy134hMUG+krwCP3gtSy8Jey81Qe57a8g==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2017 18:44:15.8593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3206
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57773
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: steven.hill@cavium.com
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

From: Ulf Hansson <ulf.hansson@linaro.org>

Some hosts controllers, like Cavium, needs to know whether the card
operates in byte- or block-address mode. Therefore export a new API,
mmc_card_is_blockaddr(), which provides this information.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 drivers/mmc/core/core.c  | 6 ++++++
 include/linux/mmc/card.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 926e0fd..f9fae34 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2555,6 +2555,12 @@ unsigned int mmc_calc_max_discard(struct mmc_card *card)
 }
 EXPORT_SYMBOL(mmc_calc_max_discard);
 
+bool mmc_card_is_blockaddr(struct mmc_card *card)
+{
+       return card ? mmc_card_blockaddr(card) : false;
+}
+EXPORT_SYMBOL(mmc_card_is_blockaddr);
+
 int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen)
 {
 	struct mmc_command cmd = {};
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 77e61e0..4cd9450 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -307,6 +307,8 @@ static inline bool mmc_large_sector(struct mmc_card *card)
 	return card->ext_csd.data_sector_size == 4096;
 }
 
+bool mmc_card_is_blockaddr(struct mmc_card *card);
+
 #define mmc_card_mmc(c)		((c)->type == MMC_TYPE_MMC)
 #define mmc_card_sd(c)		((c)->type == MMC_TYPE_SD)
 #define mmc_card_sdio(c)	((c)->type == MMC_TYPE_SDIO)
-- 
2.1.4
