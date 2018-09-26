Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2018 21:49:24 +0200 (CEST)
Received: from mail-by2nam01on0095.outbound.protection.outlook.com ([104.47.34.95]:29037
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990393AbeIZTtVFguKQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Sep 2018 21:49:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFAdWqauGD6X7JnOJZNBb2C01eficrEzMuE4+6MLTPE=;
 b=QuBBjc8gcdRRYYs6sicskdxO4sqt0h0OMkiv7jruZz5aS24/FThoE9QbJG17VOuKBE4HQxEPjYeb9vcij59u4zUDRy7OpsWlxjfRSAPPCJMlusdenDQzb/dTkjkBpDF64iczb1SKWtIyGfqhaeHbqRArl0J/sMd6CFUQ0mPochM=
Received: from MWHPR2201MB1280.namprd22.prod.outlook.com (10.174.162.20) by
 MWHPR2201MB1183.namprd22.prod.outlook.com (10.174.169.159) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Wed, 26 Sep 2018 19:49:10 +0000
Received: from MWHPR2201MB1280.namprd22.prod.outlook.com
 ([fe80::4883:508b:d10b:64fe]) by MWHPR2201MB1280.namprd22.prod.outlook.com
 ([fe80::4883:508b:d10b:64fe%5]) with mapi id 15.20.1164.024; Wed, 26 Sep 2018
 19:49:10 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     Paul Burton <pburton@wavecomp.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "rachel.mozes@intel.com" <rachel.mozes@intel.com>,
        Dengcheng Zhu <dzhu@wavecomp.com>
Subject: [mips-next PATCH] MIPS: kdump: Mark cpu back online before rebooting
Thread-Topic: [mips-next PATCH] MIPS: kdump: Mark cpu back online before
 rebooting
Thread-Index: AQHUVdH9j/uWdUY7e0u9VIL9wrCY1g==
Date:   Wed, 26 Sep 2018 19:49:10 +0000
Message-ID: <20180926194847.8734-1-dzhu@wavecomp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:405:3b::24) To MWHPR2201MB1280.namprd22.prod.outlook.com
 (2603:10b6:301:24::20)
x-originating-ip: [4.16.204.77]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1183;6:YtMt+6svUtmMexHykTFExd8U+zFCxKG8c45B/6tW41Z9RqOoOZfLft1+0WpdOySbRn4pwxaHdTjFFexDGVaEx3O0EjguVl0cfAfXWXWZqp27qoIRkF0biR5s1ve+rxMmvNYj7SDUPi14igm0JWPWPjLyalSf0AuKQbwI133MDUWr/Z7StX8KDY6ngEQ4Sy/936rRJNm5Eg68+zhIdmb5gCw7amO+MrPjp2wkv2c7IWHRodCTeDMUqjO90qiT+IIl5c9h1CDgwMJQM3bDyZPUESljGbprKUN56w+NRc5TV3Ll/zrAOde5i1+ghMov36pdSMcmTDpVJZn7aR12TVaes2HBn0DhN5EvCORS0ACxbiAto0OBkgTrzQgO0cZdxV077eLfotIgj4t4PRZFLPH1wMFhDmGkRjPZ9y5ic97J7QzTBc3jBONrzNxLP78/JZNnbnd+KiwQULpQ8aifCak7Bw==;5:khlwjKZHmgjDDtTC9hgrmF0vRBDBmKqhtputbLK1pZshbPKpFVEXVu0uKA2Iv/LnjY4N0rTM0VNfn9cFfODMHJguo6FZ9X2nAio1jWBLBZqsblmj2xvSBUhT6WEIj2RkwYnBY+01zxRR50RIZ3SCi+AuZui+bgc2oQen5lNwvrM=;7:imR27Ijvg5q6L1QdUPzduijUsTf/ruW2wF9g2XkUoP3c3RjMqhN6GBXk8oBlgroc8v5hy6WCqgkD4n6nCIHxe1ltDwAE7cHX65ktVLjHIRuPdLxb+u07d/Cq2JOGxB3YNvlbXVjYzieFnPJFY/aUQU4/5Z7/EtN+TEwykrQ2yZqgrjoJCs+YmgwHgQonIJobL8tUWp5/Eez8bxTZEt/5ifOISOo0tDUsuNpmwjCXyV6a5aJ3bL2plx3Cm/nOB0tl
x-ms-office365-filtering-correlation-id: e6aaf8ee-8a2c-42b6-1b6a-08d623e91fd7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1183;
x-ms-traffictypediagnostic: MWHPR2201MB1183:
x-microsoft-antispam-prvs: <MWHPR2201MB1183BB28EA114CDE1057F4B0A2150@MWHPR2201MB1183.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(209352067349851)(190756311086443);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149066)(150057)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051);SRVR:MWHPR2201MB1183;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1183;
x-forefront-prvs: 08076ABC99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(136003)(39850400004)(376002)(199004)(189003)(486006)(102836004)(2900100001)(107886003)(4326008)(81156014)(81166006)(86362001)(2616005)(99286004)(476003)(8676002)(26005)(256004)(386003)(71190400001)(71200400001)(25786009)(54906003)(34290500001)(110136005)(6506007)(316002)(52116002)(97736004)(2501003)(105586002)(6436002)(68736007)(66066001)(305945005)(5250100002)(53936002)(106356001)(7736002)(6486002)(36756003)(6116002)(3846002)(1076002)(8936002)(478600001)(5660300001)(2906002)(14454004)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1183;H:MWHPR2201MB1280.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eY2CPpK4FBdtdpN6D3b6DX3Pp3V4oz2hW9LNPTEGa4FH5/pHGyFrTeJFzfFvTKG+zK1bv/0bzeobwId9mJ2hCwxkyPLZ/7xMjWQFf5gB72IOwJR2ieYgykMBG5WIrtFgykf3UsFWsSFW+FkL34fb0LVJRbeRIUvV9hR63l9Qqaz2rwWbNsQg2hFk4VKtV5bqNMLDjC2ysONQRdmLMjdz8CjnGtkGJz2fZ4vE4Z0I/ue3nTloJdaPNnYJCzZm+8TIijtslons4TrKEV8VadBrRxyAP/GMbQ5tWwWsASSJBvK11rLV3GOmepCvE2wEhfT76Q+32CD4OejvZrWJybW4/KwYyZk8mDR37Wxg5PcFpKY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6aaf8ee-8a2c-42b6-1b6a-08d623e91fd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2018 19:49:10.2109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1183
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66584
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

The crash utility initializes cpu state by reading the system kernel
memory, which is copied into vmcore.

It is also natural to preserve the online state for CPUs at crash.

Failing to do so could make the analysis tool present info for only 1 CPU
by default, and unable to find panic task.

Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
---
 arch/mips/kernel/machine_kexec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/mips/kernel/machine_kexec.c b/arch/mips/kernel/machine_kexec.c
index 93b8353eece4..5c5b4351893e 100644
--- a/arch/mips/kernel/machine_kexec.c
+++ b/arch/mips/kernel/machine_kexec.c
@@ -171,6 +171,16 @@ void kexec_reboot(void)
 {
 	void (*do_kexec)(void) __noreturn;
 
+	/*
+	 * We know we were online, and there will be no incoming IPIs at
+	 * this point. Mark online again before rebooting so that the crash
+	 * analysis tool will see us correctly.
+	 */
+	set_cpu_online(smp_processor_id(), true);
+
+	/* Ensure remote CPUs observe that we're online before rebooting. */
+	smp_mb__after_atomic();
+
 #ifdef CONFIG_SMP
 	if (smp_processor_id() > 0) {
 		/*
-- 
2.17.1
