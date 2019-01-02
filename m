Return-Path: <SRS0=tVBC=PK=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4089C43387
	for <linux-mips@archiver.kernel.org>; Wed,  2 Jan 2019 22:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5E5214C6
	for <linux-mips@archiver.kernel.org>; Wed,  2 Jan 2019 22:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="cIeyU8Dd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfABWQd (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 2 Jan 2019 17:16:33 -0500
Received: from mail-eopbgr740124.outbound.protection.outlook.com ([40.107.74.124]:57312
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727055AbfABWQd (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Wed, 2 Jan 2019 17:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AucmNza4yw/CKBMUE30Pbbwq4UDOlrnra/V1Nw1Eqb4=;
 b=cIeyU8DddaaaID/9TXcegoFIlVZ7ycfFvV/IJlucosgOBlFGhl8WMbP2ZEeD5qDo4hoDQZiplU/+8hGeaaKD7hC+NvSh8HE7jTDSlTf+fw8WmRK1x6QWWddIVRQI6ig84PoKWJopk4pL6wb2TFI/JdePDhpVmHRCnfsmVv0V5u8=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1230.namprd22.prod.outlook.com (10.174.161.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Wed, 2 Jan 2019 22:16:30 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110%4]) with mapi id 15.20.1495.005; Wed, 2 Jan 2019
 22:16:29 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MIPS: OCTEON: mark RGMII interface disabled on OCTEON III
Thread-Topic: [PATCH] MIPS: OCTEON: mark RGMII interface disabled on OCTEON
 III
Thread-Index: AQHUossHe8xY/rIeqEafAKaD/j9IqaWcjAIA
Date:   Wed, 2 Jan 2019 22:16:29 +0000
Message-ID: <MWHPR2201MB12777114331F5B0B8E8494A1C18C0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190102184301.4222-1-aaro.koskinen@iki.fi>
In-Reply-To: <20190102184301.4222-1-aaro.koskinen@iki.fi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0035.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::23) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.185.176.138]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1230;6:YS50bT79RWQ73lU7yM/sUJYJSfPkTgsM5yido9Facg5BkP8WPUcko8m4YJl8Y6es/SnwH3pUT8/vKRujgH7cLmzw3opp34kR58tMuIW8K9NCdDv/iIts+hEfhZ6YSqbbOshH7ZZ3HxPQeie9S5eQTy+Ea0ZB8Y5FmMDOAwQS1C3M9FnEeSyPQNs2xwFL2CeMhrme15TojjON6K9VB7TP49x0g8bETjAt3Lp3Ltfh8AnMaDICmcRGVDUhNSPn4XhLmJpJ7DT913rCfpBwGbz1PazXTJRueDedBVlQUI+Al507qJPewhNqEMxv8ajm1QjCStCq5xHO6kmTl8SnHQ2GdJQm61aeOccRyzr2+65L5+MfvEZ7BWBUokzZTRoiLQnvBJ7e/g36BKU/+HEmO1qBSjw2aMN55Umgjjjd5x+YKGyjkqac+hSba3tCxDtF1Q8kstT4T64mnvmDCE38AXyOYg==;5:48MNrz0uBxv7ScD/TlhmGRGUSEp21bpxRbr+03cTxAmTQ+OvrJc2W0bkE/k+KZhXfPximW70ni4aEuX4jlR+JJTS9zGVg8HeUms059P6thP2WND7Wrhb8I/4UNpe1vS1tQlUXyKAzunK8TGYwJFT+kOkCzyB/n60mkz0M6YqSYdmNBZ4RcWw2+p9WpvW34EmuusUmDj9Avz2AohMb0iJqg==;7:zK9ZYEGloHVW4fvAT5BkEKmYFlYaWYxDm+21Ea+jaos1+UZoJkw0WXy9IwBPPJca4XNbUSUMaedJTDUJOfSoEBHyCWRq/wNbHzaKPoCi0GS+wSm4soZEI6hBcK9yI9jkpgGe21WWqUPduUh4Nz4FVQ==
x-ms-office365-filtering-correlation-id: 05fcd19e-cff1-4113-9a6b-08d670fff17c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1230;
x-ms-traffictypediagnostic: MWHPR2201MB1230:
x-microsoft-antispam-prvs: <MWHPR2201MB1230BF2EC10DE4B129DC2E85C18C0@MWHPR2201MB1230.namprd22.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(93006095)(3231475)(944501520)(52105112)(3002001)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1230;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1230;
x-forefront-prvs: 0905A6B2C7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(396003)(136003)(39840400004)(189003)(199004)(76176011)(7696005)(52116002)(446003)(53936002)(74316002)(9686003)(6506007)(386003)(7736002)(305945005)(478600001)(11346002)(26005)(102836004)(186003)(229853002)(476003)(71190400001)(71200400001)(6436002)(55016002)(33656002)(25786009)(6246003)(44832011)(4326008)(66066001)(486006)(5660300001)(6916009)(99286004)(8676002)(81156014)(14454004)(68736007)(81166006)(8936002)(97736004)(2906002)(106356001)(3846002)(316002)(6116002)(256004)(54906003)(105586002)(14444005)(42882007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1230;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +mn+xpFuUn3OsJl6fIuZGCSk92UPZnXgLI7VKxPIoQl88cado4jJGLnBWZnaL//m+o4knqstci32RVqSt+A8ItXSsZ6Fbr3eMxaS7SieEZxOFmfj0xDy6QXjdrOdct3KoLmo8doZmEzdtJYyxuiIFx30FcyvHTFPH8sGr/jQyzjn7DHRlSKd8jYPBnwhWd9PpU3Wgt9kpylNLGgcZzYbB53fK4kgZhdwM2znbF1CXpxsa4kIEeuKuiBhwsPPiVOM5V+O+NWtKFL6ENczemAB4qEN+w8GUA1f07BPKpOTjvD/UWS6FyCBQxF7L6wBqnJo
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05fcd19e-cff1-4113-9a6b-08d670fff17c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2019 22:16:29.7762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1230
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Aaro Koskinen wrote:
> Commit 885872b722b7 ("MIPS: Octeon: Add Octeon III CN7xxx
> interface detection") added RGMII interface detection for OCTEON III,
> but it results in the following logs:
>=20
> [    7.165984] ERROR: Unsupported Octeon model in __cvmx_helper_rgmii_pro=
be
> [    7.173017] ERROR: Unsupported Octeon model in __cvmx_helper_rgmii_pro=
be
>=20
> The current RGMII routines are valid only for older OCTEONS that
> use GMX/ASX hardware blocks. On later chips AGL should be used,
> but support for that is missing in the mainline. Until that is added,
> mark the interface as disabled.
>=20
> Fixes: 885872b722b7 ("MIPS: Octeon: Add Octeon III CN7xxx interface detec=
tion")
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
