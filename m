Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2018 20:56:58 +0200 (CEST)
Received: from mail-co1nam05on070f.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe50::70f]:42752
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994758AbeHIS4y66pV4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Aug 2018 20:56:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGPPAh3RSZgte+jSu23rwoKe574bAgrUkKQmThpNRZE=;
 b=PIgu/ax5IOaJvH+jKZ8Rf6MJTwYyjyZ9IdAAbatOc/BZTY1IemcQ5lQpcePVKkTfi56lHJkseiUYlM6Cr9kXjb1iECMmMWqqwSHp/02hLtvd07QiR2TTe6aKDaWOfD0CTc3Pgwd3AzpBMPx+APT4yLlnGLCv0ByN0HqdJo1ItwY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4934.namprd08.prod.outlook.com (2603:10b6:a03:6a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.23; Thu, 9 Aug 2018 18:56:08 +0000
Date:   Thu, 9 Aug 2018 11:56:04 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Arnd Bergmann <arnd@arndb.de>, Matthew Fortune <mfortune@gmail.com>
Cc:     "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-alpha@vger.kernel.org,
        uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-um@lists.infradead.org
Subject: Re: [PATCH v6 4/4] MIPS: Workaround GCC __builtin_unreachable
 reordering bug
Message-ID: <20180809185604.qqamyfd3etdacy3a@pburton-laptop>
References: <20180809174444.31705-1-paul.burton@mips.com>
 <20180809174444.31705-5-paul.burton@mips.com>
 <CAK8P3a2WVrPc0yu3SXL4qRHsC0C8y=t_4srEy1ELdSBYx4ME=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2WVrPc0yu3SXL4qRHsC0C8y=t_4srEy1ELdSBYx4ME=w@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BN6PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:404:23::17) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10a63f97-68ad-4ccb-df6f-08d5fe29c468
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4934;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;3:mYpxc9Fdt/hJvNFPwp/1h3w3DZd3RIFLinE0hcNOQgi5p07FV1scLYkBM3OcZXG5fj4nIl7Fd5Efbvu9doW/64XYiXoa+/Xg47flHb0NymLKGqmzLazGfnlVsPHHb0YQKeW+tfaW1HS7Q1osD0OX2GBlu8OeL22p/DREA+TuVvvaRaHcjljSQ+Zjh+rzSLTUjyLNNqlLBWZr/ofkVa4b0qrZVF16tunvSgriKm5EWxvTX6MvbEWbgIJ65KB+efbV;25:llRFpVFUby2Z5SwVSrhnKvLZLK0FbDoL4aJ7YRDUMh5SqQiyBQH54qNvZ6/fkHFJ1h0BbKJM4fVisCj54eQNnqrMh/44L+B4NIIVcD0bPpvvD9BYU8GTMiP6ZKbnptm5buBo+T/K29qtp+nMuxqCoyLLZ8Di+M0rdAWWU9z3Q5ZxH/vykq+1LRmKsWovjt6kw/MoRFjoAAzjVD6NvUVk7co83ujJ48lXnNcvBYyd/2aMKYY7B5tHCK3GbQQPMKcViPCuX8H0pX61/LJfJi5yU0aH6+3OW7NQNqKeZvWCzY95+kP11nMdgSSZcIwiimTSrK4s2i3f/FDLvm41ww0zFQ==;31:Pq792BoXemaBLOTL+6JmnSW1EAlS2BkNFpEql2kW8LkG9BEmngwLmAKt2JTffiDZiepCZcl/I+nS1FqrwStKQ8blia5DepRSOovzvDCI5EmIzHTtaRG+wQwE9ZcmAx++vxfxBIqvfCItGJ+8zrMf/pOf0rMw/1IrEVTTU3sCtBLGZFEnnn9x/PP+NTUsaLvJ7As4mjuaCz/RFnD7RzvX6XVE7jO0Gl6ZP9pgBEIEjxc=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4934:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;20:an3iwmjqLOLDXXeXF9LNlX3KFZIGG5W3rYWgOV1xEgsT2rsJwcjeNHWx8Qkj1VOGPwThodPRhHfmmazlwFI1qiPSGVZcJjmto15O1hQdae9KuOKyqBmKYjneumafJhNknerTBA8DNn+XlF/uqIuLnSRqeth9lz2VXwghJTfO48roAVyzX2g9UiLuyluMa5L1m28MZt3yVf6KC3CM4VXvv+MuM5jY80nTEMTosX+uLgWjKviTH9Vnr/n3r0lcgRIP;4:3c7S3u57kXWWw/zEZ71pm4pGESMOu1LCrkIX9F+Bu1cg7U0HtDLg3GTv3TNZOmhYLvM0sWkgNcgtzcFaGGixrZJkk7tnhvHoOBTShKBmL/mmMugmO2Zj7auPl1cDsxaEuSe7ZZSC0CEGtG+B5IhBPyZcalPxOW8zAX4Xly3YCIJMHJME2e9Jli+mdE2dTg1bIb0udbeNM+5kI6wYkzv197ldduZX7aPN8l/hT4yXOFhtGhswKD/eJUxor1X4jFrzLAt8cZKu5QnAcRyRAfFr3q4NW1rTPC312KPHdTsvDRmArxKdOb/vboMbONEUYteCYviw22W28JbYR/CI7j06aISR0FkB3TAVqLHxLktM0Xo=
X-Microsoft-Antispam-PRVS: <BYAPR08MB49347B87E5567D5FFEB78EEEC1250@BYAPR08MB4934.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(22074186197030)(183786458502308);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BYAPR08MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4934;
X-Forefront-PRVS: 0759F7A50A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(376002)(366004)(346002)(136003)(39850400004)(396003)(55674003)(199004)(189003)(16526019)(6116002)(58126008)(42882007)(3846002)(6496006)(186003)(110136005)(14444005)(50466002)(25786009)(8936002)(26005)(966005)(316002)(8676002)(478600001)(81156014)(54906003)(81166006)(486006)(44832011)(956004)(16586007)(476003)(11346002)(2906002)(446003)(97736004)(66066001)(7416002)(23726003)(7736002)(305945005)(6666003)(53936002)(6306002)(9686003)(1076002)(5660300001)(33716001)(6486002)(76506005)(229853002)(53546011)(6246003)(39060400002)(4326008)(105586002)(52116002)(33896004)(386003)(76176011)(106356001)(68736007)(47776003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4934;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4934;23:egyf7lsR5c/FTqHPeBhbWHJ+QWDHSXKrG7b5IEhVt?=
 =?us-ascii?Q?uKXEUJbLkevquF/s4B29TicD3ryrybz7wPU1YZZx3WfgCM72hT08vdj1l+uG?=
 =?us-ascii?Q?wZ2JcmIH8S4VAtW6tJJ3KMjXTLs9WxWZQVB4PdJgHbz7+qTuaIpEloOJz21D?=
 =?us-ascii?Q?/8MZdVjsxeeeiBUda/xo0HcNnFWLq6D1RUSrmCOvZlqqPvicZxgQ126PzPL3?=
 =?us-ascii?Q?xXEOCpMdGhZUgctWbxQr+fUq7Mo+RpL/b9h97j9xDLl0Ru1y2pYd+JOfvhS0?=
 =?us-ascii?Q?ZMSG4hlcZA3fbUcY9IwefNhWhFXSQc2bMU76VXBmOawwd6S0drfRl3yMsYmB?=
 =?us-ascii?Q?2GrdlcOkOIebBkuR3bcrnXqP35977eMW/gOgSF89gsZDKaQt0fK1CoGrUrOg?=
 =?us-ascii?Q?cYHkOl14tZeFrBlAJLY3WRQvVqRDIqNmInOf29XG/S6hygWn67kDIWU+EheL?=
 =?us-ascii?Q?gdRqcvhd9aFw+TGTQTitHA3Jntb8O4Gj4pOKn3EYd8DlyYW5QCot4B9C9lJk?=
 =?us-ascii?Q?gfyFbSHSdFbqvoMznpeEnqQOEEL2wVRpG/htC+NLodBm+vs0nyk5uuWDFSQt?=
 =?us-ascii?Q?m9Ebx1bGcSRpcRdGvUCDBZzvtoI1L+aEG7V+7fI/Lbedj1t5j0ZmU6/SK0mQ?=
 =?us-ascii?Q?Xo9mHRumAbAv5OvLcmvHsTYdq62g95AJePeXsY661guQIPQTrIgn8OaOMC0x?=
 =?us-ascii?Q?WUnvz8Mrg/IPtmbXeYKC/CK1g0iByRWXNK5RZKxt7lzxaMElLRu5efaUOUom?=
 =?us-ascii?Q?JZUhy4DHWrbCu2/+6Fn3ZrjvDyhGmiLCfHlmrWDLkiX1Y44luudfLfE6FYki?=
 =?us-ascii?Q?Ezx60/N/SqB9/fxg3/5bp/e64/SFJe2v0bDksl2X5fbjFLWkw6q9++lbLSmV?=
 =?us-ascii?Q?BP4ZaojNSW5y80+1o1FuZySJbRuIjjET6fVXS1We20YvsJgiz47zA+nMv8M1?=
 =?us-ascii?Q?Bz8gGtbsXsrOY6W2uvrlziyRj7nLa1gXfKKM55Cxhsm4rO+HCSMsWvL0+uqt?=
 =?us-ascii?Q?FUeWWmCmiq+D9wENTxDO3yZFp+RZdufMrSe+/UUapQ9NGUkquYdc1io4bD/f?=
 =?us-ascii?Q?QQ0m6cSomAQvPRoayRKPEWyUwO6NlE/soABmBiZvQbjO62N0GYJOGWCGUrrG?=
 =?us-ascii?Q?tS1i/r27s4yqLOO3xwo2YE98kCQuaeQZsFLKTxt+9aWOoEFKKnYUsI3FhBL4?=
 =?us-ascii?Q?FrzcZdHcXboRVm4dbC7GFaht0speEdBWi3vN4TDlEqIQXKz6jb6BJbeMr1bT?=
 =?us-ascii?Q?BX5Iq6xmEdF4n2mfhdHnAO/yc6JS11QkR/ZoTy4YwKeBVhbX7s6XgdUmF6lQ?=
 =?us-ascii?Q?/bhW6UnNgXjJVNMmq72+LkiNCQX5IX4chctGWGR/PMVfJVUgKQq40rXtYQbw?=
 =?us-ascii?Q?/cQspUPA6Yw4fQF9LqigXHe1pT6x0cCVYUJKHekM2FIxLqZhHquq/3gZTAUQ?=
 =?us-ascii?Q?G4zIDoac05gcyP/eLyVoLCvI8S7/+VX0O3xVf84NNBEuAzW7hM8?=
X-Microsoft-Antispam-Message-Info: atR1zHjMqlLADRYPi9w5Z+3O31rF7SESvuEFCk9NRfsMRANmnEX1EGeIlr3tUlmGCpCJUhPs03OXAlXK6zjtQN5vmFhlJG9q2EAvflXR0phPnRYVvkDz7K8vaTsgFbWgd7/Zl5Ah9b/uS4kf/8wAFZ2u9mjYGlyuytHl/BGEtvRm0xUeMbPoG/s6F+XM5eo+c/SWiDei0brq7X8oZm6fqe0OtkCDF7iZreKNmlPUUrqNquXdN7NGSGsbawLQBra8daP0fx7vaPkjEgQdedfpMrcnGgKCJx+mq+UvvCum3vgNr/5BRpVoFVPV+gER45esEftPiUa8N7JdkgG45OuCufZRMM3UFrHJAX7+iyTRCgs=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;6:ih1IdBRGEqcWEQ/QjZivI4RDNWUKJHZEuEZc64OXGvvrkM9KROQJOfA1L1gx89CEA+SGULuHIOQVyaSWtKCaroIo//tqgPFGEXWa+ex3TtWPytyIaXH45tUQY+DAXRKSy3Of3G+pIEyCzL4S1trZkGa/MDCmC6oohpgawvfQhKIGKZbylfQ3qNadYn7hbXiDV3L3Y8itaC1Ao7jAoo35Zy2HiCdOHs6+lru+EgIrFtLagkHgncZrt0TQRQzArTqUJE8dZrkFUWfhIo/3xdYk1nOMmSbHhcT9OP4fH0iqStTYFnEEFobCch17jjuGXyadcO4N4EKsZ1F1t0DLffpnP0SfHuLbJl8OXDYH8jOf2vMOd1t1OsHkQJl7YLh8p0FgED9yHatMkD8RhH44/Q5/3FxzKRkIJBlPi+L3r3ZT4zmKhYgAThIv/6bAkCnEwn08lemHMKvD5qHNBNi7Q1ALSQ==;5:e6cYGWest7LTkSGrePWcABw2X7LefeC6ZvKfn2ZDB4feN45Gpj4jR6trrqfSG1osSb3VvVT0OOhTvHPhpdRFb2x+FSBEbctIOmk6nCxa7q89bUGcmHVw8JwvEfkvL10ZfzdIkhYuv+19hjsIoL7+1tzMzDZeXhLAw3zOg1rICco=;7:6+8adEq8aG80IxI31eN1h0X37V3mKfP9h279uJA35GKXE022wS0g3ptamcpzbSiHc8fsd7eZJ5IZWTaxcx1I1Be3xhqJ07wp0q/LlbU/QgIaCroaNW1ndn/SFF2Pyxfpud0ER7CFUPtF0C4FnXKqW84eS1l9uC1xCFgNNG4FtpedzJtCnoUjt154p6d4OgJAGJ2ABoqoOlLl8eziUVXFXCuMGVwac9TWaAX7hQNgUE9iSdTjjS13zGjHV1Acl+TY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2018 18:56:08.1421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a63f97-68ad-4ccb-df6f-08d5fe29c468
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4934
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65506
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

Hi Arnd,

On Thu, Aug 09, 2018 at 08:12:27PM +0200, Arnd Bergmann wrote:
> On Thu, Aug 9, 2018 at 7:45 PM Paul Burton <paul.burton@mips.com> wrote:
> 
> > +/*
> > + * With GCC v4.5 onwards can use __builtin_unreachable to indicate to the
> > + * compiler that a particular code path will never be hit. This allows it to be
> > + * optimised out of the generated binary.
> > + *
> > + * Unfortunately GCC from at least v4.9.2 to current head of tree as of May
> > + * 2016 suffer from a bug that can lead to instructions from beyond an
> 
> Has anything happened to address this in gcc in the meantime?
> Could you update this text to reflect whatever is in current gcc-9?

Good question. I can reproduce the problem using the test case from [1]
using both GCC 6.4.0 & 7.3.0, but 8.1.0 generates wildly different code
which looks good.

Nothing relevant is listed in the release notes for GCC 8.x though, and
I can't see anything obvious in gcc's commit logs. It doesn't looks like
the fix Robert suggested went in. So I don't know whether current GCC's
have resolved the problem or just get lucky enough not to hit it with
the existing testcase.

I've copied Matthew (GCC MIPS maintainer) in case he has any relevant
information.

Thanks,
    Paul

[1] https://gcc.gnu.org/ml/gcc-patches/2015-09/msg00360.html
