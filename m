Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2018 17:52:16 +0100 (CET)
Received: from mail-eopbgr730105.outbound.protection.outlook.com ([40.107.73.105]:27168
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993945AbeJ3QwLDs3Tg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Oct 2018 17:52:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLYMVodelq1B1QQLdn60/8zhQDxyM9FKxAOqyuaYSHI=;
 b=QxXIUqpN/6/J9IAo3vi37iY5ZerpXBEuhACLfCtOyHlHrhy3U6Vq937eEwnhV/94pVqanhHCin3gF7CzFLs+Jaighhow482eYM36VEL+tIrATuRGwL1bG1LeQeCjHjyuGLcCGvmGecrYkP63EFx2mIz/ri9fXtIiwHIo/D8+0Ds=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.216.146) by
 CY4PR2201MB1240.namprd22.prod.outlook.com (10.171.216.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.19; Tue, 30 Oct 2018 16:51:58 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::ace0:f12e:c2a0:dc23%8]) with mapi id 15.20.1273.027; Tue, 30 Oct 2018
 16:51:58 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 1/2] kbuild: replace cc-name test with
 CONFIG_CC_IS_CLANG
Thread-Topic: [PATCH v2 1/2] kbuild: replace cc-name test with
 CONFIG_CC_IS_CLANG
Thread-Index: AQHUcFRQUdRvUBuRmUqUi+ZWeLGgeaU4ARIA
Date:   Tue, 30 Oct 2018 16:51:58 +0000
Message-ID: <20181030165156.k6blbpbxh2fmiiay@pburton-laptop>
References: <1540905994-6073-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1540905994-6073-1-git-send-email-yamada.masahiro@socionext.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR04CA0107.namprd04.prod.outlook.com
 (2603:10b6:301:3a::48) To CY4PR2201MB1272.namprd22.prod.outlook.com
 (2603:10b6:910:61::18)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2201MB1240;6:F4JLfAh/UD/LNIAd4rfY5JLYnnGwCcpEfiZq5TkDdJXZT3Fxg4a67Fu6dmd5SvTwj66HYyq9IluLkW2yQvdtB5A/nt7AFSqyBAGMcdmiwS7E8+TNzyE4rPfjomO27grMG60+s0CgKNmHbwq9+c5BRUAYujjIxmQr5L7BirMEEv+IqmoZeXgzSIzjNw6/ACHMafScID9Yw8fgfUg1ZoPTQN25Hj7jaLC93pYQvjVT9B1GEhpQJVP4xtB5QkZ9OiNaZPxqYaAAR9Opgj6RZthR3pWdMpkSXLkGAc6LjbpZMjeEuD33jgWdg+u5IfhLsCueeq9T46dAPfv6WS8QZtczmYoAjoaFzGXeA/Ab4O+ajP5MVEyo5ZDmBx9Rf4M7m7tIdmM8Zgmksn4WFalHFSTeR2wKyvk9vcpXrihpWGXiqFn8QR8c6rTNMOQwijsIeNQCseej1A+7ahPtD97w7Tyx9g==;5:ckx+K/wgd8rzs3HzdXZXUdL302esZEQ/LQsW8ST4EoElBXh9Xaan+N1Ma5FCyAdTBtEodicxwy5g9gHbCBykwjhEnGQi8zUvC/BR+FJ7RsreRaS5p4WO1a1o9oFMPYL5eujYbXG37w3NVmbsbx7ZdMJA9lrLY5o58CqBuY7IOTw=;7:EKNHjsQ2tDCoGS9w3w+hWtSvPehNm18C5/AVpiPdoXCxQNeTXHSFUErZk9rGsHenoAhXKxFXlqXixrbNM3hzISttIT9xsO8y6fGDR3kn4xYcDbPaY6Jtl88P/Z2aEAywyg6y9wcJJCTOuFqldn6+gw==
x-ms-office365-filtering-correlation-id: fa5bde02-1166-4956-0ac2-08d63e880185
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR2201MB1240;
x-ms-traffictypediagnostic: CY4PR2201MB1240:
x-microsoft-antispam-prvs: <CY4PR2201MB1240CE01CFA3381E3A09A603C1CC0@CY4PR2201MB1240.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(2016111802025)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:CY4PR2201MB1240;BCL:0;PCL:0;RULEID:;SRVR:CY4PR2201MB1240;
x-forefront-prvs: 08417837C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(39840400004)(396003)(366004)(346002)(136003)(199004)(189003)(66066001)(1076002)(5250100002)(6486002)(6436002)(229853002)(6916009)(2906002)(5660300001)(7416002)(3846002)(6116002)(305945005)(7736002)(316002)(8676002)(58126008)(54906003)(81156014)(81166006)(256004)(97736004)(2900100001)(14454004)(68736007)(25786009)(33716001)(71200400001)(71190400001)(6512007)(8936002)(508600001)(44832011)(476003)(486006)(11346002)(186003)(26005)(99286004)(76176011)(102836004)(105586002)(33896004)(386003)(446003)(9686003)(52116002)(6506007)(4326008)(106356001)(6246003)(42882007)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1240;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MKMc9vEn0n75NPpSLBhshB3W4Q9Dxquj5glw9vSdzn2TtYE/VfvUv3nKi2sKUo5/kqwlx3XhUnFrDRCdrKDPqbTtCDusXeB0M5esVLIt/WePHJRq10cb7zHRcc9XqC6yKEINKPlpbpXK99yUuYFshp9gombpUAYHd+Bnj94+SSzqpHGnNdLv45L+2XHKIbptq24WrR0cyqautJoQBQ+F6hL1CHsaTIFgiXEoaxqFpNoy1hHWJgxd+nr1FDnMWxOiRogCmIWAKsDgRBw/R4ReO7Mr6rkf3iARkwXRResH804jaBdf4WxgLVUox+7GtueuwBNiJEEIJI5z5AyrkgyrTfceV0XALMgdCQlts/s9Fzc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <256788EA86DFB442B581ECDC903CFAAF@namprd22.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5bde02-1166-4956-0ac2-08d63e880185
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2018 16:51:58.6474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1240
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66993
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

Hi Masahiro,

On Tue, Oct 30, 2018 at 10:26:33PM +0900, Masahiro Yamada wrote:
> Evaluating cc-name invokes the compiler every time even when you are
> not compiling anything, like 'make help'. This is not efficient.
> 
> The compiler type has been already detected in the Kconfig stage.
> Use CONFIG_CC_IS_CLANG, instead.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Looks good to me:

    Acked-by: Paul Burton <paul.burton@mips.com> (MIPS)

Thanks,
    Paul
