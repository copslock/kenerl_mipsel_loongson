Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2018 23:51:34 +0200 (CEST)
Received: from mail-by2nam05on072f.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe52::72f]:42301
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993030AbeIKVuocDw-b (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Sep 2018 23:50:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deb5vdz2FGjr7kqBGmpo0Vxkqps7Pre+A3tP6FkFP10=;
 b=O5Dch3T1eGIsrSKaD+bVN25GJ/p5tQ9YvPHG5UHdeKv18O09XjCPVipxnUlQ0bnW0IOvhEHk3dc4F0ncwpa9WX4WYr3TuLoSrOeZCECkHRpp2D3WQnyGvU4yzXnjbPsEdcB4KXnPZ/XKxgCERD8Wf02xqkWEmVnyChH0Dqijq+w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from box.mipstec.com (4.16.204.77) by
 BN3PR0801MB2145.namprd08.prod.outlook.com (2a01:111:e400:7bb5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.18; Tue, 11 Sep
 2018 21:49:54 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     pburton@wavecomp.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, rachel.mozes@intel.com,
        Dengcheng Zhu <dzhu@wavecomp.com>
Subject: [PATCH v5 1/5] MIPS: kexec: Mark CPU offline before disabling local IRQ
Date:   Tue, 11 Sep 2018 14:49:20 -0700
Message-Id: <20180911214924.21993-2-dzhu@wavecomp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180911214924.21993-1-dzhu@wavecomp.com>
References: <20180911214924.21993-1-dzhu@wavecomp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR21CA0055.namprd21.prod.outlook.com
 (2603:10b6:3:129::17) To BN3PR0801MB2145.namprd08.prod.outlook.com
 (2a01:111:e400:7bb5::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cae6752d-2246-4725-0f1c-08d6183082a5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN3PR0801MB2145;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;3:PZHDMZW5q3TJbxKz/McSY75nc6CaDtZ5SxgFeWPhCGeuSg7qyTQexingP0mRAS8t5jF/5r0562wKGwrY/LKq3r6TQ1mUouGlnJpJZPUZLEsWvk2J3cCF6FooQCFj3yWM6xkQ2CEt3QcIAuU2hNiHn2FcRKTVpKiLop1Jb6Az/932puURoJU+azKeffB2iscm38L1jcFYtgqzWwbNa3oO063bZVpFYy34xIwF7HljaxrZ/uwZFoCOkAxIdwMVmPAb;25:MPVNmX6oKFNyKD+BNDedg40lQCU4bIZWMIVKw9G+w1f2SV+5KzW+HkF+tbmL0lQzkDEweDGgtNEsHkkP54prQwQcfAYnZPch8ZPjSpKHPUHyaEUoln63OY9xGoGsjiv5IOkpA9xTe1OYTmlVoP9Z2MuohZa8OBNJFBpUQGcGiC9SSikzWjTv9/BRHuFPQFZ/rRjRxWjgT9pmpiMX7wPthBmwFsOTE9EdCOEgkbKq9ER+xB1BlYo6IcrYv83dJoiDotN7dEj2kQ20Lj6Xx3DDK3tE6MRAnV+284odrzV5VM/RQrOPH101gZDHsFazBVxmIsks5q5vy6wfYm9PwanqrA==;31:O0TPwVfZxbQySW7rfq2jM5HLyIIzzI7zDNyAm8JUS88wjqPc5pz2nCL0JmIaCs1yyrSttmsgRgMYWJhneLDwLlCSipyAeuqi/ai7Qz1S8Ub449pbkCuLDxoAAdFrQR26o1h+CDEBUdCGGoho7VCX8rIjHjpqPqvpc9zGtHaD85Gol92cKdOjbSL4+OBz17L4MhzYzjSL233eCqKY5n3m5b+fL9SpXWKuQBo+gMgBC3U=
X-MS-TrafficTypeDiagnostic: BN3PR0801MB2145:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;20:ZIiDs1/tml0OAW1a6CRbtLSCSFjp2bvocG+qLdS6a1JWDS2GV1v8n0pddGL/vamMbl/YLaxE/u7VtmOIwwGLhv9x5JG7eXrlZBSlUvFWQVfhC6MS7T/9PEb1Z9dRG+6m0GokMi1W6ic4fbq1ZORfbgZwf3Bx/OLsVAC+jv3Ju5kw9+lfJKotn2khPnzUMvHu/PpX3nUiqbhHe+RVp39l1h8cOY8fQ4Lh5QjEwaBnQYyJtC+tCh/dUS9MNK5rZ/LV;4:31MXI4OhEGEmkCXkR49Kht+9w+4JDsUHLH4tazFmSx03pFosd6sSnl9WHxJXVG6i0Xk1xq/Brb8bIJFUi/yAxvfz5QS7wXyqCrv/iKiwUf4uPPHJTL1ie7goAXiI+ZNKEt7qyQsGBhA9lEiqWCJOeInQTzMDnmBr52DPmr8Brhqctbb5UvYlYm+p8uAfeRr9Tmd0NAaWVmfyTvcnFvegsemYzFyoi48YgfiUMBaJWlu3mxHThVNn0y4yXmHoVemOyC1TDY4oefTqNxXlu7ZqybR3HtVcQSEN4awtL9KUjTjeGoi0IkpOEHEoTJaCeB/Q
X-Microsoft-Antispam-PRVS: <BN3PR0801MB214515DFBEB721600E3AFB74A2040@BN3PR0801MB2145.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699050);SRVR:BN3PR0801MB2145;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0801MB2145;
X-Forefront-PRVS: 0792DBEAD0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(39840400004)(136003)(366004)(199004)(189003)(6486002)(4326008)(316002)(2906002)(68736007)(8676002)(36756003)(16586007)(8936002)(53416004)(105586002)(37156001)(86362001)(48376002)(106356001)(25786009)(50226002)(50466002)(6666003)(66066001)(47776003)(305945005)(53936002)(5660300001)(76176011)(81156014)(52116002)(69596002)(16526019)(51416003)(6512007)(97736004)(3846002)(6116002)(6506007)(7736002)(386003)(26005)(81166006)(1076002)(2616005)(11346002)(446003)(478600001)(107886003)(486006)(956004)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR0801MB2145;H:box.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR0801MB2145;23:wbWv3yxgIxs3o0BX1bNhdPwtal/5QWOzaO58RTr?=
 =?us-ascii?Q?gciTWPCelyER2QqnC23PYPMmr1g4ZhH7PefiI+/HeKlZfxDavAw9KYW45Eip?=
 =?us-ascii?Q?4/TD/DmLG58LpBLwVOmD4aSvp9r23yrK+Z1TIlauljRATuRHXeWKVjtzLa+M?=
 =?us-ascii?Q?FD2nNE4cVKZvmRq9nVLRpwMwownkb+82CwSW3sH3yVhqxMTHe9/FXBH9xdMo?=
 =?us-ascii?Q?2qd+WVAF47Omza/LsW+SyezyqdAzBM+uScGzM4Sahx0YY3icy4QGELkcz6FH?=
 =?us-ascii?Q?0MCYu5P2+tCnm3ZfbTblOa/8Xm64OseRalsHY7m1D4sPeaNujq2fYD8ujUZE?=
 =?us-ascii?Q?2zxFrkJ3eGsh+3IoP2Nj+HE4z7RoAg0XiPB2uMJ5bzXVzRX/T+c36wQucdK0?=
 =?us-ascii?Q?nnjnzN3EHbgU5VT9tIDJVKj2YXUDMqFt65BlvI1uXFuEvIDVi+ovX8OTL5Ss?=
 =?us-ascii?Q?FvR73eG4sc8ct+LW7qzSko+IPv9ioouSeic0BkDndCciaVarxFH5OVK9j34v?=
 =?us-ascii?Q?zYydx8R9vjAzdx6qt5kv9OY5NBDmxcTZtNedyL9l89mMY7Tvs+fuKMwSaUhW?=
 =?us-ascii?Q?yu+iUoTto3wFk9QpRj+g9FE8xBVVL7IquzO159hETqZNb72A5VeKlgN5+DBv?=
 =?us-ascii?Q?CNT5rcLejtH2PjwlIF2BU3NsqgxaPfRttj+ikLoJPA4ZDtGCp9vZbNhMR5jW?=
 =?us-ascii?Q?Ta3SL76J6Bu+YvMf+D1Yc6TYoWf1PaT2BY2TPlCJTpeHrIVS8co57IkXSlKX?=
 =?us-ascii?Q?9gXPfVv+1UdW3OCVbwoguouyDFjQuaT4Sx+SAY519AYQsQv7rwaOc0g0LuMy?=
 =?us-ascii?Q?tTnuNH4pPgpQ5aa7mnmiM9xhy9sL7x/o/SsktxzJmvAp9vvsPzoKLtM4qFmu?=
 =?us-ascii?Q?h0SvLKeZjKScroK5VhcaIoP8fDxFD3QJrtmS0Z/RXizCtztw5HEsqd1xo1UU?=
 =?us-ascii?Q?dqnL1pJhodmEpuAeNe13txW9/RHt+9PdXjIrrWSgaOHgzqWDOi317DGHP83j?=
 =?us-ascii?Q?6Ha1nKttOz0/ntAqoau8X+xQY37bjKtlycHplFWiM6PWUMniSCdcBlRKZyhm?=
 =?us-ascii?Q?0KKIvWKaFSJ1rZ6+UMLWthj3QJ7UpcrovGyrRQu9lRpqji6PYOAPm//1cZAs?=
 =?us-ascii?Q?61/de4GkGOEDv2RxU9hiyPucpiNuOZIh0E04gTekLZP5S4tLccnqzH6rr24P?=
 =?us-ascii?Q?0kkBLeW9r4egZy5xCGFJ9d97TdVnuUlrBaPo+ku8kBd14FXfsa0MKdO/t3g?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: Tu/ePMRRREOf2nggFt715pE2+V1zmf5RNC4dGlcugAvWcKile/xGhEhwcuMtGW3Gd6h4vLF2WhMV7+YiSlhmQScbWkbZLcVEZpGGsCA5yNM1Og4DAevf/snAfi1xC79zuZcSnZajKCgUUhTiIElweTGE4ZSWCmkbuFBeXOEI1Eak0KWFIdUiQYKTlaFUmN4tYBUGBFoo22Nv7y2MfUbzOEb+o2vLA8piM0YjumkLZ4zOE08JIcTNPZbH8NyKWWSyxeyaFGeddLaxc3WDnWCV/yYVQYTaLIDzCC6DIXvgsE4JmtLK6E7hg8q3geD2t/hqXVXQXi8Am40ZHLL/kx3NQB3jYoQswfQzHGLLUOz0o9c=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;6:Fw8rx5fWcX6ixzojAzDWlGAnV/6oLGNBfuMgzWzTPhzW62pieAy8RuAj73knpyCr1OT1KlsTZdaC2PkWH1lN42HNcND2Tryjd9GoS0uwoQSdAlz/h5zy2LgFGhl5dzalrpiNsNt1iAccAr5EaLnnuHsR8GobAn7LPaOAvkiX+QSGodVS7xpFWxNy1Ieq4NqDl9r7TGFCN2sKDstHHHF8JFZw4/qii6N0RFL/jGAK7wn4YVrdMVAObVwrK56DhyqY/u+YwU6QBr4RG7kKIpBDIAzY+WBHWbhlEj+PjPCi6bC2JUpe6DDIiudV/3pIygibOjBnYXwKo9p0VdA/yuj3BXU3gJ0JBmJrFXp9zTsWhw4wVUqjXXwTI0DjG7PtxpbQcKMLLWPcDwKSxhos7g9ElI7A6W4OOxzWrPoaNoGLfDic4ykfvNlxXA9BNq8mlb4cOhgJzHrLzYP29Zx/6EYcvA==;5:SMeZNj12B1hj7mhWX3uzp/wLT8bE195phl7E6126GhYIjg9QtydZjktc1344teUs4wRZ7heehbZQNizCy+CMwNiyD+//u3eOOIcCFixzoyOo0ZetKtY+k/iBztnoxG3INnmL0fBoeje+HCvmbzbMsK3AnOize0jmJE4/hvktqDQ=;7:xEinnOGcNh7T8xX7P/wvo/arDUbH0swd3wQNBckUKW63jIYHetgxilehzhhpsyxd2H4qN1Aj9MPxWYbK/reuqDfmMpOpKyxRjs9/1FFbp2gZ4aWmxfNcOAuyVWmsP59t9Q31THKbT68bRfI7VwUDS37CwXoR85dJQVYe/EVtXWEGmM3RwIApKCKHo8f+TwXJoHdo2SrgyNhrWljhXiblqP9KTxJqaqTUBVIkJUYyrJwCwFBUE9kFExKSQ18asAXN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2018 21:49:54.3031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cae6752d-2246-4725-0f1c-08d6183082a5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0801MB2145
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dzhu@wavecomp.com
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

After changing CPU online status, it will not be sent any IPIs such as in
__flush_cache_all() on software coherency systems. Do this before disabling
local IRQ.

Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
---
 arch/mips/kernel/crash.c         | 3 +++
 arch/mips/kernel/machine_kexec.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/mips/kernel/crash.c b/arch/mips/kernel/crash.c
index d455363d51c3..4c07a43a3242 100644
--- a/arch/mips/kernel/crash.c
+++ b/arch/mips/kernel/crash.c
@@ -36,6 +36,9 @@ static void crash_shutdown_secondary(void *passed_regs)
 	if (!cpu_online(cpu))
 		return;
 
+	/* We won't be sent IPIs any more. */
+	set_cpu_online(cpu, false);
+
 	local_irq_disable();
 	if (!cpumask_test_cpu(cpu, &cpus_in_crash))
 		crash_save_cpu(regs, cpu);
diff --git a/arch/mips/kernel/machine_kexec.c b/arch/mips/kernel/machine_kexec.c
index 8b574bcd39ba..4b3726e4fe3a 100644
--- a/arch/mips/kernel/machine_kexec.c
+++ b/arch/mips/kernel/machine_kexec.c
@@ -118,6 +118,9 @@ machine_kexec(struct kimage *image)
 			*ptr = (unsigned long) phys_to_virt(*ptr);
 	}
 
+	/* Mark offline BEFORE disabling local irq. */
+	set_cpu_online(smp_processor_id(), false);
+
 	/*
 	 * we do not want to be bothered.
 	 */
-- 
2.17.1
