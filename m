Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2018 23:12:07 +0100 (CET)
Received: from mail-eopbgr700126.outbound.protection.outlook.com ([40.107.70.126]:31424
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990509AbeKTWLMmALt2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Nov 2018 23:11:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NipOHzuP7wtCy/XeSnkj6QvsO0SClDvyKOK7bUZuBbk=;
 b=EOr7rEFWXJISmAtlvDcRQCmaDlgtwAaeG5oGRHASI1rlMgUxSqOe5iDa1/I+/eHRhiIkCbNubU3nzf+KSsDLH4PO/LFZsBjMprWQD7Y+G5SaUdo1rxwq9FXuT8xnsQ7PYE8siDC3nSKoNKwrlsmbu5qTP1DgSGM4GlQ7gMYNdBo=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1584.namprd22.prod.outlook.com (10.174.167.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 20 Nov 2018 22:11:09 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105%6]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 22:11:09 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        "# 3 . 15+" <stable@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH V5 2/8] MIPS: c-r4k: Add r4k_blast_scache_node for
 Loongson-3
Thread-Topic: [PATCH V5 2/8] MIPS: c-r4k: Add r4k_blast_scache_node for
 Loongson-3
Thread-Index: AQHUgR3wOE799bhqNE+kGJXyKsTAwg==
Date:   Tue, 20 Nov 2018 22:11:08 +0000
Message-ID: <MWHPR2201MB1277A98E71BB648FFCAD3232C1D90@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <1542268439-4146-3-git-send-email-chenhc@lemote.com>
In-Reply-To: <1542268439-4146-3-git-send-email-chenhc@lemote.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR0201CA0022.namprd02.prod.outlook.com
 (2603:10b6:301:74::35) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1584;6:fMpSQt26bwuT2MIt1Rf33C1KhuOQF1kGEw5Dq8Yj8UTm2Vr/8YHHFzhHKTEb4PIUgiadESRICHpA24UVH7WeulUCr/Xgg9qnbeIu19Ka5VEScJC4DI5Rk4IUEP+Kqfz5uOeclQHoV16RQLUSEaC9HcPSfOyspvuk1GD2pQLhLk0OZwK4EBprxl1Q71FRNgdU78asL2Dv1NcMh4oFpJZNt0ev7ve/9PiOATzXOCqBVpnuj+Cq/v5xtBXcRfkgGDvTZW/eirIRR4uPdFqMko+ZUhb/HqCI2DAaqTpLcitHbj5yH3Gdi54R+mrNfo77IcOW+ml5N+ZkPJYgaaq9I18t4rW1oJFXrWrfJU1WZKjxcVzSlI81xi4YefmQlqaiCT4ZvOEPqXaAhafd7IDJByNXjOGQNhwR0F5lIuiBV5zDmA5teNa6UI5Z5a7vet7LG4g0lV9RqKvfyxOJE1O4hdHnOw==;5:fxMLeHrGFSnw02lZ+T/NxVPv5B8LzcRjI6+oxzEMMSlOox66yugiOu9Fyoz3+2wqK1Nf6gB7opr959UzpGcWo6+aLXU9mSe4pE5dCbXL5hNMPNailvb4jWYSmB7gwcfeYcBD1wTdb81aJfBbdH0QMH42l2t9y7zohrPgQiB5Kkc=;7:RPt45UBmlyWGil44JFmH+ugfmHfP1ykxSJ1nCC8VD7htOzxOJa8f4GVvymuegryU84rhzKTgGIlDiLKusy0JWZGV2l6HyNt0bKXnKAA570TYkleMXQOkI3YyvUpwwINwRJcIKdXDr6zU+i4niBPwcQ==
x-ms-office365-filtering-correlation-id: b43f34d9-6acf-4607-1cc9-08d64f35125a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1584;
x-ms-traffictypediagnostic: MWHPR2201MB1584:
x-microsoft-antispam-prvs: <MWHPR2201MB1584C783F84FAD6015B02616C1D90@MWHPR2201MB1584.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(93006095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1584;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1584;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39840400004)(366004)(189003)(199004)(6116002)(102836004)(5660300001)(2906002)(386003)(6506007)(97736004)(508600001)(66066001)(26005)(25786009)(99286004)(4326008)(7736002)(305945005)(74316002)(7696005)(76176011)(52116002)(71190400001)(71200400001)(33656002)(106356001)(105586002)(186003)(316002)(256004)(44832011)(39060400002)(54906003)(42882007)(446003)(11346002)(476003)(486006)(6436002)(8936002)(8676002)(81156014)(81166006)(14454004)(68736007)(53936002)(9686003)(55016002)(6246003)(229853002)(2900100001)(3846002)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1584;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: I17ANSdY+AOQ9UUWzIJX5wJfFsdMtAe5qolMtU0gkSelgPYsVyUxGh+DK6YcL99mvYKBbtJwmU+Ezw6RiiusRjwsDBLK1g/XCUzIEBLPDaQ2GgF1OcQHkkNJ3InJuia7kDRK3p824kM388l6crqW7BbQzNIy0EtOCL6D+dmwfbZykHOSxQK7WLTC+N/XPIMv2fEiOEJ2ydCutlUnqhBC4mZZY2eEU6v3fFuV9vwmgaJm+ciRHjDIWAPH+QIuFoXvR51bR9E2h8fzyljNvKL/g2JW+EojBpVlFV74RJeiA1XKJtGRqGvtvN2WqtF9ONmy961rOM5A0YYEmV998kjY+ZIAr6+Rby8nEoIaMAjJYA4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b43f34d9-6acf-4607-1cc9-08d64f35125a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 22:11:08.9929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1584
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67410
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

Hello,

Huacai Chen wrote:
> For multi-node Loongson-3 (NUMA configuration), r4k_blast_scache() can
> only flush Node-0's scache. So we add r4k_blast_scache_node() by using
> (CAC_BASE | (node_id << NODE_ADDRSPACE_SHIFT)) instead of CKSEG0 as the
> start address.
> 
> Cc: <stable@vger.kernel.org> # 3.15+
> Signed-off-by: Huacai Chen <chenhc@lemote.com>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
