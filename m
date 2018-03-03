Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Mar 2018 23:41:37 +0100 (CET)
Received: from mail-bl2nam02on0092.outbound.protection.outlook.com ([104.47.38.92]:62080
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994626AbeCCWkKxPipR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Mar 2018 23:40:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=R2O73uX1gqbuUtRHb4TYV1w0KZdo4P+TF9IBG9xSu8Q=;
 b=gvtr02QxQgmH15Y7jnT6ahzMLaJUNjYBAdJ0BW9EtxXRzw+SJDKxHZA3Rpj6Rdhy+e2KOSQckQvdGOAs/bCHhbgQUm25S7AH4+TZprYSlLtysOuvrQTDzasFBhkh6ouMduqSjK43uqrEeJV4AC5NgjIs7HUoktY7f0Hjir7eBrk=
Received: from MW2PR2101MB1034.namprd21.prod.outlook.com (52.132.149.10) by
 MW2PR2101MB1033.namprd21.prod.outlook.com (52.132.146.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.567.3; Sat, 3 Mar 2018 22:39:56 +0000
Received: from MW2PR2101MB1034.namprd21.prod.outlook.com
 ([fe80::1d56:338f:e2b:cec0]) by MW2PR2101MB1034.namprd21.prod.outlook.com
 ([fe80::1d56:338f:e2b:cec0%3]) with mapi id 15.20.0567.006; Sat, 3 Mar 2018
 22:39:56 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        "james.hogan@imgtec.com" <james.hogan@imgtec.com>,
        "leonid.yegoshin@imgtec.com" <leonid.yegoshin@imgtec.com>,
        "douglas.leung@imgtec.com" <douglas.leung@imgtec.com>,
        "petar.jovanovic@imgtec.com" <petar.jovanovic@imgtec.com>,
        "miodrag.dinic@imgtec.com" <miodrag.dinic@imgtec.com>,
        "goran.ferenc@imgtec.com" <goran.ferenc@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 070/115] MIPS: r2-on-r6-emu: Clear BLTZALL and
 BGEZALL debugfs counters
Thread-Topic: [PATCH AUTOSEL for 4.4 070/115] MIPS: r2-on-r6-emu: Clear
 BLTZALL and BGEZALL debugfs counters
Thread-Index: AQHTsz9g+NR1X3cIXku3PrOoSm/+2A==
Date:   Sat, 3 Mar 2018 22:31:30 +0000
Message-ID: <20180303223010.27106-70-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1033;7:Jowe6jaKTwAUiXVZfhYR4K/AuEiFaWKjUYXiUc+M1O8lT1KFi8IAWb258020693v7DUGv6mYD7jaWv6Z5IPjTIc4pZmdRyF0E81IUotJbM4XnMuLA5p0W24Nx12j8krYH265W+ABWfvUa5gbnqGRhjbBlIAqtsx4+6SXJcOtdM3VajU5OEAjWn29nVEUJSpcVdWC42/nXxRpUfpRn+KWHC8J9G8uWk6VTfnPheBklXmZALR3lQN9Rgyi7YFAvcbQ
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 875d6019-8e0a-4eb2-00d3-08d58157b096
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1033;
x-ms-traffictypediagnostic: MW2PR2101MB1033:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB1033387BFC867C3A9121AFD7FBC40@MW2PR2101MB1033.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1033;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1033;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(366004)(346002)(396003)(189003)(199004)(3280700002)(3846002)(316002)(6666003)(99286004)(110136005)(2900100001)(54906003)(2501003)(10090500001)(53936002)(5250100002)(106356001)(76176011)(36756003)(107886003)(2950100002)(6486002)(22452003)(6306002)(6512007)(6436002)(575784001)(86362001)(6116002)(1076002)(6506007)(2906002)(68736007)(102836004)(4326008)(59450400001)(97736004)(186003)(478600001)(72206003)(26005)(3660700001)(8676002)(25786009)(966005)(7416002)(66066001)(14454004)(5660300001)(305945005)(86612001)(81166006)(8936002)(10290500003)(105586002)(7736002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1033;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zwyaan80+Emjv4DGjDRoTJqXKxedyH2K7FVryICjDHd81m06sETrzg/msYzoUqdpj1eFxvIP+582YcjEhlKpqTdSfW/bn2x1KJwYAAv9DU0R47uf9A11rQnBzfs+1Zmg+fWxionWj6PkFDWa+DhXTpXhuEjSmjgrEspuW98ozKE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 875d6019-8e0a-4eb2-00d3-08d58157b096
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:30.1197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1033
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62801
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

From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

[ Upstream commit 411dac79cc2ed80f7e348ccc23eb4d8b0ba9f6d5 ]

Add missing clearing of BLTZALL and BGEZALL emulation counters in
function mipsr2_stats_clear_show().

Previously, it was not possible to reset BLTZALL and BGEZALL
emulation counters - their value remained the same even after
explicit request via debugfs. As far as other related counters
are concerned, they all seem to be properly cleared.

This change affects debugfs operation only, core R2 emulation
functionality is not affected.

Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Cc: james.hogan@imgtec.com
Cc: leonid.yegoshin@imgtec.com
Cc: douglas.leung@imgtec.com
Cc: petar.jovanovic@imgtec.com
Cc: miodrag.dinic@imgtec.com
Cc: goran.ferenc@imgtec.com
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15517/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/kernel/mips-r2-to-r6-emul.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/kernel/mips-r2-to-r6-emul.c b/arch/mips/kernel/mips-r2-to-r6-emul.c
index 81cd389e855c..cbe0f025856d 100644
--- a/arch/mips/kernel/mips-r2-to-r6-emul.c
+++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
@@ -2340,6 +2340,8 @@ static int mipsr2_stats_clear_show(struct seq_file *s, void *unused)
 	__this_cpu_write((mipsr2bremustats).bgezl, 0);
 	__this_cpu_write((mipsr2bremustats).bltzll, 0);
 	__this_cpu_write((mipsr2bremustats).bgezll, 0);
+	__this_cpu_write((mipsr2bremustats).bltzall, 0);
+	__this_cpu_write((mipsr2bremustats).bgezall, 0);
 	__this_cpu_write((mipsr2bremustats).bltzal, 0);
 	__this_cpu_write((mipsr2bremustats).bgezal, 0);
 	__this_cpu_write((mipsr2bremustats).beql, 0);
-- 
2.14.1
