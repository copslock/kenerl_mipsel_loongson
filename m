Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Sep 2018 03:34:40 +0200 (CEST)
Received: from mail-sn1nam01on0110.outbound.protection.outlook.com ([104.47.32.110]:14047
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994617AbeIOBegLLBog convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Sep 2018 03:34:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aY/xJkOPx8TgGikehaNHYs1mKkMQjm+FP/fUdsSddaU=;
 b=Q+Sqnx3xlAtXbNxgzjKLXgrZl5sHkwBzNhDETtbADjl6Sfr6UXj4CdZUhJLop2xSisRGpUIaA4pfENphhlxen6ou7aNoghqZKuhWNLV0v9huIeqlcjnMVycadtvK80yNwoIpL8nIoNXXWM0nG1I0d54CUjxbWgRESs9WDGm+U6c=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Sat, 15 Sep 2018 01:34:26 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:34:26 +0000
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
Subject: [PATCH AUTOSEL 4.9 01/34] binfmt_elf: Respect error return from
 `regset->active'
Thread-Topic: [PATCH AUTOSEL 4.9 01/34] binfmt_elf: Respect error return from
 `regset->active'
Thread-Index: AQHUTJQ86aISqXoVX0WkLkLh84fnEw==
Date:   Sat, 15 Sep 2018 01:34:26 +0000
Message-ID: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:b7Mg9nImntwLh8zm/8n5GjTHLBlXP7AqpAntmz8xzrJZ7jmA1TRXLAV8vnKWDatZ6LjX+vZNKL592n0O2xh5o7cW6uVsNdC3NSA2Hny5Z5MV7s5yXOIy+rDnDmV7lpMJXg2ULXBHZmxCmhedLnbKlgM7R3SrbYRe3kbCIdkmXlpS4VnrzgCkWGhbS8ARF1/CgCMP4MfKxrTx/+pZHziSF1wiLGmAfQ7yIz0FjJaNXxA2/tGFHhNdCP/ZP9B+U/9OXb+8CY2W/PxQlOaI7+G9xGHNVY642BKy0UpdjwFWaBaTp6za3bXZxv+DHXbIXw8K7lHmtg5AuNRsykD9bYFxEwCL6kkos1uKyXvo0gDVM9KkHlXP1TlFDrmx8pyPhCps8IiPbnDBJApjmq9XtafzoiNLIsiKrKaRAtytMAs0By+UcOE3ZcMJZ1iYkLkEA2X4MqqFXZTn2FSrCkQhP327mA==;5:l4/xpXtvs4TcqxKS+U9LMxKFPX9X2hMyeIEk8M7VpFz5oPFwYrRls3hVK2F6eo4L6lMwv2WT/slfZ5Ul0T5tYgCsUXrmlop3NEaDRiLBxEJZsVIbZFDSTpWm8YJVNM06i2miHmKVM4BTljKMZGFOcDReXpaxXvYVrJ3w2LgyzLA=;7:Id09K7SaGx68uVWzeDWG6NoxD0x/4kjK2IdYZjwNj0tTaMtG1JLSAuwG9L9aPwuTqqOpRbWYqAFko9YVfjV4hJjnY2HTfuPCPMrOnmVlk+ROkBPq3MBmX5+oA+qf8z1Xjh6V40KV+KA28sqA+NVX9eGvTgggTkRIYOc+9l3Td/AIOW84D9A9sDEBPEyq6E/ZqfsQKIkRS/t0SfTDmJceoubhmi5kPvivhTFR7JEZmtAnNQlNP7ZOaUkFYu/BuPZz
x-ms-office365-filtering-correlation-id: b0531893-369c-439f-bcd1-08d61aab5f7b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB08554253A379C2904ED77D29FB180@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231353)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(366004)(396003)(189003)(199004)(102836004)(6506007)(305945005)(7736002)(10090500001)(86612001)(86362001)(106356001)(97736004)(107886003)(186003)(26005)(6346003)(14444005)(5660300001)(256004)(5250100002)(6486002)(105586002)(6512007)(2501003)(2900100001)(22452003)(6306002)(6436002)(99286004)(316002)(8676002)(53936002)(54906003)(36756003)(110136005)(10290500003)(72206003)(478600001)(68736007)(66066001)(81166006)(81156014)(8936002)(486006)(1076002)(966005)(3846002)(14454004)(6116002)(476003)(2616005)(217873002)(4326008)(2906002)(25786009)(81973001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Q5We7aylk85hVTDla8X1Y4N0taPBExIFvq6+hAA3JctBYYHtWL2R0zq8eCmI3xD1OF5t0P2rg5lwo8PWm0FGLNEyJgGo6YAFlDsgvC6rFo9WxY7zh4XqupUOratOwLh/RJgH+iQBD4oml6hwxZOifFzDMahfdYwHB7sRAJxPso81Fe+PBsUA99uOu89T0jsdKO0BFaVVVFbiiBea6TVF4kiomAeOsWxgTEWqIgD8bE68MXKLyzdUTbDX14oGaP27SZkIxF1MM5ai0QBlRoXj8O0+NCey2lqB0mBIi5a3SXUHdwWPHE9lsmv3K6Yr/vxUPE6rIyhZJbLngRZyzSbmWe/KIzy5rf684PFQACiTGTk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0531893-369c-439f-bcd1-08d61aab5f7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:26.2084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66316
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
index a4fabf60d5ee..e7e25a86bbff 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1706,7 +1706,7 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
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
