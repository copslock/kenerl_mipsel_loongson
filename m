Return-Path: <SRS0=X/+O=PI=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200A6C43387
	for <linux-mips@archiver.kernel.org>; Mon, 31 Dec 2018 15:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D0421783
	for <linux-mips@archiver.kernel.org>; Mon, 31 Dec 2018 15:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Sn4jekW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbeLaPS3 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 31 Dec 2018 10:18:29 -0500
Received: from mail-eopbgr760129.outbound.protection.outlook.com ([40.107.76.129]:54448
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725899AbeLaPS3 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 31 Dec 2018 10:18:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEWdqMnIgQ9989bHu1jYoLFXJFljuYo64vOG+GgxtAQ=;
 b=Sn4jekW9wEWuVY45sZ9nYm7byRbjrfpMSTuuTyI06uwH1CZCWg8LrOE8aHtWUjQUTCHFbSqz3AXEicHnX1LdNcpmjxZ6lGpYCOXEMy4BlkXiXfOCeud9eyWrXiNK7sf3GyodtSl7TD4rSM4HUTVPAHLPEyqM5BXof4OUjc9j584=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1069.namprd22.prod.outlook.com (10.174.169.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Mon, 31 Dec 2018 15:18:23 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%9]) with mapi id 15.20.1471.019; Mon, 31 Dec 2018
 15:18:23 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Joshua Kinard <kumba@gentoo.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 1/2] MIPS: Fix a R10000_LLSC_WAR logic in atomic.h
Thread-Topic: [PATCH 1/2] MIPS: Fix a R10000_LLSC_WAR logic in atomic.h
Thread-Index: AQHUm+vEW8CnGSflqU6gKCMcLXwGfaWZAESA
Date:   Mon, 31 Dec 2018 15:18:22 +0000
Message-ID: <MWHPR2201MB12779EC83A14DD7DBC9049C2C1B20@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <1545699062-18471-1-git-send-email-chenhc@lemote.com>
In-Reply-To: <1545699062-18471-1-git-send-email-chenhc@lemote.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::18) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2a02:c7f:5e43:2c00:50fd:bec4:fe7e:44e7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1069;6:8gTqMvhgRck5p6riIgN23tNxjkVcer0SWXlNhzKkaHR6MZNpGqI35PyERB324Cw/CCi+JcVddTxouii1ayPgWoL3N46RSYuYZA5tL92C9f7/E6uqorQjsxpHc/douC4afcO89v1RcNrXr8Or1wiCg9pe3dMY8BwDx5LPccL1+Tu03TAUk2UrNryccVLskfWYUsw7wBLMKG6uLGOF+qrnQtcYtdcMPADS1xYqZg5bAQBV9WWGmKdA9qb1T4cyajeRqEltb25A6bZgldmq9izUwyZNOAdr+iUNPyQdlnYlxwIHjPTDA3gEdjKaW88zKbqkEDCtqs3rmGvNwXq1vuj2k9rBGv5j+XWWwk2P3kW2mavcNuvWbjLd5mhSWybS7MP1BlOj/yCJJL9vdyEY5V3GwbYBjTU6lEzHwkMsL1EK2RS5+Or/2BTBJnn/noZkuOSX8Lqv993pwzo8MzaHvHqXjQ==;5:6MOZYWTfHEXb90QlKwg6WVLLqQ4rElhOnKz1aB5dDfzYAeimD3aHAEZr2cGxU5xG+Qzd01ZBXVjOp7L/XcY7ZjekAeD53lvfKY47fF7twTaGhNFc0Qm2Fqho/0TwB3EYvVjmU0yctJs08fddaz2vR+DvEo7LDQmluyjT6wQBXl0=;7:VK58/UYkXB3LBucPFn3MVCmoXgHg+F6/LbJKED1NH5iRIGi1Zs2nHYJsYipXbhnHE/p9dYB5KtSNjShhTR7SSvw5ll7mkSFlmVujJaCDmQ0qajowZmYQEKmjmeajlyTJA0QoCmxb/oQd8s9k2uYACg==
x-ms-office365-filtering-correlation-id: 7ddeafaf-63fe-45fa-1a18-08d66f33340d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1069;
x-ms-traffictypediagnostic: MWHPR2201MB1069:
x-microsoft-antispam-prvs: <MWHPR2201MB1069290821952E1EB21D8DE2C1B20@MWHPR2201MB1069.namprd22.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(3231475)(944501520)(52105112)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1069;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1069;
x-forefront-prvs: 0903DD1D85
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39830400003)(376002)(366004)(136003)(199004)(189003)(14454004)(508600001)(25786009)(99286004)(5660300001)(6246003)(39060400002)(53936002)(55016002)(97736004)(6916009)(74316002)(305945005)(4326008)(71190400001)(71200400001)(6116002)(2906002)(9686003)(14444005)(102836004)(46003)(105586002)(44832011)(486006)(256004)(6436002)(54906003)(6506007)(446003)(386003)(229853002)(106356001)(8676002)(33656002)(476003)(76176011)(81166006)(81156014)(7736002)(42882007)(11346002)(316002)(186003)(7696005)(68736007)(52116002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1069;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BApDZ8yPaXkEhbp2gSzBhfhxdUQmSeAqEx69ImVJIzaH3Ksoclv54HJdS8Q66KoTlKOJ/1VPeE6UKMmZ1kccHjMOsFG5iYA+lgiWkUf5J/0gNt1jQW6WLAiCuFnTO5LWFj/FCg8TsJwuflK7fu++Vs24osxSEdreNRea8Ps5TRfXJmVWMel59nWYtWkSbsZyn4xYieJ5otWwW/ttWZbtBH1GUoZowYRAjS9exokhwbzGPH5kCIrHFTxDQcRXxxhBspQSuzIVwuMKBWcZuCMui6v+fEg5Vh6TZAckx+fBERM3UuY1tSnql0BdUJ8BnewD
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ddeafaf-63fe-45fa-1a18-08d66f33340d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2018 15:18:23.1246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1069
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Huacai Chen wrote:
> Commit 4936084c2ee227524c242d79 ("MIPS: Cleanup R10000_LLSC_WAR logic
> in atomic.h") introduce a mistake in atomic64_fetch_##op##_relaxed(),
> because it forget to delete R10000_LLSC_WAR in the if-condition. So fix
> it.
>=20
> Fixes: 4936084c2ee227524c24 ("MIPS: Cleanup R10000_LLSC_WAR logic in atom=
ic.h")
> Cc: stable@vger.kernel.org
> Cc: Joshua Kinard <kumba@gentoo.org>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
