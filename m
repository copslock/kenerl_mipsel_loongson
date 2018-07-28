Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jul 2018 03:24:13 +0200 (CEST)
Received: from mail-eopbgr700124.outbound.protection.outlook.com ([40.107.70.124]:62912
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993008AbeG1BXvB9yYi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 28 Jul 2018 03:23:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEspzAM0+Y6JhzQzPT+8Gt4t5dAB+2G3eJAHk3z21Zg=;
 b=LnxxS1ivg4hX8WYu/WENoNQTmEla9vyEHlFc1toz+oK+juWjuerMegIQIDN0dWeLQOz357Q9iquLyxo8wu5XgJomAWnO0KIiH+i7ZAmaDl0aymRpyzvLwvdVQN8JQO2kcdKs9CAt+dD0MqpRUJAYBjnqcZDiZZoUoM2s0e+FR7s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 SN6PR08MB4942.namprd08.prod.outlook.com (2603:10b6:805:69::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.19; Sat, 28 Jul 2018 01:23:41 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org
Cc:     Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 2/4] MIPS: Fix ISA virt/bus conversion for non-zero PHYS_OFFSET
Date:   Fri, 27 Jul 2018 18:23:19 -0700
Message-Id: <20180728012321.29654-3-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180728012321.29654-1-paul.burton@mips.com>
References: <20180728012321.29654-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: CS1PR8401CA0042.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7503::28) To SN6PR08MB4942.namprd08.prod.outlook.com
 (2603:10b6:805:69::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 770f53c5-d778-459f-60ed-08d5f428c15d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4942;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;3:HKJvAq2JAsAASlZQCdwbNGfNabXEbW98WdUXi5EZGwzBCbU7T/l+aprRHE5bR289rHQN4+AoKlShyIL1cKQdCC1PUrfihyBaX7sGbKNnRuQ4k9Y1fAzyNFo/eynk9xJNqkxsi4eDX74YcJxaxhNmOUgNjZKk3LEY7fY05mWPfw5NU7m5rmJq5t0r7Z5R1lOx/TJqUQ3WSehkCNyfVzWzIz1xVSmzgxeV9MOHhbNgHxCotvo3f15r36rrDt7G78Ff;25:bhjBygfuDrHTQnlPxNDWqV69VmgUSzt8N2ACLjNxWsnJkHlRLd7E4YDt8HUbs+wpUxdk7JLH6ryhsCubyHIedqQae/nI3l+ydSDeKAsu11bAzFCIxq+HFQNJ7r7xwgvzhS3jHnBPBYfZsdrdh1PKmv2UJLm4qct3EgnTYA6OP8CFyjCYN34KNhgA1K6oMHR6Vqe8ZWCmckQaTF4FsaWLBCgjDVXLZQbellr7k9Cg2iTBzxyXpqzmz3GqPlZ8iUuwkf/+1i6cFefIY2zS+YIqyezWNrJY7JfctMSYJ5GdhFx1rd00goGqgfI7u7O3a3jKOTVHe9fYIV/mzaIx7MMz6w==;31:X0rlRSAEEh2txYUbMrlHH97fb+N8kX2r6tyfVN0ioo8DZGqDvSxbqkX5k2gYHuKo2oor5cPA+ivFdMNwqVbRZ7AYqhWSLOrrVP2Xxo7Q8AZYLSNtSc6FV/sJY+X9T0/yPvK7GJJcMUrjahmUQqVhIxc9FWsjXODHNny1ng5F2gAn14grlQdXjHHyNV88CpXDc0LGpjHuOJ2Jgrff37So4KubggyOLjdEJIvgjnu7jwo=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4942:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;20:pTsg/4xjSkGkUxFWZlMi6QpuhLpG5i31plr57FpLEfPLpcYZ8GKErM9GgTS1rb1CO70AbfuFKQHIiTc3S5nGNk1B1gAQRFg1SsiLXoQULW+0JJPAduVwzpWWyZraXlXgG7+aRMYl67y9FWB6/T/4yoKoyM1Y+icvTAi/EQ9dXMnrBe9+4ouWQeb8tc5D4MGvnZSMiiizuGX0QUq+lD8aG3n8xLQHXU28Ta34hhVYsoEWmLcV3+XF0ZZ42s/3ZvkP;4:bcbvz/8NjT0qf+YZq154j4133vHGcEYB8gFH9NTV2IuM5SMH6hJ7WGEIupaqkUuQB1NiJKmIdqZexjyj2fuUAW5A5+MCjKjJoFZFE958qiluDpPnD8CVZJp5JK4nTcbjsY3CmDR196PrqX02gHbBIwC4Y54F3dCWwDRXqYYXb0u1q3Lr+tC6CVJo0OlziR/vlRpxT7vcbifH+qtd4dxr62X88ZG8iGGl0H2LQC7pM3iG/HPUtFDqKfQxSVEI9wFuEq6xAXrF0Sxnf1k5QTRIsQ==
X-Microsoft-Antispam-PRVS: <SN6PR08MB4942ED5B921137823E33E9DCC1290@SN6PR08MB4942.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN6PR08MB4942;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4942;
X-Forefront-PRVS: 07473990A5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39840400004)(376002)(136003)(366004)(189003)(199004)(51416003)(48376002)(50466002)(47776003)(52116002)(956004)(76176011)(446003)(42882007)(486006)(6486002)(6512007)(11346002)(476003)(66066001)(53416004)(44832011)(2361001)(105586002)(106356001)(2351001)(97736004)(2616005)(69596002)(36756003)(6916009)(16586007)(81156014)(8676002)(81166006)(478600001)(3846002)(1076002)(316002)(6116002)(6666003)(68736007)(5660300001)(8936002)(25786009)(305945005)(4326008)(7736002)(26005)(53936002)(50226002)(16526019)(2906002)(386003)(54906003)(6506007)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4942;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR08MB4942;23:Pi2uxLCQrpaLboV7Bbg2nVw0sqe2jMehpXZ1Q6OXD?=
 =?us-ascii?Q?JqmXGUDgSVVKzBaM2Fo1hzX4ps0AHT6TmvGMKikw1IpDd8VQqNZt++v7FN3b?=
 =?us-ascii?Q?XI4qdiKdtSSZqZoHJCs/Z9NuyZ1sPTIJHtTCeOCwBP3Dx8YRIrxnr7BRCwDt?=
 =?us-ascii?Q?bNYFs2mhvdknK8Yqoqt+dg/atgOuuy4sgUlS1V699V7xm8OdYtlPSzBUxyV2?=
 =?us-ascii?Q?2VZW3wPQaw9l+4AK5Gi/tNsP9jHvF/YIbPlRCbKywNMACgB8X6KhftF9MvDc?=
 =?us-ascii?Q?I28tOHwLJ6yAS3fQH+NBhU1qpjbsjq0YmmZot2l2KOmBtWGTlp65mc3xZuov?=
 =?us-ascii?Q?Rd2paieEyBdEekop2B7fjvb/nwABEXT6H70lLkFl4m9Uei+oR63b8+Cw/d5d?=
 =?us-ascii?Q?Zrb627CYkYOly4zc1SgWQ+bRSn6KH+2DJxyAlsdmNPZCfwvlnYB56Ih4T2PT?=
 =?us-ascii?Q?wfKIIMXnpDgNAi+raKPy/rT988XWerIdfcZxzdV7rPqPMCj6AfvnnozcXL6r?=
 =?us-ascii?Q?kpIVHsag8ZGqXpMDa8PrOB6pgd955IZngdLahE22T/z3ZEIUT8GmEfwV5Nip?=
 =?us-ascii?Q?OKk8tY/VlsFeZyOZgDTyTMA//Ltw58YPKemEPsnVIcHKxHqJEk7vWk0DhiBL?=
 =?us-ascii?Q?bwJM0S9SCWjVG5on1/Mizyn56on9Kq9eU3lnuzRkkT6i92F6g8226uckelKB?=
 =?us-ascii?Q?kHRIOY9wCENHS2VLPHBQZjOGlASELl4H7q8DEd4FaiDZLbsYxJq+bJ39Zyx7?=
 =?us-ascii?Q?AYnthx+bPy4d8gSXZeF21h/mmVE6O+YHdaLTwdHfgFKTlgGJYs29QiwDrJTw?=
 =?us-ascii?Q?l6+rsloxh3pufGozzH/TOV4q2os4Ak9wxsSF/0sb4frsQepUhTNRPa/ac3yP?=
 =?us-ascii?Q?uxZBZP6NWLV6ZeFHTrcRt+NI0Wg7fdVBdGUzQwOyct1Vtu/8AvEk46R74Wrw?=
 =?us-ascii?Q?FGalFZr9o+R98s6Y8X/g8A+Nhjaqk+ZDqTDN21izelYP2QMtXNV6qf0uqq9X?=
 =?us-ascii?Q?vovPf68DdmXz++fECd8Xv2lKtpOwdGI3LUxUX+NYsV+CjqYHZOYnaUu4q4mC?=
 =?us-ascii?Q?FtZf+i1m7RKdWKHCOF55UctJPc0qk6xjIENXHsb13Zc6aQnVhklthFsrqB62?=
 =?us-ascii?Q?ywYfZvEjHRJcldc8caFQV8dhxL3d/DaSxLM3m2DPOUcXwBgsUwibdd5HjGTm?=
 =?us-ascii?Q?SMtqSTOpGT5U5g+VINnruEQwfSmhOMxeHtdZO/41LQujHA2MFo+MvRneOnbD?=
 =?us-ascii?Q?BuptD9+j8sHwNmQ8u4lf612HSqzMQ40Cpt64eByvtwFDdhKaUPn83ZoV3wZQ?=
 =?us-ascii?Q?fRumhPWlwKji9JCF7/hlwE=3D?=
X-Microsoft-Antispam-Message-Info: yWDaeZDwn44Bn/ElqOPUHptgu7iJTuSH+JxayGwuK2ALlgO9LfRt30S2+ggN8nCa2L9mLYG5bzkueAHPMTW2rBaJNXKDwyLWKNv0Vvx4A+eO8nPFZlP46dGtmBJB2N2/HuWgP2+VilSf1FErb3575G5Q0esJdFh3SmksUp4fn0pg1bo6teWQk3F0wHV4XWQXjK0ANA5NOImutWYkgaNjVLf/g+VjEep+wBaY9DD26UZzm9SjoltLf38coiD5sMubiveheNYb9TE2nbrli7iSCaxOd4zPw5v6EPa9M9iRA92Z0f8PIyy1rFAmLKj76NKqqobz4xHZe8lZEbR/VPhqZbDcx387H15vdOmpzuxgS9Q=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;6:mpBCoAWnuLrj+62NApnnQL7C5gTLsKc5xYfSbpKuPgQA2/+FHRDdMI5zDj/Srg4VdDTM4ENkF9Knm9bHTqeE8MpBzOK5AIjHxPuZf154UujOYPcojL5xlJfgOBzl54hc3OOlgTZnKltHYU/SxS23qjYZ0+ufB/aJGbS6jK5ZdZrIKEliyH8b4nTEScMxapMKoJpaz2RpOLz+NNZWXShAwwHj1SVLG6EAPJDFAP3fSMWh+5344EG76r0SLcuLGuugDegAlEMUFjMxEMhdOm9cLKZkFNYtBviIpmP+ulGbUzhInQKnnRsnIrhwyvXVOaKF994Do/AoXEAI5lHMNw9Dg+3Xb/OO30XwLwOHPOMGdt/Dh1niCbpwOsB2b0xiJRaIcFiN9G+tidp7p5pkcXcCWwB8dfJYjX/c6j0hoJlIalg7KDS2Y54WO7t5+bUXkjhIDGipNvBWnwTW1mly1QbW+A==;5:C3m9CngQgRyaknBRfEcFwqy3ll+kY2ETApVBl9wFuM7MRmw0ltWq0sfHW7m/rja6MexEHJ1GRnE7YaBfyXvFQSOnRQuZbfBzwed2x1Eem0q1ZTS8C+Ttyqgn0fkoN5nG/KPNlKCYyEmlxuxFaJ149OsfIlqSk4K56TO4EYlkdxs=;7:RkvZYpZOE1ZlliI6OQLwAd/6qn/PNlihsEAT9yN8KgyIYQEuKc15ymRpq4A89+s9AQJwRhM/siTG1s8Q8nrnSZTycXFPBWYTvoo/G3bsHEn+6+MQO9a34tWtn+7Iutc9kF7J+OCitAhHm1rQjSxNQltAMt6CcUXAPIt4iM6AgUcFGsGKTOD1PH+r6VEncLSyULxPVUm2AIJsTg7f1B93K3AZQ4cHygRqCRPL9UuHEYReYjP3hhdNoKOeNjd9N8XW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2018 01:23:41.9035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 770f53c5-d778-459f-60ed-08d5f428c15d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4942
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

isa_virt_to_bus() & isa_bus_to_virt() claim to treat ISA bus addresses
as being identical to physical addresses, but they fail to do so in the
presence of a non-zero PHYS_OFFSET.

Correct this by having them use virt_to_phys() & phys_to_virt(), which
consolidates the calculations to one place & ensures that ISA bus
addresses do indeed match physical addresses.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/io.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index cd170d920d55..54c730aed327 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -143,14 +143,14 @@ static inline void * phys_to_virt(unsigned long address)
 /*
  * ISA I/O bus memory addresses are 1:1 with the physical address.
  */
-static inline unsigned long isa_virt_to_bus(volatile void * address)
+static inline unsigned long isa_virt_to_bus(volatile void *address)
 {
-	return (unsigned long)address - PAGE_OFFSET;
+	return virt_to_phys(address);
 }
 
-static inline void * isa_bus_to_virt(unsigned long address)
+static inline void *isa_bus_to_virt(unsigned long address)
 {
-	return (void *)(address + PAGE_OFFSET);
+	return phys_to_virt(address);
 }
 
 #define isa_page_to_bus page_to_phys
-- 
2.18.0
