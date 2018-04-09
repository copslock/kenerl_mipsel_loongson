Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 02:27:04 +0200 (CEST)
Received: from mail-cys01nam02on0136.outbound.protection.outlook.com ([104.47.37.136]:24156
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994674AbeDIA0pbFCqV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2018 02:26:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fO5hYRPcF3Gc7qg+DmbRLNDSUBftWJoCoPGykGQY4MY=;
 b=O8xlMOaRKvQNuzDBJ1UHsj/yZLvGs3PK3akoN5U3prk6/s1F3v5HlK0gCN3p92K0I8fDuFGaN2IWNuANoFIlWzuDKsnKMaxxqsm+CpMWQcQzwLuvZhy6VCI7WQbqr8fjzvYY+aYCRT/3hrc2yaENJOhsSg4DWdSt2KZ7hhP6WTU=
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) by
 DM5PR2101MB1015.namprd21.prod.outlook.com (52.132.133.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 00:26:35 +0000
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059]) by DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 00:26:35 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 009/293] MIPS: kprobes: flush_insn_slot should
 flush only if probe initialised
Thread-Topic: [PATCH AUTOSEL for 4.9 009/293] MIPS: kprobes: flush_insn_slot
 should flush only if probe initialised
Thread-Index: AQHTz5jnNpNo6d8vfUWSLB18nGrY1A==
Date:   Mon, 9 Apr 2018 00:22:54 +0000
Message-ID: <20180409002239.163177-9-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:Afu48+naUoc+ZnViNY+20BGvYAiQiDdwY1vNwZ5SC21xywmY/esUNUziaW80HSLqSvedE5+8VqTonFFIfc6QmMSkLMRCti5q3WUwJBQw1vmmzBH09eneJwXULEEwta7PrEMsgbTpiqAQFPT3wyr3lt+kv2dG4CdWgEB2Fxt1LeKaSBwOXC2/u1l6olDyruGZ/Ye0OVz11SxJjxDxz9WZfCt8UglXNoRU84Ofxevgzwde2Iw7Zhybrlj+S7vhKIG+;20:LZC32FPyFh2qtOfJW08ZGHGYMm6e9EmqUStSyMfZLOUcXlYijNPVEIhLNp7wmqFnsUw2W4XaE5J9rjEY9fjVlDJNZbs7d3BYfZPPWEWdTr6psREW7+BWs5SZwzplEeCVVJSyORDU4iJOELT5WzRv7k1c+ySh7nSnI/O+E0Gdp3c=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 55e7b2f3-58ad-47b0-ad7c-08d59db08d3d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB1015349DEA9E65E0FD48C18EFBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(189003)(199004)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(966005)(107886003)(6506007)(36756003)(446003)(68736007)(6512007)(7736002)(486006)(2906002)(6306002)(5660300001)(6436002)(3846002)(86612001)(6486002)(66066001)(11346002)(476003)(6666003)(59450400001)(26005)(10090500001)(316002)(22452003)(8676002)(81156014)(81166006)(6116002)(105586002)(99286004)(186003)(106356001)(76176011)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vfFjxEJSNoQlpX3fHMXq15DyCZAX/ymYh9KDczFH04tiPF5/5KyHlVbYNwy2ZdaZ4fOFeseS8nYpI+WxzBb3Mf+Im1tTi0slGA3eztQ4tULGgNZaLxbv9/v4+9ZKMIVtbmCP5atTkK4XXzdzB6oG7V2NNpscjKMrVQucG0ldY05GGjeBHR0H8anY0nzB5+anHPfz61l7riRBZXfncO87avxuE0NtrK1PDH2OkWWMOHlE4Ihbi61XN5pCqam9nSyls4FnzYkbBXZL0aVsLkbB+C3euQnhlV2FoHRX9QTsUIi/nbhRFxEvRPCkL1pCLemqy5CSCX27NIlAyZ1iVQMYL3p67LHTx69/2L8TSlaHe4X32L9NE1vl+bG9ZSjO9yrQQtNNJbnSZTSktW8GQnj4KRe3RF9J2VLnkkjw0ewFHFY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e7b2f3-58ad-47b0-ad7c-08d59db08d3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:22:54.5654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63445
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

From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>

[ Upstream commit 698b851073ddf5a894910d63ca04605e0473414e ]

When ftrace is used with kprobes, it is possible for a kprobe to contain
an invalid location (ie. only initialised to 0 and not to a specific
location in the code). Trying to perform a cache flush on such location
leads to a crash r4k_flush_icache_range().

Fixes: c1bf207d6ee1 ("MIPS: kprobe: Add support.")
Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16296/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/include/asm/kprobes.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/kprobes.h b/arch/mips/include/asm/kprobes.h
index daba1f9a4f79..174aedce3167 100644
--- a/arch/mips/include/asm/kprobes.h
+++ b/arch/mips/include/asm/kprobes.h
@@ -40,7 +40,8 @@ typedef union mips_instruction kprobe_opcode_t;
 
 #define flush_insn_slot(p)						\
 do {									\
-	flush_icache_range((unsigned long)p->addr,			\
+	if (p->addr)							\
+		flush_icache_range((unsigned long)p->addr,		\
 			   (unsigned long)p->addr +			\
 			   (MAX_INSN_SIZE * sizeof(kprobe_opcode_t)));	\
 } while (0)
-- 
2.15.1
