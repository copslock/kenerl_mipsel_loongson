Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jun 2017 00:30:20 +0200 (CEST)
Received: from mail-by2nam03on0078.outbound.protection.outlook.com ([104.47.42.78]:23616
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994627AbdFMW3AeZaIu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Jun 2017 00:29:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=aWUfPfJtaHtXaA4lYkXvh8z8pKiE/K848qWfjfKXhRE=;
 b=HDoHHz0eTLFHTpoAoGAMVzb8GuLLmS4qrDAQw93iwkzstNdR4IUZB/t/SyW1wLDhvW/zIPDhf7X04jfYz5LbCR8sw0jic58rWveZ0WgbnbKAiAGm5deZmphIp5a+9zTxniuDE6/DpOhDoDQ9p4GgofAx3YorjWPoT3Bh8yVkjbw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1157.12; Tue, 13 Jun 2017 22:28:53 +0000
From:   David Daney <david.daney@cavium.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 3/5] MIPS: Add some instructions to uasm.
Date:   Tue, 13 Jun 2017 15:28:45 -0700
Message-Id: <20170613222847.7122-4-david.daney@cavium.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2584e6c0-774d-4aeb-62e0-08d4b2ab92c8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:CY4PR07MB3496;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;3:fxHxxV084E5SEqARKZ+5P1RBm88j4zvEnmbO0Mrf02js7jC84XBjkRpA2qKv3nSDfeiKNs/Yt3F7OK4Oxmgonu7pT6Al8O3egsSHhA1mtHnCKAPBO1jspN8lgEG/9/ReBgp2mNF3nt8c/0Rco8M9C/JQDHhFqlkEZHGUTbh+/wXs4+D+lHfZGM8kcB6/64vvF4HZf/VJBOk+SnlX9SvQ40fA7dFX3ShaG4LtC/v9Rzs5jkiSaWnhsVhEqwfEkWLU4/moWNnd2xzb3eUN4jK6ZKfDPmDxr/K8bkEGRiNCMpENvcuoUBhEBt0ZL9Y0pFc6xGJk66b/ovsZidk0mM6A+A==;25:cSb1sfiRSuVls07nl4nC9J41VPHSN0FlbMskyRToH1T5W+KDGsOFeuYze4ERaZOPaAYJYoaVdchsA6PzAB8gQ2XgcNXnAxNmP7llD8uoyTaYKwGEg1+gHRUJ/AAjoLahHsWW52000ukCBNKViicGWuswya55kEvBGi5sCt9qdHT8+/SVqAuKXMhfbfnx2vEwzYqfFIzmXSZ3Oa5HoElarduztLoLiDjdCa+G3Waaru2Q4/VWqlMoAyYKYn/Mz9Ww43dKB17aWNHqfW+Q399nWjdwZOFlVdL6UngUkiWXTThOAEPTZdBzZzcKWJ/uLyuw/Knuzn2RFPheh92pnb8TsnHnU7G9jA2UqF1LeAmcjuL6yAQ03dH+uvv/Zca/U8rbKdSfsBaAPfveAmdeo3KvAxn3ze16dO2k2a4QdX82q3YB4HlY/aJxTzjqpR7wpKQtYrcg3P1Dy9zEh5ONLo0lYalS4WMoZPEyyzcyOOnss8E=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;31:zTWfhDBcE1NdrG5cDelbTtlyPc9U/nojBg1hjP14tG/jqcMTU5v9SGeeRwIWo3DR3v9AFBSX7eNUBnt0q4gyZTunTbZfxq2PMUdiuuU2ikUX/XdrahYGVfn9DxlhnU0xUlc4w6pymOEqaTkT5zeAPxbRMlT/Vg8VQeoU3HFqA6YHoldXtXq/1x2vbgXwoDCwsaticYwQ2LtOSlU1ah3JbBxzAZRXxF5a/FY0tKTkCeE=;20:LU7epWhCIfxsVX6RMgbv9tAdsDiC7o9e8tsWFzjYKz7fZhc8cYEJIbaNdJzMIHXJ+veeyalcj2peVPfcibyf06xFKQ2R5A6IQA1Fto2lEekhFm+Prige+wHqA1VYD2MRiwFppMl4zCNiNIBGSVkSC+xC1KbUaySYX8BM2bBnjh+Yg0sBwqy6jTdQdcInY9GfnwQA38CjdnBQAPO53+HlzCQPpQVHN2Tw79xA/hQZK7O77Z3LiT53pwUnS9mV+avbKGqTaweTsRBU1xZDzcACxAnxmZJxlNlU615MNwA4OQ+8UgmsPhbI6mtHDxYel77mQBQbO+fWztkRSbUUuS5xCk+DCXBYPn0+BlhUYJ0M4x9HhcBcblEN/fjRpFXpnqsIR8dwbdGDZJ6RbGKLyS3lrlI3FKOsHAdH4owaCkiIOOWG+OWuHO+l0QCxVk0q51Hm42MGgQrc1UelTMV5NDzeU39itFQVuw4XBNYNU5fVQZJAmT+RrhT3VWQh3UVOISfF
X-Microsoft-Antispam-PRVS: <CY4PR07MB34967001AE07A81F493B72E797C20@CY4PR07MB3496.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(100000703101)(100105400095)(93006095)(93001095)(6041248)(20161123555025)(20161123558100)(20161123562025)(20161123564025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3496;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3496;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3496;4:Fbp5A09S0AuyGQB+cLMJbCD62QSziKLYani7gq9OBV?=
 =?us-ascii?Q?rI5MJB7mmYleDVEKdVNu3H6GVraBC3RZeZlBIz23pV3XeVMv9CAf24O8Ab8f?=
 =?us-ascii?Q?iyKy7ZJLRNu2cPlgECxAZx7giB39Zltw+Yn3lgp2RyUh+/2uz6fmtSAkmTcA?=
 =?us-ascii?Q?jk66//Ipp0jf4gqSpxyrAUFHpwTGVVkCPwtoq4ERwAdrWb5ZtAE9kzaHFwjm?=
 =?us-ascii?Q?KR33kcd9rTlJs/dkXqqdxnbmWj19hoTPx3TbYsYOI6Ypy8neDDpe5c1UzBe5?=
 =?us-ascii?Q?T+ybUXnCLDh6BZGlAF9pL0vKJgZqvCQUwWBzThvbdQYqDQDec/QrXdfYxHMI?=
 =?us-ascii?Q?ZioA0fJACqjWvw64LTYu/Hh88c026yzrYX5cYdSvSLebRRO18idbhzakxC1a?=
 =?us-ascii?Q?tix0SMFpq8fnGnLw+bQ25PWW54moCizrKHCUx0EG0ArbvlJUzFTAzsQrOR7E?=
 =?us-ascii?Q?id4S/YkN4SUJjLHi8GI3BzST/Dev0SYFAryqqlb1/UEX5ozMHxS0kCdAo6Td?=
 =?us-ascii?Q?Z6Yu/0xddd3J1lnrKQmQOD3WBSHYs93YAUwV/oicrYOuV3OwTzJvTiatUxyD?=
 =?us-ascii?Q?U6Kf7InSk/c/s93pu2Lq6sHoB/TDaQUBRAmA7qZIcz5nhI9qLXN8MpbuK4JU?=
 =?us-ascii?Q?LNEHJHSQLzdJPkjuqUgmS7CjgUevdzVV9qNUO6Hns/uXh4D1KqEOxKaSqgTw?=
 =?us-ascii?Q?AE2RvOGGMNjNIiI02WJKEX7Es7YYo4NvRV8549CDTSfbtsIYmmqvbjez2qMR?=
 =?us-ascii?Q?7xJfLadaNoMhHUUoqT4plZswxKqo6CwESZHwo8E2qR+ErFqyEEFIiuCwXNLH?=
 =?us-ascii?Q?RxQMvnIFWDfGRgBOfJH3MY8SqXlkJs28sCVSr5G8X884w/Tyeb3VJXBNHEsU?=
 =?us-ascii?Q?r9L4+UdKvZUQE9EhU7C6zz9ZdPh1LlnY+bkT/HFNqegotZlp4UFmVOvuG/sZ?=
 =?us-ascii?Q?4CFNYz2IuAgsfHdA6sZsPEz+EmDrWopqwXp7jV/z2d2bU/469v0MmRJPsNqB?=
 =?us-ascii?Q?vPmoob/o6Mbd+ySxPwfJXBk9imWOd8lXpL59N6vk3olFfahvKbNh4QjB9kdH?=
 =?us-ascii?Q?IFy5iPR6I33nlMIZnv6MkDPBA/GOEaxFfwnwC7W/Rq23UQRtFasrkkCbFr+4?=
 =?us-ascii?Q?Nzf9R3nyoDBStPs6WTtlOFK0iXxbGR?=
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39410400002)(39400400002)(39850400002)(39840400002)(39450400003)(199003)(189002)(6486002)(1076002)(6666003)(2950100002)(36756003)(6506006)(105586002)(53416004)(42186005)(33646002)(106356001)(101416001)(50466002)(48376002)(76176999)(50986999)(72206003)(6116002)(5003940100001)(3846002)(50226002)(305945005)(97736004)(7736002)(189998001)(81156014)(8676002)(68736007)(53936002)(86362001)(69596002)(38730400002)(4326008)(54906002)(47776003)(25786009)(6512007)(81166006)(5660300001)(66066001)(107886003)(478600001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3496;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3496;23:5w2uEeZGXjohqIEIgOO/mKOmSijBU/VJHPZD1GiQG?=
 =?us-ascii?Q?ybE5LWYgYjzDLCCHoHCha5sYmi/CkwQFAFoPb4PsX4nwUdYo4025cy8aMVpH?=
 =?us-ascii?Q?BXFjaoNr8VTceP/aDN2fxVsATlpCAgvR38cISH9QYt226zygZMAwuY5GnYMc?=
 =?us-ascii?Q?eh6/0r7dbCY7DZ7INNrssfReLKW8FZ/8iesP/R61TGFHpFACFKm6aXbV4Pi4?=
 =?us-ascii?Q?AJDdNElMTfvrSPc0WabHn+QnuQmW3cDGGbnbFxSGjIP42cAWX+wM1kUVFfLt?=
 =?us-ascii?Q?2US62ZzSMFfR8OzLahmLA5RGzbUB8Ok3rv5lnwTV7vzHnNdp+T5nqqenXxWV?=
 =?us-ascii?Q?EwiLTZs6Ik1KKjjg9RcHRlzVR+JqUimEMEH/Re6aBkDaiaNEqE2wiP2B6+eC?=
 =?us-ascii?Q?xN8iccPPvtHX0tW0mnFZI2pqPKzxH3DihlonHKBCalW+Xl8zqe/bFRh8aeji?=
 =?us-ascii?Q?FnvySv+StU6a5jY6tg4pBvOMBac5Lq+Y1SMNw0gahnPUSjtzczHEzOa/jD1C?=
 =?us-ascii?Q?TtrTz/YMydN45+z8tK+nsn7CgA6SpgZonz5J8LdO5Wm3/E9ZkoSYveLCD1mc?=
 =?us-ascii?Q?f+HdJm8h9X8IvMeSkbjFpfSFVG+NDLIsL3Rbaq8rljEF3nET+fQ1FMni+Y/b?=
 =?us-ascii?Q?XfXYMKze/v566nhIGaQn3hLuBKakI/PGg/hP4CuABToQSwMfKsRPKvjv7fDc?=
 =?us-ascii?Q?D44H8WG5vFWHJmASyjIliI+tZ2Qc0iq0Lv7LBFzpGeHojdEgSNa1oaPXoWjw?=
 =?us-ascii?Q?wi5Y9IFmqHtV8jmJyGDb70mLT1uymeMpNFzENpEsS3Tv1AP9YvHMWXIrlRyo?=
 =?us-ascii?Q?pKNHujg2m0HjGAXBalzFgIb/cVIRpmksueXIS+87C2ECugzZjn9AoN/+c619?=
 =?us-ascii?Q?CUoZwrzQSEwYpYfJKcEaodA/r54lKILbzkMqXZF/TGPwjJX1grfdI3KIUbB8?=
 =?us-ascii?Q?2egpHnrZmdDKiD31cqSv4J1DbEZZRLmOMs3vRSLJGxUN5c0PMVPDhX+Tb4BC?=
 =?us-ascii?Q?5j/p6MPPPja0N1ENzHWsMhiwg7iaWtRKBNRBlE0Qep/RadhUr8+dM2T3xook?=
 =?us-ascii?Q?EuuPDyrStdGKaRTLxgjx3p/4lxekFb2CNjIxDvPD53uqZAbzH2zATQKtBTqI?=
 =?us-ascii?Q?EK8BXGtZ5yS/ON3D0hF2CNy+LnB1jcoU+yD7Va9qcEU4li7cyShHMyn+5f66?=
 =?us-ascii?Q?+H0O8Yt9EfIOcHUvz8hh6v/iqXdDLGpNm4K+rjzYzMVyHX9XwnNoF7jbbsac?=
 =?us-ascii?Q?Cuman1+2suPfK5yIGxuZ1kXej57ZWkwkM6Eu8BO?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;6:+9doNXrg9dGk2YbhfnpaPAatPUEzmgSZ1EJV+vp83Q2TVblAi+CzJLX8fZLKbBq4pa2C6gHz3kPllOZzTYGcs9a/5z14CbrmhdUq9TEQS3watYuSxG0iMM0/m72IGLrhn3ActAVghczWO67vQojce29No8wnSSDINPlX7U6AiLfbUJt7jMl6LU0ZJYAbF9tuIf4X66eqGO3DoMwmB3f2lV85NcPmwbNIdoeu6HWFR91G9DIlkpuuvCQ4cpsqx+3PwVVu4Efq27TI8JuqH4TFMNGq6n73Vc9uoYM7T8JGBTm6z4oYRZQscqiXoe51PDK8FhSanScyxoM7NlRdYju2V1ksO0v+QJQpCw7yrC86R/zbuiy7n+3SsdsAmde8RGxO7X2KBhpDbQUZFm7+rf5Bem0O5U7S1q4IfDZjsi0r9Q5cE66yygVgStUH9Zy0wT8OMw0HELN09NxQc2fndRZcXvbUnRshv4ghyk9Mk/Mu2xt4qwDAwrlrV8OZLUF1Sz5qpI7Fys34yqa0NLcIwpMmYA==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;5:aAF7NKGiELDdLxYrAspqyclhxWdh+QHM3gn5+XXWo+Rs0sbRQ7d30i1NYCgvbLnzL+r5WNRYkn4aI/s50Kap+gapks1l6pFTlsSu+91g+rseM9KzYSroTnkrMxfV6oDw8CG71tuYl5iWx6/8conS366qynrRlc++/JKhsq+N1fUaujzoLGbgdZzzQpHBXrU6g2HEp9Va9wLRzd1pgTGRVV7n9CMRafUEGu+xmDJYfPwg5TIDx0S1ZDJkdNSyV4f3ucTOPVDwx4fe6MLOIXbv24RJDvSIdCxPC0GWhLCiM3NwIslaj5x8i3fUuiF1ym23dFDfbiO4i/IL2O2XOht5k6mQ1Rd4E75gTSpZPwG/aEqASqoncRCTc4jU0WEflho85WHFPZa8BL3FRgiqwCHQCWpWFSo8YZ04Up9vpiLqRN03fDj/pE6NQpiK34YX/ong9OZMiGiWJVDM0BPlHeD0wp5Zbn3PFa+sJOcMST9aVx6H+Qi1fr/SuKBf7XxTo3bM;24:f5xysPI7XwBDTv6Amk6Ebe6dS18UbD0E6pTS5LQ1x4YHlkGR+gnPFVq9UwmttIrwNRX1Gc16of05IexBNYXVPpnZH2xJso3MUh15pH7jEks=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;7:b4uvEEY1BOBC44l8yceEAJe3zgN2OsGG9RNIuE3jhGPheGcLYYPN2UGSST/YHPkdfKg/bYsowsJBcJO2hJB8BIsrB8jJaGayIk+LghSfC59ckKOePnml0tqLYwdSz3C5Tmep7Kp3jJVb/4lpAeh+wNPEK3xl0i3sbad2+NsHDaAMe+R4JqiLOQvPWECVUGpg3YXCSuAKTGlE1rF1ZMWej6Q6cebWdDni7dDEu9AlzMqwmaJdauXc1dECbMJfCc7odlpLqDwFEfKXuoLqznVJU1XCMEq4uBiwCSJX8+aP8HlKJZZxT2IUAeI9QCz3Jn18LDxhvgpaYdMa95TOLcx9aw==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2017 22:28:53.2684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3496
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58429
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

Follow on patches for eBPF JIT require these additional instructions:

   insn_bgtz, insn_blez, insn_break, insn_ddivu, insn_dmultu,
   insn_dsbh, insn_dshd, insn_dsllv, insn_dsra32, insn_dsrav,
   insn_dsrlv, insn_lbu, insn_movn, insn_movz, insn_multu, insn_nor,
   insn_sb, insn_sh, insn_slti, insn_dinsu, insn_lwu

... so, add them.

Sort the insn_* enumeration values alphabetically.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/uasm.h | 30 +++++++++++++++++++++++
 arch/mips/mm/uasm-mips.c     | 21 ++++++++++++++++
 arch/mips/mm/uasm.c          | 58 ++++++++++++++++++++++++++++++++++----------
 3 files changed, 96 insertions(+), 13 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index 3748f4d..59dae37 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -72,9 +72,12 @@ Ip_u1u2s3(_beq);
 Ip_u1u2s3(_beql);
 Ip_u1s2(_bgez);
 Ip_u1s2(_bgezl);
+Ip_u1s2(_bgtz);
+Ip_u1s2(_blez);
 Ip_u1s2(_bltz);
 Ip_u1s2(_bltzl);
 Ip_u1u2s3(_bne);
+Ip_u1(_break);
 Ip_u2s3u1(_cache);
 Ip_u1u2(_cfc1);
 Ip_u2u1(_cfcmsa);
@@ -82,19 +85,28 @@ Ip_u1u2(_ctc1);
 Ip_u2u1(_ctcmsa);
 Ip_u2u1s3(_daddiu);
 Ip_u3u1u2(_daddu);
+Ip_u1u2(_ddivu);
 Ip_u1(_di);
 Ip_u2u1msbu3(_dins);
 Ip_u2u1msbu3(_dinsm);
+Ip_u2u1msbu3(_dinsu);
 Ip_u1u2(_divu);
 Ip_u1u2u3(_dmfc0);
 Ip_u1u2u3(_dmtc0);
+Ip_u1u2(_dmultu);
 Ip_u2u1u3(_drotr);
 Ip_u2u1u3(_drotr32);
+Ip_u2u1(_dsbh);
+Ip_u2u1(_dshd);
 Ip_u2u1u3(_dsll);
 Ip_u2u1u3(_dsll32);
+Ip_u3u2u1(_dsllv);
 Ip_u2u1u3(_dsra);
+Ip_u2u1u3(_dsra32);
+Ip_u3u2u1(_dsrav);
 Ip_u2u1u3(_dsrl);
 Ip_u2u1u3(_dsrl32);
+Ip_u3u2u1(_dsrlv);
 Ip_u3u1u2(_dsubu);
 Ip_0(_eret);
 Ip_u2u1msbu3(_ext);
@@ -104,6 +116,7 @@ Ip_u1(_jal);
 Ip_u2u1(_jalr);
 Ip_u1(_jr);
 Ip_u2s3u1(_lb);
+Ip_u2s3u1(_lbu);
 Ip_u2s3u1(_ld);
 Ip_u3u1u2(_ldx);
 Ip_u2s3u1(_lh);
@@ -112,27 +125,35 @@ Ip_u2s3u1(_ll);
 Ip_u2s3u1(_lld);
 Ip_u1s2(_lui);
 Ip_u2s3u1(_lw);
+Ip_u2s3u1(_lwu);
 Ip_u3u1u2(_lwx);
 Ip_u1u2u3(_mfc0);
 Ip_u1u2u3(_mfhc0);
 Ip_u1(_mfhi);
 Ip_u1(_mflo);
+Ip_u3u1u2(_movn);
+Ip_u3u1u2(_movz);
 Ip_u1u2u3(_mtc0);
 Ip_u1u2u3(_mthc0);
 Ip_u1(_mthi);
 Ip_u1(_mtlo);
 Ip_u3u1u2(_mul);
+Ip_u1u2(_multu);
+Ip_u3u1u2(_nor);
 Ip_u3u1u2(_or);
 Ip_u2u1u3(_ori);
 Ip_u2s3u1(_pref);
 Ip_0(_rfe);
 Ip_u2u1u3(_rotr);
+Ip_u2s3u1(_sb);
 Ip_u2s3u1(_sc);
 Ip_u2s3u1(_scd);
 Ip_u2s3u1(_sd);
+Ip_u2s3u1(_sh);
 Ip_u2u1u3(_sll);
 Ip_u3u2u1(_sllv);
 Ip_s3s1s2(_slt);
+Ip_u2u1s3(_slti);
 Ip_u2u1s3(_sltiu);
 Ip_u3u1u2(_sltu);
 Ip_u2u1u3(_sra);
@@ -248,6 +269,15 @@ static inline void uasm_i_dsrl_safe(u32 **p, unsigned int a1,
 		uasm_i_dsrl32(p, a1, a2, a3 - 32);
 }
 
+static inline void uasm_i_dsra_safe(u32 **p, unsigned int a1,
+				    unsigned int a2, unsigned int a3)
+{
+	if (a3 < 32)
+		uasm_i_dsra(p, a1, a2, a3);
+	else
+		uasm_i_dsra32(p, a1, a2, a3 - 32);
+}
+
 /* Handle relocations. */
 struct uasm_reloc {
 	u32 *addr;
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index f3937e3..3f74f6c 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -59,9 +59,12 @@ static const struct insn const insn_table[insn_invalid] = {
 	[insn_beql]	= {M(beql_op, 0, 0, 0, 0, 0), RS | RT | BIMM},
 	[insn_bgez]	= {M(bcond_op, 0, bgez_op, 0, 0, 0), RS | BIMM},
 	[insn_bgezl]	= {M(bcond_op, 0, bgezl_op, 0, 0, 0), RS | BIMM},
+	[insn_bgtz]	= {M(bgtz_op, 0, 0, 0, 0, 0), RS | BIMM},
+	[insn_blez]	= {M(blez_op, 0, 0, 0, 0, 0), RS | BIMM},
 	[insn_bltz]	= {M(bcond_op, 0, bltz_op, 0, 0, 0), RS | BIMM},
 	[insn_bltzl]	= {M(bcond_op, 0, bltzl_op, 0, 0, 0), RS | BIMM},
 	[insn_bne]	= {M(bne_op, 0, 0, 0, 0, 0), RS | RT | BIMM},
+	[insn_break]	= {M(spec_op, 0, 0, 0, 0, break_op), SCIMM},
 #ifndef CONFIG_CPU_MIPSR6
 	[insn_cache]	= {M(cache_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
 #else
@@ -73,19 +76,28 @@ static const struct insn const insn_table[insn_invalid] = {
 	[insn_ctcmsa]	= {M(msa_op, 0, msa_ctc_op, 0, 0, msa_elm_op), RD | RE},
 	[insn_daddiu]	= {M(daddiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM},
 	[insn_daddu]	= {M(spec_op, 0, 0, 0, 0, daddu_op), RS | RT | RD},
+	[insn_ddivu]	= {M(spec_op, 0, 0, 0, 0, ddivu_op), RS | RT},
 	[insn_di]	= {M(cop0_op, mfmc0_op, 0, 12, 0, 0), RT},
 	[insn_dins]	= {M(spec3_op, 0, 0, 0, 0, dins_op), RS | RT | RD | RE},
 	[insn_dinsm]	= {M(spec3_op, 0, 0, 0, 0, dinsm_op), RS | RT | RD | RE},
+	[insn_dinsu]	= {M(spec3_op, 0, 0, 0, 0, dinsu_op), RS | RT | RD | RE},
 	[insn_divu]	= {M(spec_op, 0, 0, 0, 0, divu_op), RS | RT},
 	[insn_dmfc0]	= {M(cop0_op, dmfc_op, 0, 0, 0, 0), RT | RD | SET},
 	[insn_dmtc0]	= {M(cop0_op, dmtc_op, 0, 0, 0, 0), RT | RD | SET},
+	[insn_dmultu]	= {M(spec_op, 0, 0, 0, 0, dmultu_op), RS | RT},
 	[insn_drotr]	= {M(spec_op, 1, 0, 0, 0, dsrl_op), RT | RD | RE},
 	[insn_drotr32]	= {M(spec_op, 1, 0, 0, 0, dsrl32_op), RT | RD | RE},
+	[insn_dsbh]	= {M(spec3_op, 0, 0, 0, dsbh_op, dbshfl_op), RT | RD},
+	[insn_dshd]	= {M(spec3_op, 0, 0, 0, dshd_op, dbshfl_op), RT | RD},
 	[insn_dsll]	= {M(spec_op, 0, 0, 0, 0, dsll_op), RT | RD | RE},
 	[insn_dsll32]	= {M(spec_op, 0, 0, 0, 0, dsll32_op), RT | RD | RE},
+	[insn_dsllv]	= {M(spec_op, 0, 0, 0, 0, dsllv_op),  RS | RT | RD},
 	[insn_dsra]	= {M(spec_op, 0, 0, 0, 0, dsra_op), RT | RD | RE},
+	[insn_dsra32]	= {M(spec_op, 0, 0, 0, 0, dsra32_op), RT | RD | RE},
+	[insn_dsrav]	= {M(spec_op, 0, 0, 0, 0, dsrav_op),  RS | RT | RD},
 	[insn_dsrl]	= {M(spec_op, 0, 0, 0, 0, dsrl_op), RT | RD | RE},
 	[insn_dsrl32]	= {M(spec_op, 0, 0, 0, 0, dsrl32_op), RT | RD | RE},
+	[insn_dsrlv]	= {M(spec_op, 0, 0, 0, 0, dsrlv_op),  RS | RT | RD},
 	[insn_dsubu]	= {M(spec_op, 0, 0, 0, 0, dsubu_op), RS | RT | RD},
 	[insn_eret]	= {M(cop0_op, cop_op, 0, 0, 0, eret_op),  0},
 	[insn_ext]	= {M(spec3_op, 0, 0, 0, 0, ext_op), RS | RT | RD | RE},
@@ -99,6 +111,7 @@ static const struct insn const insn_table[insn_invalid] = {
 	[insn_jr]	= {M(spec_op, 0, 0, 0, 0, jalr_op),  RS},
 #endif
 	[insn_lb]	= {M(lb_op, 0, 0, 0, 0, 0), RS | RT | SIMM},
+	[insn_lbu]	= {M(lbu_op, 0, 0, 0, 0, 0), RS | RT | SIMM},
 	[insn_ld]	= {M(ld_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
 	[insn_lddir]	= {M(lwc2_op, 0, 0, 0, lddir_op, mult_op), RS | RT | RD},
 	[insn_ldpte]	= {M(lwc2_op, 0, 0, 0, ldpte_op, mult_op), RS | RD},
@@ -114,11 +127,14 @@ static const struct insn const insn_table[insn_invalid] = {
 #endif
 	[insn_lui]	= {M(lui_op, 0, 0, 0, 0, 0),	RT | SIMM},
 	[insn_lw]	= {M(lw_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
+	[insn_lwu]	= {M(lwu_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
 	[insn_lwx]	= {M(spec3_op, 0, 0, 0, lwx_op, lx_op), RS | RT | RD},
 	[insn_mfc0]	= {M(cop0_op, mfc_op, 0, 0, 0, 0),  RT | RD | SET},
 	[insn_mfhc0]	= {M(cop0_op, mfhc0_op, 0, 0, 0, 0),  RT | RD | SET},
 	[insn_mfhi]	= {M(spec_op, 0, 0, 0, 0, mfhi_op), RD},
 	[insn_mflo]	= {M(spec_op, 0, 0, 0, 0, mflo_op), RD},
+	[insn_movn]	= {M(spec_op, 0, 0, 0, 0, movn_op), RS | RT | RD},
+	[insn_movz]	= {M(spec_op, 0, 0, 0, 0, movz_op), RS | RT | RD},
 	[insn_mtc0]	= {M(cop0_op, mtc_op, 0, 0, 0, 0),  RT | RD | SET},
 	[insn_mthc0]	= {M(cop0_op, mthc0_op, 0, 0, 0, 0),  RT | RD | SET},
 	[insn_mthi]	= {M(spec_op, 0, 0, 0, 0, mthi_op), RS},
@@ -128,6 +144,8 @@ static const struct insn const insn_table[insn_invalid] = {
 #else
 	[insn_mul]	= {M(spec_op, 0, 0, 0, mult_mul_op, mult_op), RS | RT | RD},
 #endif
+	[insn_multu]	= {M(spec_op, 0, 0, 0, 0, multu_op), RS | RT},
+	[insn_nor]	= {M(spec_op, 0, 0, 0, 0, nor_op),  RS | RT | RD},
 	[insn_or]	= {M(spec_op, 0, 0, 0, 0, or_op),  RS | RT | RD},
 	[insn_ori]	= {M(ori_op, 0, 0, 0, 0, 0),	RS | RT | UIMM},
 #ifndef CONFIG_CPU_MIPSR6
@@ -137,6 +155,7 @@ static const struct insn const insn_table[insn_invalid] = {
 #endif
 	[insn_rfe]	= {M(cop0_op, cop_op, 0, 0, 0, rfe_op),  0},
 	[insn_rotr]	= {M(spec_op, 1, 0, 0, 0, srl_op),  RT | RD | RE},
+	[insn_sb]	= {M(sb_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
 #ifndef CONFIG_CPU_MIPSR6
 	[insn_sc]	= {M(sc_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
 	[insn_scd]	= {M(scd_op, 0, 0, 0, 0, 0),	RS | RT | SIMM},
@@ -145,9 +164,11 @@ static const struct insn const insn_table[insn_invalid] = {
 	[insn_scd]	= {M6(spec3_op, 0, 0, 0, scd6_op),  RS | RT | SIMM9},
 #endif
 	[insn_sd]	= {M(sd_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
+	[insn_sh]	= {M(sh_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
 	[insn_sll]	= {M(spec_op, 0, 0, 0, 0, sll_op),  RT | RD | RE},
 	[insn_sllv]	= {M(spec_op, 0, 0, 0, 0, sllv_op),  RS | RT | RD},
 	[insn_slt]	= {M(spec_op, 0, 0, 0, 0, slt_op),  RS | RT | RD},
+	[insn_slti]	= {M(slti_op, 0, 0, 0, 0, 0), RS | RT | SIMM},
 	[insn_sltiu]	= {M(sltiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM},
 	[insn_sltu]	= {M(spec_op, 0, 0, 0, 0, sltu_op), RS | RT | RD},
 	[insn_sra]	= {M(spec_op, 0, 0, 0, 0, sra_op),  RT | RD | RE},
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index f23ed85..57570c0 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -47,20 +47,24 @@ enum fields {
 
 enum opcode {
 	insn_addiu, insn_addu, insn_and, insn_andi, insn_bbit0, insn_bbit1,
-	insn_beq, insn_beql, insn_bgez, insn_bgezl, insn_bltz, insn_bltzl,
-	insn_bne, insn_cache, insn_cfc1, insn_cfcmsa, insn_ctc1, insn_ctcmsa,
-	insn_daddiu, insn_daddu, insn_di, insn_dins, insn_dinsm, insn_divu,
-	insn_dmfc0, insn_dmtc0, insn_drotr, insn_drotr32, insn_dsll,
-	insn_dsll32, insn_dsra, insn_dsrl, insn_dsrl32, insn_dsubu, insn_eret,
-	insn_ext, insn_ins, insn_j, insn_jal, insn_jalr, insn_jr, insn_lb,
-	insn_ld, insn_ldx, insn_lh, insn_ll, insn_lld, insn_lui, insn_lw,
-	insn_lwx, insn_mfc0, insn_mfhc0, insn_mfhi, insn_mflo, insn_mtc0,
-	insn_mthc0, insn_mthi, insn_mtlo, insn_mul, insn_or, insn_ori,
-	insn_pref, insn_rfe, insn_rotr, insn_sc, insn_scd, insn_sd, insn_sll,
-	insn_sllv, insn_slt, insn_sltiu, insn_sltu, insn_sra, insn_srl,
+	insn_beq, insn_beql, insn_bgez, insn_bgezl, insn_bgtz, insn_blez,
+	insn_bltz, insn_bltzl, insn_bne, insn_break, insn_cache, insn_cfc1,
+	insn_cfcmsa, insn_ctc1, insn_ctcmsa, insn_daddiu, insn_daddu, insn_ddivu,
+	insn_di, insn_dins, insn_dinsm, insn_dinsu, insn_divu, insn_dmfc0,
+	insn_dmtc0, insn_dmultu, insn_drotr, insn_drotr32, insn_dsbh, insn_dshd,
+	insn_dsll, insn_dsll32, insn_dsllv, insn_dsra, insn_dsra32, insn_dsrav,
+	insn_dsrl, insn_dsrl32, insn_dsrlv, insn_dsubu, insn_eret, insn_ext,
+	insn_ins, insn_j, insn_jal, insn_jalr, insn_jr, insn_lb, insn_lbu,
+	insn_ld, insn_lddir, insn_ldpte, insn_ldx, insn_lh, insn_lhu,
+	insn_ll, insn_lld, insn_lui, insn_lw, insn_lwu, insn_lwx, insn_mfc0,
+	insn_mfhc0, insn_mfhi, insn_mflo, insn_movn, insn_movz, insn_mtc0,
+	insn_mthc0, insn_mthi, insn_mtlo, insn_mul, insn_multu, insn_nor,
+	insn_or, insn_ori, insn_pref, insn_rfe, insn_rotr, insn_sb,
+	insn_sc, insn_scd, insn_sd, insn_sh, insn_sll, insn_sllv,
+	insn_slt, insn_slti, insn_sltiu, insn_sltu, insn_sra, insn_srl,
 	insn_srlv, insn_subu, insn_sw, insn_sync, insn_syscall, insn_tlbp,
 	insn_tlbr, insn_tlbwi, insn_tlbwr, insn_wait, insn_wsbh, insn_xor,
-	insn_xori, insn_yield, insn_lddir, insn_ldpte, insn_lhu,
+	insn_xori, insn_yield,
 	insn_invalid /* insn_invalid must be last */
 };
 
@@ -214,6 +218,13 @@ Ip_u2u1msbu3(op)					\
 }							\
 UASM_EXPORT_SYMBOL(uasm_i##op);
 
+#define I_u2u1msb32msb3(op)				\
+Ip_u2u1msbu3(op)					\
+{							\
+	build_insn(buf, insn##op, b, a, c+d-33, c-32);	\
+}							\
+UASM_EXPORT_SYMBOL(uasm_i##op);
+
 #define I_u2u1msbdu3(op)				\
 Ip_u2u1msbu3(op)					\
 {							\
@@ -264,25 +275,36 @@ I_u1u2s3(_beq)
 I_u1u2s3(_beql)
 I_u1s2(_bgez)
 I_u1s2(_bgezl)
+I_u1s2(_bgtz)
+I_u1s2(_blez)
 I_u1s2(_bltz)
 I_u1s2(_bltzl)
 I_u1u2s3(_bne)
+I_u1(_break)
 I_u2s3u1(_cache)
 I_u1u2(_cfc1)
 I_u2u1(_cfcmsa)
 I_u1u2(_ctc1)
 I_u2u1(_ctcmsa)
+I_u1u2(_ddivu)
 I_u1u2u3(_dmfc0)
 I_u1u2u3(_dmtc0)
+I_u1u2(_dmultu)
 I_u2u1s3(_daddiu)
 I_u3u1u2(_daddu)
 I_u1(_di);
 I_u1u2(_divu)
+I_u2u1(_dsbh);
+I_u2u1(_dshd);
 I_u2u1u3(_dsll)
 I_u2u1u3(_dsll32)
+I_u3u2u1(_dsllv)
 I_u2u1u3(_dsra)
+I_u2u1u3(_dsra32)
+I_u3u2u1(_dsrav)
 I_u2u1u3(_dsrl)
 I_u2u1u3(_dsrl32)
+I_u3u2u1(_dsrlv)
 I_u2u1u3(_drotr)
 I_u2u1u3(_drotr32)
 I_u3u1u2(_dsubu)
@@ -294,6 +316,7 @@ I_u1(_jal)
 I_u2u1(_jalr)
 I_u1(_jr)
 I_u2s3u1(_lb)
+I_u2s3u1(_lbu)
 I_u2s3u1(_ld)
 I_u2s3u1(_lh)
 I_u2s3u1(_lhu)
@@ -301,8 +324,11 @@ I_u2s3u1(_ll)
 I_u2s3u1(_lld)
 I_u1s2(_lui)
 I_u2s3u1(_lw)
+I_u2s3u1(_lwu)
 I_u1u2u3(_mfc0)
 I_u1u2u3(_mfhc0)
+I_u3u1u2(_movn)
+I_u3u1u2(_movz)
 I_u1(_mfhi)
 I_u1(_mflo)
 I_u1u2u3(_mtc0)
@@ -310,15 +336,20 @@ I_u1u2u3(_mthc0)
 I_u1(_mthi)
 I_u1(_mtlo)
 I_u3u1u2(_mul)
-I_u2u1u3(_ori)
+I_u1u2(_multu)
+I_u3u1u2(_nor)
 I_u3u1u2(_or)
+I_u2u1u3(_ori)
 I_0(_rfe)
+I_u2s3u1(_sb)
 I_u2s3u1(_sc)
 I_u2s3u1(_scd)
 I_u2s3u1(_sd)
+I_u2s3u1(_sh)
 I_u2u1u3(_sll)
 I_u3u2u1(_sllv)
 I_s3s1s2(_slt)
+I_u2u1s3(_slti)
 I_u2u1s3(_sltiu)
 I_u3u1u2(_sltu)
 I_u2u1u3(_sra)
@@ -339,6 +370,7 @@ I_u2u1u3(_xori)
 I_u2u1(_yield)
 I_u2u1msbu3(_dins);
 I_u2u1msb32u3(_dinsm);
+I_u2u1msb32msb3(_dinsu);
 I_u1(_syscall);
 I_u1u2s3(_bbit0);
 I_u1u2s3(_bbit1);
-- 
2.9.4
