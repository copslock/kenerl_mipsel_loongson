Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 20:32:58 +0100 (CET)
Received: from mail-sn1nam01on0085.outbound.protection.outlook.com ([104.47.32.85]:25314
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992239AbdKITaKi3YXL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Nov 2017 20:30:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=LGD9GdPpf2VjSZ7bV8DMndj+Yb5/aG/sJF2AwnuoBtY=;
 b=W+TsuqH1nsURRwrGFlw7w1Im4TaANMOLVwochNvnbNBO999ptXfT6zNDhEHJqUfRU5kO9YAmAK2NH2K1IeW1Ooa0Jjoy8Ezovp04nKLL93FvQZ7vF+2tXmUI/lqvP0QefXHgCcwe4/C8i/qfgQPaN948W9Lny6N+e8EtzWTeWFg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.218.12; Thu, 9 Nov 2017 19:30:00 +0000
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
        David Daney <david.daney@cavium.com>
Subject: [PATCH v3 8/8] MAINTAINERS: Add entry for drivers/net/ethernet/cavium/octeon/octeon3-*
Date:   Thu,  9 Nov 2017 11:29:15 -0800
Message-Id: <20171109192915.11912-9-david.daney@cavium.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171109192915.11912-1-david.daney@cavium.com>
References: <20171109192915.11912-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0057.namprd07.prod.outlook.com (10.174.192.25) To
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9244cc4-9b30-4c95-92b7-08d527a84557
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603199);SRVR:CY4PR07MB3496;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;3:OaWxPnLF3H3M7YQjycV3tsEhSZ8GaB/zrjJkg1ZQ+SXAIlgGdYt+Te/WD5oI107HmShMUdLAL+h/6mRrrL6AaEsrP5Xs5HzU+nTw4AuoeZKjDuR3JHkWwVUfNqr4vqsPy8ser4Kj6astVzRy/7z3UBLIjVKHKcck/iHM2eFT1uZTmfAqLQUCN/jO8KGJun4dLb3CDeF7t8L6tlxlTb2UD0/cXCZIwbXAQfciHyceF6fx6W/TUcyzBlxO0C886SMq;25:Tp+tqN8L3uEVOQr+UahEQyWw8Qu97oK+1yvchWXbiahojJcleZvQQ7qsfE4Mh0lcL5BRAeoH4J0cGccUsSuvdmKG55aCyFzsV65bShviAsAzNlWSGSexNSiEQzxTAmGuioD16zH7XCm/sXXiXWpJvR4fECxNqgAGiNyKux8mO7OushUTVHSNN5juM6pG15TgdrLVpPNzpgxNolMybMOFG+B0Su3gqgF9Lo4ew3+wKWc/5rihO5CRKZs2isFPIEmO7mPbD8zVd2WJXPZrerrTeflcnPdSA4Prne+Qz3i1D5ThHagmXWF8++iBCSV0teSHjc3OtHCLPum0SOeJGkh3jg==;31:4xcrGZCQztliPGJA5BVKIXWeVavqm97emDo6jwZwEZqMfip9FzZ5T9haOu15JA5Gbt86fj9LLqbc8VL0D2C1fpHrVbqu/PVfQ+lmRODt+CmS+4d/01eBpRXFDUrWRaWKQlW/hmQDUSwkfdfIpkIVs5ZD4p2ym8JUHFJZYzZCP1C8BGqezRZnWMlnhimiEDmIoBAdihVzELRYKvvzvHrCe6OL7yYSCLOdc3ifZznESCY=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3496:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;20:NUEeno9hoy8FzH9VdfR8719rru3gewdFCMRcl2WJZq5v3AkPjflkHJvNjc6fH0ImrKjbDK2nejkd+UZybAaTKbzeXsnnRUEyyPxWg9Pqv5+mu5jkLfpon2riZCMV1Ua+nQ8cWnVyRJBM2cyDhfyc/jlrYv5XPl9Xsr9NxPyPvlcH/rELgXUFmJWIfz/Eukq/O+AsYJm5J37rRDJ0ekRGudqxNSBbG6qOm+RC+9icSxeego1uz+2TG8Psyuil0kdnmi0KY55kT6gE+Dbf9ioMo3qw1qpTHSuer8LAvim4BDKOrdq3SO5Bs4BUDSKMHu6Ku9oSMnP1F/jyzfRnci7xH5bw6GYRFjv01xhqcwAnNQNFaKML1hJdCK7VAgC49GIupnNoEy/tzZI8Ao2IsrBIYBmMVU7oPaurukQjeBLNpXqRmxPjFm0ZCdbkR/CG4KdEcDFQjVfmBM4pPt48VuImTtEqLf5864DRaRre0SxGOND6OoWoL3ANrk35PIsc/kIL;4:iJTOwVgHj7Kgoc7kCBoTuLyU1Mo9bL3hpc+P1Hi5bBzGaOqXrQwWJfysvmfWHBtwvzYJqA149hjy4zqqdaukYLANsQKxj53zFsy6UqJ2KXp6ocBB8LkZBxekLM6AJBWkl3+qreBeffojCct5cZEIgURLhmLnv5HwbhKGD26/sPZK9G9KQiFTQh16cNa3KCojsfymmaqbbN1Y4pLUSsGLPbn1RmCd5ai2LAWmuiyqc6a3Rdr8nF6IDRj3MloTUU/3XP6wDNknk06dMVD0/fYyBx7YWgY+/VkRRDTVt165bfgjh62v5aoo+TRQJ3wzibi/
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-Microsoft-Antispam-PRVS: <CY4PR07MB34965ED6F6E1EF31460877BF97570@CY4PR07MB3496.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(100000703101)(100105400095)(3231021)(6041248)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123560025)(20161123558100)(20161123562025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3496;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3496;
X-Forefront-PRVS: 0486A0CB86
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(6116002)(47776003)(6512007)(8676002)(478600001)(81166006)(81156014)(1076002)(36756003)(101416001)(6666003)(2950100002)(69596002)(110136005)(189998001)(86362001)(97736004)(2906002)(54906003)(3846002)(50986999)(16586007)(316002)(68736007)(76176999)(8936002)(50226002)(106356001)(48376002)(50466002)(53416004)(105586002)(305945005)(7736002)(72206003)(6306002)(25786009)(66066001)(53936002)(107886003)(6486002)(16526018)(39060400002)(33646002)(53386004)(5660300001)(966005)(4326008)(7416002)(5003940100001)(6506006);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3496;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3496;23:/9knfSaveVnhyy5sCPf7QC6hO0XZ6BsaQqs0vFxFi?=
 =?us-ascii?Q?MtnBpQct4jD3RplH85GQKqYqIHJs6JAz/LnFsqnwv5ycOMTk2MWD6eBbZ+g5?=
 =?us-ascii?Q?2O8jiAhXbxdrkpDAdj6NiNRS+d/RsrgoLQ3pYRg3VwuOxCkBy0vJOe7lv9Wp?=
 =?us-ascii?Q?v5zR8zkgH4Z+aUWk2+v5PwW+gctRAmjsOrkO3BZdsKJsS+z1VWLK/GANI9ra?=
 =?us-ascii?Q?QyQM9DNY6ONP6tEVpppXctoi40ddS1uYpnw4IAZSVxQjKwkWxkGcWgwF95dD?=
 =?us-ascii?Q?ScrqVO/pfmMe58HczzOsGrXvCz3N4Ij1ZKYC7XOZ+FXrhBqRVLDIrtN6mk7C?=
 =?us-ascii?Q?M+DbdSj5tnMqDV+CHupHeAXPUwpbh0zQbpfbwWJnQ2U7I3U4Ini9yk1dIvsV?=
 =?us-ascii?Q?f9fkTZhhj97iAEnD6FU0GikdLBqZUlXmZWK467ezXfd8usgSZk8wCLKsH+fc?=
 =?us-ascii?Q?7WKQ3z/wwnc51t5BNXnlJB07vCEf7OXtbsV7zQdb5gjuizjSIy5liM4AkLD7?=
 =?us-ascii?Q?rvuGfXV6UpM/5OKnLCPXgFSTJcU6sWPJDSosQXTwNKZCdBzVYIpLy60CcPSE?=
 =?us-ascii?Q?Xrw2dNjQsBQXpSON/l2ukKlxIlFmtUOeh/hwbtrFe8aOsTu+EnNqxoOoWIhS?=
 =?us-ascii?Q?wtXz5G60y0Dr0FEXYeLmiBVm8G+9cNeiarlCseXNGN6dDZM7CvdcbwTiFnPz?=
 =?us-ascii?Q?EphugQ6qrrtNLoXxCDACXEc546ULB4CMVKVCmUuyUkfPOZWuQArfiVKJsF3f?=
 =?us-ascii?Q?I1AdY7u1C7rY8h6N+wwx9xiyE+Q2Wab0YYOFZQBadKOYfYp82MwqAVEHHqH8?=
 =?us-ascii?Q?1JBLjpuNtHy7dF5GkCeBiLRlydvf7Xtv1r8+3OopNHKXD7mYgYy/LiBkvBct?=
 =?us-ascii?Q?Wlz7SQwXXDTg4XmbNYQq+aZ2VT7vZ8GovoR9ptf9oP5woBze8iy7YBIcRQaT?=
 =?us-ascii?Q?QBiLnr7ZJiDOsPuQK32E1k2DU/4t2wsQP5z7pn90biXPGUwrlLc4IRyYs/S9?=
 =?us-ascii?Q?LV1YbH1fPdP8Sy6spQfY2z5+C5Pih0ur/8PWrsk3LdsOa0U17RWNeDKv2wz6?=
 =?us-ascii?Q?hAzT0PtRx6EpBzhwHiBkLt+rw7QkiLG3hScjEh73zLFIj35ByVM/6/VBBqYM?=
 =?us-ascii?Q?BeqzhECeyqDqpOPXUmju/2SaMvNPREiphNvmtc7uxgXzZQGnQYDIXEzOY51C?=
 =?us-ascii?Q?P2c/MQjjP84eemRyHE9Dcj10tpHT+YLmBWudizGoClg0jIds+qPfFKEVkcuM?=
 =?us-ascii?Q?2hxevrIkD457/h0F5JfMNL48sty+l0mu42X9GZHBv2+ncEu0PvHtMbvZyQa6?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;6:Yvno/yrEA0r/UidoaZzOgRu70SNEiogRzUrCVRhhEeEW71Tl1UxuT6lvKnvK/6PSKp91XxjW87yeY04xprbv2qVPCNenEw8to9N6joVSwqZ1aAsGnSJJjxZlFfnsCoBt/sNq54/DUP/ABanOpw1/1A2T5TRKPH63TuQPUnekSJbkr2m8BApdejGwFmCykewud7DsDwZJtd3V8jdIwaf8deFFNgI59euawc0aY1YE/ASxqxfVbDanOsQQBaVcMS2dAP6ZZltt3mEe+TsnU0TFh8SXIkQnNZsrmKDfSIhZ7qSPcsvVLy73CpjQO99ZN2WWEj57eAhdyu93LzDKIbrbuGPAroR1VRxkjvUwn7eHnCE=;5:3CILPlEalY/TaGVDhYrPMAhEQcNGVYp1KaGEV7zHPtfTsLsuk087voEQvoyJg67o4aP6KL33YVr/nQ6cCqS0Hy2dgThLfjKCtHq+7cdSOb30Ijn6SNpj0U4SwloJADgkDzWaieVwHXN8SgC2UlqgK+EiMijfaV7/ExRuEKnj+uo=;24:Bjc3n3TVjmqdsNwJMIuOhDgJV2O2F3GKItukcNhGsvsrHEUI9B89XfExD3uFUDvALJ4gcpuAmGZ2oYYtGizCh2ZHfFZmJTTuuRDJ74ymFtM=;7:KBc+LGKTat0GXlAWTY/JsjPnAFPFgbdHU+5j7cVAOqjZSUicLc8hjqAPWKyyO61ITnb9kop8tP+IKJkBM0jP+mwThCNCbebCNSd+SxKheLBak1Ehi5CBrIcwPuibLOUywkiagw22GaCQ+oftYEa91j75tS18LGDeb6+Nzf/RWS1A+ax4eoR/0WQIgDHzI7nSZrZJs+nf5UIRBCkE/oN8c0adJ3qHUs3enggKleOGChPsXJ7LfORILh6ajuH7s20T
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2017 19:30:00.6180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9244cc4-9b30-4c95-92b7-08d527a84557
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3496
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60822
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

Signed-off-by: David Daney <david.daney@cavium.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a24f56e0451..142af33adc35 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3212,6 +3212,12 @@ W:	http://www.cavium.com
 S:	Supported
 F:	drivers/mmc/host/cavium*
 
+CAVIUM OCTEON-III NETWORK DRIVER
+M:	David Daney <david.daney@cavium.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	drivers/net/ethernet/cavium/octeon/octeon3-*
+
 CAVIUM OCTEON-TX CRYPTO DRIVER
 M:	George Cherian <george.cherian@cavium.com>
 L:	linux-crypto@vger.kernel.org
-- 
2.13.6
