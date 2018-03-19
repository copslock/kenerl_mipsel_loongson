Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2018 17:11:30 +0100 (CET)
Received: from mail-co1nam03on0100.outbound.protection.outlook.com ([104.47.40.100]:36928
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994662AbeCSQKytnywD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Mar 2018 17:10:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=v+jtdn0Uwr5G6Qn8WcBX1sJYgkqoZH22tROB7MuJS/4=;
 b=buWm5JCtlaQEnqk5j55s7/NvkaYYSYi+M9f06LCgAs7gkXQl22EDbRg6LVi045J1uslD0s4SBcJ/yPAmZoGIfjarI6tIUPYNe7Wm8Qvt+5UyMTSbWAET6QvYpNBDjUtOu1icVnu9j0lfPVUsrCC9ym0tK5Js/zx78I12i3nUAX8=
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) by
 DM5PR2101MB0888.namprd21.prod.outlook.com (52.132.132.157) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.631.0; Mon, 19 Mar 2018 16:10:43 +0000
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::3d9b:79e7:94eb:5d62]) by DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::3d9b:79e7:94eb:5d62%5]) with mapi id 15.20.0631.004; Mon, 19 Mar 2018
 16:10:43 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 137/167] MIPS: kprobes: flush_insn_slot should
 flush only if probe initialised
Thread-Topic: [PATCH AUTOSEL for 4.4 137/167] MIPS: kprobes: flush_insn_slot
 should flush only if probe initialised
Thread-Index: AQHTv5x8PRbrJ/xMh0+wzE7AektnlQ==
Date:   Mon, 19 Mar 2018 16:08:14 +0000
Message-ID: <20180319160513.16384-137-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0888;7:EPq7dy7JHWBTRfC+mk5/+ippKx5OQYxs9inD6JsvyMi7Cac7FIU+LX9olAy++fE8YRtyvexqazwKLarGIglBIFIyUKrBoGCK17E5QZtRzIpjIas7gWkGXXr+WgaDDScIPlHnCdg9Uhy9r/9oJJ7aPgT2GFRh8urLaJru4ioNKE8359QP1JdshG+mg8u2oyNTwiLBWbsqiR8DVGAiv2a3sWC+qcyFk5tHSqdLkKQI78O3euhoLavPxbP7yzZnXWKw;20:KxqsHbxakguu8ReSXvXOfNqMGP+RaIc/g9K3Dmyg0p+qAIyfw5JPJxBx0T2SNAi4plyJk4mTgyseTiTvho41s6aX/UUS0v+q9auTNFuIyP3ND4pVdg7pxpzOLMqhpFO+KiW3WF3OU2Aguwb2EIy8yUYyGcxymP0Q6RT1f6wlrGc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9849dda8-a634-40b7-099f-08d58db3f7d2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0888;
x-ms-traffictypediagnostic: DM5PR2101MB0888:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB08883F26F8CF87D1ECB0A7A7FBD40@DM5PR2101MB0888.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0888;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0888;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(366004)(39380400002)(376002)(189003)(199004)(6486002)(72206003)(106356001)(86362001)(3660700001)(6436002)(68736007)(53936002)(107886003)(8936002)(81166006)(8676002)(81156014)(2906002)(6306002)(6116002)(4326008)(6512007)(1076002)(86612001)(66066001)(966005)(25786009)(7736002)(3846002)(305945005)(5660300001)(99286004)(5250100002)(110136005)(478600001)(36756003)(54906003)(2501003)(6506007)(186003)(59450400001)(26005)(14454004)(6666003)(2900100001)(316002)(2950100002)(102836004)(10290500003)(3280700002)(97736004)(76176011)(10090500001)(22452003)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0888;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: i/1NQqcM1G/oJiH6oFmjqFCc5MCotKqgMitREyoNRTFuQQk9qwpPl5sZofiAQfowI0Jq4D7iW/Z2olJfCgoI30UegDUO0UcVUIr1tbvCaueW0AQq6tb+ObiLbI2pDX7IcP48NQxC6uaJgl9mUKxX+CF/KdNm5PTq0dc+Z70DQvhT32SwP2iZsdMqqtTB8Sb5QMdw9foVxVRrQ7Xx59QL7k3eGNKd2Hv/aqBUqlGiUK/6FAFTs5ZIOL/VIeowZP8i2aaSAwwRsW+bhYFiaf0sKaE/AMo6a6tlSuOKWC7A+y0wyFd8t/G2AiwyONj3eGmHo9GVs+I95WhhLHma6uh8Kg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9849dda8-a634-40b7-099f-08d58db3f7d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:08:14.8196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0888
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63051
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
2.14.1
