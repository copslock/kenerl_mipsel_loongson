Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Nov 2018 20:46:09 +0100 (CET)
Received: from mail-eopbgr780120.outbound.protection.outlook.com ([40.107.78.120]:15450
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993840AbeKUTp6TFN2e convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Nov 2018 20:45:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWkvJQbIhorjLQqxD5SOKS1mSUyFdmHff425N3CIyT0=;
 b=D1Sb+13g3goV2vy/b8bQtxOF30aeX4I+0yz+qUKQr1dnEsxhZLiGzOkARlKjaLaSIbq7gEr4GMfv/aDcaatHTHASlKj+sNk1KD0/BcLKPhk0XBDQ/zxRG54CCQntVgyu882C0CsZ603/2hH31LhYDNC7bs5hWyGQhhXirIywIHs=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1054.namprd22.prod.outlook.com (10.174.169.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.31; Wed, 21 Nov 2018 19:45:51 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::690f:b86d:7c2:e105%6]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 19:45:51 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
CC:     Andy Lutomirski <luto@kernel.org>, Eric Paris <eparis@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "uclinux-h8-devel@lists.sourceforge.jp" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 16/15 v2] syscall_get_arch: add "struct task_struct *"
 argument
Thread-Topic: [PATCH v2 16/15 v2] syscall_get_arch: add "struct task_struct *"
 argument
Thread-Index: AQHUgdFVNht9C6cLakeqWf7v58LJOqVaofiA
Date:   Wed, 21 Nov 2018 19:45:51 +0000
Message-ID: <20181121194549.4glznckje73z2uxk@pburton-laptop>
References: <20181107042751.3b519062@akathisia>
 <CALCETrV1v-DPRfDRwiH=xn29bxWxiHdZtAH1nw=dsmDtnT0YGQ@mail.gmail.com>
 <20181120001128.GA11300@altlinux.org> <20181121004422.GA29053@altlinux.org>
 <20181121184004.jro532jopnbmru2m@pburton-laptop>
 <20181121190009.GA10301@altlinux.org> <20181121193512.GA11297@altlinux.org>
In-Reply-To: <20181121193512.GA11297@altlinux.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1401CA0002.namprd14.prod.outlook.com
 (2603:10b6:301:4b::12) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1054;6:iefVsIiWh3uSZ2Iht040SAjaQCtvchxT03wgPvh+VpGX1p3R3M6+3gJ3Hwtdu7YcJKw9PyRr8gQIk9mHGTMTzV6a0IcNPM00sUAsExcuo7uDmKFRjpAQdFgBZcChE1RRQV9vaCJiK1IZXBbphlY+esioMe/wGR5RSel9WwpVTVfvZNCH8cQve75J5ZIfxWm9NfCbE1tqoGH4VPNl0hChacriOFT41p2gvHVTvEJVLjKVrCMyisIQj/eyAukWS9c3jw1njeqKRWKOWeyhB6ukoxNn5GTSaZLmyc8hren3fYi8T871H/FxJ9n5bURg/73zDuY75TgzNE9p+sraTEFqVZ28jMrcraQBC5KdBXqVXShlJ4ZV7y7LIeKDRcKnGTp7NK735Wksiw/FFy5mXD9JHr6FewBxqFHsjWmrfKqTayq49Z7anaAR0+KAGylHU3bahQFOr3Z2GYI7arhkJ/nBAQ==;5:VlvW9W3grT5+p8yxno+MzGJblhCfWx7Okt26ECM4e2cLqr807DLbCLViPwMI1L2hi7WUCNYUBSjFukQ1xvmPFXJqt5pHT033H+x4KOLm0nE8Sd0u8ZFP4EZ6TpwvKK3O/pexdeAV0BxWk+FptLXaiSbQV4cBaxdPO5aT28AB+ac=;7:xkfgEy3twUi7UxOk2pOtmgmzIvDV1hPoLLl2uwb8BglgW7hDDdJZ9u6tWW7of4UqC72r8CsNGUebv7W8Po6TwXCzjSdeTpCfzKhheybyD1NmqOFrArGPChMS2RnZKIRR9gOPWyieZ5SvlBl2OdEgAA==
x-ms-office365-filtering-correlation-id: 5ad994e2-1dd3-4947-a468-08d64fe9f0fe
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1054;
x-ms-traffictypediagnostic: MWHPR2201MB1054:
x-microsoft-antispam-prvs: <MWHPR2201MB10549F70E8677210F41C11F1C1DA0@MWHPR2201MB1054.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335)(65623756079841)(197064567915663);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(3231442)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1054;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1054;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(39840400004)(396003)(136003)(346002)(376002)(189003)(199004)(52314003)(3846002)(1076002)(6116002)(53936002)(71190400001)(71200400001)(8936002)(81166006)(81156014)(54906003)(2900100001)(8676002)(33896004)(58126008)(7736002)(44832011)(476003)(11346002)(7416002)(7406005)(6486002)(14454004)(2906002)(6436002)(68736007)(5660300001)(229853002)(6512007)(9686003)(508600001)(6916009)(6506007)(386003)(102836004)(6246003)(256004)(14444005)(305945005)(97736004)(26005)(66066001)(111086002)(33716001)(105586002)(76176011)(42882007)(52116002)(4326008)(486006)(99286004)(316002)(25786009)(93886005)(106356001)(446003)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1054;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TnJ/L4eKAimvBE9ftH/a91H2VNANF6dEdMp7boUv+FixxuPeKRiVZWlMLr3BvCFisnZYsgVVV5RN4WavQtyGmktvXjfkdyv6ju1ceUxE0mZk5aMouRezI9yHpQ37N9grPRaJWLm9urjsCobOj7RQsTolRkr0sDtd2JlxC7pmTDrIZG+c5zu6nU3qJVznF2oa9GPWQ9BOQlvf3CLOGC9z85AAwQyQpiGSmTiKUhE7kH155Zf3vpqRKmvoNgvE3YgWD/ICcFuSvcbFjHd+9RcpeV58NRwxXXINverEBDuwBDPr2B0tpPxWkFM4o1G8wGiYyRSO9hmJ30gAQe4aKPP6ZxrcMM5FZLiSp/9xM3l8YDk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <708ADDE084183B41A3B884270BF84771@namprd22.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad994e2-1dd3-4947-a468-08d64fe9f0fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 19:45:51.5163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1054
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67427
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

Hi Dmitry,

On Wed, Nov 21, 2018 at 10:35:12PM +0300, Dmitry V. Levin wrote:
> This argument is required to extend the generic ptrace API with
> PTRACE_GET_SYSCALL_INFO request: syscall_get_arch() is going to be
> called from ptrace_request() along with other syscall_get_* functions
> with a tracee as their argument.
> 
> This change partially reverts commit 5e937a9ae913 ("syscall_get_arch:
> remove useless function arguments").
> 
> Reviewed-by: Andy Lutomirski <luto@kernel.org> # for x86
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> Cc: linux-audit@redhat.com
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-c6x-dev@linux-c6x.org
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-ia64@vger.kernel.org
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-um@lists.infradead.org
> Cc: linux-xtensa@linux-xtensa.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: nios2-dev@lists.rocketboards.org
> Cc: openrisc@lists.librecores.org
> Cc: sparclinux@vger.kernel.org
> Cc: uclinux-h8-devel@lists.sourceforge.jp
> Cc: x86@kernel.org
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
> 
> v2: cleaned up mips part, added Reviewed-by

I thought the last one was v2? :)

Anyway, this looks fine to me now:

    Acked-by: Paul Burton <paul.burton@mips.com> # MIPS parts

Thanks,
    Paul
