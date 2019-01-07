Return-Path: <SRS0=HQ/I=PP=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A432BC43387
	for <linux-mips@archiver.kernel.org>; Mon,  7 Jan 2019 21:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F852087F
	for <linux-mips@archiver.kernel.org>; Mon,  7 Jan 2019 21:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="kKXnJ1OT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfAGVkI (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:40:08 -0500
Received: from mail-eopbgr810104.outbound.protection.outlook.com ([40.107.81.104]:37052
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726872AbfAGVkH (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 7 Jan 2019 16:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmxG+kYglgpZv7Byfj9UAuzpYIMKpPM/+b/CwgLxhK0=;
 b=kKXnJ1OTjMzFfi3dCnnLEo4/zd7MfiRVsJUVBijIfuZ1mk1DRNctWCb/L4hpRC0nC3Zvv4YLZ2zor69SAoint6/bIpNZAHCcG9+pW7EAZ38anwGK3uUG2YbH82zbGjDlVnLMHPwCOnzF+Uz/KazJoUn1+axxUb+dngLcRtj5ipE=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1760.namprd22.prod.outlook.com (10.164.206.163) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Mon, 7 Jan 2019 21:40:05 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110%4]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 21:40:05 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
CC:     Paul Burton <pburton@wavecomp.com>,
        "jhogan@kernel.org" <jhogan@kernel.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "john@phrozen.org" <john@phrozen.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        "stable@kernel.org" <stable@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 1/2] MIPS: lantiq: Fix IPI interrupt handling
Thread-Topic: [PATCH 1/2] MIPS: lantiq: Fix IPI interrupt handling
Thread-Index: AQHUpe/gosOp4lxTTkGLKChvIpWpI6WkVzQA
Date:   Mon, 7 Jan 2019 21:40:05 +0000
Message-ID: <MWHPR2201MB12773AEF89B40C0F472CA382C1890@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190106184412.18096-1-hauke@hauke-m.de>
In-Reply-To: <20190106184412.18096-1-hauke@hauke-m.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0207.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::27) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2a02:c7f:5e43:2c00:50fd:bec4:fe7e:44e7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1760;6:4Sgh8tFh/hW6ldelzVUOsSIT+9+hUgR85VM5uSKf9WhvuQlIgPsxRaXv2cROKFLJIU75HopOwoVg9W12RuJYhfz2HwZwiNp7VQyv7oIfU64FZf8J4Hd/j7hx4lvLf9yZd70xIIqJjow0mGaoVpSlzkFgxpc/Xkz/0DeQRhdLZAlDIbrBHxfOGprRMyIRSJGZPrccISqcowI2m5FLT3OnDdAGESWaJO+WKu/asJqIdYeeVGt1qQn8VdPMlIPhk6f5R1jm4WAdWW8kCQlq3lohPgHFWeuu79TFUhXvMzTA6qRjThoY4aaHIHJHldl7fnptos4F8B9+r8ODmbU4UYrH4Ij70T58Z2u+WsiCQRqT1O60T1M5XAck/bGqnfHgMz0NJdGZqZcF3bk5gqXDkqQN7jXZOEHmUCKXqaGZXWzUedFgH/PbW/kr8VrEpM5t+tRWHPqkghS3FHTzuAk2nmEopg==;5:h6Uvj2qC1HFzhTmgHfgKtgKSfnKd+DhXXmeBGg6QA8Xuh6I3Ftrml7x5bnhn4rye4htm3hWqwlMqbbi/ZWqtfQ+nJdCDxK5LNDa2fbUK2VitlATYtwybuhYVLY0C/FBsvwUpX2AQi2nbA5UYc619+BOCoEufNRA98bEDgpdxwhP4OjCb5kzN4Ob0C+MF5ZTBcrChX2AtRNxQjBJUVfMsNQ==;7:84sTz3bigKfJXUI3yawn2oJeuKk1SfBZyY52xgxzmCiTSGfuecnu3F5TbMEA8wS40ZNRegpwKvHBuryL0mRtm+wAWmlmd2grOAj3uM8VTl5B7mN5MVtFS/RcT79gmeOlXpWt+QTedYadIk02OEDFLA==
x-ms-office365-filtering-correlation-id: 303da6c8-85d5-4224-26ba-08d674e8af84
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1760;
x-ms-traffictypediagnostic: MWHPR2201MB1760:
x-microsoft-antispam-prvs: <MWHPR2201MB176059CE268BB75DFFD158E9C1890@MWHPR2201MB1760.namprd22.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(93006095)(10201501046)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1760;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1760;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(396003)(39830400003)(366004)(199004)(189003)(7736002)(14454004)(305945005)(105586002)(478600001)(99286004)(4326008)(316002)(54906003)(6246003)(7696005)(52116002)(71190400001)(25786009)(106356001)(76176011)(71200400001)(74316002)(5660300001)(2906002)(186003)(386003)(42882007)(102836004)(8936002)(6506007)(55016002)(33656002)(46003)(446003)(11346002)(476003)(6916009)(6436002)(53936002)(486006)(97736004)(6116002)(256004)(68736007)(81156014)(9686003)(81166006)(8676002)(229853002)(44832011);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1760;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mR3sAoEJ4txoCcNkqmVbZhdFdRx54ZuYfFCcd02s88gn9J4xo6+4KYiAWf3OdtgaOXs2hrNnFDOPEFisyU3B9rGu4PtRMPlb/tGgOJLwu3cmhmI+kg1haWoMtrVjCpzBxxr9jJNJe3CVZeSFJMf1ZAdqWcGXSZvEw2kh6NT4G9lJRNgSINNbcY7kRpZBtjs76dZF2mL4nRpyPHVyo9WglKPKt/4+8f7VJUbxXDQ4yuZgMkDkuBdVXIuJFMX1+r3fch/GxEibvWyG8K8/S384ocGPziTL/vorv0MLpSMHHlywsXq0rebjgbt15YtvVH+I
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 303da6c8-85d5-4224-26ba-08d674e8af84
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 21:40:05.1505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1760
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Hauke Mehrtens wrote:
> This makes SMP on the vrx200 work again, by removing all the MIPS CPU
> interrupt specific code and making it fully use the generic MIPS CPU
> interrupt controller.
>=20
> The mti,cpu-interrupt-controller from irq-mips-cpu.c now handles the CPU
> interrupts and also the IPI interrupts which are used to communication
> between the CPUs in a SMP system. The generic interrupt code was
> already used before but the interrupt vectors were overwritten again
> when we called set_vi_handler() in the lantiq interrupt driver and we
> also provided our own plat_irq_dispatch() function which overwrote the
> weak generic implementation. Now the code uses the generic handler for
> the MIPS CPU interrupts including the IPI interrupts and registers a
> handler for the CPU interrupts which are handled by the lantiq ICU with
> irq_set_chained_handler() which was already called before.
>=20
> Calling the set_c0_status() function is also not needed any more because
> the generic MIPS CPU interrupt already activates the needed bits.
>=20
> Fixes 1eed40043579 ("MIPS: smp-mt: Use CPU interrupt controller IPI IRQ d=
omain support")
> Cc: stable@kernel.org # v4.12
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Series applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
