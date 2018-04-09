Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 02:31:28 +0200 (CEST)
Received: from mail-by2nam03on0724.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe4a::724]:10945
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990588AbeDIAbWMT01V convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2018 02:31:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=msLDu5jzGByBOCLdLaSiQW60vG+Sn6Re4F4yrgjOh4Q=;
 b=eIvmGYqzzGj43uzRkbzxqDdWESl8kM5B1Apdy9y2N6aMHV7et/zTwWCTLios3MEtZPm9VEh/p1dckBTlvJ3i6FkTfvtmFxdwlSl0S/NrE8MqgM9UyW6oxJSfdZs1w7oBeGcmqrnbhxVc4vlLnvrk35oI1IO4Yy0iW8Zo4iK2Tvs=
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com (52.132.128.13) by
 DM5PR2101MB0917.namprd21.prod.outlook.com (52.132.132.162) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Mon, 9 Apr 2018 00:31:10 +0000
Received: from DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059]) by DM5PR2101MB1032.namprd21.prod.outlook.com
 ([fe80::8109:aef0:a777:7059%2]) with mapi id 15.20.0696.003; Mon, 9 Apr 2018
 00:31:10 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 159/293] MIPS: module: Ensure we always clean
 up r_mips_hi16_list
Thread-Topic: [PATCH AUTOSEL for 4.9 159/293] MIPS: module: Ensure we always
 clean up r_mips_hi16_list
Thread-Index: AQHTz5kwY8h7ZolO/UyoRSYhafVnFA==
Date:   Mon, 9 Apr 2018 00:24:57 +0000
Message-ID: <20180409002239.163177-159-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:5xsU/X2zTHPzrKHlTCq+Nx3s6JuQ3A2VS8RmDp4krXNrOTWMdjYTL/y1dZBJDcaY4aYQIgd7CXyBT4Ha0aZS+5F7IVc7ZQzC4azlgHisnHPHqLxXPdF+NkbTjitLbnVzTdGz9WyPXWqDgB8KDzBWigyKux8VCzQXrDkpITToxCvsVm46FX6R1C2gNIN/sMXDeyHj60v997CXVaMgqol0NUac/dUP80oB31wRjdHIT8c6cn28PFOmy/5A+89hZZPx;20:XBjl/SDMzQWNcm+FEdo62TNiVLdfN88XDUx25V80K9RCljwA436rNV24Xrhj5uI/xPPbM5rjB9UsjyVG5cbmMEal8n++uEXb7i1/nE2S/slBeaRpScLaqe4Xb2UK2MSbKfhdCTNpsMs6k/nL0L458ducwyiy5W4ZH+zMjMM2BnQ=
X-MS-Office365-Filtering-Correlation-Id: 4556d5e2-a6bf-4b2f-33e7-08d59db1315c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB091735FA6C508328FD91169DFBBF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(99286004)(22452003)(106356001)(26005)(110136005)(478600001)(54906003)(10290500003)(316002)(1076002)(72206003)(186003)(4326008)(97736004)(66066001)(11346002)(25786009)(86362001)(575784001)(476003)(446003)(2906002)(6666003)(6486002)(105586002)(86612001)(3280700002)(3660700001)(6512007)(3846002)(6306002)(6116002)(6436002)(2616005)(486006)(15760500003)(53936002)(7736002)(8676002)(81166006)(81156014)(8936002)(68736007)(305945005)(10090500001)(76176011)(6506007)(102836004)(36756003)(107886003)(2900100001)(2501003)(14454004)(966005)(5660300001)(5250100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LkxMkKII3j3HmnK9EciDqTAf/Shzw5kC9UJ50iZWFSf9m7bwyZTlFhF8Dmf7tmGfv3SDs7ean6bJEY5sEv8BE0vsGhWHlB2M1M0lwClBm2MCYGbKjRGOsHv53UvEEKphj8Qnn2n6eMvfXj+U0Lu5yndiwIqbh5OqbNyPLjYYJWX84iF8W/P8nyATlTk6O4SXmxHeoYpU+qEvHesohF9AuVo2tD0El9Mjlkx5pbFHakY3UMfkKAAgVgBFShILF3vGDEYl1M1c3AcXfChCX6E0IEKIaTouDI7R3XYfsXWg9j/DIQH3oRZL1bSSzYJoZKztU7PjbKNPbHTG+4iFERPIIkhnJC2fztEHO/P7llXQavAYkV/Y0Dgkdf1jrp4Dl2i4Jvu67zSG99N3fvh3ijbX35H0krEJVprK9vOYkqzbCe0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4556d5e2-a6bf-4b2f-33e7-08d59db1315c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:57.2063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
Return-Path: <Alexander.Levin@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63446
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

[ Upstream commit 351b0940d473146923711bc943fc881354a4c1f3 ]

If we hit an error whilst processing a reloc then we would return early
from apply_relocate & potentially not free entries in r_mips_hi16_list,
thereby leaking memory. Fix this by ensuring that we always run the code
to free r_mipps_hi16_list when errors occur.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 861667dc82f5 ("MIPS: Fix race condition in module relocation code.")
Fixes: 04211a574641 ("MIPS: Bail on unsupported module relocs")
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15831/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/kernel/module.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index 94627a3a6a0d..ddcfb59593b6 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -251,7 +251,7 @@ int apply_relocate(Elf_Shdr *sechdrs, const char *strtab,
 	u32 *location;
 	unsigned int i, type;
 	Elf_Addr v;
-	int res;
+	int err = 0;
 
 	pr_debug("Applying relocate section %u to %u\n", relsec,
 	       sechdrs[relsec].sh_info);
@@ -270,7 +270,8 @@ int apply_relocate(Elf_Shdr *sechdrs, const char *strtab,
 				continue;
 			pr_warn("%s: Unknown symbol %s\n",
 				me->name, strtab + sym->st_name);
-			return -ENOENT;
+			err = -ENOENT;
+			goto out;
 		}
 
 		type = ELF_MIPS_R_TYPE(rel[i]);
@@ -283,29 +284,32 @@ int apply_relocate(Elf_Shdr *sechdrs, const char *strtab,
 		if (!handler) {
 			pr_err("%s: Unknown relocation type %u\n",
 			       me->name, type);
-			return -EINVAL;
+			err = -EINVAL;
+			goto out;
 		}
 
 		v = sym->st_value;
-		res = handler(me, location, v);
-		if (res)
-			return res;
+		err = handler(me, location, v);
+		if (err)
+			goto out;
 	}
 
+out:
 	/*
-	 * Normally the hi16 list should be deallocated at this point.	A
+	 * Normally the hi16 list should be deallocated at this point. A
 	 * malformed binary however could contain a series of R_MIPS_HI16
-	 * relocations not followed by a R_MIPS_LO16 relocation.  In that
-	 * case, free up the list and return an error.
+	 * relocations not followed by a R_MIPS_LO16 relocation, or if we hit
+	 * an error processing a reloc we might have gotten here before
+	 * reaching the R_MIPS_LO16. In either case, free up the list and
+	 * return an error.
 	 */
 	if (me->arch.r_mips_hi16_list) {
 		free_relocation_chain(me->arch.r_mips_hi16_list);
 		me->arch.r_mips_hi16_list = NULL;
-
-		return -ENOEXEC;
+		err = err ?: -ENOEXEC;
 	}
 
-	return 0;
+	return err;
 }
 
 /* Given an address, look for it in the module exception tables. */
-- 
2.15.1
