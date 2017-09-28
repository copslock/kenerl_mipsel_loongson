Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Sep 2017 19:42:59 +0200 (CEST)
Received: from mail-bl2nam02on0060.outbound.protection.outlook.com ([104.47.38.60]:31924
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992378AbdI1RjLaG4fF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Sep 2017 19:39:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=7ahVtwI66NnF23ND/I/jpJDDkY3ooquWjGbCbOsQiCE=;
 b=P2t7Z/yanU3vqHWaUuLVVaIV34cpvfOiHGDZ3APR9dZv5WKTwfn+0GhD+P+WzyxL+lEu6apMLcQ7rjJSDQsktOXT8l8rDZJi4aCe8GBbl/NzQdevyNq9oL1FLXwAUKcCejBB4V64K/X0fKGVUn7qwyMJunsRPSNqySZmuwWhzeE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 SN4PR0701MB3807.namprd07.prod.outlook.com (2603:10b6:803:4e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.77.7; Thu, 28 Sep
 2017 17:38:57 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH v2 01/12] MIPS: Add nudges to writes for bit unlocks.
Date:   Thu, 28 Sep 2017 12:34:02 -0500
Message-Id: <1506620053-2557-2-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1506620053-2557-1-git-send-email-steven.hill@cavium.com>
References: <1506620053-2557-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: CY1PR07CA0024.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::34) To SN4PR0701MB3807.namprd07.prod.outlook.com
 (2603:10b6:803:4e::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de7a49b2-6936-4400-6496-08d50697cbee
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:SN4PR0701MB3807;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;3:t3jAMPz3NHULpRZucOou6LDT8lXw/4RjnBg9GKH0nhqP/NXobNtQOfmhNV4P1rfpKmAF3GMi8R+X5HtEDAaElSaw2hxOGYg8qczAkc+pt+SqrkIlsrHqQzGTvBxxK3pchqPGqsVRnGQsapGqqdUWfD2bNA+ELmGpKMfiQ+glm7jviisacmPp61iQVf6HIayKtuDt0B5WxHUcpPhfzU9TK1IAfrBEmjUiwSxkPigZJTxB5eHrLL6W5zmFWTqHInRI;25:8AZqxMDnPKD/RQ39oyeUEjliafVHH9aHS/u8D2sn3RwlVc6vsXhoDNwSCub8Ldgw4Mm0qu+kSmwPAjP7VNI1shU/hMFqPaQNGZlkYYppZQgzHsxZEmZZKBavP6e8Jk8jp3YdBkRoXYCNGPI4vIwdViKmfXn36HEiWgQ0om4NWJIMUOzIAGf/0KGjfhvzLQviYuVrfgeqB1O7SPzejTD2qHuB6e1rhGEmAzhXa2H6NVig1pPSRYbtsG8wLlUEjtCTbQagaGyeU1ZnxYH6SA30KSDLWxGArR32bV5fNheAQEBlS9G2Yrw8bnWUT4rVbSjtXuWdvr0G1HW7JyFwlNCvUg==;31:pCSzPLndE6zUilDmnubwDuD+xRaLF9FiZRMs29WEBYFh1vQwt2Jg3eZSskvvSEqD7fB5TV+p3Xf/MJ3KGjEBnv6V03Y3Th7/rty+WI+S1e9EOv61ckaAsiDeywfXJt2si1ezPkUnnrSF4+sPa1uzttydWqrghQaF1o5QHQKSlrXbZWri+XPOATOn2pDlYTqRNpkXrdIPlkBreBgUO3BVaZn5PhSF7R+ZDWier4eavBQ=
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3807:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;20:aG/s2BWM8WZITQJwVydqy5K5nrHSCOWTdtV8zFM6I7KYkGczZXHY6SfmsU+2VKtpUD3SzZYbazgXxyUn45VV3qxcWIum5vpGnZSKIUMuA7wIm/WR7Rp3VB3I049mhysK10bIMQEBl+J+CeNV4WId/KwwUS5HieS5MCugkaRxeLC5O6SRThVlE+yCBOIIkKK0xVhZPBoHDmrikTOMcORMfTDYM/IRJXlAH8YQAxpDhKOVKL12KxFOYq63OZzWILZrosJx6FfQTL2FEJlTNuo//oPy+LBLtm0pg89EFxfJLjw0KqniFfPgbUhMsAhXTtumJnPQDSCDkK+aBjiZ+CI0onb7DzXGTF2G88ER4CZ4hN0E4fhPTqvv+/DeLBcR/jTXDN/+AvXkdDhrQmfKfQvTCeRfzWAPC/uoK9r0TvrXxVu7623rIiYUoAEATJzsDabyUGqDSx12crwWm/nBLF+K2h8SIbAHnj4me7a0fN8yBCpwEw7q95M+31cT+D7f5Z7p;4:YJlF5XE7d/p2glb0+V8QaLZCA5vK7AFKOKqJxkCnllPmG6FQMEt6+H5SVnOzB2C/u3hM3oK5xs9kgyf9VPfjQGo/YNszfKF5FOIK6ViWUjXoqKnnX7cyn/8zcUbaAGTQhffKQairuioVKVoQVMXXESgsgJ8LQw3Wq+BJ1I/svrS3K7T44q5+9Jx1Jw9+BupkMCcSv0aH1EK2HseCThdiaVxzkkKiiFqykjbFSA7sh0cU++6U/ECXtGNdDT8BD1hu
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <SN4PR0701MB3807A7DB7D23D63FB10A5C5980790@SN4PR0701MB3807.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(93006095)(93001095)(3002001)(10201501046)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123558100)(20161123555025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR0701MB3807;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR0701MB3807;
X-Forefront-PRVS: 0444EB1997
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(76176999)(53416004)(6512007)(50986999)(189998001)(2361001)(68736007)(6116002)(5003940100001)(101416001)(3846002)(86362001)(2906002)(36756003)(53936002)(33646002)(106356001)(50226002)(2351001)(6506006)(105586002)(6666003)(50466002)(316002)(2950100002)(6916009)(16526017)(25786009)(16586007)(66066001)(47776003)(305945005)(6486002)(478600001)(97736004)(48376002)(7736002)(4326008)(81166006)(5660300001)(72206003)(69596002)(8936002)(8676002)(81156014)(450100002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0701MB3807;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN4PR0701MB3807;23:rw5laWwuxOAjo7EmHHK8QMU5wLfCLGHH3BF2vrX?=
 =?us-ascii?Q?HbHkUrNIfBviAKoQNMFUyry1Z3X/6illD1kfhnMH9SpNBeonN+B4GS5ct0Wg?=
 =?us-ascii?Q?ULUiYLQcGJhInAT1nVJMJyUWLi8jkeVjHxLFtEfjucn3sZUE5qmg0Xwes91s?=
 =?us-ascii?Q?RouwPzEbnRYUY9zJcRSue0Ha84fcptlImAQ18InU6tlCiYG0sgy46xkJjnVr?=
 =?us-ascii?Q?SytZindNwNmnkbW9QuUrp8qaf/Ge26O3c/AYza5bLzfxzv5TwvsS/DsphbuU?=
 =?us-ascii?Q?Yed12lKcONPNF97MwLX+AvXs4bjIf0z09ooGN6kp1DWr5sHmV+baOboKEO/N?=
 =?us-ascii?Q?fYGo3/isxRMhpnrsaensWlB5KmEXd4AjkHP0GjnMbnU7BWoWJ+vXK1o4nN0R?=
 =?us-ascii?Q?oSY+gVopvwdttjlnsLccZ0tuo1WNaiQRUq2/EWkvhgSmmboPeG+sw71F0U9O?=
 =?us-ascii?Q?5AR3V7Zm3wez9UzbYOYMnVS4XLpHdwpSgPneLc58lFaf+AkoqRvSFbtagcGv?=
 =?us-ascii?Q?PYfWHrEbqu27XurauSybgsaSrcRGMEEDj4Y+fHISVe7CshAWNCC7vFj8iztc?=
 =?us-ascii?Q?jBbYwPz9jRsdyzaP8AsQ/Ql60GeGLAuyWdrf08F9dJ+0RcKMH7xDaNNiPvjj?=
 =?us-ascii?Q?erhyF6GKhJMKuFpqX8MOw6G9EyoiPdl5wZGbCZwQF3jda6tDMf0ktXO6Fpjz?=
 =?us-ascii?Q?tyOJ4/RaEP3gSCeSS1OYPRhm7cnVyG+gS/DZ4J5pw6DGTxZr+pQqZKdU6tXu?=
 =?us-ascii?Q?+TH6tOwU1FQmUmBuVc26YLtLt1zL2tYgL8mW7ax5kc5gX8NmYDRbAhcg8uJp?=
 =?us-ascii?Q?0nckaE9yO+7McoD76H0EWQU1QTpKQCD+LRPbzCbTskZlREuu05fjiCEjxD+E?=
 =?us-ascii?Q?0Ns9PqX/skrjpOOy4MB24OZClJsUXV+pWIGIIFNYFABFNoNBeVNNRywFypNI?=
 =?us-ascii?Q?S8FuFTPzNtIe0orycw3sCiQEbw9J4PPL5eeSQ3jGPqxS/O+5mNvEUku5DeHd?=
 =?us-ascii?Q?631DJKEjTKXpFVYweMnpxLNvyIr7DnPJ7g6nftXtwx+fn992XinsEBh0llX9?=
 =?us-ascii?Q?jDELpn8lRs3HXtjOxFpOUNNcTLvQYn9DCCgkS1gGBJDh4pT4dObk8x5Nkyaw?=
 =?us-ascii?Q?GbMCyVc98c+/lPz1WvyodkKjAO9zA3m2w583OXCvqcOkiy3B0MrLP4F06Ox2?=
 =?us-ascii?Q?Ls6nbqBfNEksAyQM=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0701MB3807;6:y3+OggrkBlKbuej4puIpO644x3dl0Ljj0g2nY6qoKccglNUmK+BRDXrIiqMDirGJ69a8ecJES5Mayw/qq+W9OK/CdWBg5DAA/wOwEthd9g40Z2OMW2ZGQQYiqx1gDXxvphXU9+/37Bc8Am+naHLMFg09vE1xKfZzGr9rGoYzxeZdN7J+7izR7oxMVxVuP/GI3QyHwvu4Ipq0DaGDXV2rxlBoHsZjl7Yq4e+gcCB7A7zd7UYHC98WUUtjjCAZKpbVoMvyNbVYPspEPCvKviipAUZW9BQwJm75+72o8honvCfXvTm5tiOOJwi/jxD5VAzXp1ly3YiHPJAT6/0ne7e3Ow==;5:b0T+lM7RJtOBeI9wHGAhQTAwbNrFssw6DrZbd2+w+Ulj8gCzj59E82Zt8AVLe+7Wr3ZQk/xDpxr6lHXkjTvuqKL9D469qhLxaOML67QBnZ3E7KdQcWDLEDqH+uwU68YYFbS9WS89/o17kgqzFl+ZFg==;24:pFcBbCyPU1x5xzlbhm4TTk4WzFS81uG+Ghi6ICERC+lrJTrjluOZki/qHPBxP6Mm8S4/j6skEEymVKT2FbUrNwu3u36AujaCQfveKSxp+Ec=;7:81YjI89f7TPveLtIgI1eNS2D6V4ZUpgsyA2DO8G2b+H9n8YOKCArGf89cN58azpPLalU2b70g21YpL7vOjyWE3RRWXs9HewYyrFncp/TZxswF9xuwtqJJ6pTAjwAA2VqEkaCaK9pjcjnUIr6U3ANZDU4EelYYfly5Ys8fPGG4Li3zN9dat/t78J4asWvmyz/cXdAAe0A1ereeYmAQurYWKzm6itKuYs/0EozwMqAlQI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2017 17:38:57.1050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3807
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60194
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

From: Chad Reese <kreese@caviumnetworks.com>

Flushing the writes lets other CPUs waiting for the lock to get it
sooner.

Signed-off-by: Chad Reese <kreese@caviumnetworks.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/bitops.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index fa57cef..da1b871 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -456,6 +456,7 @@ static inline void __clear_bit_unlock(unsigned long nr, volatile unsigned long *
 {
 	smp_mb__before_llsc();
 	__clear_bit(nr, addr);
+	nudge_writes();
 }
 
 /*
-- 
2.1.4
