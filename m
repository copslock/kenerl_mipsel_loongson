Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Mar 2018 23:40:17 +0100 (CET)
Received: from mail-bl2nam02on0092.outbound.protection.outlook.com ([104.47.38.92]:62080
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994614AbeCCWkJZ4mKR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Mar 2018 23:40:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3Zf1zVfRE7KfOy8MNfmsaJI+2l11x+IuY2uYagpsFNQ=;
 b=DoTPLjbmu0bYXM8botwZot6wrlkP9hBugSJ9zgRW9fmk5UNdecGaNKwqUnPWVK6NoNwTJpxYIWBLdUOvjQ15BKwHJ6IutNya0jboU4ZRy3SlMKSfOLl+jr9fGHGLMuJvmyIXEy8rHStUkGFnGFouv0foCwXbxYwEsCBNhYOHNXk=
Received: from MW2PR2101MB1034.namprd21.prod.outlook.com (52.132.149.10) by
 MW2PR2101MB1033.namprd21.prod.outlook.com (52.132.146.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.567.3; Sat, 3 Mar 2018 22:39:55 +0000
Received: from MW2PR2101MB1034.namprd21.prod.outlook.com
 ([fe80::1d56:338f:e2b:cec0]) by MW2PR2101MB1034.namprd21.prod.outlook.com
 ([fe80::1d56:338f:e2b:cec0%3]) with mapi id 15.20.0567.006; Sat, 3 Mar 2018
 22:39:55 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     David Daney <david.daney@cavium.com>,
        James Hogan <james.hogan@imgtec.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Steven J . Hill" <steven.hill@cavium.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 067/115] MIPS: BPF: Quit clobbering callee
 saved registers in JIT code.
Thread-Topic: [PATCH AUTOSEL for 4.4 067/115] MIPS: BPF: Quit clobbering
 callee saved registers in JIT code.
Thread-Index: AQHTsz9ekiLLqY3ehUywucTq1NLk/Q==
Date:   Sat, 3 Mar 2018 22:31:27 +0000
Message-ID: <20180303223010.27106-67-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1033;6:iY4ZR1GTcBETtd21piklw84aA4EEjMoU+JlW1tPhzfUdTk5oEdAe8W0Bgd1H1XguvDoda48kbtFbLrowaQEbQFGwITuoinxr7M4Ic+aEJEeKA7NfmITanYLWaTlXX4CJ4g8kdfJdnLSoy4TLIptN+V4myg3D+6M1PnfSRFPSclaSIEcQM0bkXTzDjRAhK2Fbiy8iJmOJcK7wWR7z3fZ41CBA89bA8FDymsur++HBZ2LUwH9NWaTMLwGYpMU31XFvrE/VHB+Jhybrw/D3zYIWPunssGGiRugYA1uMu3vEHmDdR1TAkCTo7HePgamZMIsPL6q1C2LorI9MIVDfX4VTuMkXtaTzdmYYnnLob19krgjcrjz0QNuSbpt0g9MbSuRS;5:t4vYU8530X/wD954RXK2gGsGK8paYy0M8cdD4k3DTx+LrI1loQ5ttDb94nsgj/tRSl2AXzBOSstgOFQKWqfi0PSifnq8cIhl/DHqAZL07qs9r1g1kKQ8EvjPxkPF7s+PDaoM8ognPiZZD2RnIGyG+pWLtOq/b2yIFL/fiur9Oto=;24:DCQL8dFo5bWqbj1DnzTUeLrzYM1AlQOTEY+MhLij/rrfwSIRx/vTUqNMc8g+JPTXqnHh6k42RStyXZP3AdNVRlDzfLshKS+3JxQYtzTi9/8=;7:VtSvYVLfgRx9xYSAAYthDR3gOk+gEGQ546uKvg4eg7zamc67LzkhIa4Y0KyLszSxhcp//B0Vhe+lAsfnDN3Nys/Y2okCLVYaic6mDyl2FtoIueA/T3qV1UMxt0JTmcQ6iGzj7ysvcPUwqP1Nuvf3NCr86Gc91QVYBsVMZ0K6YqujTWa1KonYi/RZH2a69rr6aOefODoC1YxqzERNw7sGwRe7aFRfI8m8pnb6g8TYLP/Bikkq/WedjrfGXOtALKCo
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9cfe1ff2-0907-4a79-9526-08d58157afa7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1033;
x-ms-traffictypediagnostic: MW2PR2101MB1033:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB1033A5B916012BA7B33839C4FBC40@MW2PR2101MB1033.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1033;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1033;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(366004)(346002)(396003)(189003)(199004)(3280700002)(3846002)(316002)(6666003)(99286004)(110136005)(2900100001)(54906003)(2501003)(10090500001)(53936002)(5250100002)(106356001)(76176011)(36756003)(107886003)(2950100002)(6486002)(22452003)(6306002)(6512007)(6436002)(575784001)(86362001)(6116002)(1076002)(6506007)(2906002)(68736007)(102836004)(4326008)(59450400001)(97736004)(186003)(478600001)(72206003)(26005)(3660700001)(8676002)(25786009)(966005)(66066001)(14454004)(5660300001)(305945005)(86612001)(81166006)(8936002)(10290500003)(105586002)(7736002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1033;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Yww6rJlrpKoP9oRUW6TmCqu8Asr+qaHtxPanB5x3gx0HrbHiWw7MkNkZrKgHFGGFatsuSntBNvANQ+8KY0+46aL259NSsRwIAJi3RSPZwObEKM2cwhM58aZgT3pFzv/Fbwi61KZ4sseUiNbznxAS+lxtllGFeTQflTTlMX5OwdE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cfe1ff2-0907-4a79-9526-08d58157afa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:27.9634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1033
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62798
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Alexander.Levin@microsoft.com
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

From: David Daney <david.daney@cavium.com>

[ Upstream commit 1ef0910cfd681f0bd0b81f8809935b2006e9cfb9 ]

If bpf_needs_clear_a() returns true, only actually clear it if it is
ever used.  If it is not used, we don't save and restore it, so the
clearing has the nasty side effect of clobbering caller state.

Also, don't emit stack pointer adjustment instructions if the
adjustment amount is zero.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Steven J. Hill <steven.hill@cavium.com>
Cc: linux-mips@linux-mips.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/15745/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/net/bpf_jit.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index 1a8c96035716..c0c1e9529dbd 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -527,7 +527,8 @@ static void save_bpf_jit_regs(struct jit_ctx *ctx, unsigned offset)
 	u32 sflags, tmp_flags;
 
 	/* Adjust the stack pointer */
-	emit_stack_offset(-align_sp(offset), ctx);
+	if (offset)
+		emit_stack_offset(-align_sp(offset), ctx);
 
 	tmp_flags = sflags = ctx->flags >> SEEN_SREG_SFT;
 	/* sflags is essentially a bitmap */
@@ -579,7 +580,8 @@ static void restore_bpf_jit_regs(struct jit_ctx *ctx,
 		emit_load_stack_reg(r_ra, r_sp, real_off, ctx);
 
 	/* Restore the sp and discard the scrach memory */
-	emit_stack_offset(align_sp(offset), ctx);
+	if (offset)
+		emit_stack_offset(align_sp(offset), ctx);
 }
 
 static unsigned int get_stack_depth(struct jit_ctx *ctx)
@@ -626,8 +628,14 @@ static void build_prologue(struct jit_ctx *ctx)
 	if (ctx->flags & SEEN_X)
 		emit_jit_reg_move(r_X, r_zero, ctx);
 
-	/* Do not leak kernel data to userspace */
-	if (bpf_needs_clear_a(&ctx->skf->insns[0]))
+	/*
+	 * Do not leak kernel data to userspace, we only need to clear
+	 * r_A if it is ever used.  In fact if it is never used, we
+	 * will not save/restore it, so clearing it in this case would
+	 * corrupt the state of the caller.
+	 */
+	if (bpf_needs_clear_a(&ctx->skf->insns[0]) &&
+	    (ctx->flags & SEEN_A))
 		emit_jit_reg_move(r_A, r_zero, ctx);
 }
 
-- 
2.14.1
