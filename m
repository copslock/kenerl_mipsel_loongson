Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 20:30:37 +0100 (CET)
Received: from mail-sn1nam01on0084.outbound.protection.outlook.com ([104.47.32.84]:34944
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992185AbdKIT3tGzhxL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Nov 2017 20:29:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=H5nBmSZoi7F4q+THjhmGDsxL1SaBD1ybpCKXd/Hxa5g=;
 b=gia+dgDkbxxFNNvj5iEu8pvxsqaouGzZR0V8TFtZYdH8wVJZydrFUteW3zV+ARNYy3yElvK+N0nsQQzOzVVxCGh40uT0F2bxM8/U0oNFl1cPNEpulQ9bCkUWIWPF0J+Z6AL245+vfMO0OSuDZ5v8/yH+0msRTbQN4uubYF+pyB0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.218.12; Thu, 9 Nov 2017 19:29:31 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Carlos Munoz <cmunoz@cavium.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v3 2/8] MIPS: Octeon: Enable LMTDMA/LMTST operations.
Date:   Thu,  9 Nov 2017 11:29:09 -0800
Message-Id: <20171109192915.11912-3-david.daney@cavium.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171109192915.11912-1-david.daney@cavium.com>
References: <20171109192915.11912-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0057.namprd07.prod.outlook.com (10.174.192.25) To
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7efdbe68-92c2-49ce-aa5f-08d527a83723
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603199);SRVR:CY4PR07MB3496;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;3:9k/1yXkXzsBnOv3k41Hm3yKCUCTgN3djCfc0VM8nGdCFa4G1Gx0jwoDyZmQDlG1QnDp11djlmWaqY6gOLhdorGeHvEt6WljfMEtHGcvknL37VmbeNk/lUUA5Hv9CQMm04IFLzx+IAtAI5ywafPloeOFkSsApVy3vl3zr8CF964W/x/AkHMwoh/vM9iR1mA4mWu85AHgnMFS60MUL49v8ZieNyhsbLwKmwCisprpFNfjVUOppA7Sk/QZvyqY+t9ii;25:pcUCcK2hcWTdB03+u1YcNDfdct7OtC3cBsfeK85p4b4b+N8PQnGdYOB+5xI3oyayrZZxkAC9mpthbUWi8cCDXrSdNuvobtB/xQ56Yqt7tAvpIuzgm8cNbwD697nEIUnTBKu9VlnFJ3NX0aUL5M6jbS+fcJ7kdaqSCEgR1FM1jGvSwQkSkRFGAuaxaDwIvO1GKWsY4l+2rwR39/X0jtH0nLrBEGbdR76E4y3RBR5u+PgfuQFD8uSDhaxbyKoOhaxHjIwxpPSdbybqcAyDSv7aJEoEv79FtxFnqViQnA9DCzoiEM1IKbjCf29GIo5qHmQv3qVyM4CtEUsja6x0pHVvbw==;31:cZ3eky0eJ8sufq5f9r8dAysE/z77oo8W9X6JYL9oey7RPTvIR07SEX0QgsxiPXetC49t0C7atM3hvaN1oPlVCX+49Uw75wXHbbska10LTmJivEv0VCFSxMaHek8j6ousW6MLLegzqzFWPCue0N/QXRlGsn8sQ/St5gzvHqQmcujMFOTU9AL4scCjw9QzMWQ5y+YeZjyzk/W15e08vbvuNSQ1Lot80pwkEX7ELVc4ldM=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3496:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;20:mqe7HQDBUbhD39S1mjs5YADRGC9T9pFE0eF6FOf6BuZD2S9iDIt+NOy/fRmiV2Le3E/ZSBbR9zMXTPRMe+14hQHn1XEF9SAd53OgdOInz/3vLZGz+Ah8IzLep8wXzi+RAoUmaLdcdxMvCZqmYwlfKqSKBZRQSL93bBsN4Uf+l9ebAXDF0iXlZHw/ovIIB+piRAgcHw/9lIOsT1JJVPtaME5XfsVT2/O9lnqZom0WzQsMBnLhKm70X0sQpYoyxIJFqx0p6ppVYTOlvVpPVlhGuLl2RmbPh7RQlM1u4jU0+i+ouyJGXMsLT4UPlFJscfvZsUKceRiREi3OkVLcF6gOe+4rKH3dfxoK99JdN1W2wDsv/hbY2SPZAhJta8cbi1tdp3i/hQLhtLn8zMJRC1hfotI18aaaToGCInedJxwaWJDdwU84TGa7Wt84RZRocfPIm4ApMZZa2lurCGC8xKKVRAHN5qt80qIPPHeWDvux6CABJOakJbrSstZS4QsDmYTm;4:NW1GTND3Fo3pSyTvb8gmBAgaqhyrSmoLwtMOeV6OxU/yAJjOPTRX3o0dw+wa0UGPf9W/8WZKlRWenaciKuPZ2VTz2eo5DfpdXzdIi6ZAP8uIzvMVrm2xf510F95kd+kP1GjcoNdL3bB32j3G0kQNE8XNgdinUHjF/pL3Xy8EUreNYtmcdh2MqGYOveTdRwGz88Sq0/g/H4sgT4iGfsDpTxotFeaBgEu+70GR7KggLb55jmVcm7zC/bymLuuo0jxNWrvoTb6Nbn+8wdGy9WpyCg==
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4PR07MB34966E1ACE5A94E4B48051DB97570@CY4PR07MB3496.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(100000703101)(100105400095)(3231021)(6041248)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123560025)(20161123558100)(20161123562025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3496;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3496;
X-Forefront-PRVS: 0486A0CB86
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(6116002)(47776003)(6512007)(8676002)(478600001)(81166006)(81156014)(1076002)(36756003)(101416001)(6666003)(2950100002)(69596002)(110136005)(189998001)(86362001)(97736004)(575784001)(2906002)(54906003)(3846002)(50986999)(16586007)(316002)(68736007)(76176999)(8936002)(50226002)(106356001)(48376002)(50466002)(53416004)(105586002)(305945005)(7736002)(72206003)(25786009)(66066001)(53936002)(107886003)(6486002)(16526018)(39060400002)(33646002)(5660300001)(4326008)(7416002)(5003940100001)(6506006);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3496;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3496;23:nJMxWyH5LxG07Hcv+u+aoahMe8rHY3EjlUPD/Ox1t?=
 =?us-ascii?Q?07aEcPliduR7EzBfgW3/eLO3G6VDOrgmMoWlv36RV/nj1ZFoGqXQvltE/gWi?=
 =?us-ascii?Q?ZFPEJpdXg7R2NxpumsyOYfgFHbJoQF4FOVI/F2pkaj7vMaGbl0NYWjshxRPH?=
 =?us-ascii?Q?mnCjI7Eatk0ee2jYAuroP6/2bbeFNC96l4vO5JnM5YVzz2KZGL3udq+Ul0Bo?=
 =?us-ascii?Q?HERmwEoIAtEJdxki5kPODRfe/3AqoFnDtDow0dgbzVwc7jvMfrvYsOK3x6Hd?=
 =?us-ascii?Q?t8WDz4BB23I/WGcaFgTI6vp4Svhcc0P2toJfwSkIea/WDftab60F8mB4LKhB?=
 =?us-ascii?Q?PbeDMYwuaLBuI0cKJCTZ6ve9JVKICmVKlfcKzmSVP3enmfKsLmqOmHN/U/i7?=
 =?us-ascii?Q?EqjP7ChmZLheBXd2fNJw8P/xTh7mo1YIg7d5YZ2c+jbU7Kfwp2AnK0Rb9GtK?=
 =?us-ascii?Q?aM6O6zPJ0C68NV+fBSCZco5w8qHeu0ru6b396CExLd5kCG+5Zaalj3925ewE?=
 =?us-ascii?Q?XQ+xonxnl+DiHuQv15O5jJL4DVnK+imRjtPOzsJFaabvijuRMZXwA4YQOQtN?=
 =?us-ascii?Q?/5NY6Sz4v4hMm4JU1qgzT12z6Htq7M3zTdjgKNYnIAFW8hruQLePQr9QnmBJ?=
 =?us-ascii?Q?hMaN2V2KNIvqjAq/+jBZjXhL8tGtvF0UePsvBncPHrQijlXj3wmrtNn4/OQI?=
 =?us-ascii?Q?DiMmXd2cCyL5Yb4CAqLi9s9tRzKPGyX8EMZee+rBP0GSTqFy5GxzXkhyQxn9?=
 =?us-ascii?Q?tdBMM9zWHJkC1R62oi/UOhmrbRjfa6TRoGofRnxnCDxCyqjizLtjWjLCIn4h?=
 =?us-ascii?Q?Ukc/ETMjJi3kfpYvpmjKvze3V/z/CKGI2aklxTFOUZ1fzEKQIEiRmR535b5h?=
 =?us-ascii?Q?19m6+DIRFE5agFUIO9PMC79HMgyhMg6aiyOUjm2p9rM71tvZJmxPTyCOsui9?=
 =?us-ascii?Q?YCwRkLP4nthGz10h1w1Ml724wCcH9j1I1/ZhgAan5kFGWPfNiEuqKGlU/nFT?=
 =?us-ascii?Q?xArR4XT/n7ULyt6LlHchwRUQD7IrqXa5MHgbLeSJYPLImSD4gGrBC6qAHQ/z?=
 =?us-ascii?Q?tTYq5jkJ87+7YW2oE5dUeMEpEUSmgjIOtqqHCAefX+zD7/y0nzhActfl9sO/?=
 =?us-ascii?Q?IE9jF3ycGOCKukB1GlLbMUbIhtdnQ+BqkFRbrU3KAgVjPrGfkDHYTY276DoH?=
 =?us-ascii?Q?rEbHnQPzM2uNlQb0FJRIL0xcdnKtV8+XL/Y1nWcxLksjPOGQQPQzIH+8vNWZ?=
 =?us-ascii?Q?TLNxCRLpuI+r1Knz0sNqFUgwwLWh4cN6p6omeXd?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;6:nrmxOOsA1+mQSZAoPB2Q4c6VGiYedm3JYOraTHusVCOIhRamuo4tjck+0C066wdfayh6Nl2SYgoW7Lf7zbGe4C6G/raVbXWYhQidonYkI78jhxEMB9ZRnhHlQbBEz0gZ6tvzf75OveDgJ1K9Mo+9AgqWVVWSNkT0P7FYxou7miYdem+Iw94SSWZYuCMxCuIcgtnFCoJGICS3f/IuZZcgDWv2QKn15C7F+0Xk0yTd1HcxQGmHkpO1lKphoyEHx9h5tghPG983R1W8o1AEZwzDlS7WAoPRYnO8PbbWZwnWilp5oAoJ5z9nkH2qhc3m8F6/Km5QVH7pfxwE128olM1k/QJL2QAEkRhgSv6vtcwY9vM=;5:KRCtq6W26xni0OVeuazZYkXUJKpFHYy3UD3j5QxHgvPVjMo69Yfu37H0XIUglUi4v/k+33T3uW2JYDrdhKj9y8ly7Iu1o8zoHtVuE43hS6xo4IK4KnMEJRQJNbmSNGkO/gf5el7XAzajuMN8vpJLrEtrwCA2ZwceYUrpaRwPyac=;24:0qkhO1QORULrA7pU8fo7dTJR1Cj/3L3xZA1f1FTIIUGKbauY3GApwimYzvNPmxBV2w03wmsRNAhTE6HimKWvhvzJ31f3m/bBTYNkCoA78f4=;7:1Lazm72WyNB6i8jpQ4tmZqCP/Lf77IL5nEu4GAIUy3WEK1wTAUzygaCj31KPhkQNidPh8Vji9lHTtFfoknV2gpjjAk2G/0tmKpLVp4LUHKcSrnpji0wd/FD2JIwAgyLPUUZQTxROzlnx4NmoRDnuwH4ArJk3z3PdyxSgjfT98qovb3l7F/XgUn7YKbmnJTOdCv8yNI7Bwz3FAg8KKtzdMElMbtQ+30u89iKHo4AzJxKJtfrGc+ay9rjPErzMf9eb
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2017 19:29:31.6803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7efdbe68-92c2-49ce-aa5f-08d527a83723
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3496
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
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

From: Carlos Munoz <cmunoz@cavium.com>

LMTDMA/LMTST operations move data between cores and I/O devices:

* LMTST operations can send an address and a variable length
  (up to 128 bytes) of data to an I/O device.
* LMTDMA operations can send an address and a variable length
  (up to 128) of data to the I/O device and then return a
  variable length (up to 128 bytes) response from the IOI device.

Signed-off-by: Carlos Munoz <cmunoz@cavium.com>
Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/setup.c       |  6 ++++++
 arch/mips/include/asm/octeon/octeon.h | 12 ++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index a8034d0dcade..99e6a68bc652 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -609,6 +609,12 @@ void octeon_user_io_init(void)
 #else
 	cvmmemctl.s.cvmsegenak = 0;
 #endif
+	if (OCTEON_IS_OCTEON3()) {
+		/* Enable LMTDMA */
+		cvmmemctl.s.lmtena = 1;
+		/* Scratch line to use for LMT operation */
+		cvmmemctl.s.lmtline = 2;
+	}
 	/* R/W If set, CVMSEG is available for loads/stores in
 	 * supervisor mode. */
 	cvmmemctl.s.cvmsegenas = 0;
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index c99c4b6a79f4..92a17d67c1fa 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -179,7 +179,15 @@ union octeon_cvmemctl {
 		/* RO 1 = BIST fail, 0 = BIST pass */
 		__BITFIELD_FIELD(uint64_t wbfbist:1,
 		/* Reserved */
-		__BITFIELD_FIELD(uint64_t reserved:17,
+		__BITFIELD_FIELD(uint64_t reserved_52_57:6,
+		/* When set, LMTDMA/LMTST operations are permitted */
+		__BITFIELD_FIELD(uint64_t lmtena:1,
+		/* Selects the CVMSEG LM cacheline used by LMTDMA
+		 * LMTST and wide atomic store operations.
+		 */
+		__BITFIELD_FIELD(uint64_t lmtline:6,
+		/* Reserved */
+		__BITFIELD_FIELD(uint64_t reserved_41_44:4,
 		/* OCTEON II - TLB replacement policy: 0 = bitmask LRU; 1 = NLU.
 		 * This field selects between the TLB replacement policies:
 		 * bitmask LRU or NLU. Bitmask LRU maintains a mask of
@@ -275,7 +283,7 @@ union octeon_cvmemctl {
 		/* R/W Size of local memory in cache blocks, 54 (6912
 		 * bytes) is max legal value. */
 		__BITFIELD_FIELD(uint64_t lmemsz:6,
-		;)))))))))))))))))))))))))))))))))
+		;))))))))))))))))))))))))))))))))))))
 	} s;
 };
 
-- 
2.13.6
