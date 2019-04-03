Return-Path: <SRS0=IOgP=SF=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB57C4360F
	for <linux-mips@archiver.kernel.org>; Wed,  3 Apr 2019 22:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469B5206DF
	for <linux-mips@archiver.kernel.org>; Wed,  3 Apr 2019 22:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="QUH+T135"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfDCWAA (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:00:00 -0400
Received: from mail-eopbgr680113.outbound.protection.outlook.com ([40.107.68.113]:17798
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726099AbfDCV77 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Wed, 3 Apr 2019 17:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4blga3nvyXR8fYqX9Z2z8ysG7NvlPZLca9VDaAt92ZE=;
 b=QUH+T135pSOcrfL4zeGtmPFMbIi+YifsIKh4C02WhI4V+uXQnvVTSAKi4fUBrFS30+Z4gRY1BIGt1/eR3vjH28G/irwAnzWY4NwQJ7jK/c3StTmsk2D0XEkPGX8zrKQHAWvMywN3A2waQf46N6q/Po6V02ghtwGeFBE7Tr/iZXI=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.19; Wed, 3 Apr 2019 21:59:56 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%6]) with mapi id 15.20.1750.017; Wed, 3 Apr 2019
 21:59:56 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFC] mips ptrace32.c and compat_ptr()
Thread-Topic: [RFC] mips ptrace32.c and compat_ptr()
Thread-Index: AQHU6B4C3jG0/7ci/UGphFj2QWYJmaYrAN6A
Date:   Wed, 3 Apr 2019 21:59:56 +0000
Message-ID: <20190403215947.ethx24puujm27hhb@pburton-laptop>
References: <20190401000104.GF2217@ZenIV.linux.org.uk>
In-Reply-To: <20190401000104.GF2217@ZenIV.linux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:a03:180::44) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 869092c3-b03e-41c1-7ba4-08d6b87fb51a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR2201MB1277;
x-ms-traffictypediagnostic: MWHPR2201MB1277:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <MWHPR2201MB1277ED8DF95B973D6346F7B9C1570@MWHPR2201MB1277.namprd22.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39850400004)(366004)(376002)(346002)(136003)(396003)(199004)(189003)(42882007)(478600001)(316002)(966005)(102836004)(6506007)(1076003)(386003)(76176011)(58126008)(81166006)(26005)(54906003)(53936002)(81156014)(97736004)(99286004)(52116002)(44832011)(6916009)(25786009)(486006)(8936002)(186003)(476003)(4326008)(33716001)(105586002)(14444005)(3846002)(6436002)(6116002)(256004)(6486002)(6246003)(66066001)(5660300002)(446003)(6306002)(68736007)(9686003)(305945005)(8676002)(71190400001)(2906002)(106356001)(11346002)(6512007)(229853002)(71200400001)(14454004)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1277;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pRfLi6liCQFcNmIoI1QC4z9ZkpPmZ4KDmYnJ1AFWMS4crzuYXo5PMffdPJedeLPMEqXDzfrESy4OuLFATWtJv3q6LCZKaunF3GYUu+G0sTnTB5YNk1W+jP8YikPfnShLDV07fE4TwQd6V1rC4mR/Vp16/vxVXyU4ZnbbPeuVDo6gWDE1kMv6qs+SXBSfV0jxY3W0QzVQwfcfq7dZakoX1KcH1x+6Tm+VBBxdKHdhSRE4AyxNc2j8N5CeSpAY67eJAk2oMISbumtQziHv0+YTwP9jSkoPaCA4xAouK1NXxKHxvjB72EiF5HVeTUFfDjG94Ut2effqE3JfWcRVvfOhDNPuIm2C2UGEPtcRwcG1S00kS5UsyjHDbBlIxnUKaRLAz8vhBff1ymWQnDGp1UWRI6sXGzFVtZry0IJ/H2+fGd4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <538EA14DBFD4374CB34076E5AC58460C@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 869092c3-b03e-41c1-7ba4-08d6b87fb51a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 21:59:56.2576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1277
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Al,

On Mon, Apr 01, 2019 at 01:01:04AM +0100, Al Viro wrote:
> 	There's something odd going on:
>=20
> 1)
> static inline void __user *compat_ptr(compat_uptr_t uptr)
> {
>         /* cast to a __user pointer via "unsigned long" makes sparse happ=
y */
>         return (void __user *)(unsigned long)(long)uptr;
> }
>=20
> Huh?  The first impression is that it wants to sign-extend
> the argument, but... compat_uptr_t is and always had been
> unsigned.  Initially it went
> +typedef u32            compat_uptr_t;
> +
> +static inline void *compat_ptr(compat_uptr_t uptr)
> +{
> +       return (void *)(long)uptr;
> +}
> so there never had been any sign-extension in that thing.
> So what is that cast to long in the current version about?

Good question. It looks like it's been there ever since it was added in
the separate arch/mips64 [1] & then got carried forwards into arch/mips.

The only thing I can think up is that perhaps Ralf added the cast to
long in order to avoid warnings from -Wint-to-pointer-cast, and ought to
have used unsigned long but didn't & got away with it. Later sparse
warned about the cast & we got the band-aid of the extra cast from long
to unsigned long [2], which ought to have replaced rather than
supplemented the cast to long. All speculative of course, the git
history isn't really descriptive enough to say anything for sure...

> 2)
> long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
>                         compat_ulong_t caddr, compat_ulong_t cdata)
> {
>         int addr =3D caddr;
>         int data =3D cdata;
> ...
>                 ret =3D put_user(tmp, (u32 __user *) (unsigned long) data=
);
>                 break;
> and quite a few similar in the same function.  Here we _do_ get sign
> extension.  Which is bloody odd, seeing that all other compat syscalls
> end up using compat_ptr(), either explicitly or in the syscall glue.
>=20
> Shouldn't it be doing
>                 ret =3D put_user(tmp, (u32 __user *)compat_ptr(cdata));
>                 break;
> instead?

This is weird, and I need to go wrap my head around it. Worrying &
confusing me further is the comment above compat_ptr:

> A pointer passed in from user mode. This should not
> be used for syscall parameters, just declare them
> as pointers because the syscall entry code will have
> appropriately converted them already.

I initially thought it was trying to get at the fact that 32b user code
ought to be providing sign extended addresses anyway since MIPS32
instructions generally sign extend when run on a MIPS64 CPU, but
actually arch/mips/kernel/scall64-o32.S implicitly sign extends
arguments (using sll for the first 4 args in a0-a3, and the
sign-extending lw instruction for any further arguments on the stack).

So perhaps this is what that comment is referring to, and it's saying
that syscall entry points should just declare the arguments as pointers
since scall64-o32.S will have sign extended addresses already anyway
which makes explicitly trying to sign extend using compat_ptr() a no-op
(even if it did some sign extension).

That implicit sign extension is not done for n32, only o32. And this is
despite the fact that n32 is where I'd expect us to be more likely to
have non-sign-extended addresses since we'll have MIPS64 instructions in
the mix that could more easily generate such addresses.

And of course that only accounts for pointers passed directly as
arguments to syscalls - a pointer in a struct will still need sign
extension & we seem to have various bits of code scattered around doing
that sort of thing that probably ought to use compat_ptr() if it worked
properly.

I suppose we're getting away with this purely because of the typical
2GB/2GB user/kernel split of the MIPS32 address space. If users never
have pointers with bit 31 set then sign extending or zero extending is
all the same thing, and compat_ptr() doing zero extension becomes
harmless.

I need to give this some further thought though & it feels like
something we can clean up for the sake of sanity if nothing else.

Thanks,
    Paul

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit=
/include/asm-mips64/compat.h?id=3Df19e2d9e9eb4
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/include/asm-mips/compat.h?id=3D01bebc66793f
