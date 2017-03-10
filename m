Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Mar 2017 23:14:30 +0100 (CET)
Received: from mail-cys01nam02on0047.outbound.protection.outlook.com ([104.47.37.47]:42469
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993906AbdCJWOTIXz4n (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Mar 2017 23:14:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=JM3DqyAlbkfpDfsy49k0PiLgsQv3l0HH/U9wJ0DT2gY=;
 b=QqZhPgIxtDpCnmUO64I9cY9CFqJR9iQwnc0VJtKhJ69HxC2GtSX/PGCQBFaWeCuhdlo2dh3ccBGy6Z7d1oLlkDakG8bblr/CWLoiY9vJ1dn0Ewl3mpJegu5gDwxxZZC7MvSURpjud0+/kVBbTZ3ZtrfpLt/4zw2IiegJb3mxfik=
Authentication-Results: linux-mips.org; dkim=none (message not signed)
 header.d=none;linux-mips.org; dmarc=none action=none header.from=cavium.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 BL2PR07MB2417.namprd07.prod.outlook.com (10.167.101.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.947.12; Fri, 10 Mar 2017 22:14:09 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@imgtec.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: BPF: Add support for SKF_AD_HATYPE
Date:   Fri, 10 Mar 2017 14:14:05 -0800
Message-Id: <20170310221405.30648-1-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR07CA0042.namprd07.prod.outlook.com (10.168.109.28) To
 BL2PR07MB2417.namprd07.prod.outlook.com (10.167.101.141)
X-MS-Office365-Filtering-Correlation-Id: ae0d2e10-773f-452a-70da-08d46802c6f1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:BL2PR07MB2417;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2417;3:RH0ehlVgnLKrUsQv952wclZbNxZtKdyiGjDnfZXowtZkOIGgkbHB5JtbcZ/4GfrR4Z5OsUVD+J75xytj6MyKjjAz0n9irJ5XfmwXF2g+4FM8qQ892VtbTPbwXtZ7+BC2I61EcBuFpUz/R80auqZEY4tHKLznfpvP4BADXc1Ob53JnIlSiF3lmpYXdwbPjz1yBi4aTglJa+xVkT2HFs5ifWiCDIRptxMqbtCkJxZsok2R2I/7JkVahO1PAaZ+R31cTn5LBkAT2qGXGVHiqKh1Iw==;25:wlwmgrtOc4CKH7Vi3JsdOoV2Uwpsio3BKRYz2z70+1Hct8YHXPV5gkh5eRlHtPxNZabVrdQL/MI+VLGVwNgAvZQwCAy3p45ctD/NkwQz4/2wcbctSys0w1EILMyZ2PEQrTraf+WN6ddTpcugT+LI9tVHHs+nBel6Z/0WnkYOjat0ow1JwHolyx2WMRLoUy7fww1GqdAGQRzSNDAyoQ54tMLXd9LIMIhGZCylhxwGOrz3A08gkRahSyjjKHt5IvRrc4EvuQ0Tqs2G5yVKSiXBHXD7zuTlUk/tQf7fQDEr2zwMDh/skuMedOWVEncSne1WBFOndc+sgcGz4JKJ8bNIvew2HoRpW4l0i0TXEyueIBw7/6tpfCE8mrMo42rwzSMxmXKUV9JcvQb18t/zsnFmj9zoK1a1dm9zgvPj60qQoyPoPVGfJaDBmsXOyxMQLVkm1ldZp7kEoOGYSqk0GJ6bew==
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2417;31:NFeeUdDa4i/PmvLo/raGYsXEWfWJjZZeKLoXyA4q8TaRFBkNyhYsuXt7jDhJrmh4S1WXNRRy+x4rQYAhWHAU+zfosMHH0GsO76wOEjcWAtNlLNSuq65ud2NP+a3KiiH+E9UloxJhcadnG2GUyo6zUpdwoeku0R31VPWk3uiG+JaZm3gBDHBojXfobk3IouOMDtQ50dBNbFpDClZw/iQLndVUNEht37uoVxR5Puc2y3M=;20:9BGaE6nIrgvdBY0dj9QS7ZcSkh/iAR5sFVEHQiMgO0I6PkuDMzjap9g6jmNAK+Vy6wx9j4CizoAnAYt8ZR4OrqyJwllbQ25kAkbt0e8ldVKv/6lO0hPBsr/lNdxIILjzTajTufLC65lVnVwhBnw0OFx4xH5WHXctDX2ToDcPUMaixSBoxvzy1FJcnOSdtibyGCjmvTr0MiEzYsxsv6Bum7stPZC169fWbak/1SOTgW9UpAya0wCaT3AtjKA0O7DKaX2mhrU2IPMdgYiVHXmL///EbWkrHT3VycCRpfjJkKcVtHTXQZzuPqHGhQbruTnlP6Ch0+vi/v8GZA4xL5eKsbvfCxFf5GMyNvG2qAZjI0uwvGLXSOFK7uqQbmFxFfqFN1jhScT66zYWp/3UapgIwrkVmjWY/w/BpYY3d6lVpSQoTFfb43e3xPYqx0zpRaNTTTXNCEDW1x+/yNsqNDdVm3Q8Y1wgmmWmheij3USDA3lPW+qYcrkQoz/VzfkuMZo3
X-Microsoft-Antispam-PRVS: <BL2PR07MB2417DF5FA62D789FA7BAE70597200@BL2PR07MB2417.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046)(6041248)(20161123562025)(20161123560025)(20161123564025)(20161123558025)(20161123555025)(6072148);SRVR:BL2PR07MB2417;BCL:0;PCL:0;RULEID:;SRVR:BL2PR07MB2417;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2417;4:ZxuHAYpcjStn1Me7IfJp8rrdHwnEh29Xvut4jx02Up0C+4SlY1cWN9NDYu+lo3bQVzOtp2cKhWDC6pW32HdJInWBdYzkKWEnrUzcWQ+4QIgj2iH0ARtk230vOZ6Eoo6EfrRwq5Nl6URvmSU4bkpvXGJ8EnCGb+bpq+F7js3TWEsOW/GY7vGS3sOc02fBn1ZqmGIvL/kAej0WEPDzJkOslj6blKCoGm4hEeIFx58huHF5fq0GvHnAV7NWr1pZXoKg4+IoEDuMFTt5QYPsZ3jhijvbF2qaeKlFV/FLRxPxFhja2nRxP9a0SxrR0dXZrFzGqcmkRY0YDFaSFoYLiORCplrcercUNjCsbDOKKHeL+HGG7Y/IgU7spfmSRUnTdNHR7RakGaAH09QWFFkA+L5LIS2LClwZw8f45+d/JBKWzbCc9SuL8aYvDKtFcQ33BXUaW1b9mjsylCFHBO8W9rlfJYMVNt3vHUedA7I8IkqI28gtvO/HKRvH8gr6eXpukhLXmydYoCbHvgTJlku8/cbuCdN4Rhjn9oujmE9o3JX0DSO7vvO7xIMXoqWbaBSg+VKDAiThfwQ3Zfntwa+aiF0XIH8uJnipOhE2+Pp5n7XxJVg=
X-Forefront-PRVS: 02426D11FE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39450400003)(5660300001)(8676002)(6512007)(54906002)(81166006)(38730400002)(42186005)(53416004)(33646002)(3846002)(36756003)(25786008)(7736002)(6506006)(305945005)(6486002)(6666003)(86362001)(6916009)(189998001)(53936002)(6116002)(50226002)(50466002)(47776003)(48376002)(66066001)(4326008)(107886003)(110136004)(1076002)(5003940100001)(2906002)(50986999);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR07MB2417;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2417;23:MAQUHCnywzPwkGe3XewXytp8Ri4mlCxEfcye3ssDUbfWN9PxsHHppBBbNxQL9AKJ6g8cjnhehBcLHdxgaKO3CIaUZcg9Tl/qml+fbCHkc98XMN2rhuS73ZZP1oar8J2gijB/CAGnlcE+UC3x0QxR7khFJVEu6k1vwVf+o/w8TeqwzvHitAbdsGcxets99WzZwviYXFu3T5x5Y9em1B+L7yitVXuxfOPdPhAc77xbXsNypnojL8PmyeibdPpQbmfNbRR15c6cbLqYWZLZN3iGPzypjQdt1rw5mX52SBM7nMG/4huYa2k6CMSSdq6+aumo08tafqcxZEcmosOJ5weGyLpfhWiByvVkfLNFfZMJMw/R0a/91kd6RJ4EDJWv6JDVZ6jN2Gv3fRf3ZurXnggZGmhcSJOMFDIQ14jjkeqgJBN1xhZavD2yZipq0HlF7lxMTjlZG9zztfPfrLLZFQgMfdyYMKIOvSLA1i4JlRbdG4IcMst1jDzkaiF7682TWxFe4Zc80YbBInYQOHRqxcBzg7/OmCR1JcGJ2DIzxvWPmPSEA23/BoOkrCt9qDWNCIsj9jykUhu+G2rDrXZdnLqe/6BtiVcSTx9FNv8zG/xgJbKwhbDRMzv1Qnn+gqlgJTBZbb/p9CFSj46UoOjdL3BdUus9OK/vx9nNxLqXwFa/9gKryXrkLxQ7+BA8/zQl8287y2k78dQhTyPH0dF6yjMzoglkZJPkJ5+VU8Lu81cr6mwrDjKH3nhX5WYbrdPDJ/7yS6H7R4ueBZHUwF6i5HuLiIjVhvdsuPjlopo85/4wdsEEQE7mHANtwZLX7zEfS0l1UnqDaBqBII/FXAx17ZPQoZCcRMdyhaWbBDrfYWCZFpnVGIvEIshLIcObcmnyCIm9R5i0qD62s21aGqo3l6oIPh0MPaoB/24m03kDgZnTOQA=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2417;6:hhwC7xfsHjYLJ70UIFlfWoqrKzfdHXJKpnGiawq8siaHLjmxDZzWUFkNDoghkeOojxpcv029Zq28Zwojm0i976bRaLe6elMHFxYTr9QkzH2/S6ttwuY94nzNgDFnBRP2hCkg+wHdr749ZMXcEA+ng9h1X2lz82c7xfwKQBzG2mGkxDP+ns0aCRBFtKLR5X85uyC6dAGqwogP/Hb9c3VzTdZoWdeUmzTnWlmPGHrr7FB8a7EWB0UOOtOaxw/It4VAgQYcHEKy6/N1bs6A+yhmkv3OCAhX8K5boOYlrqGa+AsxDIGOQ7mpbUaadDjcewx7NWaSSQjOqxAcrh6TEHcpGGj9WNwXy4mAsyJbcQcjhPcawNrjTfuG72T+LKCFj7X9dG5HVbwkAehwZSoaigFojQ==;5:4958nRPivPo8dp9i1iR7Wy9fSUU2gh68L8scIBDICfr38N4s6nggLxXjKLd5qbfEOeBpGwVYfONxrdNL7SBofP1XoC7gkaDmPZ4lK9LqXE73m8n7lHq7LiOZ789vmsAP9jOAWSZoRH2lLgWJyPq+FzVBbxPvOkM0ICq5piu9BTs=;24:ADZx5lp2NoBv6RbPDcbKRk8Zcd9xn5WalSi8lyfsbiPFLootTNjt3rajPQnjLj9jkiIJppsCx9sxjqvnEZZAoGtFZoZfUpLfR8ApUuj0LkY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2417;7:DGw0fYWLARcqp5dDuIo+j6sSGgkj0SBXixgEUXYKUC9QDEKjLG50pyC+V/P7Vti0mf7nI+LUOsra7cO5/s/afYQ+ou1xe1hlLItU/VlIRHYKVLA9shTVxyZSrYWNZPkkTohMw4kNVexWZja4XfuMgS73rzQLvfVyxdHa5+fpV9aKtOocrgbDQ0wXc95VXsFzOl/qzKqSLdE8e8kNgOeV7yhhLgURCrZb3YkdrcP252aouHZM0IkiLa4lUFPU+rVpvdQh5qWEYMI0+2ND+c8ub2cAmhjEDARXHdNcpbaLu1H49aAfBYbeQeHyYErWhV7HWtJf26f2LHTPZLQbdA90KQ==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2017 22:14:09.6611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR07MB2417
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57134
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

This let's us pass some additional "modprobe test-bpf" tests.

Reuse the code for SKF_AD_IFINDEX, but substitute the offset and size
of the "type" field.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/net/bpf_jit.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index 49a2e22..f613708 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -1111,6 +1111,7 @@ static int build_body(struct jit_ctx *ctx)
 			emit_load(r_A, 28, off, ctx);
 			break;
 		case BPF_ANC | SKF_AD_IFINDEX:
+		case BPF_ANC | SKF_AD_HATYPE:
 			/* A = skb->dev->ifindex */
 			ctx->flags |= SEEN_SKB | SEEN_A;
 			off = offsetof(struct sk_buff, dev);
@@ -1120,10 +1121,15 @@ static int build_body(struct jit_ctx *ctx)
 			emit_bcond(MIPS_COND_EQ, r_s0, r_zero,
 				   b_imm(prog->len, ctx), ctx);
 			emit_reg_move(r_ret, r_zero, ctx);
-			BUILD_BUG_ON(FIELD_SIZEOF(struct net_device,
-						  ifindex) != 4);
-			off = offsetof(struct net_device, ifindex);
-			emit_load(r_A, r_s0, off, ctx);
+			if (code == (BPF_ANC | SKF_AD_IFINDEX)) {
+				BUILD_BUG_ON(FIELD_SIZEOF(struct net_device, ifindex) != 4);
+				off = offsetof(struct net_device, ifindex);
+				emit_load(r_A, r_s0, off, ctx);
+			} else { /* (code == (BPF_ANC | SKF_AD_HATYPE) */
+				BUILD_BUG_ON(FIELD_SIZEOF(struct net_device, type) != 2);
+				off = offsetof(struct net_device, type);
+				emit_half_load(r_A, r_s0, off, ctx);
+			}
 			break;
 		case BPF_ANC | SKF_AD_MARK:
 			ctx->flags |= SEEN_SKB | SEEN_A;
-- 
2.9.3
