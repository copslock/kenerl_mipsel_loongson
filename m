Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 13:12:20 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:42019 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011991AbbD1LMSeKhHR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Apr 2015 13:12:18 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 9699A28BB81;
        Tue, 28 Apr 2015 13:11:10 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qc0-f169.google.com (mail-qc0-f169.google.com [209.85.216.169])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 560F62805F2;
        Tue, 28 Apr 2015 13:11:08 +0200 (CEST)
Received: by qcrf4 with SMTP id f4so68178555qcr.0;
        Tue, 28 Apr 2015 04:12:10 -0700 (PDT)
X-Received: by 10.55.41.93 with SMTP id p90mr18071308qkh.98.1430219530768;
 Tue, 28 Apr 2015 04:12:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.89.146 with HTTP; Tue, 28 Apr 2015 04:11:49 -0700 (PDT)
In-Reply-To: <20150427233529.4423.20839.stgit@ubuntu-yegoshin>
References: <20150427233529.4423.20839.stgit@ubuntu-yegoshin>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Tue, 28 Apr 2015 13:11:49 +0200
Message-ID: <CAOiHx==LrOO26tPCxxh27bQ0b2a28LzvL054fQ6UVLFAvAOJYw@mail.gmail.com>
Subject: Re: [PATCH] MIPS: R6: memcpy bugfix - zero length overwrites memory
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47127
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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
