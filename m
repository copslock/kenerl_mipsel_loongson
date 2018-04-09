Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 02:32:44 +0200 (CEST)
Received: from mail-co1nam03on0131.outbound.protection.outlook.com ([104.47.40.131]:60385
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994651AbeDIAbaFRRxV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2018 02:31:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=sBl3efyoKilowowuruacTG2JLHhPcU4g7PdNaCMcmbo=;
 b=kXKZtZ7kEhKJVLblvV3sOlsEnilSEo9JSuACSf+S+eJcscLA4JAx22Xp31P4FRA0WNVnPMKH0dwrPnx1p8RP8aAlS0yMFLOFa1cytjPg7F4wzBWQVGem4Ur6NnSY4UcIOKLNUzdOog1PYXuKnp0yjB4IiiopxPKVYFMGz2evW48=
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) by
 DM5PR2101MB1126.namprd21.prod.outlook.com (52.132.132.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 00:31:19 +0000
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059]) by DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 00:31:19 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 172/293] MIPS: CPS: Handle cores not powering
 down more gracefully
Thread-Topic: [PATCH AUTOSEL for 4.9 172/293] MIPS: CPS: Handle cores not
 powering down more gracefully
Thread-Index: AQHTz5k3iIfUkeNmn0aEPwTfl+qWNA==
Date:   Mon, 9 Apr 2018 00:25:09 +0000
Message-ID: <20180409002239.163177-172-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1126;7:e5iewB6aDLXq37bqs+Abhm4K1lY0+dw1XNqoswSVPtTmpl83vVonj0ZMgRvRnmoNoOLJZYfQ7G7jbE+JFgLI/2679uBcXQFz9G/TH8TMy1T0dwQSQOqUwGM6xFigXGbNp00JHY1XhkEgTRibvzgm7he5WSjiAuV2SYP67Ni9FvX9p5InJCCiGCp9wciMAweBTi77odaqRqi522dzmF/x3j96bZB/R7+JoWLjcjL7Pq1h+A0TgJlaMVN3svPmnb0u;20:ICLiTZ0IIPFPMHOk9r+Jt1RdeZZmqjRS6egJs59h52imKxNaSSADDfZ4AA1saX3P1RrhOtepYcEPNJlvQ4Q56T/BYtXqABoYQb1y0OE2wfcWDCJ/D4y/zT7os3ud94oQi2UAoJlOxNXQet3sFELR4GEOprlDnETFr6BZxEfbzD4=
X-MS-Office365-Filtering-Correlation-Id: 2460727f-0e0e-4b32-8481-08d59db1367b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1126;
x-ms-traffictypediagnostic: DM5PR2101MB1126:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB1126C41733FFF16512CA1445FBBF0@DM5PR2101MB1126.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1126;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1126;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(39860400002)(346002)(376002)(189003)(199004)(2616005)(476003)(81156014)(8676002)(81166006)(3846002)(486006)(2900100001)(6436002)(186003)(478600001)(72206003)(110136005)(54906003)(6306002)(2906002)(86612001)(6666003)(2501003)(26005)(10090500001)(102836004)(6512007)(6116002)(14454004)(966005)(5250100002)(10290500003)(1076002)(575784001)(446003)(3280700002)(3660700001)(11346002)(8936002)(25786009)(59450400001)(6506007)(106356001)(4326008)(107886003)(36756003)(105586002)(53936002)(86362001)(66066001)(6486002)(99286004)(5660300001)(316002)(22452003)(305945005)(76176011)(97736004)(68736007)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1126;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NppVqoYk0prVV/VWVuAGY/cjrr0UEzo0ziC2y8kUVyK1wjDjWniql0XwjVdsuja/DBNJPQ03G4nvEFcIlf9BUxH1NGbTSGwuPwYuL88i75+8u3d6wtWZ1v9aMYWEvyqPZISxVBVAw5nfyxaLjFkaFOQK8iVdMZ6Y/kVUdIGh26/+R81PxsK+1QYwn/Ej0Pv0w9mo5dn6K96TeEmIKsLcNJTFeW6Udk/Qe/i2tmRhJtGPuD2xeWHjcSw3Kmbxp0/p6HXleWQCqIi6jylKD4ZgJl6W654+3kPAUZ8WL3MWJry3kUHdkIf7/p6c3QXPn+8papv+dE0ObwQd8vft3hi1jbMI65eJBln6Q+syl7kwAev8OcZq/02WalKlAa05tqPtEuRULVnGnuhUr7ZK/Phq6Z48TkXR01Y5T0UcB3mmGIw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2460727f-0e0e-4b32-8481-08d59db1367b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:09.1751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1126
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63451
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

From: Paul Burton <paul.burton@imgtec.com>

[ Upstream commit 4ad755c9e39c0eeae16f96b97602f1954f582c66 ]

If we get into a state where a core that ought to power down isn't doing
so then the current result is that another CPU gets stuck inside
cps_cpu_die() waiting for CPU that ought to be powering down to do so.
The best case scenario is that we then trigger RCU stall messages or
lockup messages, but neither makes it particularly clear what's
happening.

Handle this more gracefully by introducing a timeout beyond which we
warn the user that the core didn't power down & stop waiting for it.
This at least allows the CPU running cps_cpu_die() to continue normally,
and hopefully presuming the CPU that powered back up is doing nothing
harmful the system will continue functioning as normal.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16197/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/kernel/smp-cps.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 63c8136d5132..adee2bba191a 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -487,6 +487,7 @@ static void cps_cpu_die(unsigned int cpu)
 {
 	unsigned core = cpu_data[cpu].core;
 	unsigned int vpe_id = cpu_vpe_id(&cpu_data[cpu]);
+	ktime_t fail_time;
 	unsigned stat;
 	int err;
 
@@ -514,6 +515,7 @@ static void cps_cpu_die(unsigned int cpu)
 		 * state, the latter happening when a JTAG probe is connected
 		 * in which case the CPC will refuse to power down the core.
 		 */
+		fail_time = ktime_add_ms(ktime_get(), 2000);
 		do {
 			mips_cm_lock_other(core, 0);
 			mips_cpc_lock_other(core);
@@ -521,9 +523,28 @@ static void cps_cpu_die(unsigned int cpu)
 			stat &= CPC_Cx_STAT_CONF_SEQSTATE_MSK;
 			mips_cpc_unlock_other();
 			mips_cm_unlock_other();
-		} while (stat != CPC_Cx_STAT_CONF_SEQSTATE_D0 &&
-			 stat != CPC_Cx_STAT_CONF_SEQSTATE_D2 &&
-			 stat != CPC_Cx_STAT_CONF_SEQSTATE_U2);
+
+			if (stat == CPC_Cx_STAT_CONF_SEQSTATE_D0 ||
+			    stat == CPC_Cx_STAT_CONF_SEQSTATE_D2 ||
+			    stat == CPC_Cx_STAT_CONF_SEQSTATE_U2)
+				break;
+
+			/*
+			 * The core ought to have powered down, but didn't &
+			 * now we don't really know what state it's in. It's
+			 * likely that its _pwr_up pin has been wired to logic
+			 * 1 & it powered back up as soon as we powered it
+			 * down...
+			 *
+			 * The best we can do is warn the user & continue in
+			 * the hope that the core is doing nothing harmful &
+			 * might behave properly if we online it later.
+			 */
+			if (WARN(ktime_after(ktime_get(), fail_time),
+				 "CPU%u hasn't powered down, seq. state %u\n",
+				 cpu, stat >> CPC_Cx_STAT_CONF_SEQSTATE_SHF))
+				break;
+		} while (1);
 
 		/* Indicate the core is powered off */
 		bitmap_clear(core_power, core, 1);
-- 
2.15.1
