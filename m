Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jul 2018 23:45:59 +0200 (CEST)
Received: from mail-eopbgr690057.outbound.protection.outlook.com ([40.107.69.57]:55342
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994612AbeGCVovRU3g9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Jul 2018 23:44:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omFUx78MXXb2c0x5IIjSZl4QWwouyVyg0NWdjgBhiQo=;
 b=iD7k/NLgievyD1sZIApMkDTHzqFvnL2nZ7cIjafWNsfUPoh/qWaNV8KcFf0PYyddUY/B0w6BdgbWFeHBuoGVSgrOoLPWDVqXEz6LyIC9fQdvCLyJFaxoXfdZR/CxiQiNtQBYDPHlL5Mv0Qpf//sNwv2nDJG5HWTFf4b+cm++grQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (50.82.185.132) by
 DM5PR07MB3960.namprd07.prod.outlook.com (2603:10b6:4:b2::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.23; Tue, 3 Jul 2018 21:44:36 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     Chandrakala Chavva <cchavva@caviumnetworks.com>
Subject: [PATCH v7 5/6] MIPS: Octeon: Create simple macro for CIU registers.
Date:   Tue,  3 Jul 2018 16:44:24 -0500
Message-Id: <1530654265-26949-6-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1530654265-26949-1-git-send-email-steven.hill@cavium.com>
References: <1530654265-26949-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.82.185.132]
X-ClientProxiedBy: SN4PR0701CA0008.namprd07.prod.outlook.com
 (2603:10b6:803:28::18) To DM5PR07MB3960.namprd07.prod.outlook.com
 (2603:10b6:4:b2::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 392af9fc-af75-417a-57c8-08d5e12e2bff
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB3960;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3960;3:qS5iCNBGFxglhemqcj2/7E1VKt5SbXtu+rni22DtduW2Mw5jRqBE46tz7BoGeQ7bbm8iDRM0u3dDRXjih2jKi79Udpm044bToVeRMhXNZ53Sfq/rjgMwT7Ks6FzzoIpGtqmIgDRIcb8YlNS/69pq9BpSCRC/OPv+u2l1JlRHEsX/AqBRi0uCz+RihBqAK4/aOL+4IDe5lw5LWGn7kWxwY/A1UOvxx8iFKCEVgUrZMiCfzVQWPz0lfFV4sHjHVIkr;25:LA9z7UwNmL5poeVXkgcVrnTavTLV9ZURfYJFWj7EJoRzdbXna1rOa9mJ5E8hSFrqt/fEMLNfCxdi7e6l9zdRVSnb2WH6BLUd7XiLTYO0vBtH8Y2mOueoHWvT//22mo0xCxL54RqHIdd7/WwZdX4xtptYkg35X0oE2dkJ602dGJXYvnAxsDj2gfCukRJoIqMi/wdQ9e3aAnOrYeqX1hHfKILkftAgxLBKSaCHQtHmUTdWg8hLjeVqQMHPGd2nk+dodSrmGfxo25gNBXuTtwUk3EEmwwWL6pYH9uYWxa3lDSuaGkKilmu1+/9/Kx3Qyk24f/9E/vBMogxyd46PSixq1Q==;31:SZjvdX5JkSfqRXsO3CFVAHIFlpCeyavllwvqTn6PHyPYr1JsWki2cha4dtBxfEi3hF82f+Y1CeErvdPye4+/B7K8omYoCBwCVqMoVTgIwCYh1C+rcRKk4smZPnNcwHeRAbjo/niVe4NbAunOu70sQxE+ZumLoTIZ4ULdXv8JE7j4jSYfgdWocIdq7Yrj0VTrk3EX9qL4iVRgkiZOrs/nyAQPgGLCgGPTF0UGq0cmBU0=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3960:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3960;20:RwnC3nQyamI8HbMGszSRiSv+bqtUb4/Ntc9mk0Cs5FtfHswKcGIRgujPG6ubEJdzRICBJLygzQMiMjg+8BI0GezxGgHGOSr5AfUMbTEDfXaHZWPwh0FbcunGzN0CXHiizjlM8VFg55cGrKa5MEJp4eeM/ZyAkWj207rwEOSdjAXu5W84k2x2KqhsuvtY6C37fcsBpFk2r9s3wYbSsFcEfH/a9qw80Nzs83rB9pkzBDW/fInz6ifvAl8TYr9GFlY8t1ai5UTxh8Ld2im3gw9MiMd5SnFfsWuuBsfZYOQHLh+DeQj5ujYkQOx+lln+eC3dTo4aycUaKB1CyCUNdX4xbHwlM/UHvlAheUnmmDq25PpFDIACkZc71QX2g+ONobFDErbaxGF+HL88W42t85rdJxUpQQV6Pncm57b+/BKj4VOe9g8xnZwZenTi1u92VAMvxi6RyAd7x0EjvU0+CC1egVxl63W64i1sV1Ft9y0O9/i0VYL/t0TW95Rx+3QRoqBy;4:DO1Ik/mNgLdEFu3nEiZKu6NKdxNtxbINxSmMqbYpjkKk18nw+43+ooSqczvtBRqRVPOkcv34jAf4xPWvtFATBsFDVU8EjFw3AFU2fytwRDaEaNt3TkmsIg6NYS9ZDETJagRxT5hh9u50Ga3B/ACsrG22ZDcw8sPwZNxXh+sTaVeLfuSqHSd3EPGKYvx52jubjEAhD3Wth2TQewles6KJavMia6t33MaTeSBpIoafj2WyK9drsp/sR274nfq+u2FhMzXcmdtlhqFyTE3zL06EPQ==
X-Microsoft-Antispam-PRVS: <DM5PR07MB396097BBB3DAC84F4FDA345A80420@DM5PR07MB3960.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR07MB3960;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3960;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(346002)(396003)(376002)(366004)(199004)(189003)(316002)(6116002)(5660300001)(3846002)(6916009)(72206003)(97736004)(6666003)(47776003)(66066001)(6486002)(53936002)(68736007)(16586007)(107886003)(386003)(36756003)(6506007)(50466002)(2906002)(48376002)(186003)(26005)(8676002)(53416004)(486006)(2351001)(76176011)(2361001)(105586002)(106356001)(476003)(446003)(69596002)(11346002)(25786009)(50226002)(575784001)(51416003)(52116002)(956004)(4326008)(2616005)(16526019)(86362001)(478600001)(6512007)(305945005)(81166006)(8936002)(81156014)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3960;H:black.inter.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3960;23:ph/L4qjwzw5JZgzVs51Tzg9Nz6ALPqOg9lmfjDAwN?=
 =?us-ascii?Q?KkWh8+gxL66AmIw8iULFHT5/IqeLWuAKVBEhsgb+XG7RmegOiTGYcL1a542m?=
 =?us-ascii?Q?ORBtOtT1zpX9fx3ztijsB0c+WWhPz6qpqpUY5dFf7EjCHsz8AO45V0iL5SyW?=
 =?us-ascii?Q?QF33hBIdJuobRVMhiCH96mehV73IBRBhfsdkbfT418/iiD21JjHV5TZXrKbQ?=
 =?us-ascii?Q?33il0Wwza9Ma90Z1URS0scXBPsWsPcK45D32iTj1Gopww1AnmIbElcKGl1zS?=
 =?us-ascii?Q?onz9rKQCEMAw1JzKjV/yUa098IU+n1x5llkUajNrsnGSiSzQmo5QJM3jjdnW?=
 =?us-ascii?Q?vr3cod9hlk+WSJ+kZqYlI5KPddWv/PMkhOxiVYLpic875JXDt30RiiGtdhwp?=
 =?us-ascii?Q?fF2dkpPKbX/gKvSQJHg4bHc1XzAzYKTwD2m9sLIBaLFdwqCqazc+z++yRmN8?=
 =?us-ascii?Q?bLLhQA1PZ2onswcWMnp/JJeZm4TByE3sdixj3M5VI4oRVOx10x74FgNzucj9?=
 =?us-ascii?Q?K6sdRL2bCtMNjHwfetUfQl6Y1MpFhiKSBfcwb8i20Rynka7A1N6TsalR4PdG?=
 =?us-ascii?Q?SBQSIul7ohvcRlyrEy8ZCrjuhmueWuGKZUHN+Ch4+B/vN57e5NGShNS9ggpJ?=
 =?us-ascii?Q?ApW0O0StzNTvZy+XYP9IXxb55cn5t73sbNsJ6qREt+j3HTUBJ+jMZFgEuc8l?=
 =?us-ascii?Q?8h6W4RD27TBMT3qLJLqr6SAVKUjqOuoM8deHQU6HhLTwdyX3mEWgVafBBN+d?=
 =?us-ascii?Q?frZ7E25eVd/LqnRsvXpwfdth1bj+jOIHsrAk/gzif6zSPQ3b4F2gr1cu8Zhk?=
 =?us-ascii?Q?gqsQ2fi3YkVGTiaGO1zQtrmrYunCIJlpThZ9sROOyWYpm3vK0ifqOxUBwRN/?=
 =?us-ascii?Q?giqB4njXT/UH57Vu3Du3DVqVkxMpJ0J3R+BnFKzliqxQvRES2SvaYLRW/jB2?=
 =?us-ascii?Q?1IeF7U18G0HAcR2ATqmBy/2Pr1vxQ47oR4WZgzTTK7jz4byRNS+Yio40om5Z?=
 =?us-ascii?Q?Ge/XSwLqIpoGgMpByLxn0rNx4H8Tye6cedQ+YDs70wWciDWKIg1ia6wh8W2O?=
 =?us-ascii?Q?+g0QV69Ukj/06bKDWz10d+pwUWT/Pld/q0E7TtvCmSHWmhzYKm7I/0VBuAF8?=
 =?us-ascii?Q?RhufGI/2u22Dfc4SCywlP73S3naCzUwVPKgQjQrQfx0E+sNntRNDuL8fTf/O?=
 =?us-ascii?Q?ORbDG8IlP1OTZxfjjQqT01kpJdvvv+KSxZpHQJg6xmBhLppz0ApTVH2OjKPC?=
 =?us-ascii?Q?enOUWfAVUfwzwHXAdnHGFziLswzP2ALvLQsfOEW0Kr2oVdobwwhYwu+CddJY?=
 =?us-ascii?Q?9TZOE7oKp82CKfSlQwnan4=3D?=
X-Microsoft-Antispam-Message-Info: dzDC1PadK/Bkr4J9l4+Wuq/c+S/3NiHojsaLlCfF3IjHwpAb72qI+f1TMTXWvdstlzjiZ2ya+9UtKcv9OEE1h+IgVaCLW8ZD0AVXdUewTfZobSHHd/qVqBV8J/+7le+SpOSi2Cz2ATOayzO0+3djU9NXd3jbbcG7AkEDJoNwQgnHWiRfo4PE5RlMAnWEJtVhhECU5Y0dpQosH9MH5Go6pShXkQN0lgbAjgvCNwnqKZUWptaW3PPjRTbzL+WJuZ4+oCL01ebCaL4eP5Bydv/R1+rmBQFs45+UiEAxm3aYBD9ICgqmurY+7xDw5h4ie+QrrszUwZojCabUFjh+f3Nxk1QRqlN08mf0BiMchpQIrJo=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3960;6:PSIT2RSasOYA+bYsL6qKp8Qfi9tlLEZ+zQ8dWOxsmxwTZHCaE2vNvBFvJ6bCB9cd88kJsuOg4NYVjZiHlSLiVy+9wTuZxExCA9Uh/EyGudBzz5Q5ADFwakFkrZRh4mjQyzTxFi0QcHJyDQtSf1njlRa9YPt30LEdb38u80PKFe0eFAo7WQOHcYTXJnT+j6OHt5SW0YmjbkqUfHEpKAUdgn45fgWAYFTYvGOf4LTxmJHmGdfop/MejB9AwaFAilrYEK8cmshoJlTus5C0o27+AIY6YAKCkR8lLLTmRKUCRKblayp9+c/tF+UJZnISEcS1YZGGB5mV3+YM2LUlRsCCdHaLK36XxfqSRdUw2lQfDqpB3A2WnHKrWKPIdo6deKxRJn4u0ixwQkCCWuavL16AWBnaF1o5DlO5jYGlnY0Z6t5rrzB/XxmDIUxRwh0yZDQ22qbbYTXgX2BmWD8sl5KQ5g==;5:NDrXgaJ0IWlnpKBKuEweUhfuGQw7m2jE95JFsnPaBj5f+leQp+l/Ja9mobTRf8rWZBBUe9blS6QZ5gR3AsqDrN1IUt2HZLzm5DzKvcp+U2oKOujldYDGnIvstjuUV81o+/5SSYHKkTo4taWbKQg2m4GyHSgy05IuqYMLD4t6O00=;24:hIcaeV3OXmVi20CXT5VP1YsWE5t7O0h2du+s7mX1ONZtP7PnoRODcTykEfHprC/yUFx7pDo1HTJpdMup05o4YqOC65ChG0BtjXqEUCcALCo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3960;7:Mxqpr9D10thIfubg3HMBh9LG1PZVnb09Eq8aKFc538PRpODV2s36jzUImtrv3LztFkcnzuOzYsq7hgSOR7ievuCUwBj6hxS3lCrru7jeU8Sho49mYo5Cbj9ORGAKsIkwi3dyq6yQv1e+EiPcZWX6oE28+z2wTknoE04CVw/Ge+PKFFe2Kh0LA4ZcByv9UgAhVW4M4F/sgh6rikTl3oIFFHdoD7fdyLMhqrxaR7AGDcjD7s5QGaDpd1jxO/1onUe1
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 21:44:36.2200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 392af9fc-af75-417a-57c8-08d5e12e2bff
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3960
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64595
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

Create new CVMX_CIU_ADDR macro to improve readability.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 arch/mips/include/asm/octeon/cvmx-ciu-defs.h | 60 +++++++++++++++-------------
 1 file changed, 32 insertions(+), 28 deletions(-)

diff --git a/arch/mips/include/asm/octeon/cvmx-ciu-defs.h b/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
index c9fa6b6..652f166 100644
--- a/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
@@ -9,34 +9,38 @@
 
 #include <asm/bitfield.h>
 
-#define CVMX_CIU_EN2_PPX_IP4(offset) (CVMX_ADD_IO_SEG(0x000107000000A400ull) + ((offset) & 15) * 8)
-#define CVMX_CIU_EN2_PPX_IP4_W1C(offset) (CVMX_ADD_IO_SEG(0x000107000000CC00ull) + ((offset) & 15) * 8)
-#define CVMX_CIU_EN2_PPX_IP4_W1S(offset) (CVMX_ADD_IO_SEG(0x000107000000AC00ull) + ((offset) & 15) * 8)
-#define CVMX_CIU_FUSE (CVMX_ADD_IO_SEG(0x0001070000000728ull))
-#define CVMX_CIU_INT_SUM1 (CVMX_ADD_IO_SEG(0x0001070000000108ull))
-#define CVMX_CIU_INTX_EN0(offset) (CVMX_ADD_IO_SEG(0x0001070000000200ull) + ((offset) & 63) * 16)
-#define CVMX_CIU_INTX_EN0_W1C(offset) (CVMX_ADD_IO_SEG(0x0001070000002200ull) + ((offset) & 63) * 16)
-#define CVMX_CIU_INTX_EN0_W1S(offset) (CVMX_ADD_IO_SEG(0x0001070000006200ull) + ((offset) & 63) * 16)
-#define CVMX_CIU_INTX_EN1(offset) (CVMX_ADD_IO_SEG(0x0001070000000208ull) + ((offset) & 63) * 16)
-#define CVMX_CIU_INTX_EN1_W1C(offset) (CVMX_ADD_IO_SEG(0x0001070000002208ull) + ((offset) & 63) * 16)
-#define CVMX_CIU_INTX_EN1_W1S(offset) (CVMX_ADD_IO_SEG(0x0001070000006208ull) + ((offset) & 63) * 16)
-#define CVMX_CIU_INTX_SUM0(offset) (CVMX_ADD_IO_SEG(0x0001070000000000ull) + ((offset) & 63) * 8)
-#define CVMX_CIU_NMI (CVMX_ADD_IO_SEG(0x0001070000000718ull))
-#define CVMX_CIU_PCI_INTA (CVMX_ADD_IO_SEG(0x0001070000000750ull))
-#define CVMX_CIU_PP_BIST_STAT (CVMX_ADD_IO_SEG(0x00010700000007E0ull))
-#define CVMX_CIU_PP_DBG (CVMX_ADD_IO_SEG(0x0001070000000708ull))
-#define CVMX_CIU_PP_RST (CVMX_ADD_IO_SEG(0x0001070000000700ull))
-#define CVMX_CIU_QLM0 (CVMX_ADD_IO_SEG(0x0001070000000780ull))
-#define CVMX_CIU_QLM1 (CVMX_ADD_IO_SEG(0x0001070000000788ull))
-#define CVMX_CIU_QLM_JTGC (CVMX_ADD_IO_SEG(0x0001070000000768ull))
-#define CVMX_CIU_QLM_JTGD (CVMX_ADD_IO_SEG(0x0001070000000770ull))
-#define CVMX_CIU_SOFT_BIST (CVMX_ADD_IO_SEG(0x0001070000000738ull))
-#define CVMX_CIU_SOFT_PRST1 (CVMX_ADD_IO_SEG(0x0001070000000758ull))
-#define CVMX_CIU_SOFT_PRST (CVMX_ADD_IO_SEG(0x0001070000000748ull))
-#define CVMX_CIU_SOFT_RST (CVMX_ADD_IO_SEG(0x0001070000000740ull))
-#define CVMX_CIU_SUM2_PPX_IP4(offset) (CVMX_ADD_IO_SEG(0x0001070000008C00ull) + ((offset) & 15) * 8)
-#define CVMX_CIU_TIM_MULTI_CAST (CVMX_ADD_IO_SEG(0x000107000000C200ull))
-#define CVMX_CIU_TIMX(offset) (CVMX_ADD_IO_SEG(0x0001070000000480ull) + ((offset) & 15) * 8)
+#define CVMX_CIU_ADDR(addr, coreid, coremask, offset)			       \
+	(CVMX_ADD_IO_SEG(0x0001070000000000ull + addr##ull) +		       \
+	(((coreid) & (coremask)) * offset))
+
+#define CVMX_CIU_EN2_PPX_IP4(c)		CVMX_CIU_ADDR(0xA400, c, 0x0F, 8)
+#define CVMX_CIU_EN2_PPX_IP4_W1C(c)	CVMX_CIU_ADDR(0xCC00, c, 0x0F, 8)
+#define CVMX_CIU_EN2_PPX_IP4_W1S(c)	CVMX_CIU_ADDR(0xAC00, c, 0x0F, 8)
+#define CVMX_CIU_FUSE			CVMX_CIU_ADDR(0x0728, 0, 0x00, 0)
+#define CVMX_CIU_INT_SUM1		CVMX_CIU_ADDR(0x0108, 0, 0x00, 0)
+#define CVMX_CIU_INTX_EN0(c)		CVMX_CIU_ADDR(0x0200, c, 0x3F, 16)
+#define CVMX_CIU_INTX_EN0_W1C(c)	CVMX_CIU_ADDR(0x2200, c, 0x3F, 16)
+#define CVMX_CIU_INTX_EN0_W1S(c)	CVMX_CIU_ADDR(0x6200, c, 0x3F, 16)
+#define CVMX_CIU_INTX_EN1(c)		CVMX_CIU_ADDR(0x0208, c, 0x3F, 16)
+#define CVMX_CIU_INTX_EN1_W1C(c)	CVMX_CIU_ADDR(0x2208, c, 0x3F, 16)
+#define CVMX_CIU_INTX_EN1_W1S(c)	CVMX_CIU_ADDR(0x6208, c, 0x3F, 16)
+#define CVMX_CIU_INTX_SUM0(c)		CVMX_CIU_ADDR(0x0000, c, 0x3F, 8)
+#define CVMX_CIU_NMI			CVMX_CIU_ADDR(0x0718, 0, 0x00, 0)
+#define CVMX_CIU_PCI_INTA		CVMX_CIU_ADDR(0x0750, 0, 0x00, 0)
+#define CVMX_CIU_PP_BIST_STAT		CVMX_CIU_ADDR(0x07E0, 0, 0x00, 0)
+#define CVMX_CIU_PP_DBG			CVMX_CIU_ADDR(0x0708, 0, 0x00, 0)
+#define CVMX_CIU_PP_RST			CVMX_CIU_ADDR(0x0700, 0, 0x00, 0)
+#define CVMX_CIU_QLM0			CVMX_CIU_ADDR(0x0780, 0, 0x00, 0)
+#define CVMX_CIU_QLM1			CVMX_CIU_ADDR(0x0788, 0, 0x00, 0)
+#define CVMX_CIU_QLM_JTGC		CVMX_CIU_ADDR(0x0768, 0, 0x00, 0)
+#define CVMX_CIU_QLM_JTGD		CVMX_CIU_ADDR(0x0770, 0, 0x00, 0)
+#define CVMX_CIU_SOFT_BIST		CVMX_CIU_ADDR(0x0738, 0, 0x00, 0)
+#define CVMX_CIU_SOFT_PRST1		CVMX_CIU_ADDR(0x0758, 0, 0x00, 0)
+#define CVMX_CIU_SOFT_PRST		CVMX_CIU_ADDR(0x0748, 0, 0x00, 0)
+#define CVMX_CIU_SOFT_RST		CVMX_CIU_ADDR(0x0740, 0, 0x00, 0)
+#define CVMX_CIU_SUM2_PPX_IP4(c)	CVMX_CIU_ADDR(0x8C00, c, 0x0F, 8)
+#define CVMX_CIU_TIM_MULTI_CAST		CVMX_CIU_ADDR(0xC200, 0, 0x00, 0)
+#define CVMX_CIU_TIMX(c)		CVMX_CIU_ADDR(0x0480, c, 0x0F, 8)
 
 static inline uint64_t CVMX_CIU_MBOX_CLRX(unsigned long offset)
 {
-- 
2.1.4
