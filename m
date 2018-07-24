Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2018 14:32:43 +0200 (CEST)
Received: from mail-eopbgr20105.outbound.protection.outlook.com ([40.107.2.105]:43776
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994002AbeGXMc2BZ8nB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Jul 2018 14:32:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CJeUKcZ+spKdQVJYR6TNXYsaV2MnduRaLLm2hEiPOo=;
 b=H+tV0k7i3c9AS7pIDYmg7ikvWG8817z1c4QwpG/9peujqr8bhUxFUthDOH7bZ6BFYWTSvNoKql9LfYrL0raksny67uOZDyWM9oH2m7MunE8I5Ka8qBdOjBa6bSAqdZdIN4xH9HJPFJNxEQOEgh/b58hdSD/F0jj+N1yDkDwAdCk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
Received: from ulegcpsvdell.emea.nsn-net.net (131.228.2.20) by
 AM0PR07MB3969.eurprd07.prod.outlook.com (2603:10a6:208:46::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.4; Tue, 24 Jul 2018 12:32:20 +0000
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
To:     linux-mips@linux-mips.org
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>
Subject: [PATCH 2/2] MIPS: Octeon: Select HAS_RAPIDIO
Date:   Tue, 24 Jul 2018 14:32:00 +0200
Message-Id: <20180724123200.6588-2-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724123200.6588-1-alexander.sverdlin@nokia.com>
References: <20180724123200.6588-1-alexander.sverdlin@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.2.20]
X-ClientProxiedBy: LO2P265CA0160.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::28) To AM0PR07MB3969.eurprd07.prod.outlook.com
 (2603:10a6:208:46::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51254b24-f44e-44f4-e05f-08d5f161806c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:AM0PR07MB3969;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR07MB3969;3:kF9wNdL1NK9mBFFM8bFU7Aq0if3K0LwqzsQL9g8yXuggmlcXqr2x3kwBHcq/9EPjzmmhoXqLO+sacV1LD0OTv0gzqJqQ6y6mvltVmEGRvk6pncxqlGoqy6icq9Hmmb26WA+D4Utq01I0vHtyh6bHvAgM0kzjOvnnFwRKfOhfWEC9ydCIvTVtc0HYrjGutb74vCTqD6lDRQnqMkknO2mV/VIAhvo1b4Iwc4qnTLH8deGNYCVtBgdlxMeAqEY/2Yo5;25:hzIQD1TeW3mPSgTuZNLKLe8eogn3za5vvZ2H+mIGZKb5eOEgzRR9hrrUY30SU0sKcvllKrDxWzYVWImv3GpzwCsr4FboAYSP0a/4akdoycufFIR1i8Ik3VICz4Yw33MyzdgZfuK8Y3RtU/pqvGPeO3MkkUutV1zclqUSkmB6qDZQlbVMLpjk4s7fWTFVbzKFlCSw5ZpvQR8ZN2hXWcTtPXDG4KF5EEeLrr0KS63i2EHmncXHBvwKcyNkneC2ZwoqkRqbl9STYPUf4mDf2s29egGZPLhmXuU9YS1yvootHLr1fa8uwGn0UvRozOkcf3Q0htKlDGSLdOYR3T1M35Nc2A==;31:Vw25F8Fysp8NacaEnNCysO5CE/Bq4/vgLVbT0bqIA4Dqb6gra+BrQa9+NtHyah9tIEKjj0gxLp1c6hMfUCZPyFcJkB+6a1Z6W/DBwMrZPUdqDRQUoXYtkB5sT9WGOsyUk89qQ+BnqY2KEyEkxc/oRNf+v9EqkFqEdrYAdXCAnJV1KYa2lDI7j1bQ6HCf7NN6DGt81GX+nFnJWXlhv4Zdqh7ofL8rXAaG1gGqnEz/1OM=
X-MS-TrafficTypeDiagnostic: AM0PR07MB3969:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR07MB3969;20:f5r23d/igduQRjNY55Z4bF/5GEsLRnkwOxgYMc/dsLqUqBYPkiZT1yEYXbAmY90ztDw4YpK/eZUo3F9d3zZxMpI/RX7AxC0u+Hmx1GzdgYueErYMdncFoHUXAiCQ9TLJR7vFrTsj9rC7DdMzaBcvrs4Y7Y2WE90AfNLC2hCIPBYlY0SnbGrMtk4mW34aeHGEa1nQoe3Ka60u0hJAj+RAg5V59PJiGCRgqYIuJhCjlUZ1V7itk1iqjxqBwyM2X97ifHPS63n6iBhR/badDdXTKK6sCrGf74R720wdCtexr2blrHvz7OaQvJTTnEr7Pt0cQ5vB6U+hw9T5BD5BRYD9bAlAtzPzEp2p5WadB0gT3bQfXEnA71hiW4VDKXNTVHruTjGuK8aSm3OwI50s+c7PB1SEvU0Rbck2cUKw7oYMRrqg+1rjbWkCZIv0B8cVturmatnmytBVNwYrYM9MH1zXqxEgDY75/reEaQD76gBvRpT81kLdXtewttnU059baQMmi8H8gXAlFqhvrUBGBVA+5f3Mm+YG/z5W/DmDmV0DYtn/VjDLePAH/teRJshvBc2NdwyOEtebnYlEmJeSoG5BUKpExWxlEsNkL/bzUIcvlMY=
X-Microsoft-Antispam-PRVS: <AM0PR07MB39691791F8E55CFE02EC318688550@AM0PR07MB3969.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597)(109105607167333)(195916259791689);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(11241501184)(806099)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR07MB3969;BCL:0;PCL:0;RULEID:;SRVR:AM0PR07MB3969;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR07MB3969;4:lG2PjxeIWaGCfwoPn/MRIseU2bPJbijqG+MTqKUxpYdWabAZSkJlln8bE9wqoyn6RyAkyxB59+BXgO5FqdGlGTU7S+89zdZLFeHApWYSJUWNijuIYgsMYCmuHO2LCW3E9Nv3QBLZUC5JwNby8yP0uLpVFpjoAg6veakgQ7I5pnYk0nOXSzheRn9X/PU14uKW799O4RKfRVYRfkQrkKTdbBj94T8dyFUZJbqLxYzrVgT7jOEjLnKolJZaU4MC1fHNklvbK2+llhz3/8/oKNGnsFSsdWJjzXYjHvQyt9uBxnXx+nXtLRQFo2FcnMFjxQmQbALkhyIZz0gtEeyJNOijjodmCe5IwJVw3hZYNVODrZGxWapyYN/5q2kX8QHKYdAX
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(396003)(376002)(136003)(189003)(199004)(36756003)(486006)(476003)(2616005)(956004)(11346002)(106356001)(51416003)(52116002)(105586002)(25786009)(186003)(1076002)(16526019)(48376002)(6116002)(7736002)(68736007)(3846002)(2361001)(44832011)(50226002)(446003)(14444005)(50466002)(305945005)(86362001)(575784001)(5660300001)(26005)(81166006)(2906002)(81156014)(6916009)(97736004)(6486002)(8676002)(6506007)(386003)(16586007)(54906003)(8936002)(316002)(478600001)(39060400002)(6512007)(6666003)(4326008)(76176011)(47776003)(66066001)(2351001)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR07MB3969;H:ulegcpsvdell.emea.nsn-net.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR07MB3969;23:bijA5Ow201Ss0k8sXCvVpfnqOEH4bSG0rm5b4Ig/M?=
 =?us-ascii?Q?RH/uA1OcVGSZXRTifvLRbv3pLRK0r9NT3mdgXwr2PViqn6Tg7DVbwdfRtxkj?=
 =?us-ascii?Q?aZjTjpXXKgrHiKfbK6JG4CdRSbkJ4vCOO2An/G+LlvcUImfm0gRPe4IFYxYa?=
 =?us-ascii?Q?W9dYSNzLU8L8/fo7coZFRpNzEyGD/PnCHcS5DBg0h0vAB5624Rr0hJs2lkZT?=
 =?us-ascii?Q?hnOHQulkRemWI2gFauNGIW+NtOY1rIWAptUCLDhUBNbAr4vsVirOg+B26SZ/?=
 =?us-ascii?Q?V8xXB48t9YfVaqedg4YoDWt1XTId+LlniFIqfp0vCsbVMMLRJB5H8VaezFtp?=
 =?us-ascii?Q?3aVEf2SX5KJaYXmGl/RKu3F2jKqGskFDZU/nVPBfSPmPMqjmcg8njHynL9j5?=
 =?us-ascii?Q?tuFOAL/Da7xMyB9ZOepNd1uYmDfTG6Ac9gyKs8RLlM8Lo0tZJiI/pKxWOHyT?=
 =?us-ascii?Q?+RGE9JC7anP9uU9Rsc/0erg/i/QPBm7jI8t/tm3jlXQHEYzpL8FmVuGzQfT9?=
 =?us-ascii?Q?WjhSsT5vSCTKjn8Q/XvXKfKQKrn5aT2r7gkZDJiwCwUPyWd13ast+CS3y0wO?=
 =?us-ascii?Q?lACZZZKLg84C42ttUJyjgHUz1oPZaFYiARIUHmUK9EgLg+egBqGcLwHeoSmv?=
 =?us-ascii?Q?+BEq7Gga2g3qGKCPatenbSvhqyBbNq3ShKkS595uAV0Fg+D4lvsaSw7ay3uo?=
 =?us-ascii?Q?OOT+RhBWIGEGNbgNRMdtGTNYjsNML709uXMiN5NjcZnH34sQShBZrLACxgk7?=
 =?us-ascii?Q?DJRbVhLp5fg4wBcLCxL1um+XrhNEHQCByPLwS8wRsWYOypa4mDhmLNB9LYGU?=
 =?us-ascii?Q?ClkrcGDHGcxE3eETcgh/c9GvynY87n50JXC0S5uyLtnoMhNxyu7kuITIT7RL?=
 =?us-ascii?Q?RzCSYEvT0PCcG3HOmMkTGNCzeCqFqdmQwzPthPtvMgZ72DDDiUQNJyIvtW3v?=
 =?us-ascii?Q?9j4NTFNNezD0AoHoTdRnxO7DEXd+ep276nK3oZPxZIpobYf/rnBBIuU+uGLf?=
 =?us-ascii?Q?5uQ6i1yK4HtSSpILxEL7KM3dbcg/Fv0Cp7eKE7yAbSUWTnydh8sBKvxwpQUj?=
 =?us-ascii?Q?dvdviMZn4r+pRpnoxApE6BmohB2aOfU8+unyWY2TbK1T3gkseG5tj0KMF5nm?=
 =?us-ascii?Q?UzaOH70jAy0TOlJ4ObSOHb7Ami7xr2Ga0s05nUMWLphZqAP1grGGIBt75ziX?=
 =?us-ascii?Q?jn1dOpc5HiLShRAR7VJtqHIiJsFx5g+VdAwARfxxmPGNwV0gLDlm9tGBYTr0?=
 =?us-ascii?Q?4cFzmjOf4v3/yn1MnbCYtuNOoLjEaKSafpcUb6dpSfWZXJ6Wn41hmycZ0bRq?=
 =?us-ascii?Q?IpNNBX/iR0FpaI/JwtUdLPsKtpPqo/bH2ZuJ1X5NSMQ?=
X-Microsoft-Antispam-Message-Info: 8uiOlQ8GQuQ+xrVaWp65h//FYsBH3T9DyapLWWpYen47fU0Xl1ESQs/QN4TGnGKgy/xSOVFJ1DPJydt9sbjVCvqcTUxZ3EOTEEbzLVuuexMhRhqmphNMLxMdYuzzhgzXzIjkPrJ0VjMT4vmnBGPumhSkByJVsZZWM4FEqCf7tjBPcDsGDzURX8s2GXoHL1j8zkF+vV4g83UbBmlFBJBD1Yk1/LvZCrPjnMJFlMiDc7p1zrEWuRnkbL5yChWUrRY0twI974xWPV12M4AnSdQzNatku5qKzUy9V+k3oS3rcQvBG7osmP35VaZWqUF50HXAPk8AS4nYep/AhBPlalvhLuHyLmjB9Z4qR7UkwGT68w3lVonuKWUt1b1qXAudj+YlTDxbnGWqXmwEIhGdc/rkDw==
X-Microsoft-Exchange-Diagnostics: 1;AM0PR07MB3969;6:LGVHt+j6V2oq1+8RyR8vl3xR+IMnPum59Di6CrCZTjOrsmFd7cdyCqQpR3jBFoLodWEM+7jS9ldGSyAcIOSKWOYRB4cQdr0vJH6qVIQnx1bKnPD3/MbJEOJfEGRmyXizw3W1EyVLKs0PjOtD/pcZVECEITnPbltqWaCwLexudo82J6gKnYDX0AqWLZZcLCZ5aqdAZR/XNaQNVvtXWr+wBgJX5qqbof6nPl8cnrDYZHU8rLEsjE0veC97/C3x+c4RfMMqYTHpE+oHblroJLZPUTQcMOc4cpGuR7++Wq5qfF4RfTu45dWOQla0lG3c9TQ2ysDToXbfGddxk5sxeng1PGzQhw6uix0aHMKN7akqsa/DgmSKiANXcEefysbN8k5/GSap+MjgxUL6JbKL+GLB9LTBfV6SlBFzqSdAhcEF//SvUfDvK6NOd73xOG0pLyunDHNYnRz1wUU3yH4JvrUjWQ==;5:bx27SDGhMOVmXoqsktn+/XiYSxZsUXzjNy51CeoSeXyyN3rOu+KeP97v2vlHFl/0QXdW6Fb1Yob0zIgvv9kJL2mGPPd2iUyvWaUDWlyaJKmPqEuqc4jIEsS7zsuxokDukc0BMeDZ+3gG0L4cCLv7hi4NNLBF9fsYeSWxokMyG7M=;7:uFjE1qezKwrb0zG7MgV/v8N09pOftezycxa3TiNv2YKP5NjC7L+6xHD5yPAGd0scFLe+0likIKc1oa/tysxmjpif+VIOPR+fX6Lr3QXod9sfVhIlu621huWOuiUqdUONq77g/9WU7cZSclOo9sTcgRaBfBAvHuT05sPPu2qU2mR4VQPIZUU9HIq5irHlZ40WEfjUV+sm82XyLMRsl0O/KET1RPbTmwdGZRYdhosNfa1ID9gKdknap1Qy1oTENzY3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 12:32:20.4378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51254b24-f44e-44f4-e05f-08d5f161806c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB3969
Return-Path: <alexander.sverdlin@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.sverdlin@nokia.com
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

All Octeons starting with Octeon II have RAPIDIO controller which
can function even with PCI disabled.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b7fa44ddf452..235feb657b0b 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -890,6 +890,7 @@ config CAVIUM_OCTEON_SOC
 	bool "Cavium Networks Octeon SoC based boards"
 	select CEVT_R4K
 	select ARCH_HAS_PHYS_TO_DMA
+	select HAS_RAPIDIO
 	select PHYS_ADDR_T_64BIT
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
-- 
2.18.0
