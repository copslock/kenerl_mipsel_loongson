Return-Path: <SRS0=6l1E=OM=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48D1C04EB9
	for <linux-mips@archiver.kernel.org>; Mon,  3 Dec 2018 22:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D6320864
	for <linux-mips@archiver.kernel.org>; Mon,  3 Dec 2018 22:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="r4WPa8gk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D6320864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbeLCWmI (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:42:08 -0500
Received: from mail-eopbgr680120.outbound.protection.outlook.com ([40.107.68.120]:27390
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725926AbeLCWmH (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 3 Dec 2018 17:42:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cF2DI6F2YoYro9OAXfwH//b3zeIzn1tzY7yNCHFId0c=;
 b=r4WPa8gkzSzeYlAxphtm4+SQ7WfWlKb++t4Lj5lzzho+CJ9k91Q2A0SJxXlOBMQcgI3oTkkFr8TTO8acharUyXcRbWmXhOXs48QZBsagf3b0MNxxt/8/xYPkYdoQBd+CO2fUR/3SBx0C4RN7khzuGe+EML/v8FobLhzFBgbn8N4=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1438.namprd22.prod.outlook.com (10.174.169.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Mon, 3 Dec 2018 22:42:04 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985%4]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 22:42:04 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Jiong Wang <jiong.wang@netronome.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "oss-drivers@netronome.com" <oss-drivers@netronome.com>,
        Jiong Wang <jiong.wang@netronome.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <pburton@wavecomp.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v2 bpf] mips: bpf: fix encoding bug for mm_srlv32_op
Thread-Topic: [PATCH v2 bpf] mips: bpf: fix encoding bug for mm_srlv32_op
Thread-Index: AQHUi1d3/x+GjpAZHEqjuorUVrDYEqVtnCEA
Date:   Mon, 3 Dec 2018 22:42:04 +0000
Message-ID: <MWHPR2201MB1277C127DA9E9CABBC6F96BEC1AE0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <1543876074-4372-1-git-send-email-jiong.wang@netronome.com>
In-Reply-To: <1543876074-4372-1-git-send-email-jiong.wang@netronome.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO1PR15CA0091.namprd15.prod.outlook.com
 (2603:10b6:101:21::11) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1438;6:Vm91WPN3c4P1CIeECeXDv/nlBLrUfI4cIZK/FOLIQSzj/DA3iM5AyabtiJR8O+0AY/vnzT47G1FUgRf6CSdf/9SKSVRJo6RfhNym9ZH225DyGnZwlxs8BUCDD8xz8qE7UVFUYiXJtW6XvfcYjqy8fE6yTFbnuM+GFzFXmUl6z6gwvkLH9weVKbKmbLH0ow+aPSOUaCCaHLHhT77W/IY1Ch02/E8r+6fM3z5ufTiqp8QBwT9KN9/0/TdcerixwSoRH8EY1loaXna2HT2p8ixrxfqOudkJjP86Dp/9p9XCbcfQnECSyqvbf4y/p2yO8XagLY+tq6cTeD0iw16EFKJ6unr4Fwp8exw9eP4hsJGW/ZPq6ch5Zi1UnUApE5vRdfoD0xMLt+5ktfAxV7fXfxvpPexTKhrZ2auaxXdBkxEfz0wnz8sulJwjmPqR8i69OkslbSI1x+5ejpSn9GU27zj7Ew==;5:XP3EdwaSIb2dNWJEd9VAPsvP6R8RDkIRd4YVyE/16DIUNz7CsgKNS0Y7fOqfaONpBj1TjHSsxdGAi4Cb1NGqiCvyOAik8X/Tcl/DWnU6EG4upKKlGH1IV0HQ+K5td1E7vCaT9p6uDZfJDoZ1/V9ahvcbjm7j3PdYATIcYpqtm3M=;7:CllbxqLM7NqJdiEBte/jQGSpLPiNYIFinjqYLHfkcLxisuPew5BBCqX4H77fdRLaORORMYwfb6AQ3QY6OqkmJCj1Y35QxtWwERaEG2o/d/nY/OU85p3TS4MaJ3kIfIhQyKgAGxdMURdrpFw/DXoa8A==
x-ms-office365-filtering-correlation-id: 6068b107-e642-4c9d-beb6-08d659708c0f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1438;
x-ms-traffictypediagnostic: MWHPR2201MB1438:
x-microsoft-antispam-prvs: <MWHPR2201MB1438A73D08F9DB56C537B9B8C1AE0@MWHPR2201MB1438.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231455)(999002)(944501493)(52105112)(93006095)(148016)(149066)(150057)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1438;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1438;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(396003)(39840400004)(136003)(189003)(199004)(42882007)(508600001)(8936002)(44832011)(25786009)(6916009)(74316002)(2906002)(229853002)(6436002)(99286004)(102836004)(186003)(7736002)(305945005)(256004)(4326008)(33656002)(386003)(106356001)(26005)(105586002)(71200400001)(3846002)(6116002)(71190400001)(11346002)(486006)(39060400002)(316002)(97736004)(6506007)(9686003)(53936002)(476003)(55016002)(5660300001)(52116002)(6246003)(7696005)(8676002)(81166006)(76176011)(54906003)(14454004)(66066001)(81156014)(446003)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1438;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4ANAfx6Cbmqn4MHNJauwCue8x7j4EAvJKqyNCQgMGmvqEWm5V4yttkY6z6RRUXYlNDtfzE7fTOAU/lPZxJRc9ZnD5E7UP0Rku2A81h+LKCTi3XVE5nW9JIe7eX50lJIQ+GyaT8WNfbD+j7puFcGtcdiTrM1n6jVwLioyXHhPo4+f6n8ikyxMMPem0vRu9OoTsHVAYb27uXmSE3JCSvWg9LszJQjUcu8ibddUdvqq1ajy5WDsVdbGRsvzrqPyXyh+8Rdy4ucPqAASm8bL+QE/2As1rwFsnLdyNjFbe+1xHHMgUC6o9qWoA9v1ctuI/WiFXT5jFLTkiLiVX428Mk5lrmneEH+WCNi3TYDvyL37wB0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6068b107-e642-4c9d-beb6-08d659708c0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 22:42:04.3057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1438
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Jiong Wang wrote:
> For micro-mips, srlv inside POOL32A encoding space should use 0x50
> sub-opcode, NOT 0x90.
>=20
> Some early version ISA doc describes the encoding as 0x90 for both srlv a=
nd
> srav, this looks to me was a typo. I checked Binutils libopcode
> implementation which is using 0x50 for srlv and 0x90 for srav.
>=20
> v1->v2:
> - Keep mm_srlv32_op sorted by value.
>=20
> Fixes: f31318fdf324 ("MIPS: uasm: Add srlv uasm instruction")
> Cc: Markos Chandras <markos.chandras@imgtec.com>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: linux-mips@vger.kernel.org
> Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> Acked-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
