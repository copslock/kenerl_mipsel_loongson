Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2018 23:46:15 +0200 (CEST)
Received: from mail-eopbgr700129.outbound.protection.outlook.com ([40.107.70.129]:11117
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994648AbeIFVqKuSZZw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Sep 2018 23:46:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iq7aLInTaoxLEymncABM4N3q5G0iO/9iWmk9tXEdjXc=;
 b=B8g0q6TS3Us6W3ikAdsrlbMoTuVYGNaM95PMxfNQAYbqwikiGL1hCeGLVVqmrLgFX2MKM8OBMUaQ1VZPXE4ly/sQJewYqTbR+HSty+FGutsCHcHXrJ9nVRWAZ6iQxSDXTOh84q/jMc2kFMEUALhJ3bo71KFnEy45Ye3Wo1uAeKA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BN7PR08MB4929.namprd08.prod.outlook.com (2603:10b6:408:28::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.13; Thu, 6 Sep 2018 21:45:53 +0000
Date:   Thu, 6 Sep 2018 14:45:49 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Russell King <linux@armlinux.org.uk>,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Jinbum Park <jinb.park7@gmail.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Stefan Agner <stefan@agner.ch>, Eric Anholt <eric@anholt.net>,
        Simon Horman <horms+renesas@verge.net.au>,
        Tony Lindgren <tony@atomide.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Olof Johansson <olof@lixom.net>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Dirk Hohndel (VMware)" <dirk@hohndel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Justin Chen <justinpopo6@gmail.com>,
        Markus Mayer <markus.mayer@broadcom.com>,
        Gareth Powell <gpowell@broadcom.com>,
        Doug Berger <opendmb@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 07/12] PCI/MSI: enable PCI_MSI_IRQ_DOMAIN support for
 MIPS
Message-ID: <20180906214549.y4xpleiukzw5rmqs@pburton-laptop>
References: <1536266581-7308-1-git-send-email-jim2101024@gmail.com>
 <1536266581-7308-8-git-send-email-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536266581-7308-8-git-send-email-jim2101024@gmail.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR2201CA0066.namprd22.prod.outlook.com
 (2603:10b6:301:5e::19) To BN7PR08MB4929.namprd08.prod.outlook.com
 (2603:10b6:408:28::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 719efe19-a922-493d-9d1c-08d614421eb0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4929;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;3:Weu/PSx89DoMJQ9TEtvq2Jes5bfSHFdtuLkr4Ly/6WfpnBLT7MiPQY4j/pXL77QjjB4hdgI5qzj62ZqDY4buneQ8Sc+23O3woLgBggZE4YRCQgr5L2kBO35qA1CqrPxuq/KigiL6ItP16ibpv9nu6crmhi9/kx2vdrff4lsyaYENqJOtldYFkI48LPI0zuHHGf2NPx0q8cMmFFC2/2V4s4mkKthhFTHqmGnvRQ5Q+YnvrESzlLjDNEUDVAL2fD5M;25:eQ/oI6FoirQPRO3kWHJYpG78/5g4a9kpk9I/tX8Ml59JiR6oX1wHe0ZfdBkVwED+d1x5nZOv88RPJGnEiMIVs9M/AD5HM7nY9E/oVrGhVi9i9TuEFXw9Na57nPLr5uHBCFD+aY9ix8hI9mHDp0tcrb4fvaZEmfDWoUPt4Mmfg+qU17doX5sdWP5RjmeKx6kwKSIybg6Z//Kq/CJJhadAye5HyWlA4zKfnDkipCOe2dRt2r22hT5C24+vn95bqhKGMVXjJvyqGJlJVYoiz2MuSnuo6zk8KzeDocp5VRcjkwD2RWzv6IV3DjuYyCQ5zuAZDrbm8945idO2fArGHRqikw==;31:H65x81sOIsSTSdVoP9/72VPQbPr4+PwzJFaPFoNpE8/ZwrPFioxEugHrLGLyDx7HAua0IFtdk08CKm6szllVo+YK+8SCLbpi/qPQoSxN8MbGiPH6i01kf9fQ0rHUcfo3HmdPJW6gcchWQagrpmajnUNSvC07BrnoE2be3waoCLmxyIV+lIbAKnWv8iVPfJdX2c1l5fAuQjI7EzrZRaIg1zr+IZQPJRKpi/IyISRM5Kw=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4929:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;20:uvq+3ENIktuQtZPkxIZXB/BEyDGT2DfQYFN7TDLid4Nju69EL1gPL/dDAEB+csAf0Qvri9lnUFIBZ6pp8NTShfA5WnDHtmQV7guA9OLCOF6NRk6txcRMRIkYL1e6N17e52VgGHTQN3DQ06hepXvO2KhyorZFcj/f29HS9OMCANzDmHX+Ixchb3ppwhJw1BC/5CwuiiXR7Bvn0xekvbPAVZHMRquzQZ0jnO9zTtgF1AjyhddRbRG6+RGGo3Iq+NKk;4:NVU084CT8iNhFsB4boDqM8jiiPjNoQ73tmEVTi8AAadfDeu0wqf5G+GhgTieaCYJ4Ck4MYx+bOZOMeSOwnD8M0iXt3lNJFqPLwZIwadjzrwGNeoNYiZC9vqNxsCH9tiXdt7m2pT0/fcgLSJ/A56xafFzkbCGMGJznJgB5QB94yXreTisiP/pgNNN44NQLIMl0s9gGFyVWfrtaLaiw2kS5V7x/xk0uSw8RgQ5T4ngq2WgbtqHQ7nY3cXJ7Jnq3Pb5W+pqJN69iMCLhVhh8eQIfPcgjttQIff8obWv+XRaPMbyPZVeG6b0CDxfErPKLxQQ
X-Microsoft-Antispam-PRVS: <BN7PR08MB492910265EE903176527DC8EC1010@BN7PR08MB4929.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:BN7PR08MB4929;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4929;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(376002)(366004)(346002)(136003)(396003)(39840400004)(199004)(189003)(2906002)(42882007)(8676002)(105586002)(6496006)(476003)(446003)(7736002)(956004)(305945005)(11346002)(52116002)(186003)(76176011)(33896004)(386003)(26005)(478600001)(6486002)(76506005)(229853002)(50466002)(16526019)(81156014)(9686003)(106356001)(7366002)(486006)(44832011)(7406005)(7416002)(8936002)(23726003)(1076002)(3846002)(81166006)(6116002)(16586007)(33716001)(58126008)(4326008)(316002)(47776003)(1411001)(54906003)(66066001)(25786009)(68736007)(5660300001)(53936002)(6916009)(39060400002)(97736004)(6666003)(14444005)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4929;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4929;23:4zyd470GQSYKtGJVa3g2gsVr4ChZ8O+RrkvvaxevI?=
 =?us-ascii?Q?k3ttrhMQwEqWD0GLPUlOr0vjbj0bqixqsY1JS49VDn5KdRT4yB4B6pcLVtxd?=
 =?us-ascii?Q?f41pnQAp+Z+RXSQDuWJ3NyCldhfrjiiNRi1r67zkdf7HMR/dBLxQc03DxTO7?=
 =?us-ascii?Q?o0qzgSfxsh9P3OB0R0oYCxAAlV4bcCVPX+dvZAFSEyxOX+GpsGiTsvgUKfC5?=
 =?us-ascii?Q?/GJahwBuh78KHSHco5pRe+0WebVzLyDRbQTcDpvEG7lasTwZ0sJncuk3Kk1O?=
 =?us-ascii?Q?SkLihvw4O7JsAnKLhW1ZwVZ8SbuyCoap4Tsnr78Xr23sgdscWHVdNkpPAKKf?=
 =?us-ascii?Q?vCuSAJyCvcmkJHE7eXRajyQALeb4QrQJuUoEM/tKhmVbBaqdlETLp36wSQlm?=
 =?us-ascii?Q?JtKesYvHCwmk12+hPI8G9CWK0+XASqmW1o03AUiI5SU4d7XgCYUuS0Nb9J3K?=
 =?us-ascii?Q?+JwuJZQ41GEiYEL0bY6LbQVr0cFNXcOIUrzZbv7gOkG4OdoYnkjal5RrSlfs?=
 =?us-ascii?Q?HO7M7sPgDNmowuF0gRD7E+ajEbGu5tNoXTo++Q9lbPADEDNCggHyIdb4Bi/y?=
 =?us-ascii?Q?MzsCqdb9/a3Hx1T9NzUSXf2tw9kkVOv0Psiv8z53Z87OyjPccGYfc2nO9Qc+?=
 =?us-ascii?Q?5pyQOmzdihj4GgaBEz3O4V+X1I1U8VNYDmTnjS63sL1pis6gFMv1e1Iu260c?=
 =?us-ascii?Q?ma/jAXcVYdQTbtOsjcYJyA5ZOdFU/jVxz2FyK3puGG2OHNvKsPjamVIeHEXL?=
 =?us-ascii?Q?X6pSM9w6zuTLrehn0066OQ+cK136brjf/pY7jXTHFUwD8RW/dcPtdOkYdzb1?=
 =?us-ascii?Q?ncr8XbwNbaZlg8Ac2r9TARYq0Ya18HGSf0lUSbGkAnlNezHRANN5dsxWvBpa?=
 =?us-ascii?Q?xyaW+mKV0qP0aCLqQZyk67FJtqa52lp1awqEFCok343zf/sn9jIvDaaxXO1I?=
 =?us-ascii?Q?5rHk/ftDwRxyomQ39nPVdI9YZT4fIyyEV/hIrvgThe10BqJ7LVMl1UWLRfyt?=
 =?us-ascii?Q?tseEjJrbJmpIZdTnN2IdqXv9Q9/C7D+vtB5m87vnnPeOw1q+FT9/GaDC4YCk?=
 =?us-ascii?Q?JUoaEYRm3gM8sptfNAI7OjAVT8gg7hvKqxub0bkCSJjKz03LFKoWrud/MqFR?=
 =?us-ascii?Q?bCzvIHujFOyhzndhFlPQ7ewzHQg/Zs4V1zL9cNM+hmepOR8q2eGYFuxGLD3l?=
 =?us-ascii?Q?rM9F6FqetwVlcr5288hOJwFn4w9r7j9nqoE3fxUAHuVGiG5dkeCcDhAQ8U8J?=
 =?us-ascii?Q?kFju8sMwWhNrgGwrnFi84oH4Hxn1wCCaWjwAouLS6SgRkhXEi1L8MBXYljrt?=
 =?us-ascii?Q?DZHiO0NFZPhOgsxOgCvsO9vovYtuK1sH+LKtfbt46mht/7RpbFjH38JNJKyJ?=
 =?us-ascii?Q?qtQKujVCUWtvaNDLL2h4VE/B6WuqFgV1fMxUweil3Z3C6qGD4NFvjXWF83JJ?=
 =?us-ascii?Q?D2tDT5TYA=3D=3D?=
X-Microsoft-Antispam-Message-Info: o1Qe1zJi6nEem/MEfSkYJcQchoy9ql7thv4YMYBgtX9tPiMTliCXTF3PZ7Ac0F6VbY8qoKaYFgBaQwQgQFJnWfm53+pb75h69r7LQGCd+cxM60wozUjdCzQ7cjmF5eXJHTgY5EBOee2D4YxXGyRn4fQZJvajhjSIhNbm6wewnU4QO0NPVi7pIXsKexTPTO+jHNI6Yy+kQTs4KzKpLBiuXPqhFjS+vuBuMMBiPXCDAPpll9gioZyNbef/DGlefTPVeKfFmUJYmkEJVmL+cu353siZYlPPKP5gFMSjIu8z4bWlV6Hs66oDTboarbXYBhN+PakjYP1dpQU2niiUXFz1KQo5PHvdWHwSj99A470KKD0=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;6:blTGbEWbH4yEBdNVQWAsmWpT/vJdpq0bphqfhpdlx3Oswun1CQZjBlyF5Y3q27LdwjD12ihHZe1Wye5fh8YsnEAJLnJnz1WLorreqMmHoVoa1k7svTaWeLhWTvP1Rs9QBTNaAYD6qC60udiobM0Nhdp3OOVp2Aiqqad9u5qAWLXVmdlnz4t5kTQduFqBCaXQbdymBYMR9uzasSq3Gn1HErGWNMjPBfm13ktQ/RtWWtNBliwMshw0jnKZOhWj2uXMPhDPJzsoMwwYw6tu1nIDSb716DvK1gr3OHpR32AcxOcV8MweWzpknKszrD7S+0ZFSjakOQ1XySw7v9XsZNrah2+qyFAFXx13WvK8QBqGfEW0cy3wAU4mXWXjn9FhFNgoIRvRBjd0OJF83wTfy+zr3CSQjRrgmSxvbnk3peY7zkjHv89dMhxlxFz4oWikom/3X6EVp8juWs69Hh3rVJFSag==;5:JIPrkSoPHxyi9VNpel3GHfEH4UeTWHIl6xTspsHp/WF313Xt2/neA6mNGVsO6USnjvDpz+wZFcXCxaMBTMpDZTnCnK8qyhrgj7m3LXU3sJwLjsJ2teRmYq+DMu4N/1GmUkPKw7kHwLB36LhV1AiT/rRrsFq3rrmqmDHQXiNyASg=;7:uyHYsReQ5wErGYQaUaru+sTfXXZQgIoQvm7kuwrKkjMQxvBAZ+zAN5Eh7VhiBKAZggs4Q4ibADJV25ZUe3klrOOevOycTFNnQomlGcvPHjR3V6fy1jG8s3AHSR8yRPv+cQ6r0YBkY/t2sgfweYKOpwjNrxMeOj1iB6pyEalrYnbNUq2SpeN+Svc8kGLHF8EqsaMU0k6q5PRD38M1rfQHwhK+zrUGNQiguCKcTuwBX3ijA1YfHXK/QJDGJx4o7Y4d
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 21:45:53.2448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 719efe19-a922-493d-9d1c-08d614421eb0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4929
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66097
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

Hi Jim,

On Thu, Sep 06, 2018 at 04:42:56PM -0400, Jim Quinlan wrote:
> Add MIPS as an arch that supports PCI_MSI_IRQ_DOMAIN and add
> generation of msi.h in the MIPS arch.

I guess the second part of this probably became untrue after rebasing
atop something including commit 34a4399f196c ("mips: use asm-generic
version of msi.h"), and ought to be removed.

> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  drivers/pci/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Otherwise this looks fine:

    Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul
