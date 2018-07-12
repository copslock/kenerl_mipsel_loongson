Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2018 19:05:17 +0200 (CEST)
Received: from mail-sn1nam02on0096.outbound.protection.outlook.com ([104.47.36.96]:56605
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993900AbeGLRFH6c6Dy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Jul 2018 19:05:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WV3R6YSXLTz/PeOFzgKsbDBvqZmxlQRgZSZ1JXIrMU4=;
 b=isAj45Tuo1ap6m4/PKCydoZEKi4CABkPy0iY+fRJX5NHXSbQ0XSK4KCXQc01LL/OE57kWgK5XWRnPD6kSh/TR12qHJk/HFgwOmUtr2zLzJJsZQpDFoY9BHn81iZQ3wuGE0FZJE19seDG9zk76IbXownnux3U+MVpoL/Ljq9MmCI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4934.namprd08.prod.outlook.com (2603:10b6:a03:6a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Thu, 12 Jul 2018 17:04:56 +0000
Date:   Thu, 12 Jul 2018 10:04:52 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH RFC] MIPS: Make UTS_MACHINE reflect
 big-endian/little-endian
Message-ID: <20180712170452.5kn52vgfqs27qreo@pburton-laptop>
References: <1531297697-7952-1-git-send-email-chenhc@lemote.com>
 <20180711155729.kwv73y5bw3mlkbq7@pburton-laptop>
 <CAAhV-H4rW7fa6zKSSuDboZqbuvOJkY=nHhSsnU36Be9d-foB-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H4rW7fa6zKSSuDboZqbuvOJkY=nHhSsnU36Be9d-foB-Q@mail.gmail.com>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BN6PR2001CA0041.namprd20.prod.outlook.com
 (2603:10b6:405:16::27) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f995595e-8bac-4337-4f61-08d5e8199820
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4934;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;3:FTMeD76iTFjAhpzQSyV9Jou+uitavKFJYHgAtbBAy9Mx9fqhQLRWmwoK/D44Qr7NVcP16zq3v/8ggAiLzEvNY3Fn3oHjL649idiNnTxwr9HoLmVwBICUxbpkpM9OeBM5SekST/knGsnlBGSwxOkjq7b5GJXo2NJAJ7ZFNu24vAW3MmwJYU5MH74Q9h7k0cjQH1EDyoy+dRLkh+Z7lZbhctSeqR9EDub8CZdD0nFRkwdSub+nrvVJyBEYQ1meamnX;25:UAsaiolZeMwdumYCdEUxbwzFrp80gWKiodpQe/m949IGnfBoFq3nkEiD/MmzRFhJxT0EQNIWjcVocM1ad8k6SaqKCy8dmLAcIYYaXxj4wzenRwOH5jzlW9p/+M/T8ZiMCNPRf6uMOvbqp1E4uaY/XQS9cbt0QIkXeCj1i3SPMYeZgdgIf6VCEYiAkUEf3ClppOT429B6exSaRakvZUdAIOHmRH7yYoeCwOMt2liqZhJKnDzP345crlLVA+eMrz/IkrjwY8lKuOZhWGPK0Wm1Uig9xaLP++Gt7p6zuErgGUNTwS97FzC3VUhA/QJVwdA2HIXLte3Jk/jnz4Yft0xtCw==;31:TLcpde3sPVejlPaYXtrQfr52WlXW8r3S00qirJaytiZXNkRPFhgMIt+V4KS3AS+aPjLYzoCQ13aHV5s9gnT9TRc90JqJdiZR6NytlbacxVYFOAf5w0NuATewo4AU60gCb9KbsTS+595+FCv+ZA//H/gcyAV3ZgCEqsBDkiWyeqdycBGFzuSjdmD4TMBOh5RdlvoIZJHtBFFrWT0fLQ2u9m4WvF5kMSvjM572wR5G/D4=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4934:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;20:2MJQGVUzGiLxTkSMDh/O4tqWNzfiERNdyn6vogVhkCVx5gl9Nh6ZLTLetz7r6Hdq8ehdfFfybBPh+hSBIpjX8OWSx1R9rC0xlHKhn9dE+OwQN6TyWm9KirqFg64zhtgdea67St3XEYDsNzJI6qd0z3XAZJ9JxO0BlWiLSYeB27CPaePFJPVJLJov0f+KzZw6GeKpaZTBVYM4oOPzo+iMDNS5dHV7R68x6lELdgaEqm5NkmdK9h8T8xP+s898WR3C;4:7ikM5mGucuVfVqeWGAwIcxysNnMJTr5vUSbGKU+/TU7nG6PfxDNifKaGltjxCUfXR3/t73lTzLeKJJLskflYZh915c2CQDClkkdouY5rck68Ux8E7auO4GcaSYCBgEWcDDXY2KlIQD0DtPJ393p9r4/yfi4Ot5hkLWYTD16kIjqfDvh+Nt2S08yIwN3s5IDJ0+nREQ6Mbkn4e2bY45WXOlCE5nz06eunNaujkHb2B6ku9H0++qY9T60Uya7PBV9j4StG0ar7KdnBr2NNi8ORfZ6EqmR06Rx2+o7Coaz1l7i/0r+5oRmSr7oe9JP8PcNiCM4Wabpv5tvIJLowIkksS55TY91KAjIu55ZDqgGaSnI=
X-Microsoft-Antispam-PRVS: <BYAPR08MB4934E56EBD5FF543BC740291C1590@BYAPR08MB4934.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(278428928389397)(166708455590820);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(10201501046)(149027)(150027)(6041310)(20161123562045)(2016111802025)(20161123564045)(20161123558120)(20161123560045)(6043046)(6072148)(201708071742011)(7699016);SRVR:BYAPR08MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4934;
X-Forefront-PRVS: 0731AA2DE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(366004)(346002)(396003)(136003)(376002)(39840400004)(189003)(199004)(33896004)(478600001)(66066001)(966005)(956004)(11346002)(446003)(305945005)(476003)(16586007)(58126008)(54906003)(2906002)(7736002)(316002)(8936002)(47776003)(50466002)(81166006)(81156014)(8676002)(1411001)(486006)(44832011)(6246003)(229853002)(6666003)(6916009)(53936002)(4326008)(76506005)(26005)(97736004)(39060400002)(1076002)(186003)(33716001)(14444005)(16526019)(106356001)(23726003)(42882007)(52116002)(68736007)(6496006)(386003)(76176011)(9686003)(5660300001)(6486002)(25786009)(105586002)(3846002)(6116002)(6306002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4934;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4934;23:yZ3wQ235QFks3uoBxEyGIVFHPd7aWCjf/7+Y6mJUx?=
 =?us-ascii?Q?aYykoQFoB9rpiLtnK/S+ZpbTadAdv8yXy9bOqW8XkWFUUNup01fts9UOyXBF?=
 =?us-ascii?Q?TFFoPnVh2nly8M9JTZY7Qh4GsGDKUFlGJAgkjQ9Dtzd37mgf7KtYCqRJnzYe?=
 =?us-ascii?Q?UxbswmlOGA2L6mxAKAvDRptdwzJMAmBiWsjDobX8PfP774VPYJ+Qx/nwbbzO?=
 =?us-ascii?Q?HjF+FoMNJD5twqEpA+Nsak9MkS006uQ09jUiVLqkb9jRXiIg7z5Wr+HCg2mV?=
 =?us-ascii?Q?AebqD24/LqkS+twEb/qqds4lBAHFO1DLpd2Kxsznsq30ZtZchOwFsSPuoyuc?=
 =?us-ascii?Q?h7fq79y9tr+cNTYyQ7yXbvdeVoVhUUyhVKAxKzi5GID6q7qWRhWNN5ZFaHk3?=
 =?us-ascii?Q?Vg4b/lrs62PKC+W2CDCvcTpoMPVFFzVcofmbrc/a5g1GqT2XgscBvFItqpM3?=
 =?us-ascii?Q?OFxd36vwOVBeEtPa7xSxmkxZmS8FfxOk+cKJudkpMYUTZHSBBijkE4rxqTAn?=
 =?us-ascii?Q?bk7Knp/nR9WVL2FFVuGyJLwb8CYcYqP5GSW1ceRqGfc3LUhH9KuzUw2g9BNV?=
 =?us-ascii?Q?iSnOT/ASVcUQJf9hscNAysmy3819Tg88xym3gm1tnOKs6FC82QFj6qzLS5HH?=
 =?us-ascii?Q?0gTYM9MPFxSy5BcqJxX1dhBVzWn7IdOAbzUNRiNh0YfHKBMtv7BpvcjQ4WoZ?=
 =?us-ascii?Q?Hd3VtRr1vsoWxWaqWD+3oALtOycj6km0eXWprYwwWjETFMJuTZG+A0yGoUrd?=
 =?us-ascii?Q?UY8+2IpRThguBHJfeyI+s9m6LupFUJjVKgl9swLlryM+WuIutBa73U4nLY8n?=
 =?us-ascii?Q?ANjFtiln3tw4EitoHn/5ZXOENkZYxtxW5vByy9h9M0CZaebOZ+VbcGLBPgt5?=
 =?us-ascii?Q?IDhs8RCYeemf8r6MpLkfQdESWljG6BLODgvnZShOGguApzxDlO+ZqNZnrVQo?=
 =?us-ascii?Q?O6XzgYUzJRDb5jhrkmpyZSCb9yjSJppty/2b8KDk4sLzrr2ZoxEjTjYfhGEm?=
 =?us-ascii?Q?gTVi+3GM8XLXKU0lQfYB0/N5OVVLqGB9kyv4V0lvBbOr20+f4VUec/05YOME?=
 =?us-ascii?Q?VDn4fRMUtUSBxBIjZTFh4qXGbECTyyixs6eYqEQi5S3HaS6QZ32XpwiUvPIU?=
 =?us-ascii?Q?cYKqnIoBnF27gyMqfqo3hIjmgtTtDUvQ85G74GeVatb1J9BGb9Jhnww/DzD0?=
 =?us-ascii?Q?49+TwcEAD0GlMxQ/qoNVLgSSSPpWagSVkrq6lIqawxkWqT7HRvnwVb10LI8A?=
 =?us-ascii?Q?60Ax8vpDjxLy5uw3g01O+zJY/JUvQN3znF8PWqKTC2i9+DplnmxQBaD7lqIl?=
 =?us-ascii?Q?xZYhjazVWxa/E0eUcMbrPcCcNYa3/lP+RIRS9lPMMB3Udb4o4RUJErno10Wm?=
 =?us-ascii?Q?WicMGzrjHH+Z8abLJ9HbII72dc/CQqBL1510bL02UFXxFhe?=
X-Microsoft-Antispam-Message-Info: hsJrAUBlu6ArajNas8LQQ9lETCK06Z8dj4BBrotW3gAx6er4TT2jAuvBq0J6fKonGfl7NfQKDjgQAXPAPAI77FFOjlPDcdfyDq0gFjGRmaZ3QU7OBWzgZyfBnj5PoBm4nGuThSGW+dJx8+0+zOvHzbt1e3NqXg5f97qr9xhcnPzw4nSzLArRnkH8xO4fM4wW80J9NocjPdE2wcfc08ABmxOLXR1Sx+T9ZqWz7rAPCBKFHVqc9TBDl3R2zXL5jsCcFN75NY+97xzajcXDXjhDiALX2u6YYummlKg5Q5MdXUMqMbKM2T/YolUXSbo271B6eyeUG5L2kYxK3lgnKVHgedFM6jNjRrRrIAPrWqNHgVk=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;6:yEAC01xNYlxjRCIYbCqYqbu7E5RBZocRdWwZvdC94bUItio9pRiwLTm7rWQjgYBBfNDG00Q2jfmYQiIoGkhRgZbqkItlyoX8hWMDf88eKbXjz7AdhoiJOYFC/w5vC9vo3vX5+8/EWnYzLUipzjsMEioz9LSKT0dPbL15Mzo28dcK4qde/zyP4QXmvAMsX+V3znqbkcO6yI70nd0EJTFUptXDQEtMD8dS9yOyrqZPhlPf8yaT/L2uKLscTm79oO3uqgM8/1G2Ik7L1NcmJS5TfJI9MRNhd1IQu+N0z5Z5MITavByigBug1yRh8Pggsk+a1lzYyTnKQUtls78CdCyr7+oYGl2i77IZjN68sH22am21voRGfPjH9RMqi/yX8dVbWRjqN++Eo3YGdRyvA28gjIeaoNICTrHXM1+qOAcxK3iEFyQ5buZnPbmHsLPzyK3oAjeaAgPfvpOlzLKzPdJ+/g==;5:RLonC9CXSNDnq6cjhB9dwjbkxYlV2YDFn6a/WWP0as2TpyKTLN+O+iy3+u8sOEaiDV1+FZYEGzuLdC8MrpFoBAjXg1+NKY1yVZcbqa4LOrBEU1ySBc0kgwS2V3ZVL5l3J36ka8pfHgvE0YDQP2Yl4w/o8F0ZgZ+q1I1mpk/JFeE=;24:3xm/FmCSnv9EeO2zJzIthE9FyXtttKfBrDiOQIpwXLftRyBqg4SC4+PYPzaLiR0/Aot+JVubnMB+6fAQlad1PLhG3xSLv3dPX/54HLAw6MA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;7:o4KSv23E2vjFaS0kFs/IZxuiEagm3uMe9wCjhxuWuvdSENY06DK5+ugaNxFRu5Y/2egxkmAIrwyTsBbaZUM7MpZExRSUd4b/bBppGoLKGu7sZlBXRS21TfWZep9eEl3eF8zWfo4wa6d7uY+JvwL+W70R4oixP0fEcnqkE3VjJ8AIDrgmkNXWAVGBhutYAhhtzsPts9BaJRNkMavabTUkYxUkSkDPK5RxX9m3LhKNngnrzOxWSiwI2CgPBZvoMBrA
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 17:04:56.3631 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f995595e-8bac-4337-4f61-08d5e8199820
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4934
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64821
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

Hi Huacai,

On Thu, Jul 12, 2018 at 07:09:04AM +0800, Huacai Chen wrote:
> >> It seems like some application use "uname" command's output to do
> >> something different between big-endian and little-endian, so we make
> >> UTS_MACHINE reflect both 32bit/64bit and big-endian/little-endian.
> >
> > Since UTS_MACHINE is exposed to userland (which is of course the point
> > of your patch) I'm not comfortable changing it. If some piece of code
> > checks whether uname -m gives "mips" then we'd break it by suddenly
> > giving "mipsel". This is too risky.
> >
> > Which applications are you talking about that look for endianness in
> > uname output? Since Linux on MIPS doesn't expose endianness information
> > in this way these applications will always have been broken on MIPS
> > systems, and it would make more sense to fix the applications than to
> > change the kernel & probably break others.
>
> Hi, we are making Fedora on MIPS, we found that yum use uname's output
> to adjust endianness compatibility. We haven't seen anything broken
> while we changing mips64 to mips64el, do you know something about
> "broken things with this changing". I also don't want to change
> UTS_MACHINE, but if it is harmless, I think we can just do it.

A quick GitHub code search find a ton of things which check uname -m,
some of which expect the exact string "mips":

    https://github.com/search?l=&p=1&q=uname+-m+mips&type=Code

UTS_MACHINE is not something to change.

Can you just have yum detect endianness some other way? Wikipedia tells
me yum is written in python, and a quick Google tells me there's a
sys.byteorder variable which would indicate endianness. Can you just use
that?

Thanks,
    Paul
