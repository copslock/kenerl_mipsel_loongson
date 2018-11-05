Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2018 00:00:13 +0100 (CET)
Received: from mail-eopbgr740114.outbound.protection.outlook.com ([40.107.74.114]:64144
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992783AbeKEW6eVQoxs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Nov 2018 23:58:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxrpVpkRMcd+3XL6mWEyPEXzspnME78+LErXdBTm8UI=;
 b=OkaWG93DOgke9yNJUOGNEuTf+DWR1u3izjLu3fJC9bK6cV2rZ1TbH2t1ibnDhQthoTBh4ji8oaxYZcDDhjztQ/2V5LIUVI9o0xfa22RqgOnrIOePtnDxnYXhUBgIe7UutG59paflOu+ZofIE09HhSDAx6jvd4Eq869VjAkIq9bw=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1645.namprd22.prod.outlook.com (10.174.167.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Mon, 5 Nov 2018 22:58:31 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.032; Mon, 5 Nov 2018
 22:58:31 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Huacai Chen <chenhc@lemote.com>,
        Paul Burton <pburton@wavecomp.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>
Subject: [4.19 PATCH] MIPS: VDSO: Reduce VDSO_RANDOMIZE_SIZE to 64MB for 64bit
Thread-Topic: [4.19 PATCH] MIPS: VDSO: Reduce VDSO_RANDOMIZE_SIZE to 64MB for
 64bit
Thread-Index: AQHUdVsSg6tSW+hcd0698j7Ms6GR+w==
Date:   Mon, 5 Nov 2018 22:58:30 +0000
Message-ID: <20181105225815.24489-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR12CA0051.namprd12.prod.outlook.com
 (2603:10b6:300:103::13) To MWHSPR00MB117.namprd22.prod.outlook.com
 (2603:10b6:300:10c::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1645;6:98UtNhg6z7vYu5NlG0YmcYXADJwY7b3+EAr2z/ThACk3fpFsIQhgVj7aK1pydY7/Svg7LAdnYw2hSTgRd4kOJ0VmD9qyJvQM4GT93TP9RjGTqjrklaGxrskAmHZuewJFPfnRfi8eW3OzE3DrkyswfdkweuhPUmJWSVDSsHLHxlAsrWVaVHECNzG6e5hQ2aXhVFxYayjn1/+4iyzIfneCa2p1qlCONXNfxeQnb/i+QDlTxomGVHQbNpQf4W8FIanrTCxpXQCiC3T/tuhMjT+G/MjRTAYy3yGYnukXKn8bI2ILS400Q/rJonN7/WJVHzZj+IApkvRvSQFPLAJKVmwAG8ar0Bar/IsPcNufb9f5MjVATHOWRF4A8Br1LKMTRXG5c5+G8h0AJ5h6kIOnbpoCGHDu4x5FoR8eGanRlFYbhaMFpRwgFcZTSHfbxIa5IEiq9HfyEKMU8tFCYzsXPf7S1w==;5:fqFqQx1Hsne+gKIdD0yqPpPGlsqYPsekyRfdwlzzPlRSIMkRIi3m2QsX75Woy9pjqZCTs0IkIhGOq4ptqhPRh6TQYFBR16ERvtrcEcwAtC6VIFHD5SZQ3VHcJPDMFRSkO5Uh009OZk8MzSAzAbaGM8vlCmtl/KTE15+uQrlaPEY=;7:IVUJ+mqktNk/nCYmf7cjgrEny5rj3sfzQ3xXMk7z4EYI2viYOQb+t9R3LE8ood1Z4NSzmln/YIVXYHvQtAj4nJrK61hCdJWKPQ/4UerPf9MrGRqEkZ0FyInfhgGkwfTqW4kd2Tpf1N1hr1gRWbkQXQ==
x-ms-office365-filtering-correlation-id: 25e83eb3-d58b-4f7a-2257-08d643723411
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1645;
x-ms-traffictypediagnostic: MWHPR2201MB1645:
x-microsoft-antispam-prvs: <MWHPR2201MB1645E8E9224432E61A655318C1CA0@MWHPR2201MB1645.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(93006095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1645;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1645;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(346002)(396003)(376002)(136003)(366004)(189003)(199004)(5660300001)(2900100001)(575784001)(44832011)(1076002)(486006)(42882007)(110136005)(54906003)(105586002)(4326008)(3846002)(2616005)(2906002)(25786009)(508600001)(476003)(8936002)(81156014)(81166006)(39060400002)(6116002)(106356001)(71190400001)(36756003)(71200400001)(6506007)(386003)(966005)(52116002)(26005)(186003)(2501003)(68736007)(14454004)(99286004)(102836004)(97736004)(316002)(6486002)(7736002)(66066001)(8676002)(6306002)(305945005)(6512007)(53936002)(6436002)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1645;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7JKleMSNmwBchjAkcBBFhriLu+nwL5kynCYAnERTRQ1ZJuyrggsNkXyFRzu4BxL3e9S6LgW5ORSPa6F5OzsEQTr5jhZb5JZJSK/RKSwaaDDNsTveIAml1nu9rru3GS0oPo//lcPBOuXhXzLfdilKbnPOv1T05vr6Ox1eDxWX2luvFMP46sg7+eWHLHC2u+2HT5KBEdWEZ7u6m6TKLG1jzR+9hu85PlmEI5FDYBoA+MlRxOsPysdX0tPKhn2Kd16XMEEIErBJPiCTJieD1DVZVTOOzf7+Lqhvx93qPn15TLC7e2DoZvz4JWSIRQBvH/6TRLWPBkBQmUpkRUp3u3VY56KlMjy12PZ7Ao3JJf8YW3g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e83eb3-d58b-4f7a-2257-08d643723411
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 22:58:30.8893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1645
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

From: Huacai Chen <chenhc@lemote.com>

[ Upstream commit c61c7def1fa0a722610d89790e0255b74f3c07dd ]

Commit ea7e0480a4b6 ("MIPS: VDSO: Always map near top of user memory")
set VDSO_RANDOMIZE_SIZE to 256MB for 64bit kernel. But take a look at
arch/mips/mm/mmap.c we can see that MIN_GAP is 128MB, which means the
mmap_base may be at (user_address_top - 128MB). This make the stack be
surrounded by mmaped areas, then stack expanding fails and causes a
segmentation fault. Therefore, VDSO_RANDOMIZE_SIZE should be less than
MIN_GAP and this patch reduce it to 64MB.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: ea7e0480a4b6 ("MIPS: VDSO: Always map near top of user memory")
Patchwork: https://patchwork.linux-mips.org/patch/20910/
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: Huacai Chen <chenhuacai@gmail.com>
Cc: stable@vger.kernel.org # 4.19
---
 arch/mips/include/asm/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 49d6046ca1d0..c373eb605040 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -81,7 +81,7 @@ extern unsigned int vced_count, vcei_count;
 
 #endif
 
-#define VDSO_RANDOMIZE_SIZE	(TASK_IS_32BIT_ADDR ? SZ_1M : SZ_256M)
+#define VDSO_RANDOMIZE_SIZE	(TASK_IS_32BIT_ADDR ? SZ_1M : SZ_64M)
 
 extern unsigned long mips_stack_top(void);
 #define STACK_TOP		mips_stack_top()
-- 
2.19.1
