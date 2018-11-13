Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2018 23:22:10 +0100 (CET)
Received: from mail-eopbgr680093.outbound.protection.outlook.com ([40.107.68.93]:6162
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993032AbeKMWUHe2w0u convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Nov 2018 23:20:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+und/gTnklCaJODk/cyX5YEAUE7LKbD8z6ukZ0uHgk=;
 b=PZ0vXmI1BJM5AqsdheYyYpL6LhGOWZOmZE/LE/Xr85hXiS/xAsxwfopWgYygvoY6f9UlGY7Z2tr1gYisB0qveiovjWwjOx2/7d9gxomHt1oKBbgUDUAHz6BlmJkB7JAokAe5eXgd27ILmSElaO12fVo3melKxj0c6wG+jAmJGfM=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.216.146) by
 CY4PR2201MB1750.namprd22.prod.outlook.com (10.165.89.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.21; Tue, 13 Nov 2018 22:20:05 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23%9]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 22:20:05 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Let early memblock_alloc*() allocate memories
 bottom-up
Thread-Topic: [PATCH] MIPS: Let early memblock_alloc*() allocate memories
 bottom-up
Thread-Index: AQHUe58H8pk+UODci0+f9Jku+HeIDw==
Date:   Tue, 13 Nov 2018 22:20:05 +0000
Message-ID: <CY4PR2201MB1272584D86653816B828DC3BC1C20@CY4PR2201MB1272.namprd22.prod.outlook.com>
References: <1541821814-7738-1-git-send-email-chenhc@lemote.com>
In-Reply-To: <1541821814-7738-1-git-send-email-chenhc@lemote.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MW2PR16CA0004.namprd16.prod.outlook.com (2603:10b6:907::17)
 To CY4PR2201MB1272.namprd22.prod.outlook.com (2603:10b6:910:61::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2201MB1750;6:CYcua/tdFu3qiVI6zBU7VhCgyRk01NZJWzDi461EIq4PM3O47fyYiEuufN2pyIg4VJr7ykDzBTZlK3kaxZSO0nF5ztEPQZD8Dkcq0la56UNg+QhL7dqINzBaNrmF0Ry4EURa7381iLhtLQulL0bR3bAUuYRJX/i1xbRoWT1bU+DzB+fv2xSAFBKw9kDrmbfx5XUopyQjSfDgLtH7pXcMc1Ss+YOVunuIFUU2iRGhrY3SLkSceN5zXBbo9g3FX1AAhdmqFhk/abpnAFY+jH0ruAcJ2k0VMsRtnvcYo7xYWpo5sl5PhaF2wlF5D2M9RFLEpLX271rGkgFX4CKW8Cm1I3e4yZE1FY+VYvYO6gl4BjC/pnMORxJiSgxVQ06l8BOCbhLLG04jPtSwRwGsmxr6KCgsq5jjIqXghs+A5XPJ/+sJKgbswCGSL8xdkNEQGJaczAW3fUQMaJNSP9VDV500DA==;5:S9EBhpBo0RrKOOo07PsQY0b+CoW6VoPS5CMd0clnd6aVLoz7z4Zw+sbLioVgT9Dvgt9s6t2/RrRzUigPC1LtYigCUvhXkkA23pLor3x8pERpYi/IBg9mc+OR8FuUjl90VNOtWDMD2MeT0IRAi+MYBwbZCLtPIIUMeBv3CUNXBus=;7:qv5tlkFVdv4hBZE8pBNK914iWpKgPln6FbuiFNzMnOwtpPv1rKed2dQK68fwrzgWzaxji/68ZP81QLodE3t1loQ0gQ0uLaNkEzBoS/fYDHO7nE6eBcyAn55cgdk+8V1u3b4WrqKk0bzXQx/MTGbMtA==
x-ms-office365-filtering-correlation-id: 272cfad9-cbf2-4850-6fae-08d649b629be
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:CY4PR2201MB1750;
x-ms-traffictypediagnostic: CY4PR2201MB1750:
x-microsoft-antispam-prvs: <CY4PR2201MB1750D48B83B333A58A1941D3C1C20@CY4PR2201MB1750.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(3231410)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(2016111802025)(20161123558120)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);SRVR:CY4PR2201MB1750;BCL:0;PCL:0;RULEID:;SRVR:CY4PR2201MB1750;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39840400004)(136003)(396003)(346002)(366004)(199004)(189003)(71190400001)(6306002)(97736004)(6246003)(55016002)(305945005)(71200400001)(7736002)(2900100001)(256004)(39060400002)(54906003)(102836004)(9686003)(386003)(6506007)(508600001)(966005)(14454004)(42882007)(74316002)(53936002)(4326008)(6436002)(186003)(26005)(316002)(81166006)(5660300001)(8936002)(229853002)(105586002)(6916009)(2906002)(486006)(25786009)(81156014)(6116002)(8676002)(106356001)(66066001)(446003)(68736007)(3846002)(476003)(11346002)(76176011)(44832011)(33656002)(99286004)(52116002)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1750;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: v+h0Ypied4rtdy7xAQVKVhO1I1vZeub9mepSoVa17lZ2ZPylGkMqzQTk3wPJfu2LbQpM6XqcYwevrIpsGedd1SvcCyhaaNUM+wfLt+DYTykiHCImWJJKw3AVVU1QeOD2i7mtlSKeEh7UQo2F5HAkyyqs1h0VpRQ2uoDeeaUKTCfIiXQLw9vytEwELW3XaLVpauJNIsVtz8lcOlnCAn/nS9pT+rk8hflr5kJlM2dBfc5f43SpZ8DXA+H6StSgVbiQo8MNBf22jg1ScCOe82O6gqumXf8nqItRW2ouUem9G5apLgMBUcWI+TmjPL8NCj8tJj94q4W4UHOWC+39CLaCwWK3mBvoihvRiBOGth5Vxbc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 272cfad9-cbf2-4850-6fae-08d649b629be
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 22:20:05.6388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1750
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67260
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
> After switched to NO_BOOTMEM, there are several boot failures. Some of
> them have been fixed and some of them haven't. I find that many of them
> are because of memory allocations are top-down, while the old behavior
> is bottom-up. This patch let early memblock_alloc*() allocate memories
> bottom-up to avoid some potential problems.
> 
> References: https://patchwork.linux-mips.org/patch/21031/
> Signed-off-by: Huacai Chen <chenhc@lemote.com>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
