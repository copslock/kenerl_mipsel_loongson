Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Sep 2018 03:32:45 +0200 (CEST)
Received: from mail-dm3nam03on0091.outbound.protection.outlook.com ([104.47.41.91]:38912
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994612AbeIOBchUtMVg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Sep 2018 03:32:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hg1bncH4IytrDviDZDnDwc+Ra2dAPR/cO78VnODpOo4=;
 b=P+GtrVkXJab2nj67RoOO1I2PpG18NUlLfBTMHjelLW82FSlENhzr6UTlQJGjomLvPfb4CWkYnJOshu2GdY/OJ0Yp5CP1IOTwYAVfRff9vURWnR5KROSOx4ArmHMlVH03cAnQP6Ix293B+JG7a31R/uIxg3sDfT8MfKZc4zHq64g=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0117.namprd21.prod.outlook.com (10.173.189.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Sat, 15 Sep 2018 01:32:27 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:32:26 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Maciej W. Rozycki" <macro@mips.com>,
        Paul Burton <paul.burton@mips.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 01/57] binfmt_elf: Respect error return from
 `regset->active'
Thread-Topic: [PATCH AUTOSEL 4.14 01/57] binfmt_elf: Respect error return from
 `regset->active'
Thread-Index: AQHUTJP1t1tAaRFp9kS2tKGdzsd1oA==
Date:   Sat, 15 Sep 2018 01:32:26 +0000
Message-ID: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0117;6:bxTuN9gLaJQlilUCFp42qLOPT3OOTEGwYaQmfyGnSOrCJ8zRDoTq0l81WVVA9YArNDppM6ChIYiGLPeiZWLB+HPoT4DbIhq6O/gL/piLkXvx3Ti/aOKlDY4Yo/vYwpQopKtWnapoc5c1ZZKKCHMyQnwmVF6cmdIVBJUT3xMgFE8XlYFmeUGL5qi5ZkKoyxWfxGBAAdkSG+aybtxKD8HsqL3M7B/qRv+5A2MEu72FdibFlPk807D5N2gWypXdcIEv81yJrx2LctYZxCmW/R58SGlUE3+ESmaOd2fIH2dIaVBUSIoOchhsWhUW1//GDhuOw+KJXVwvO+7/ocpQQn1OHUJBjKj4ngVqOi0+LYnHngftnYPSTh4e0CJh8oK/WBKukdAGZL3Sf32+vyC8i6w6DIlU05FQ9Ip/qTq7mbf9mw4ePnmxt0Z6h2fZJ3VsjA5R7P60m8QqZ7ZYuhBj66YNWQ==;5:h2tWLuqqEgeXzKSQv3yvDcw6WQXKG+HcEcZL/1HRdoieLT5RuAsDFSSqE79SSEEPfK40LGIBxXD8f6kmLDieE4go8bldMKRadc2m6l1f6Zi/ty36nHF4wSVs6lSNhoacAJbz0NS2biEnHevOHAQJ1lRoZlYZClwrPwBgjzJwpnI=;7:BFnE0aLdS/2XLPOdDiMcsIp59KnDvY/0erEHH1LGX9LkHhH51hrc5/Xk94R+lMhVH/lK5tJRyJDNhrJXekhs1UQzb4CQQh/+D+Y9t2UdsjHG5inqQOpAcA9LFxHxWht8mrsnlDSUwDL1GQXQYJC1PqbRiJRfJIVmU2La5s+jyOxqp7yVcmGVhcW1z8GGq62cMDZo/QDDkI6cty9j/LJgm88YCeoOzslbGm/HbU/y0S80Hm06uE5hjumX3BujXKFe
x-ms-office365-filtering-correlation-id: da673d73-5610-47c0-fdf4-08d61aab1859
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0117;
x-ms-traffictypediagnostic: CY4PR21MB0117:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB011773CD28A1E60971EA1212FB180@CY4PR21MB0117.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0117;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0117;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(199004)(189003)(36756003)(316002)(2900100001)(110136005)(54906003)(8676002)(478600001)(5250100002)(2501003)(66066001)(72206003)(10090500001)(86612001)(476003)(2616005)(8936002)(102836004)(486006)(14444005)(86362001)(256004)(575784001)(186003)(6506007)(22452003)(68736007)(26005)(217873002)(305945005)(2906002)(6116002)(3846002)(1076002)(106356001)(7736002)(5660300001)(105586002)(53936002)(14454004)(6436002)(81156014)(81166006)(6486002)(10290500003)(6306002)(6512007)(99286004)(107886003)(966005)(97736004)(4326008)(25786009)(81973001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0117;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kc2i9E50tsdw/BEU5iQU69ysWveQb3cFFiZuWhpfDuZ0F/4zdwmGpXMmjRPHdetRnQVDYB39WCqAWWY8MRgkPiyA3xkyUQQjkgL+ulA8lJs+UCAQQazeJCDAPxrDwPm1Q731fWWOXMHuKcuvasfa5mHvkyBoJbgaWtqDzYMJmZ6bYgEU4ZKFNnyL+fsALTA0Ejf+0jEe9CEbTvo3LY7dSRk7Pe6FxhVHQw/gIwkUxOyLcQu66UQ6965/ZaEJ18YPhGWeJ+KGdnKQQgql3lPwevLWPTw2YK6GEN3++ev5UCVnE+4qxHS78OpjqumRO0xX2ODjHeIXGgKzTCR/8wirwDjVdwG9Y5TL+CHyjP7xxUo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da673d73-5610-47c0-fdf4-08d61aab1859
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:26.8690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0117
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66314
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

From: "Maciej W. Rozycki" <macro@mips.com>

[ Upstream commit 2f819db565e82e5f73cd42b39925098986693378 ]

The regset API documented in <linux/regset.h> defines -ENODEV as the
result of the `->active' handler to be used where the feature requested
is not available on the hardware found.  However code handling core file
note generation in `fill_thread_core_info' interpretes any non-zero
result from the `->active' handler as the regset requested being active.
Consequently processing continues (and hopefully gracefully fails later
on) rather than being abandoned right away for the regset requested.

Fix the problem then by making the code proceed only if a positive
result is returned from the `->active' handler.

Signed-off-by: Maciej W. Rozycki <macro@mips.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: 4206d3aa1978 ("elf core dump: notes user_regset")
Patchwork: https://patchwork.linux-mips.org/patch/19332/
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/binfmt_elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index c0e3f91e28e9..469666df91da 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1725,7 +1725,7 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
 		const struct user_regset *regset = &view->regsets[i];
 		do_thread_regset_writeback(t->task, regset);
 		if (regset->core_note_type && regset->get &&
-		    (!regset->active || regset->active(t->task, regset))) {
+		    (!regset->active || regset->active(t->task, regset) > 0)) {
 			int ret;
 			size_t size = regset->n * regset->size;
 			void *data = kmalloc(size, GFP_KERNEL);
-- 
2.17.1
