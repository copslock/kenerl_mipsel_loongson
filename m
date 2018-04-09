Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 02:33:30 +0200 (CEST)
Received: from mail-sn1nam02on0139.outbound.protection.outlook.com ([104.47.36.139]:26304
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994669AbeDIAbbRTyPV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2018 02:31:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=akIE3DNCbCisK8ypbCrSNwHe7ZYNZox2PsqVVSVwZY4=;
 b=RBWA7M6m4HfAYiOVjjLccZ74qkWeAz+3IvqJzzDCsSNeHsInSktX9AMdijSw/VsHbBwKID247YkU8+0RBKN8SsidSfbT7GfAqpweeVQpJHcM11xxbK3/GyvH7k7YiU6Jzrz9aXYJG1BeFdMhx6tuVsOZ964wVFXMko/psN0M8uE=
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) by
 DM5PR2101MB0917.namprd21.prod.outlook.com (52.132.132.162) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 00:31:11 +0000
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059]) by DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 00:31:11 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     David Daney <david.daney@cavium.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 160/293] MIPS: Give __secure_computing()
 access to syscall arguments.
Thread-Topic: [PATCH AUTOSEL for 4.9 160/293] MIPS: Give __secure_computing()
 access to syscall arguments.
Thread-Index: AQHTz5kw90QkbJtP7EiDzyohS4co6Q==
Date:   Mon, 9 Apr 2018 00:24:58 +0000
Message-ID: <20180409002239.163177-160-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:/+Yi4XP4VgaZBRdcCIAFdErbQT5p9zNR6Zpsk8YKxsjAIayStHje3HDyaZcUEqOEFUxEIS9GXMyjV8/qTIdhJg4o6mO7iYs9mdkU/S8AucR0rXVTWLOLhqQjcyl4ZTys0d+WroZX8FeN+JF0D0FDzfhs5t6VEzzAkjXtSspBlvYVsooU0vYD29trLmhmneHHYMrxQftOZpuPj4PG5Ui3GiUqbwx1EqimBtrARmba3zD0ueNuBHLI3hdBZecpcwSO;20:q8NccyA9g5QlU1cT6qx71k2AXRgK7f78zkzTYpiMyH7fMN7iIfLWcanIo6NMVli0AU7s92zoZCUkMRgs9e8chVT5xuyo5ADr2pG5lsQzT4Zkui0QUxSdWIvzHPcJ9yezVJ843gNfuF0yVINU0btfnggiK7ipZWOl8ZI4E45WyEs=
X-MS-Office365-Filtering-Correlation-Id: a4f90c6b-f992-4ac8-7b35-08d59db13205
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB0917FAE53FF2EDCF02C8A292FBBF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(99286004)(22452003)(106356001)(26005)(110136005)(478600001)(54906003)(10290500003)(316002)(1076002)(72206003)(186003)(4326008)(97736004)(66066001)(11346002)(25786009)(86362001)(575784001)(476003)(446003)(2906002)(6666003)(6486002)(105586002)(86612001)(3280700002)(3660700001)(6512007)(3846002)(6306002)(6116002)(6436002)(2616005)(486006)(53936002)(7736002)(8676002)(81166006)(81156014)(8936002)(68736007)(305945005)(10090500001)(76176011)(6506007)(102836004)(36756003)(107886003)(59450400001)(2900100001)(2501003)(14454004)(966005)(5660300001)(5250100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: l7R997OkgbQEl4UQl7Ro9U5+0SArx81lOssqy9vqN4pP2zH+3BxJAKdkgJFWzHpyGcyvh0dVYmFDGoTNgOEsmRHdRD0766tvty2GfraOiQ7Jp1rJxCe5/XB1MxMeknFVrAHOeqxu/1Egq0oInwUicS4SSkrkkX3TDnAoFWF7Fau4RM3aUqSHU854WhrtlC/nb33uHxSSrr6oBDzOOFOj/ODBOjle6Sb4NJlbdF45Lu8kYzbPMeoh/NaxMmsG87OY4yNRLdAZxEhrLuqkTx3gyPY0KiJYFuz0mzYQudupcx5iBx9uBlx2iSh1rr9a5jV/K5t9CjYGd8enpCLVbNGYK5JjZyS6gjoP891h57qjZiTx/bNzrUKQH7ezFFEGvkfC52ueZEI2EGPwOVZjkc2wltPL3J4wHyfk7mGAWMBiAiY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f90c6b-f992-4ac8-7b35-08d59db13205
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:58.1126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63454
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

[ Upstream commit 669c4092225f0ed5df12ebee654581b558a5e3ed ]

KProbes of __seccomp_filter() are not very useful without access to
the syscall arguments.

Do what x86 does, and populate a struct seccomp_data to be passed to
__secure_computing().  This allows samples/bpf/tracex5 to extract a
sensible trace.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16368/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/kernel/ptrace.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 0c8ae2cc6380..956dae7e6a69 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -1011,8 +1011,26 @@ asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
 	    tracehook_report_syscall_entry(regs))
 		return -1;
 
-	if (secure_computing(NULL) == -1)
-		return -1;
+#ifdef CONFIG_SECCOMP
+	if (unlikely(test_thread_flag(TIF_SECCOMP))) {
+		int ret, i;
+		struct seccomp_data sd;
+
+		sd.nr = syscall;
+		sd.arch = syscall_get_arch();
+		for (i = 0; i < 6; i++) {
+			unsigned long v, r;
+
+			r = mips_get_syscall_arg(&v, current, regs, i);
+			sd.args[i] = r ? 0 : v;
+		}
+		sd.instruction_pointer = KSTK_EIP(current);
+
+		ret = __secure_computing(&sd);
+		if (ret == -1)
+			return ret;
+	}
+#endif
 
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->regs[2]);
-- 
2.15.1
