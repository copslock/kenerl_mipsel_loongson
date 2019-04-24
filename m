Return-Path: <SRS0=tpP8=S2=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48111C282CE
	for <linux-mips@archiver.kernel.org>; Wed, 24 Apr 2019 19:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C18F2175B
	for <linux-mips@archiver.kernel.org>; Wed, 24 Apr 2019 19:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Cq40i783"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfDXT3c (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:29:32 -0400
Received: from mail-eopbgr720108.outbound.protection.outlook.com ([40.107.72.108]:30144
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725946AbfDXT3c (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Wed, 24 Apr 2019 15:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7/AyjO6O3F7APnFi/cYPCcMaTbpsBRvdsn1jqxi8zs=;
 b=Cq40i783VkDIdQw51Eo0ZPu5hvCX93sVUEQLARoTEui7BZDxE5ImkQLF5yTSmp0Pm9g3XrjvoMBfgPkeOLvj/FhUmnfmqmHw61+3T7qhZJA5wh+h0Ll1P49YRTQW9VUU2opNNrD7pjX/LUN30yso9oGEONZ+xKeFKUofB1VIxTc=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1182.namprd22.prod.outlook.com (10.174.169.158) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Wed, 24 Apr 2019 19:29:29 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%7]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 19:29:29 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: MIPS/CI20: BUG: Bad page state
Thread-Topic: MIPS/CI20: BUG: Bad page state
Thread-Index: AQHU+spp/ojd69QglkGCzSQtjt0+I6ZLsnQA
Date:   Wed, 24 Apr 2019 19:29:29 +0000
Message-ID: <20190424192922.ilnn3oxc7ryzhd3l@pburton-laptop>
References: <20190424182012.GA21072@darkstar.musicnaut.iki.fi>
In-Reply-To: <20190424182012.GA21072@darkstar.musicnaut.iki.fi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0075.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::16) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84d0241e-5eed-4977-601f-08d6c8eb2b3f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR2201MB1182;
x-ms-traffictypediagnostic: MWHPR2201MB1182:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR2201MB118248C8CA8C7A2492EDCB45C13C0@MWHPR2201MB1182.namprd22.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(39850400004)(366004)(136003)(376002)(346002)(189003)(199004)(54094003)(102836004)(76176011)(386003)(6506007)(11346002)(26005)(186003)(25786009)(476003)(33716001)(6486002)(52116002)(6916009)(6436002)(68736007)(99286004)(446003)(66066001)(42882007)(7736002)(305945005)(54906003)(1076003)(58126008)(66556008)(316002)(73956011)(66476007)(5660300002)(64756008)(66446008)(66946007)(53936002)(4326008)(256004)(8936002)(6246003)(44832011)(71200400001)(71190400001)(81156014)(486006)(966005)(478600001)(14454004)(229853002)(97736004)(2906002)(3846002)(6306002)(6512007)(9686003)(81166006)(8676002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1182;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: l161aSF98xcBLcjyJrUF7FMAbjLVTCFVwIqO2pIR7x/kW1qydwnC2h8t948AJVbW5ZojlrY1GXltF6R6Cpudc5lsr01buZkexxifhmI1wMdvACHRvbLSh4BDk86bG+sE5vG00/i0zYFASLfVhKkze3OrjQwcofUA3WCx6t1MEPS00/PYg3agkv/Mz59zt5X7Ne1u0xJn4QGknSfdB87xzXwfgiKv7Vm+kR9/56NRYkKuYdvyk68iqfsRPEB4C7FiMhy4ZxxQMJjnkymUqQAhcn57QB/zTtG1CIIMTt5LEe4GpGQFMAPv1/JmCudTvmnEqamwDs+CNkDahPpJhw1HU5BmFt3PQ33YAXol/jcp6kgdz2PJzyW2vgeiceOu7O15uIpkOXNugZNY4Bi3Jf/+/et6D8fseuH9fzdHYw6DUV8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <53CC108A17D0F64E8F5147A3DDE5D833@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d0241e-5eed-4977-601f-08d6c8eb2b3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 19:29:29.1420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1182
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Aaro,

On Wed, Apr 24, 2019 at 09:20:12PM +0300, Aaro Koskinen wrote:
> I have been trying to get GCC bootstrap to pass on CI20 board, but it
> seems to always crash. Today, I finally got around connecting the serial
> console to see why, and it logged the below BUG.
>=20
> I wonder if this is an actual bug, or is the hardware faulty?
>=20
> FWIW, this is 32-bit board with 1 GB RAM. The rootfs is on MMC, as well
> as 2 GB + 2 GB swap files.
>=20
> Kernel config is at the end of the mail.

I'd bet on memory corruption, though not necessarily faulty hardware.

Unfortunately memory corruption on Ci20 boards isn't uncommon... Someone
did make some tweaks to memory timings configured in the DDR controller
which improved things for them a while ago:

  https://github.com/MIPS/CI20_u-boot/pull/18

Would you be up for testing with those tweaks? I'd be happy to help with
updating U-Boot if needed.

Do you know which board revision you have? (Is it square or a funny
shape, green or purple, and does it have a revision number printed on
the silkscreen?)

Thanks,
    Paul
