Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 00:14:12 +0100 (CET)
Received: from mail-eopbgr680094.outbound.protection.outlook.com ([40.107.68.94]:46351
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992905AbeKGXOCfUNRU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 00:14:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMQAQxDwY4rakH3jAzJlvKBmP/uigJdqK6SOZeYceNE=;
 b=P8BJvJ0OhaccCqNQMXYyRDmr8XDLa372ECPPdmRpvwmaRUSXsMIz65yNKKe4kG79wpkn8SZPAYgsqhoK/dBc4BJmL4QsEU8tXr9UHtI1c3SF6xTdeciIuDZas7fWIci7ZK/tfPoWOhNyn4GOEsbJ1gy9esReURFkGSlutHu7VNs=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1472.namprd22.prod.outlook.com (10.174.170.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Wed, 7 Nov 2018 23:14:00 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 23:14:00 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH 04/20] MIPS: Ensure emulated FP sets PF_USED_MATH
Thread-Topic: [PATCH 04/20] MIPS: Ensure emulated FP sets PF_USED_MATH
Thread-Index: AQHUdu+Q4BM66QDh4Em1P4CkDMqrtQ==
Date:   Wed, 7 Nov 2018 23:14:00 +0000
Message-ID: <20181107231341.4614-5-paul.burton@mips.com>
References: <20181107231341.4614-1-paul.burton@mips.com>
In-Reply-To: <20181107231341.4614-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0028.namprd21.prod.outlook.com
 (2603:10b6:300:129::14) To MWHSPR00MB117.namprd22.prod.outlook.com
 (2603:10b6:300:10c::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1472;6:rkUTHE3c+fJM9Td7KNBe5axMgD9uXyVLNQcAsH8IjWLs4nq6wpyR0+qsTuoE5BJ9gfYd0ZRN2DoVzS7+vYHDYHsJLlO08LgkYE68DMTikv3mX7eLM3XNS3zCp6Ddu+bFEIyJJNuwZypiQ+GNvxuRGNv8fMAs8jGCdcbBfC2tfwPSu85f+sqCY6FCphIvBZAro0a0o/2QPiFJMEZSj0YRO4Z5dbmMZHSU1Bwqs/sUXEVBykGKipuMh2pB3jng4rzTSEEcmgB2IxUEd3/Dx4Plw0xsHG72/YeZitJgaL/c9FNctM7QySzlzw8MkN+XYiMi8vsBwxlPVuuH7IlOh7UJHE0LDPhEZ0joqeu/lLeXlWblg563T8TwPihbSXxKceaDKPWTOnMXM8o4zIZtgqGT+i/EyPjptq9+i2wyEP+gIklICXnh6P60Tr9XCKitjkHdq2loHVi5M5+2YKMCzaC7NQ==;5:Vubfw19JEOE1gBf5MAsJZTNXeWODjCTnw03HOqooqcCj/6Sq3qlqeUW3KWxFtvy0kyJQ2cDsxqSx7KgtOi+rXNG0BO9YbdgeXqonf+xxnQBbE7t9IUbd+gdM9tXlUekgX+kIJgsLkPZOU5wd/iVd+qSdl8Wti0ED/Yy2UczYCXo=;7:dyACyIcJH5RyI6l0XXvSYGxmz/4te24K42Tpo4nzMvWRETghdjqnBEVif8tlow14CgJYrhxkktkuNT3LMc65Epu+OwT13ukr2/ZxJlP3mGd1JZ2Hyb0S3kMND2YnGC5nfY+6kgKk2Fe9c2Amu96pMg==
x-ms-office365-filtering-correlation-id: 2e18e3de-1729-4f2c-1db8-08d64506b352
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1472;
x-ms-traffictypediagnostic: MWHPR2201MB1472:
x-microsoft-antispam-prvs: <MWHPR2201MB1472EEBDDE1EAC9064EFB622C1C40@MWHPR2201MB1472.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(3231382)(944501410)(52105095)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1472;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1472;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(136003)(376002)(39840400004)(189003)(199004)(99286004)(52116002)(256004)(14444005)(26005)(186003)(386003)(76176011)(446003)(11346002)(102836004)(44832011)(476003)(2616005)(486006)(7736002)(5640700003)(2906002)(6506007)(6512007)(71200400001)(6436002)(71190400001)(316002)(2501003)(14454004)(8676002)(81156014)(97736004)(3846002)(6116002)(25786009)(8936002)(1076002)(81166006)(2900100001)(6916009)(6486002)(36756003)(66066001)(53936002)(305945005)(68736007)(107886003)(508600001)(5660300001)(4326008)(42882007)(2351001)(105586002)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1472;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4ZB1pXMKQidrDqKL/lhFPxVFIRLvBf3cuF9RSvST2J/rrxAR1cx6i5NydzIEvTI94TFhyTACfYZz6cReouDr7vPYKe3sZIsNLid+Te8UTIlGPi/LIVV53HquIT077URFwFor814YTv60ZaUNF+zWIW09G5OH9Y/qQ0ZwtC+yr3ZenoKaitYDVgVRu7jktvx8X02ts7gqVoSYVKqj7+5j3WFAWgKE5g4M8eRQepC0h2EBZ2BkvoTryzbjv7wOSNqPOiB+Kz0QlVsjJKjAd19S2DDhcdm8W4ZvCLKheg2UTb8mkSmE2ZMMfQqDzvsfWGQ4J5huOIiBuZscF61bA0zmYf7dY2QwlnKuI8wHcNIYGeM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e18e3de-1729-4f2c-1db8-08d64506b352
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 23:14:00.2099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1472
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67140
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

Emulated floating point instructions don't ensure that the PF_USED_MATH
flag is set for the task. This results in a couple of inconsistencies:

  - ptrace will return the default initial state of FP registers rather
    than the values actually stored in struct thread_struct, hiding
    state that has been updated by emulated floating point instructions.

  - If a task migrates to a CPU with an FPU after having emulated
    floating point instructions then its floating point register state
    will be reset to the default ~0 bit pattern, losing state from the
    emulated instructions.

Fix this by calling init_fp_ctx() from fpu_emulator_cop1Handler() to
consistently initialize FP state if it was previously uninitialized,
setting the PF_USED_MATH flag in the process.

All callers of fpu_emulator_cop1Handler() either call lose_fpu(1) before
it in order to save any live FPU registers to struct thread_struct, or
in the case of do_cpu() already know that the task does not own an FPU
so lose_fpu(1) would be a no-op. Since we know that saving FP context
will be unnecessary in the case where FP context was just initialized we
move this call into fpu_emulator_cop1Handler() too, providing
consistency & avoiding needless duplication.

Calls to own_fpu(1) are common after return from
fpu_emulator_cop1Handler() too, but this would not be a no-op in the
do_cpu() case so these are left as-is. A potential future improvement
could be to have fpu_emulator_cop1Handler() restore FPU state
automatically only if it saved it, though this may not be optimal if
some callers are better off without their current calls to own_fpu(1).
One potential example of this could be mipsr2_decoder() which as-is
could end up saving & restoring FP context repeatedly & unnecessarily if
emulating multiple FP instructions.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/kernel/mips-r2-to-r6-emul.c | 3 ---
 arch/mips/kernel/traps.c              | 5 -----
 arch/mips/kernel/unaligned.c          | 2 --
 arch/mips/math-emu/cp1emu.c           | 7 +++++++
 4 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/mips/kernel/mips-r2-to-r6-emul.c b/arch/mips/kernel/mips-r2-to-r6-emul.c
index 9c1690235896..1468d1dfb793 100644
--- a/arch/mips/kernel/mips-r2-to-r6-emul.c
+++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
@@ -1175,9 +1175,6 @@ int mipsr2_decoder(struct pt_regs *regs, u32 inst, unsigned long *fcr31)
 		regs->regs[31] = r31;
 		regs->cp0_epc = epc;
 
-		if (!init_fp_ctx(current))
-			lose_fpu(1);
-
 		err = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 0,
 					       &fault_addr);
 
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 650b9dd05b8e..db52d30eacec 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -794,9 +794,6 @@ static int simulate_fp(struct pt_regs *regs, unsigned int opcode,
 	regs->cp0_epc = old_epc;
 	regs->regs[31] = old_ra;
 
-	/* Save the FP context to struct thread_struct */
-	lose_fpu(1);
-
 	/* Run the emulator */
 	sig = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 1,
 				       &fault_addr);
@@ -848,8 +845,6 @@ asmlinkage void do_fpe(struct pt_regs *regs, unsigned long fcr31)
 		 * register operands before invoking the emulator, which seems
 		 * a bit extreme for what should be an infrequent event.
 		 */
-		/* Ensure 'resume' not overwrite saved fp context again. */
-		lose_fpu(1);
 
 		/* Run the emulator */
 		sig = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 1,
diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index ce446eed62d2..4c7de9f6373d 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -1220,7 +1220,6 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 		die_if_kernel("Unaligned FP access in kernel code", regs);
 		BUG_ON(!used_math());
 
-		lose_fpu(1);	/* Save FPU state for the emulator. */
 		res = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 1,
 					       &fault_addr);
 		own_fpu(1);	/* Restore FPU state. */
@@ -1733,7 +1732,6 @@ static void emulate_load_store_microMIPS(struct pt_regs *regs,
 		BUG_ON(!used_math());
 		BUG_ON(!is_fpu_owner());
 
-		lose_fpu(1);	/* save the FPU state for the emulator */
 		res = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 1,
 					       &fault_addr);
 		own_fpu(1);	/* restore FPU state */
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 62deb025970b..82e2993c1a2c 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -2831,6 +2831,13 @@ int fpu_emulator_cop1Handler(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 	u16 *instr_ptr;
 	int sig = 0;
 
+	/*
+	 * Initialize context if it hasn't been used already, otherwise ensure
+	 * it has been saved to struct thread_struct.
+	 */
+	if (!init_fp_ctx(current))
+		lose_fpu(1);
+
 	oldepc = xcp->cp0_epc;
 	do {
 		prevepc = xcp->cp0_epc;
-- 
2.19.1
