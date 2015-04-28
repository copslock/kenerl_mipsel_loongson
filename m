Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 17:41:05 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17084 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026213AbbD1PlDILOLq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2015 17:41:03 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8051DD0FE1DF9;
        Tue, 28 Apr 2015 16:40:56 +0100 (IST)
Received: from BADAG01.ba.imgtec.org (10.20.40.113) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 28 Apr
 2015 16:40:58 +0100
Received: from BADAG02.ba.imgtec.org ([fe80::612d:e977:c603:32d6]) by
 BADAG01.ba.imgtec.org ([fe80::8c38:df2b:fd93:33d3%14]) with mapi id
 14.03.0123.003; Tue, 28 Apr 2015 08:40:56 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
To:     Jonas Gorski <jogo@openwrt.org>
CC:     MIPS Mailing List <linux-mips@linux-mips.org>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: R6: memcpy bugfix - zero length overwrites memory
Thread-Topic: [PATCH] MIPS: R6: memcpy bugfix - zero length overwrites memory
Thread-Index: AQHQgULZ1bzX0vDhRkipbErP9k3qlp1iuxGA///V1yI=
Date:   Tue, 28 Apr 2015 15:40:55 +0000
Message-ID: <2t0ohi7dtgbcu7itm7j8br57.1430235652967@email.android.com>
References: <20150427233529.4423.20839.stgit@ubuntu-yegoshin>,<CAOiHx==LrOO26tPCxxh27bQ0b2a28LzvL054fQ6UVLFAvAOJYw@mail.gmail.com>
In-Reply-To: <CAOiHx==LrOO26tPCxxh27bQ0b2a28LzvL054fQ6UVLFAvAOJYw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

You right,

I am debugging new core and got a wrong backtrace.

Please cancel it, sorry for noise.

- Leonid.


Jonas Gorski <jogo@openwrt.org> wrote:


Hi,

On Tue, Apr 28, 2015 at 1:35 AM, Leonid Yegoshin
<Leonid.Yegoshin@imgtec.com> wrote:
> MIPS R6 version of memcpy has bug - then length to copy is zero
> and addresses are not aligned then it can overwrite a whole memory.
>
> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> ---
>  arch/mips/lib/memcpy.S |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/mips/lib/memcpy.S b/arch/mips/lib/memcpy.S
> index 9245e1705e69..7e0250f3aec8 100644
> --- a/arch/mips/lib/memcpy.S
> +++ b/arch/mips/lib/memcpy.S
> @@ -514,6 +514,8 @@
>
>  #ifdef CONFIG_CPU_MIPSR6
>  .Lcopy_unaligned_bytes\@:
> +       beqz    len, .Ldone\@
> +        nop
>  1:
>         COPY_BYTE(0)
>         COPY_BYTE(1)

AFAICT it should never reach that if the amount to copy is zero bytes,
so the check seems to be superfluous:

        sltu    t2, len, NBYTES <- check for < NBYTES (4/8 bit
depending on 32/64 bit)
        and     t1, dst, ADDRMASK
        PREFS(  0, 1*32(src) )
        PREFD(  1, 1*32(dst) )
        bnez    t2, .Lcopy_bytes_checklen\@ <- skip to
copy_bytes_checklen if < NBYTES
         and    t0, src, ADDRMASK
        PREFS(  0, 2*32(src) )
        PREFD(  1, 2*32(dst) )
#ifndef CONFIG_CPU_MIPSR6
        bnez    t1, .Ldst_unaligned\@
         nop
        bnez    t0, .Lsrc_unaligned_dst_aligned\@
#else
        or      t0, t0, t1
        bnez    t0, .Lcopy_unaligned_bytes\@ <- only outside place to
branch to it, and only reachable if len >= NBYTES bytes.
#endif


And in the loop itself each COPY_BYTE() will already break out if len
becomes zero, so the unconditional b 1b should also never be reached
with len == 0 in that case..

But maybe I overlooked something.


Regards
Jonas
