Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jun 2017 00:29:55 +0200 (CEST)
Received: from mail-by2nam03on0078.outbound.protection.outlook.com ([104.47.42.78]:23616
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994626AbdFMW3AI0Qwu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Jun 2017 00:29:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=jhvmtc8cSw4Guw3tSuwhL3iqvJs62Cijin40n0ei8hM=;
 b=gI5CyT22U5cCFjp+nzGPyW/e+O0cGJdDSRwz4Q+Yobk15OekKXH6JAL4tDEL5Kou07wwBzcwUWrpwTZtSREZSTE6xvsLoMtUfgqNlNp7tHHHuiejh39VM34adtrZL63aptNCBi2nOc9tgmmFldeG9WpaHm66ygF92rvkY/n9lSw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1157.12; Tue, 13 Jun 2017 22:28:52 +0000
From:   David Daney <david.daney@cavium.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 2/5] MIPS: Correctly define DBSHFL type instruction opcodes.
Date:   Tue, 13 Jun 2017 15:28:44 -0700
Message-Id: <20170613222847.7122-3-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20170613222847.7122-1-david.daney@cavium.com>
References: <20170613222847.7122-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0048.namprd07.prod.outlook.com (10.174.192.16) To
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR07MB3496:
X-MS-Office365-Filtering-Correlation-Id: 3297bd5d-3f93-44a3-f1d4-08d4b2ab9255
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:CY4PR07MB3496;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;3:n5/p8nw/51iR9YjEJaBowdnNzArOzOaijYZjYj7E1CLzopWxX2eHeeL4qN1OqyHDpCxzQENnvVQeD8rqPR95XopTpI4SRMsdNQ0w64SxO9EHszoO+beaw8ZQGIKsoSfLV89WfrTNBgasDQqR4HgLrFfdYbv/mTnQfnvWeF9hfLB9SxMAfKSAibL4pFgMascidVCdY930nRD8xxVwbYwt2qL3Uy3ZpoDVdgJ061rOwhFXLbngOLQggZ+brO6xdFK11GxrGccKBpAplRGUOFIwv2o9rcOA81iGqvg7s887awgeBJdwBitOy8PgYb14ZzKczc0wgSOJ9JkadZO6txGN3w==;25:9Fy2XzAr7iCjDwGV08xl43PHy1B8My9ceX8xr9UCszR36QFeDak2lhHNm3c6lPQbyrWABDaRPSe0LZ8HtQp+8Z4zFp7gvv7TbC33lvVSIR+v+tVWbkdFU5XG5DcKJqh71eJQCjlNSt01c0MjhZwREmTF7PoJY7m1sC5mQ9oakLLXNYhS02WZ2nEWxqJ4zKZ0SX5fTgxlj6SSOZ2pdxAsYeW8UC+dlPeG68NRF5yvVeBsNW5C51nW2wdbhmK4fTiFzLC4ogIvF8gKJxKMb1H19BXwd0xkX6Wx1dIV+SEEQxPWMwRF5d4w9eCnSpWVYkGB1YZN4x/8sxDL2N25Nnex2ONgr98p+42uXOx9EiHQFv2dz22xUeKE5eG3upaI6cZL0uJ7GYEYnWnWOg/tmmlKyYe5fwnnuu33YwZVvu+ZkdbP8kQvBbpVoRirzDv33XXG5QEYmF/xALaI1HccHs2FVG6z697jHv1u1W8tJrj2ekU=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;31:C9CUmjGPKIuBWQs6f2A6iStXfPnLH4VxXNPIlhQw/6xx0pjF3bnyYT1S2Va9b8hQvKryWfD+ivgeUsSh5W7dpvnoTxrAOLzPvRpdpAh3MmcQ/WvrtTQb420Xo7hdKBulCkuB8VcOKLYURUSai5DXNy14O/nLTh9LXzYIYOxt3hsIJjX2enRI3tS8C9xRBmQ6nGMVfBdCYnjigiK0Fm7SktInxJIgXU/CDIiMs+vH+Qs=;20:wR2BQsiOdsMcyseoM9jWT/Zl3aOhzzI/GVvH4WTucbbKPqS++hIS4Lbmcer3i6/vXVWyhZ6EKGlPwmOgWph5SRK14rfR/JCddvFKYSyX26cNSzbVM1ao4X+XuSiOI9KCL7LuTdSL7dDiD3EWdtXmR0z/43yjLG9aTngqC0Ls/MtxX17/v8SXWJt4rZ65Jo7LB36YpC2jEbclY6/WrnjHFjmPdSMbMEfMdxQ8d1CNpW6MSP309VTvvMvTECBBRpFCRbYVA3T7EYYGV4Kh+9QXsyDpDl9w0u8GXxSV3A8s1egLgjmglbht6s1YaHizUIn+qmiCukrSvZ1Acsz6S2X/f9HkqH80Lo7tZ8FKv+W769rk9P0MgWTSOiMT8pVoXgsbY48gJtLEMkudE3lrYjfL9fVWMgd+PyI6WUNtyWYP9FJH8w5eVjxWxGMWTuMExhBTydovwHR/pBEkwSLBE3PLhLCTDyxGSb5nzfhMiZGd2YIn6h28XslBrl2bi5xQ3TNh
X-Microsoft-Antispam-PRVS: <CY4PR07MB34960A20A3032CA81364BC9297C20@CY4PR07MB3496.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(100000703101)(100105400095)(93006095)(93001095)(6041248)(20161123555025)(20161123558100)(20161123562025)(20161123564025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3496;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3496;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3496;4:RTlj/PVvXn3OV4wUiwO4cR1whwNiP/rVlQFW/Adt+y?=
 =?us-ascii?Q?us3nbgxl0eRC44nkGwW2ahS9FhOby7HEtyUi8AjMQ7S+c6dosPtmFodZzKXK?=
 =?us-ascii?Q?XOFTGyYi+QZY2LJl0mGrslmld8zLbmRFuah0tExZ0oRqRpAZM1EYWX+8R19L?=
 =?us-ascii?Q?Qt6/4QHkqSvrqWjl0ZNPX7KYBwVP/TRj3/JnnqqEEVcuPIBNXBsuGv3W/v7x?=
 =?us-ascii?Q?tL38XPJttR+lZ+BCRIes8LWdzeUFt20k/a1J+iHAON2X504l/orXhfY919Ii?=
 =?us-ascii?Q?4gG8Y4Sl+UbxH3x/V9TtEllFtd7YebekI9xQ0JC8dr9SYAI7Bbt8bIXJfGZl?=
 =?us-ascii?Q?Gtz+MdFnuIFY9eiVg7AIyDu1KnxCTNKz3jOUsUh+sk1KbgDmp8LfKqKXsPv7?=
 =?us-ascii?Q?9aP0ABXoyF6/YRN8y92tc7I5W+fBV53EKycqVYFI93vpg7MN3ZBtipgwNIGg?=
 =?us-ascii?Q?MsOyR+b8BuQ6WHYp1OThWZ1+qWJIgy/R5N8P4l5/bMd/cVnOIwYximoV/EVN?=
 =?us-ascii?Q?A6TaizJhx9jXk+PbsqL60onaxyPFglEN5vG1heckGE1h+xNYGNtFHz1/0E1G?=
 =?us-ascii?Q?JxbRJXHeWp8Xm7FFTcJNcOXchfbx4PGrqS2Gf0c61gIH85ekBQWDQWmFINYj?=
 =?us-ascii?Q?k+eCUPaeRuZiOBkwzE5Y/BsEarABS2EMABbedkhixJJz+YVosObEfSJ9/6Ko?=
 =?us-ascii?Q?LE56D7ptAMVeH/yGSpWwqWq4SK9BkhuXOJNNqBiR23DKM1Adk9GP+qH1GzzX?=
 =?us-ascii?Q?5niEnxzCqTE1Sr0TC1zRn63fMJoEybR0Ajm71+wsNBg7RIgjWUOPPhRnrstE?=
 =?us-ascii?Q?cjSJOh8Jv0u+kZE0PSS0wFj8CSyUNPgaYm3FK8kQDgVchj5F/V+kpXcAthJL?=
 =?us-ascii?Q?MupAxCCzrTc7/XMWWcQjcSyTVWyzpaWL3q6O146OGLULSeIxQVztHB/EWUCC?=
 =?us-ascii?Q?GD4cjeMGVsAmWxFYxJ4zfxZ7sfpv6ho9C5xDIz9VkmeuDOzxz4mZnFGwNkfF?=
 =?us-ascii?Q?B/ufA1us4ZhCWLww5Cn0t4Jnk8W+EPA1R1ojNk0O4RXDr+y0rzzqHfWE3vxb?=
 =?us-ascii?Q?wenV5QzVtLLSBLXJz8dX2xBHRBZ8nJHi5wjEFQGKTOaYiiJ7EgVkQCd93PQP?=
 =?us-ascii?Q?fx92mJYmJjO1m3EXdb5Y7k6mz7KaBi?=
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39410400002)(39400400002)(39850400002)(39840400002)(39450400003)(199003)(189002)(6486002)(1076002)(6666003)(2950100002)(36756003)(6506006)(105586002)(53416004)(42186005)(33646002)(106356001)(101416001)(50466002)(48376002)(76176999)(50986999)(72206003)(6116002)(5003940100001)(3846002)(50226002)(305945005)(97736004)(7736002)(189998001)(81156014)(8676002)(68736007)(53936002)(86362001)(69596002)(38730400002)(4326008)(54906002)(47776003)(25786009)(6512007)(81166006)(5660300001)(66066001)(107886003)(478600001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3496;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3496;23:gjJjN+fVjjUbiHujvv1VLyK4xh07XmEvFP0MeqlOr?=
 =?us-ascii?Q?YVR+pXHezBizdaEADP/iLPtsjRCU5K2Pm9Yika9Ry62W+SKxtTms10SluXTL?=
 =?us-ascii?Q?b4YIimJS+9FmOyvtLFzPt+anyXEipR8Z+7MZlI6zC1+bp+wbnEwCs0M5OFQh?=
 =?us-ascii?Q?hO0XOXOF7k4YSd3rSgz4LjmlOtna1zOuKXbePWLB/TJTQQQqiNcjpuNFO3V4?=
 =?us-ascii?Q?ljEh/zWMlaWvCtu8w02qHIPBcIthaXuEi7hfCYNV5t5oFMHhz75mlrT2aPhw?=
 =?us-ascii?Q?EqOqeYrnl+8cDVTQbzWYQ/FggxwRQtjgEwpOmJwwTq5SlT+MahsDMR55YTjc?=
 =?us-ascii?Q?0EH2SDwSuA9YFIeo+qxQ27anxf+ZGx4ZBRwN85kGwuZFofMPIczgR0NQ6wl/?=
 =?us-ascii?Q?rZOKIjuP30e9eAQDBdZ9LVBNcPtCQPaaTyfZSPv9rD/wiguiwBAlmaLqPeGQ?=
 =?us-ascii?Q?i97XU2mcb1oIpcKrBkkQOqwMjC9nUwItOFdBDA/mgLxuB/9ooLhccMcYK8Sy?=
 =?us-ascii?Q?97JznUr6OeGk+QYgWdZmMeTAVdE1DhgLpmHIhvbxiFRDIwJZdBc13hBAZm8O?=
 =?us-ascii?Q?7Inx08qo+phzJ3NpshcLNEKgVFyjUX2CsakCqrMTkmEopfJPIwYNyr8uHQE7?=
 =?us-ascii?Q?pVIBlsUj78UlIm28L2gWdHjWUAiEX/pkyGjh7xu2pC8iJWhj9AyftFWAW4OC?=
 =?us-ascii?Q?98+h4AuBNuCEYZHUTpCz7O3huacDvB738WAeqEYJgzSlAxLy6F0x/Gdx6o8/?=
 =?us-ascii?Q?tv6RscnnAG2FJLRku2AYuBbhzYze8kh2goj/CEdCWTgaBz9AzmQDPQeBAzlx?=
 =?us-ascii?Q?yWJ0zbEtZjo7UMTJsRHZYHKnGbvlBShwUSxiMv09hx6qllvv/Lr6glNX8oae?=
 =?us-ascii?Q?CY+3XKtYhepHBQxx7cx/Cwj/cPENmBGn+C0XtbWGphqVauQht5rKkosqWTXX?=
 =?us-ascii?Q?i1FDyXXOAPe4PRBcn/SuOUvCTyBRhf9zKss7iJoRp7CilellB4LH5zr+USp4?=
 =?us-ascii?Q?CYyeLcBEhthE2bZODi8mBySzyGi2feo6MK7yYyAMVsAvn/JireHFwMYt4phe?=
 =?us-ascii?Q?ZbXlDMRXcj0cP/K/b/ObsuCAAuUb5WvhTuGmvcqJTf8UK5KlPv+Z2nZFfiH9?=
 =?us-ascii?Q?9HJo8u8wDt9B/QYoMMjJQ0F6peh0KDRLKkDhbRmBn3Ota7UxXdg4rYFsTXco?=
 =?us-ascii?Q?GsTlRzscx8sGtfZK1s9c9oHOOT/MuM7aT0jd0GGa6peZbIdynk80tST35Ko4?=
 =?us-ascii?Q?PuD7mKZzzEuPhVMRF9B4KL7pMdncAJkJORSVX6l?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;6:62ZHGw0rbGulgMoxv0i6FTs44P9fH7pQwl65/Lh2ekxgq+3cHHXYPRAUYLSMnKGyFNcndDVKhWCVqfH1voGwpChJrDmFNJ2lcN2t8tmAbvtDDImfzBEDczxLEYM0WAsxp/blI+GOrrsyT/AP5uflAfeZbIlZ37n7jmcjjtfg+JcK5swWbh+xpn5NDL3UPlRqh0lVz/aeXQZN8CVzbFg1A6naUfeLFqqjInt73GNR49H/RdxKa1Njc0jSu3u5Daw2VsMPVobXp5RZwiw7ai/SHvTWA1slG2qmYRRO789CRVPYVAujfUDplEgBlOuZyuwjN0wveiBHRaehOzr49cj2cKSa37J2ZHLZrck+xOhljH6+1Vo/AmBYg/5SLMwSIAw2agX38yS0SbfXgAf2B0bRAO9RwYXw2zEumtFWyWZ1B3Xvik5cyR3sszb0l0OJ0oeGYh+Afk6jRYVz6CmiB3kEb/HV8NaGcLl3lT4/XLvW9S5zppek4TCz51CHGTR3Oa438bnizU8S1cKMb0zkZcPWeA==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;5:T/GxJ6fNdRANI7k+BRXewF8Y1RMXCKKBx1242MQ0o4pp5qEJEa3xMm6iyAFjCOUu4OiaAIov60+CDwRT9lEZ1yxI/kxF3DerQ1MYGpu3H+1tE/zVUXr6bGpKphQthNH8/8UNdApPLGR2M+zf10D7Z5ZtlQX6q6bFia/005PN5ezpo6IkI/d+3k8ct+wE6SsqYLvk4H+PvAvY9cCm43PqVdIm2K0wLDWFW2whgqswohOIBX9WCq3/VVI5QCDwrAO+zyowXHgsB2knSHj354mhz/x0f0Iy4suvG25Rm8CLTFuu8dHLPDFiT7NZl9/wJvz67hXt21NIzRqJzDepGLeai4Snc5RtIccEbubaNrKSoV0jTXASccrAouzsls0smlnUomcyrfyvWy+bfHJx7eW8Sectlfe8l6xVsKw6CYkCgNwR0D1OnKrMLPhc31J7eAKiXqX46x3oiW5D5iPkKuSatAG+FourfRonGV/5pGsio8kRf0PSuMdWxmjHP7myb7vp;24:cq36jgdCCQLhFRRZ4LwCYG/JFUp00cwN7kO7ijF5iNRwtC+SQ4VL/Vopp7CQFqPHesJWjLzt7XrWgehD83J9do1cKeUb/fCNtP+cZ6VBSYA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;7:ZbOEimheb3x6gwfW0AC/hXSzvCUWMmEOsXzNfS0Gf8WWlb7UQFm40hPWhL5xa/zIxM2ftOVTcOoKkDJJAmrC4WPZsVdZf/JQaeMcifLjTSwwYVudM4o1f/NHm11DsQ0jrebuwW509M91+aFtWXFtdjMah+mTekp5Jk86mcfDe9zXwJH7B98K4ZOIbJg8eDwU/2KBUrHReq2fwqEpLh9MJFco+UeaCuF3tLjo4oxBrUO2baOyykn0jeatUpJHHaLbvFmD48MisNwbg9OsDc9K7kCdGLxGsi8UeXDrfjGXnmIqoMxrnQyi+PjpDEVd57CD+RcyDoh8M37ishLBcbrWUw==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2017 22:28:52.5184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3496
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58428
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

DSHD was incorrectly classified as being BSHFL, and DSHD was missing
altogether.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/uapi/asm/inst.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index b5e46ae..e5f5385 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -276,12 +276,19 @@ enum lx_func {
  */
 enum bshfl_func {
 	wsbh_op = 0x2,
-	dshd_op = 0x5,
 	seb_op  = 0x10,
 	seh_op  = 0x18,
 };
 
 /*
+ * DBSHFL opcodes
+ */
+enum dbshfl_func {
+	dsbh_op = 0x2,
+	dshd_op = 0x5,
+};
+
+/*
  * MSA minor opcodes.
  */
 enum msa_func {
-- 
2.9.4
