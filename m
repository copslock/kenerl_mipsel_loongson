Return-Path: <SRS0=VxEc=R4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A324C43381
	for <linux-mips@archiver.kernel.org>; Mon, 25 Mar 2019 21:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15FA220811
	for <linux-mips@archiver.kernel.org>; Mon, 25 Mar 2019 21:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="FnGZnjbI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbfCYVCw (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:02:52 -0400
Received: from mail-eopbgr820095.outbound.protection.outlook.com ([40.107.82.95]:15932
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729123AbfCYVCw (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 25 Mar 2019 17:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BT/iqKaVI/PG8I9rzf4SwzVgj4V+ok12L5lFaE+Zs9Q=;
 b=FnGZnjbIscufJUNDOE/M2bwESJchGXEjM4KrwKu/dON76eMpB6CUkK73UGl1l8qs4CaemdBILUFMKYV7P78760Lyua5V9VJyDX1fkokoT2RAGeWQsrpDV5VSiA8LDRHDK/z8AgRhDo79+7nRjmjoMvxgvjTQfHwm3tGI6BT83RY=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1022.namprd22.prod.outlook.com (10.174.167.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Mon, 25 Mar 2019 21:02:48 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018%3]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 21:02:48 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Burton <pburton@wavecomp.com>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        George Spelvin <lkml@sdf.org>, James Hogan <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MIPS: KVM: Use prandom_u32_max() to generate tlbwr index
Thread-Topic: [PATCH] MIPS: KVM: Use prandom_u32_max() to generate tlbwr index
Thread-Index: AQHU4NmiNa7OUdhgaUe67JGmz2BUC6Yc2n+A
Date:   Mon, 25 Mar 2019 21:02:48 +0000
Message-ID: <MWHPR2201MB1277E2E9E0CE42C7CCECE372C15E0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190322180349.4256-1-paul.burton@mips.com>
In-Reply-To: <20190322180349.4256-1-paul.burton@mips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:a03:180::26) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0733858a-4ff1-4b11-0aeb-08d6b1653c43
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1022;
x-ms-traffictypediagnostic: MWHPR2201MB1022:
x-microsoft-antispam-prvs: <MWHPR2201MB1022DF941A6A4DD6839E23C4C15E0@MWHPR2201MB1022.namprd22.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39840400004)(366004)(376002)(136003)(199004)(189003)(52314003)(76176011)(6506007)(4326008)(53936002)(316002)(6862004)(66066001)(68736007)(6436002)(386003)(229853002)(478600001)(42882007)(26005)(81156014)(9686003)(55016002)(6246003)(7696005)(52116002)(5660300002)(2906002)(102836004)(14454004)(106356001)(105586002)(97736004)(33656002)(8936002)(7736002)(256004)(486006)(74316002)(446003)(305945005)(52536014)(25786009)(476003)(54906003)(71200400001)(71190400001)(3846002)(6116002)(186003)(11346002)(8676002)(44832011)(81166006)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1022;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Q9MQEWnLyLNSS3FoiSPeqmBv3E5IDRkFb+ZiYAihT/wmZpRQAhc0p5Rwu/Sz1rHCrik/mPzzaF4YBsMWRVxCdIJrqiWLTcgY9cCzA4o9ljKst1MnbCbt75RcVEYvnOA+EcQHRRpEc/4xdINpKHxbx7CfL3v9FIm/5pSgOa1RIuBCck5b/oVNLgkaSkT+A7SfswUm1Zz9mumTj80nSSn5K1ZKvr0yRWYmospUdj1bbd8Gjhjwvz3zATdCX7NZRhPTaTf7OMbcZgusNRspne71mjfdf/eK8bohRAEeoMsWqSlXR/UGBZ9MLO0ZTdtr2krbvA3Bxgfobw6tzZqdzwqCEgYPO2AHebMORNEFNk9lpqy7XOObXe6+KwBiIL/MW2CaOR+Cve3yQAiKuBMjMHsDvqVHzIwiU+y7b3nT9JVwCu4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0733858a-4ff1-4b11-0aeb-08d6b1653c43
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 21:02:48.4407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1022
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Paul Burton wrote:
> Emulation of the tlbwr instruction, which writes a TLB entry to a random
> index in the TLB, currently uses get_random_bytes() to generate a 4 byte
> random number which we then mask to form the index. This is overkill in
> a couple of ways:
>=20
> - We don't need 4 bytes here since we mask the value to form a 6 bit
> number anyway, so we waste /dev/random entropy generating 3 random
> bytes that are unused.
>=20
> - We don't need crypto-grade randomness here - the architecture spec
> allows implementations to use any algorithm & merely encourages that
> some pseudo-randomness be used rather than a simple counter. The
> fast prandom_u32() function fits that criteria well.
>=20
> So rather than using get_random_bytes() & consuming /dev/random entropy,
> switch to using the faster prandom_u32_max() which provides what we need
> here whilst also performing the masking/modulo for us.
>=20
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Reported-by: George Spelvin <lkml@sdf.org>
> Cc: James Hogan <jhogan@kernel.org>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
