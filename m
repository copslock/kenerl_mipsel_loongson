Return-Path: <SRS0=Dbp0=OW=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757ECC65BAE
	for <linux-mips@archiver.kernel.org>; Thu, 13 Dec 2018 19:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E689F20870
	for <linux-mips@archiver.kernel.org>; Thu, 13 Dec 2018 19:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Nc01EhmF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E689F20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbeLMTrs (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:47:48 -0500
Received: from mail-eopbgr770139.outbound.protection.outlook.com ([40.107.77.139]:32800
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727684AbeLMTrs (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 13 Dec 2018 14:47:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SZdWJ2KM5PN2yfVymq/6XYo9WBHyaK8qGBX9dCduIA=;
 b=Nc01EhmFd6ySYF7ufveOdMybO/BvKFjn28EaqeqTiV3S0ihpgUMSo9LQfWJxMng4T6x4UeGqiSI+Z+ugyIifVT/QI3KA58z4lzoEgAg+JiZBayFl0LHYnanX+FGcE0jVkpjUBbL0QMsdT++xSR9BJLJuhLkp6o1TglQ6SzYEmmQ=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1727.namprd22.prod.outlook.com (10.164.206.157) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 13 Dec 2018 19:47:42 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%7]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 19:47:42 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Stefan Roese <sr@denx.de>
CC:     U-Boot Mailing List <u-boot@lists.denx.de>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: MIPS (mt7688): EBase change in U-Boot breaks Linux
Thread-Topic: MIPS (mt7688): EBase change in U-Boot breaks Linux
Thread-Index: AQHUkfNMcpdXGl+ESEeHCV0Kj78/+qV72oOAgACZdgCAADdbAIAAAhyAgAANi4CAAFqIgA==
Date:   Thu, 13 Dec 2018 19:47:42 +0000
Message-ID: <20181213194740.mtphrijpnkzo2za4@pburton-laptop>
References: <e4f0fff9-a3c5-85ce-c4be-6e0aa0f74592@denx.de>
 <d81ac18d-47ed-02ec-bc37-f5a7e0ab9223@gmail.com>
 <543512d8-91ea-2a49-5423-680860c0ba9f@denx.de>
 <CACUy__X434rmJnX96i057-ir8yiCBjMac_V41HJ+pyG0xLPcRg@mail.gmail.com>
 <dad02a31-ed34-f99a-26c5-60e4a7209057@denx.de>
 <CACUy__XtyDY08KTTMnKoXXKq4oUrNYdRXZOmtuXEmnfD7UveiA@mail.gmail.com>
In-Reply-To: <CACUy__XtyDY08KTTMnKoXXKq4oUrNYdRXZOmtuXEmnfD7UveiA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR14CA0009.namprd14.prod.outlook.com
 (2603:10b6:300:ae::19) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1727;6:dJh0MtNcXWe/lgA+ViymB/WMIY0qF2nMPPfPQ0MlP4bfr20jMFxsNyQLP8SuBfWZzSnU4lp3Xc23jfSmYvFChJMHn9OLOEG753TajsAVWT/5n2YiV0ErUg4ErSr/m6PAdrMX0OXGHGdxw/R7B5SVcNHBkWvyhgMQCdBg1YkuWKa53Xz26yEJQcDdqyQpl3dLLTll6o0JY6gpPoLD0jIj8oIlWAasZlp8Q21V5uF6PobHhnn9DF3l/1A5H8WSTN0b6QLfLi1cL+QMYt6Qg2oRLkn9yNOOCHj44H0RMHFqaiY+SivHxy9qy/zM4r/SQ9FvZcwm4ju3D5+g+tEKoo1igkIEOh9QT+ohsD/24LSytcsu7j9buY5FwLeYgKhwpRc9hz5OpP4K0IyOqQTKc1j9uhc5+lke2q6wqw46fg/wKFkg1taYwnVIEzlBpvJPi5W6FT6c6ijF2DxPIYbKFge2UA==;5:qIhnPcN0sA+xyTftGg96yfJiNVse97FFVK6QZRfyD6A7yjSa+xb4VQ3v4iW7pHRW7WJWI4/WRpoW1ggLShwrCKzpg9YR6lRwH0txiCrygN41nHcwZlEQk+PwNyNjfE/3SJBsHwXTh0lEJwM1G/eJU8n/weDqtYBwJGFhNyJ/Nh4=;7:iP2gwc1qMEc5O+wsxfOET+pjs6CUGW831teAcVfcx3zuk4d7eTOPdh15psvOsaCD+9ZiLJNBo8Q2oh9W16dXGI65Lc/3rh+GbMD4uDJIoj7Qnl5MxcjuXGIx0l7VFk41MU0vrMmSxL8f19QXbPePmQ==
x-ms-office365-filtering-correlation-id: 2b69c0c2-7083-40c6-f84b-08d66133d843
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1727;
x-ms-traffictypediagnostic: MWHPR2201MB1727:
x-microsoft-antispam-prvs: <MWHPR2201MB17275436B8BB13402E91EE7AC1A00@MWHPR2201MB1727.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(93006095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(2016111802025)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1727;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1727;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(346002)(39850400004)(396003)(136003)(376002)(199004)(189003)(6506007)(6436002)(71190400001)(52116002)(6486002)(14454004)(186003)(14444005)(966005)(305945005)(256004)(26005)(102836004)(508600001)(7736002)(386003)(97736004)(33896004)(229853002)(316002)(42882007)(44832011)(33716001)(76176011)(446003)(6116002)(11346002)(58126008)(6512007)(486006)(110136005)(53936002)(476003)(68736007)(81156014)(99286004)(106356001)(9686003)(2906002)(39060400002)(5660300001)(575784001)(25786009)(105586002)(3846002)(4326008)(6246003)(81166006)(8676002)(1076002)(93886005)(6306002)(71200400001)(66066001)(8936002)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1727;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FbMNPJTBqOwQAy96R/BN2vZyQ85t6L6PgJJRC022XmThDDC6y9Y3LvkSTdMz1qHBEFKGxRgtYZe1Hs+iRR1RDu5gBQVLKxpPuv9+PG8zwj/Gz+rqxwq0bQG47pFi1sXY4oCdR3fdVQwpCu7KbGsuBvqxnEa6l04DjpONGoDwt1WYk2z0oRxjkV84szOBQQZIALnDZliwmjPcwGu3J11BbzekLaiSgxFQwRSAUs1TIzezqg0E846jn4n4ZpRj0PKoUrSSGjL1FENIUpxcBXQV8qggHNN68izq2UJ/n3SK5DBMTNs8iAFq6NMCG+gbfsZJ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B6E0533404A31543991A3638E67D7887@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b69c0c2-7083-40c6-f84b-08d66133d843
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 19:47:42.5516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1727
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

On Thu, Dec 13, 2018 at 03:23:39PM +0100, Daniel Schwierzeck wrote:
> > >>>> Finally I found that this line in U-Boot makes Linux break:
> > >>>>
> > >>>> arch/mips/lib/traps.c:
> > >>>>
> > >>>> void trap_init(ulong reloc_addr)
> > >>>>       unsigned long ebase =3D gd->irq_sp;
> > >>>>       ...
> > >>>>       write_c0_ebase(ebase);
> > >>>>
> > >>>> This sets EBase to something like 0x87e9b000 on my system (128MiB)=
.
> > >>>> And Linux then re-uses this value and copies the exceptions handle=
rs
> > >>>> to this address, overwriting random code and leading to an unstabl=
e
> > >>>> system.
> > >>>>
> > >>>> So my questions now is, how should this be handled on the MT7688
> > >>>> platform instead? One way would be to set EBase back to the
> > >>>> original value (0x80000000) before booting into Linux. Another
> > >>>> solution would be to add some Linux code like board_ebase_setup()
> > >>>> to the MT7688 Linux port.
>%
> > > I could also prepare a U-Boot patch to restore the original ebase val=
ue before
> > > handing the control over to the OS.
> >
> > I'm not so sure, if overwriting 0x80000000 (default value of EBase on
> > this SoC) with the exception handler is allowed. Is this address "zero"
> > handled somewhat specific in MIPS Linux? AFAICT, the complete DDR
> > area on my platform (0x8000.0000 - 0x87ff.ffff) is available for Linux.
> > So allocating some memory for this exception handler seems the right
> > way to go to me.
>=20
> maybe that's why some platforms define a load address of 0x80002000 or si=
milar
> to protect this area somehow.

Does this Linux patch help by any chance?

https://git.linux-mips.org/cgit/linux-mti.git/commit/?h=3Deng-v4.20&id=3D39=
e4d339a4540b66e9d9a8ea0da9ee41a21473b4

I'm not sure I remember why I didn't get that upstreamed yet, I probably
wanted to research what other systems were doing... Speaking for Malta,
the kernel's board support has reserved the start of kseg0 for longer
than I've been involved.

An alternative would be for Linux to allocate a page for use with the
exception vectors using memblock, and ignore the EBase value U-Boot left
us with. But just marking the area U-Boot used as reserved ought to do
the trick, and has the advantage of ensuring U-Boot's vectors don't get
overwritten before Linux sets up its own which sometimes allows U-Boot
to provide some useful output.

Thanks,
    Paul
