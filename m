Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Nov 2018 01:14:08 +0100 (CET)
Received: from mail-eopbgr820137.outbound.protection.outlook.com ([40.107.82.137]:40208
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990406AbeKJAMINUOQ8 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Nov 2018 01:12:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjXnAVnQNi7atVKzp8to69CdhlE6Ra6iZtyNbn1pdAY=;
 b=bf21c+Zdl6LKgn0RxEhnlGxQcYxgnpBFXqBkNHiZa0QX1sCYzyHQCIFVattuLYfKWvfTkoKCa3tP+x8HfaFNw+XvTivfM1sTu4Ceq0Zxdbf9g/SVPxqwK70roMgq+l7RGTM4HJI57oWMdMabiLH20K2QgNf/z1YwjEsotKIL120=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1744.namprd22.prod.outlook.com (10.164.206.162) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Sat, 10 Nov 2018 00:12:06 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.039; Sat, 10 Nov 2018
 00:12:06 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Paul Burton <pburton@wavecomp.com>
Subject: [PATCH] MIPS: Boston: Disable EG20T prefetch
Thread-Topic: [PATCH] MIPS: Boston: Disable EG20T prefetch
Thread-Index: AQHUeIoDHv3bBIoYiEWwubIAC3hotw==
Date:   Sat, 10 Nov 2018 00:12:06 +0000
Message-ID: <20181110001155.12786-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO1PR15CA0111.namprd15.prod.outlook.com
 (2603:10b6:101:21::31) To MWHSPR00MB117.namprd22.prod.outlook.com
 (2603:10b6:300:10c::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1744;6:RSh+ZbKWZLTQS75bLGYxjNQyU/P1eWC9u8e1xly+BhFIZaDA5zS2nNGLJcnBPvSOTnHKOlF/inSmPvbP019BZVPBetNRE2dB5jWsIdCmifKHqH4/Na6/LSC67aDM60qkBhZcAbrhQ4AUvtpZO/rWetKdrKOTIZJ2vHbKWnTZjLxqHrt1wxRQycusrNd7eg0HSSKFWZytACzDxZNMrYfHRnqmpq2W2wjYZO4NHzz1JECtImDx9IaItbPPrpOQ/LPoQYb47Tu/SGx9cEsq6+YuAFeKqbcShKwMaBFbMORQXcYNzSk58BC6NG3aA2+KUnumsC8qbJnVNabsZcnTZNUtTMyQW+WudCCnzvBnsZw4WPb6YXxBt0ctHTCRQNJVemQNQygOZNF8h7RaDIfYOJ4/xAMSr3p2Zbb2SaM18U3Kcfh8DRN9ou9un0pBkd5lA0b/8IJslJvrEEoQEpql/RZ5fA==;5:fDDipQAcwfdxpT45yCylE+aUoOBnTIKLEyDs42PlRamOKHpayEYmOUNNSWVVMovs1RFzQ1elwgY09ZutE18KJEfo+Y+lGLNDeLdd2lsIop7EB8hfOoGK0v5lCCCTGvueB+zOz89xNO1+4s5rJ9vsgaWlcIuGpXW/SytIzYPlcTU=;7:5oNaIxa+lxlJjZtPW5gklvi4ho17jcTt1Ty04I+6/p4ArX2DfMDYNZTVyyLsCd0J3MS9o1pqsWc2wwIv5YN70IHXHJruYPUGg/3rTd9bZNAhrIb7DG5m9tkZADdsvEWbQOWmOlSzqVomCyP7kzSOzg==
x-ms-office365-filtering-correlation-id: 2f58e0f3-dd08-4c1f-26ca-08d646a125df
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1744;
x-ms-traffictypediagnostic: MWHPR2201MB1744:
x-microsoft-antispam-prvs: <MWHPR2201MB1744BF5EE5E03FAC3BACF3E7C1C70@MWHPR2201MB1744.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231382)(944501410)(52105095)(10201501046)(93006095)(148016)(149066)(150057)(6041310)(2016111802025)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1744;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1744;
x-forefront-prvs: 0852EB6797
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(376002)(366004)(346002)(396003)(136003)(199004)(189003)(97736004)(36756003)(25786009)(102836004)(26005)(6506007)(386003)(68736007)(6486002)(4326008)(186003)(1857600001)(5640700003)(486006)(2351001)(2616005)(476003)(6512007)(105586002)(106356001)(508600001)(44832011)(6436002)(107886003)(14454004)(53936002)(2906002)(2900100001)(42882007)(6916009)(14444005)(256004)(8676002)(81156014)(81166006)(8936002)(71200400001)(71190400001)(99286004)(5660300001)(316002)(66066001)(2501003)(52116002)(6116002)(3846002)(1076002)(7736002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1744;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aHJm/2iZjWgVqdlB9e3dPh4CRcFzL1hMljG9rWtFfWJCFjHq+4fCxGcp7a6tizG4CBJ8Xye0CfPXCV5QzDF6B8ErcMeVYaPwP+7fiAQhXOF2QE5l4TriXm+Y+SmiV2MQFvn9ZJcZzbhA+7BcOpdewiH51i2bzYKCWlGbXbIrXF2mWr3qK0QTDQBwagoVwFgVTaSZInkY5gQWxiMdz391EhDtyPAUy1b744zwAd2DCsOy6BABjJfa2zWIZtuDmL2MzMrDO5VVIFADAS2mfCLg1iTUUgRAAa6owsY8V5Jj1NtAeLUAVzHfUOk6eYDGBxuRIH/Q2TIynC7SC8XY4OGFUo1eytoYWDuA5ZpbyLlJNW8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f58e0f3-dd08-4c1f-26ca-08d646a125df
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2018 00:12:06.2707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1744
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67216
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

The Intel EG20T Platform Controller Hub used on the MIPS Boston
development board supports prefetching memory to optimize DMA transfers.
Unfortunately for unknown reasons this doesn't work well with some MIPS
CPUs such as the P6600, particularly when using an I/O Coherence Unit
(IOCU) to provide cache-coherent DMA. In these systems it is common for
DMA data to be lost, resulting in broken access to EG20T devices such as
the MMC or SATA controllers.

Support for a DT property to configure the prefetching was added a while
back by commit 549ce8f134bd ("misc: pch_phub: Read prefetch value from
device tree if passed") but we never added the DT snippet to make use of
it. Add that now in order to disable the prefetching & fix DMA on the
affected systems.

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

 arch/mips/boot/dts/img/boston.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/boot/dts/img/boston.dts b/arch/mips/boot/dts/img/boston.dts
index 65af3f6ba81c..84328afa3a55 100644
--- a/arch/mips/boot/dts/img/boston.dts
+++ b/arch/mips/boot/dts/img/boston.dts
@@ -141,6 +141,12 @@
 				#size-cells = <2>;
 				#interrupt-cells = <1>;
 
+				eg20t_phub@2,0,0 {
+					compatible = "pci8086,8801";
+					reg = <0x00020000 0 0 0 0>;
+					intel,eg20t-prefetch = <0>;
+				};
+
 				eg20t_mac@2,0,1 {
 					compatible = "pci8086,8802";
 					reg = <0x00020100 0 0 0 0>;
-- 
2.19.1
