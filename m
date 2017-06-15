Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 00:36:47 +0200 (CEST)
Received: from mail-by2nam03on0075.outbound.protection.outlook.com ([104.47.42.75]:37054
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994789AbdFOWf6PqMtr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 16 Jun 2017 00:35:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fFwT0etABm2A8j54hKP9lBPUS1tt1yP48hpQffAVG48=;
 b=SqgtDOrKo1ckehAEcb0IX6BtF1Ode1HGd0jvc7xNYbbPq41GH3ddV3e7GV1EevqWyWQfnh2/F3NY+/XlUou34F7iRc5uWPSDCrE7IRYFgMw07R8KIDZ7uH3kkvjt53vU/Py8OYA+SeuTQNnSeQ3ebiZ5J7YPDrdk2O+fSoYpM1U=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cavium.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3501.namprd07.prod.outlook.com (10.164.192.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1157.12; Thu, 15 Jun 2017 22:35:48 +0000
From:   David Daney <david.daney@cavium.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH RFC 2/3] samples/bpf: Add define __EMITTING_BPF__ when building BPF
Date:   Thu, 15 Jun 2017 15:35:42 -0700
Message-Id: <20170615223543.22867-3-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20170615223543.22867-1-david.daney@cavium.com>
References: <20170615223543.22867-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0070.namprd07.prod.outlook.com (10.174.192.38) To
 MWHPR07MB3501.namprd07.prod.outlook.com (10.164.192.28)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR07MB3501:
X-MS-Office365-Filtering-Correlation-Id: fbfa0dea-f5ad-425e-d680-08d4b43edf00
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:MWHPR07MB3501;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;3:g11bbMpWJAf2H0EtDDZQPX9qg+k3rbbeGAoS2ifdLAXnZJR+rVuMLNvhw4qev12Fa0RJBDDiJfFxE6IJJIbqX2wQMRBkvFjGDS0iNb56JiNtVmiDqXfXxhBLJoCvZ/fZ/9pw6aTARRkEgya1mWlwvxXHsTdT++P4kEh6vcphgeFBkwSrkgLpf/u7ZbOusDiEgomGp82jzNhSUZWmW8flqLX4tb9Gu/bGqlkeGnUzRTpfJGStRBUU17ngOl32/b1x9UyMMane7TpH8sVvXOXEEsJj/gxObVGaamA9nxRM8kP4xRtU9xbH6ZxOKV7pXkXJINNuCRlMDXymTYr4x3na3A==;25:ziU/Num49QIGxV4MTdYagaW2g99OgyekMtxf6dwsR1mUPKyWH9dXVlwV88yfPVS9/Ckm1IB6duY0YS3JKOVkAa1D38kEoH5WfmwITd6y62MYRmtrn8Ja9DCbXYUw7dQVUGKPlxLOsw1KJoUe6Em/XwnAGoagTRYmp6K8HS9AWGjTVVLnjfap2pul5s1+Wx+cPykBx17JROf7OXQi3EP5roAQ9UzA5zV1jqgP3sIgOid7uuEUOkDMedwPlHAh1WXs++tTrQbM29uGBlD1gwrhBhVMDvSp9GMfb3hhZmwEhIliTI8d3/LdAmevPA3LYE7u03/1YxLuTb8JY9Ut3QDqknW3eW/ah1dpJGdBtQTVv+99OFNvAjg2eS3mZgbWtHS/2wQCnLXyQD62ofB6UJXMQFjv/CTXPMqyi7JjYYRSdF7dcs/peETOInBoir/AWSK1gdZxs9ah/0aw2h/jqEOv62NeRQPR/Et4whx9bzV2Rm0=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;31:mW8C3fd+pFokq6lw5RtFXbtTo1ii11cLyxFxm9uHN5SVbK9188oNEu2DDieqTAFBswOwfHEgR8SiZ63cbTCNLXh1OX9wLcWChV2udX1OMiAo/Dz3+P5xjCek9D/6XTLXrcyDi1n5lLgsG0X6RaMx0DNxQfGAaqrNmMvNFLN2ycOsYrm0J55gMzCvpoVRUBzBS5sFBZZ5gPuctAFFDV6/JTRhOTV+fwXmiGpW6Kmyf0U=;20:sg10ahqomhf62a7l/ljkVfwUDvPBrqtonXJOw9ZzsGKXS+ophnvLQdUPQi3jtDbB9OqURobA07nRTeZR7YcmGeX7+xb1ULJ+W3sxE/QHZrWKl5WjQXhhywchk0txc94GyWYyVHToXsCau71ZPMCBuYOV+l8fs6NEFhBQCYByWqAbUpAkry4E66Jk3MYuaUKUBFMXrdU7hF+G/8AymBJqmHEuW+z9nK2S/nH5HWmgkoRLyP3sWWJlp89lNWPk6HfkglF7UmkQZijaMaAAbckzCfvu/kE5JwnkL1Arqgc8CF2GBEbO+9uKwvXgXlKsDbFS5MFq+1QNgTLl6y5a7mvCBTI6z8s3hc2RAkOS5z8OzCBWzWF0FSFBb1AS5H+8h5CJvL3X1hkfwRywmeLegKXoCSDJ8kod6LDION/XuJXrVkFhEy+29iGbCAWq4ERG6fBQNPjhH7w4bF/Ujw/cSLC8wl72GvTL3uqEJqehqZ7sca56LgekSrjZ8kJUfvtLnv12
X-Microsoft-Antispam-PRVS: <MWHPR07MB35019D45AB8FA19D0673632697C00@MWHPR07MB3501.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(100000703101)(100105400095)(3002001)(6041248)(20161123558100)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123555025)(20161123562025)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR07MB3501;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR07MB3501;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3501;4:JAruq2hyVWsC2PXSYewcNmKnq6doXFx0aQzOE8p5pU?=
 =?us-ascii?Q?woJfpHfapV6gKAedzajiZ6RwGZkoABtUlEmP1N+CNIdcJy5tUp7hGTYXajge?=
 =?us-ascii?Q?w/ARJnm5GA5QNLF3QP1Qd6mfx68jbiQbvdH0DN0qq+kamEabzz1TIPOBj58N?=
 =?us-ascii?Q?GNvcILVuKmqFRAwI3kiYdWrt1SJntO7wVh+v1KUM70Sb3WwKnWOnwAWYnxzP?=
 =?us-ascii?Q?l81+QGbRhNnBylh7nHIr9n4ES/plw1SmwSLH4WcJXGhnozShjY9T3CfAvb/o?=
 =?us-ascii?Q?59d5RDEDb8REoK1YyceS3B7CtfuvqK8WvWVr0uJLcPNLB1My5yxMdhMyOFZ3?=
 =?us-ascii?Q?hWH/poQjfOIt6NsEzyifhlNGfeSg6MYAX76XuFyehjPaNfoYoYb/hIxiK/tO?=
 =?us-ascii?Q?+eSiljQ/Uqcm0mPOehhHLCB7QHA0Wh73cw8RXteCgdpmmHPXGlGgqGR+aoSt?=
 =?us-ascii?Q?Oa0GMe4gEYAg8bLVfi2mZNVo6XP0hK809dJv5baN8iIfBjLHWijO/7zi2Lnu?=
 =?us-ascii?Q?LJoy7Mn5rV/pCEjLgio7QBNZJw1aPHHUl92KGlBL5V1rGFnNGGknllMcGCj3?=
 =?us-ascii?Q?5NGq8AYuv0s0MrEoFpnWSqyUw9afnu8UISiz9aeP00l7Fe7J3oNOn7mNFSPT?=
 =?us-ascii?Q?gjUXsvpCxvEMpWSv1FP2QNGsj9iN29b1iA07ZXq4wN0O18BR6/b3dk9U90AT?=
 =?us-ascii?Q?N9ppFUz/+eQ+dkOoqhokSyG+rhJbfOj+gMMuEhszQ0mpsW+YapQof2DHH2ie?=
 =?us-ascii?Q?cXdcUn4JtrkBrs4tSQ57omaY4ylOMp4+B3GHswamUaTwFFixyyVSbq7fq8Ck?=
 =?us-ascii?Q?mjjEmX7QFL+vXr28dOEnjLvEjhuqXKgwLyZuVReTaJ22bKR9Dp3zwP/QDolX?=
 =?us-ascii?Q?3EqKhhJ970+6CUQBsaqT/mtM/PelRsZNvyLQ3IQSs5cDogx2nFIEt6e22x4C?=
 =?us-ascii?Q?OVok1bARRYstZNfl1VGdMGrgFc+nowNbEP3hQm3Kfq+DD5RSbYx0Ge2KbO1e?=
 =?us-ascii?Q?ugO8m3eJQ7/mQPMGWziLKTtdqyuwH/YgcduyWXRcVCJZSEKrHaPQeE8Ywb7U?=
 =?us-ascii?Q?YUAiA3qHtySsXozGDozqm1xckQzgOhOxlClBV1oOXyEZQZ6ZY3Au1BJXyMkU?=
 =?us-ascii?Q?nxFwzvzoR9BbT4Z17EPagMVX9g8R9F?=
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39400400002)(39850400002)(39410400002)(39450400003)(39860400002)(39840400002)(81166006)(72206003)(8676002)(47776003)(1076002)(7736002)(305945005)(76176999)(6116002)(50986999)(86362001)(5660300001)(2906002)(36756003)(3846002)(38730400002)(66066001)(2950100002)(53416004)(6506006)(189998001)(478600001)(107886003)(4326008)(6512007)(5003940100001)(42186005)(33646002)(6486002)(50466002)(53936002)(48376002)(25786009)(50226002)(6666003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3501;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3501;23:Jn8yA85su0aHoLv5xFz3aVlLHPp8CtIN3OcWmiNpb?=
 =?us-ascii?Q?GBQvhhrX5ujLCb0ms4g42FeD0GenKA0Vj9uP5/CMk/RwvESw78m8LrCLlXFT?=
 =?us-ascii?Q?EnDk2/1o/itg875EtIsZQztMikTlj/NLZmmMlfBpiAftDep1d2cwR9LutCTB?=
 =?us-ascii?Q?RP+pNIZWwJeoidq00GSn38HDFqy+216UOZGdoiDHBMYaOS6wgx7BQoRNVDEg?=
 =?us-ascii?Q?Ss05ew/8ZQ4pFOdy/0WlgtBnNsGsObprP09nUO9YOaWNFDoyyby+lDLkfdBu?=
 =?us-ascii?Q?0QIu02LibwuQYRF2aUytBGquvRgDiDUhvr2lNH4fgzw8p5sd2hlYUO0eJTtT?=
 =?us-ascii?Q?8hS3XkS1vnpXFiH/59gYMAKfOZf8W1wz9Tn3kgS4n+vobmTOIyvb2SnOo+CK?=
 =?us-ascii?Q?m67QRMNzKd327H02NislkZYywYleK14B7Pqyyt05alD7C9GCdd0E2fQPYWsV?=
 =?us-ascii?Q?dYPw5GYkFrvPJr0da1cytUarmT8At8d80Lxts2UoSMkGHrtiv0H8VthkaD3y?=
 =?us-ascii?Q?Mp1fk5wbnAYhNF8f/eUw/MjOQFtGqpxuIPpoWw+2bTgB5rx10WVwSTOetC/1?=
 =?us-ascii?Q?MmSRnIDmJNuavIzQK+JqmZhLqnLlpCAHnk2k9ZKWQC2k5VdV0RQ6S00BIgo+?=
 =?us-ascii?Q?u/NfotxxGsVzH6WmoBaAB5Uet8GmS82zA1CrxLaM6d82V4gMwtQUlPwL00HH?=
 =?us-ascii?Q?CdqV3nuZuev3A7gZfaisXtBVvhAI+yyJN5TQNlk+2uGhOe95UGreBlRK4NV2?=
 =?us-ascii?Q?MRYJrVBmmRjX7FsClA/MCBJda04e7AXhZWlbZoGK1XZb/jIp979FMg3ZCjFn?=
 =?us-ascii?Q?t5isvEbDZBDzlsSAx2qQLhWhFWw59jO9edLnaAx+AS4Gmrjs34Zco8mQbaVO?=
 =?us-ascii?Q?15RMIuITsiPvl3ewGJrwc9GpwqaiP9Fgdh/nHhUL00yzhbuPaSoakx8Zs9oP?=
 =?us-ascii?Q?37uCY6TYsR5mOzsxWZiSOrJO+faRr/Rm7moh7gH4BEaZTraclGy7ah0T9Jch?=
 =?us-ascii?Q?EtYDmyYDv0S2+Eg7f2DIeucmfw9HRM3bWi1hkpK73k41hd4vzdEFXeweEnyD?=
 =?us-ascii?Q?r2dGoyMhrTPnV4CsNqNAcEInKvUKH3Hq3KB1+sGEHziS82smcXER5qTX0aaQ?=
 =?us-ascii?Q?+YS9taZf+8=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;6:zZAEYcIDo+V9WaXqf+fXkRUtEV56RcuVxpY6DBsF0qvwA3HcWeLVSXh6ZYdsUDfzTyjsnUcpcAomqZ2KbPa6YCrqdlMQ2SFuZYiS3BwNLuydMHlniws+1PF/OeqNcOVLXL7mcy3USfugCKRHQgusvCckOF6n+18UuGmhqoFx/ROSSQkK4xWvbGUQKT5qsJPqWv09RKNRR+P9hqoCi2fwi6zzXmu6u77Uvm8sNAVBzq7Xk8Lv7Qqjxk1BSzJHFmiyG5KJ3gyaFjGUtbaoChlCxB8wiMqNY0gxNwn7UG4fyUuCIvRQSeBHHYixn9R8BzWhaK3L5+pQtSJT64OSCsg12q2ds3nFqgy6cMKIxpb5+k+VU5XDBBMoKrWFCpGxVMD35Ux/pTJ8fCPznna88+XZW+knc7UMaq+O+kEBlljSZD+BI3NnHr7ZbtjpV2yyQdxQZgWPNRnngub6pWPoK9M134Pc0rWlrlGPxggut9xqfWUvN6g9nsHjwlFOOwES/G7s22R814jBUfDdMMvQLerRQw==
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;5:BwoAjaQv1tpTGvojcAgRLOliNZFusjmz/DmXo7okXJvAJRsV98OnYpxfLAHI12L+XDblmjroWGieE0aCEyLZUCt1E/as6Ca+/aXgXDB+yjcFrqqxDSrBZUeHgAJkYDVrmO7umRfBaBWZRJZJZCP0VQ8Zo2N+i1iBL2WJtXiYvTrDGDGr+72eVZ1c+lL0pIsLXz94b/LC94nWPxdBvOhN1n5lgEQLugibqOSS6jR3WLxYv4PJQmDAN5ZjByGgyW+ixwzrLkvo+FbIgWPzyO5iWHMKU+CcHEKE2RSNnTMBbH6M3WvAAu7yQx4Qbjp6n5icWCn1kJRmmdR1t2GSj3mQLYP+9PgBWgLEUwHagaEZPen+u7/CSW9cnaCY+CZqnYbvXP858DkFIGC1jcbB67+fqOmbmtT78t96PwO0vwcjPHOdH5OlLXBZwk9f1knknLCIPL1A7kE6VhmmLHdHEgHXUHav0HCAzXwyjq7r7J4CYWO43Y+d0Q8WSxS6gAO4q6Yw;24:XxaHpaRb9fG2sa//jTrBUMt+41tEwB/ntwJUhgrfD1VF8eaT1+2N+J4WeNAoDEhqg+W7VTDDvWGI9Dh89/5qW5bUVwScHQtovpyKGcRs7oU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3501;7:GDp9WEk1gLhgCp7Ggo/2V3hzuX1UXwfTy9Vznz3d4UCdUWgbTJOf3Q4rLGnliED7BNQJc7U9YtW2nDZJA0cQxYtsUr7znj0zuMrKIDwul8KC6MmMW7nbVKSo7Xm+R15YtLX2oMG0g4opv8EZOEiZS5t1OW3O/xRpR9wHdZaEl98NbQ1d2L76yBCX8f70uQcxL7vicaUxutPXes9vNPTNvZJKri/KMcP1SFDjn6YmY1eAKyVsO+C4evcYVitkdvZ/nn55V3eR7PJnkrbb+NldbPifJG3snGfXNrhzbriNZfP2gi5TVZIY+w2Go37hD4lU4oFF535shh9rO9zlGdXzHQ==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2017 22:35:48.4678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3501
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58481
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

... this allows gating of inline assembly code that causes llvm to
fail when emitting BPF.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 samples/bpf/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index a0561dc762fe..4979e6b56662 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -193,12 +193,12 @@ $(src)/*.c: verify_target_bpf
 
 $(obj)/tracex5_kern.o: $(obj)/syscall_nrs.h
 
-# asm/sysreg.h - inline assembly used by it is incompatible with llvm.
-# But, there is no easy way to fix it, so just exclude it since it is
-# useless for BPF samples.
+# __EMITTING_BPF__ used to exclude inline assembly, which cannot be
+# emitted in BPF code.
 $(obj)/%.o: $(src)/%.c
 	$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(EXTRA_CFLAGS) \
-		-D__KERNEL__ -D__ASM_SYSREG_H -Wno-unused-value -Wno-pointer-sign \
+		-D__KERNEL__ -D__EMITTING_BPF__ \
+		-Wno-unused-value -Wno-pointer-sign \
 		-Wno-compare-distinct-pointer-types \
 		-Wno-gnu-variable-sized-type-not-at-end \
 		-Wno-address-of-packed-member -Wno-tautological-compare \
-- 
2.11.0
