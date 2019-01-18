Return-Path: <SRS0=gTW6=P2=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BF9C5AC81
	for <linux-mips@archiver.kernel.org>; Fri, 18 Jan 2019 19:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A30A20657
	for <linux-mips@archiver.kernel.org>; Fri, 18 Jan 2019 19:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="oKSlY/2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbfARTdz (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:33:55 -0500
Received: from mail-eopbgr780135.outbound.protection.outlook.com ([40.107.78.135]:44480
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728738AbfARTdy (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 18 Jan 2019 14:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lI+vI6okr2or9vRt6MHyYgmkUj4cWtnsUn4vP3SIa80=;
 b=oKSlY/2nhO0hrz3hjc0iGhnCTYEBqWFIWRdidGc2Vwrh/O6zXQ1rgWJM4LNwd21IqvOni3DfSNZAn9hqiLqa2XUF7WaqWAoH/RmlmBWiyVSOiL7fs8pivx8hz2skAhtLTKgRMTmIogiinmezdRE/RGP81WhpOnb7dgDUDdCaKk8=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1327.namprd22.prod.outlook.com (10.174.162.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Fri, 18 Jan 2019 19:33:51 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110%4]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 19:33:51 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
CC:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        "jhogan@kernel.org" <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "nbd@nbd.name" <nbd@nbd.name>, Hauke Mehrtens <hauke@hauke-m.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Compile post DMA flush only when needed
Thread-Topic: [PATCH] MIPS: Compile post DMA flush only when needed
Thread-Index: AQHUj9bd+V2+QGoge0iyRnB7XdbZMqW1qcqA
Date:   Fri, 18 Jan 2019 19:33:51 +0000
Message-ID: <MWHPR2201MB12776FB9987D8C7A68481689C19C0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20181209154957.28403-1-hauke@hauke-m.de>
In-Reply-To: <20181209154957.28403-1-hauke@hauke-m.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0165.namprd04.prod.outlook.com
 (2603:10b6:104:4::19) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1327;6:qy4BHqBQ85xJDK++04nPv8SzbEItwOxW6FP84+RbcLUnQGZQst5Csj7k32nzc/k/EWtMRmJPcBt4zkI06qA7n/3IGZH+Gxi7WWTrAq8v1h/tmYCekMvXdCoTNL36Rc35fZKxhEVjs21Hn+LVcs8a+Pt+3HdVYx0Vxl8iC+f5nKh6DqMnIDvYik7aLvu3qGqe9+Gn2dXkWCDlnZ7AV7FlPvNFPgNZQj99vV3tpKSEJjQ2rLsLG6Rwx0Sop4BF9Wr2uTQYC6ZoObPbUgqxmkTEqJOszofp3j57bWStoUm+DbVIv4rymfeq23ZcWaYWGs6gMzVkazf5u8Sazt65qGmRdcYKlSjDVAfh5ATY4f7FNa5uH+rc9P4o4ikQwZ2Pr7MFdUA7vnHym78/PeOKfyCU8qxwBhoYINqKNAJdOP1CK4uDtBcZEu0rK1K/IcEegTRwLJUMFmem/9vN+6UaK46rAA==;5:ET4zVLoL9kCGym0Exm0hR35vp98m5XskSPFE/lg0yVoJbPobeut/IKhRP5F6LFUcx0VI1F8BFmfEvysHCutipExwGB/ebXifpqV5Y//NwMF97Pl/3IMUvMW7bbgHK1Gph5vVTZ08KKr9WroegGWO7Amv+zRUz8uaCD9bYzOXOg/wu6WFRHrInGVbGZqr12lITSTUKb7MjXJxx6xBnUVvVA==;7:JHJ6+R6ASkyvsh+egQLehyq2fZBWVwMifFOy+NCsUWN0RcJIoO2zrwB0nrRIEI3KR1H22C2YLNvaK7MSLsk82MsU7HjJ1/rbOZ9LozKTfL76b0w1XsK9toKkYWTqdHchvr5Uxn09oP/G+bEBrPijEg==
x-ms-office365-filtering-correlation-id: 8f27d02f-b252-492f-abdd-08d67d7bdfc1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1327;
x-ms-traffictypediagnostic: MWHPR2201MB1327:
x-microsoft-antispam-prvs: <MWHPR2201MB1327626250D2ADA5E32E8DE4C19C0@MWHPR2201MB1327.namprd22.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(396003)(136003)(39840400004)(189003)(199004)(4326008)(76176011)(6116002)(68736007)(6916009)(3846002)(316002)(54906003)(33656002)(8936002)(229853002)(5660300001)(66066001)(74316002)(386003)(52116002)(11346002)(446003)(25786009)(97736004)(26005)(6506007)(102836004)(42882007)(6246003)(186003)(9686003)(53936002)(256004)(105586002)(7696005)(44832011)(476003)(106356001)(2906002)(486006)(81156014)(55016002)(305945005)(14454004)(8676002)(7736002)(81166006)(6436002)(4744005)(71200400001)(71190400001)(478600001)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1327;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nu0KZzcCL82unMnXpOWcu7xWkPV+wy7x46HtwnIp7zmnPjA4HRGQqcYhPDBJk6fuCWdlAE+oeNJClIChsrZ6DixGYES+ztlwWyytBhmC8VCD7sOxdXGsITfWZuFFZkkgm+hkRztiQfd0HUNU4LkEPuMmxuvD0qXxIMfQivvvFJfdqDOVWOeyMCj1MwyLX2bOly9aa2cdsj+4mM8p8eSlDIH2UgkDsKIe2ZNc7+3sxM9ELVHtq9jjv+HsdmhQ+XAibKrCSglnI5h+95t9YyFSA/CYS3GGe4xGFI5vXlWGL6zSbvEEea60pStFfDq449wY2LDpwunNrZ14Ljozd9HAXTg+mOpt/wNyPHMvST9yAwulEXwMhT7gk9nL+EEztGsGH5/Myt5tbTXqCVMTYdV5WL3JRRULr4qQbc5EZnlxoI8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f27d02f-b252-492f-abdd-08d67d7bdfc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 19:33:50.7194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1327
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Hauke Mehrtens wrote:
> dma_sync_phys() is only called for some CPUs when a mapping is removed.
> Add ARCH_HAS_SYNC_DMA_FOR_CPU only for the CPUs listed in
> cpu_needs_post_dma_flush() which need this extra call and do not compile
> this code in for other CPUs. We need this for R10000, R12000, BMIPS5000
> CPUs and CPUs supporting MAAR which was introduced in MIPS32r5.
>=20
> This will hopefully improve the performance of the not affected devices.
>=20
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
