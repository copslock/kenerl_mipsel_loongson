Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Apr 2014 00:29:15 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:50675 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816543AbaDIW3MvSIEZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Apr 2014 00:29:12 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id B44E7283FEA
        for <linux-mips@linux-mips.org>; Thu, 10 Apr 2014 00:28:25 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com [209.85.216.179])
        by arrakis.dune.hu (Postfix) with ESMTPSA id E92F128028D
        for <linux-mips@linux-mips.org>; Thu, 10 Apr 2014 00:28:24 +0200 (CEST)
Received: by mail-qc0-f179.google.com with SMTP id m20so3580975qcx.10
        for <linux-mips@linux-mips.org>; Wed, 09 Apr 2014 15:29:10 -0700 (PDT)
X-Received: by 10.140.41.200 with SMTP id z66mr11883545qgz.102.1397082550099;
 Wed, 09 Apr 2014 15:29:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.109.97 with HTTP; Wed, 9 Apr 2014 15:28:48 -0700 (PDT)
In-Reply-To: <1397059208-27096-1-git-send-email-markos.chandras@imgtec.com>
References: <1396957635-27071-14-git-send-email-markos.chandras@imgtec.com> <1397059208-27096-1-git-send-email-markos.chandras@imgtec.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Thu, 10 Apr 2014 00:28:48 +0200
Message-ID: <CAOiHx=kh3+Xzvyx7PsEfNCiEf6cRP3ucQKDfY3brZ6FR2KwW4Q@mail.gmail.com>
Subject: Re: [PATCH v2 13/14] MIPS: net: Add BPF JIT
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39750
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

On Wed, Apr 9, 2014 at 6:00 PM, Markos Chandras
<markos.chandras@imgtec.com> wrote:
> This adds initial support for BPF-JIT on MIPS
>
> Tested on mips32 LE/BE and mips64 BE/n64 using
> dhcp, ping and various tcpdump filters.
>
> Benchmarking:
>
> Assuming the remote MIPS target uses 192.168.154.181
> as its IP address, and the local host uses 192.168.154.136,
> the following results can be obtained using the following
> tcpdump filter (catches no frames) and a simple
> 'time ping -f -c 1000000' command.
>
> [root@(none) ~]# tcpdump -p -n -s 0 -i eth0 net 10.0.0.0/24 -d
> (000) ldh      [12]
> (001) jeq      #0x800           jt 2    jf 8
> (002) ld       [26]
> (003) and      #0xffffff00
> (004) jeq      #0xa000000       jt 16   jf 5
> (005) ld       [30]
> (006) and      #0xffffff00
> (007) jeq      #0xa000000       jt 16   jf 17
> (008) jeq      #0x806           jt 10   jf 9
> (009) jeq      #0x8035          jt 10   jf 17
> (010) ld       [28]
> (011) and      #0xffffff00
> (012) jeq      #0xa000000       jt 16   jf 13
> (013) ld       [38]
> (014) and      #0xffffff00
> (015) jeq      #0xa000000       jt 16   jf 17
> (016) ret      #65535
>
> - BPF-JIT Disabled
>
> real    1m38.005s
> user    0m1.510s
> sys     0m6.710s
>
> - BPF-JIT Enabled
>
> real    1m35.215s
> user    0m1.200s
> sys     0m4.140s
>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
> Changes since v1:
>
> - Add 'wsbh' implementation for MIPS32/64R1
> - Rename 'rxhash' to 'hash' because of
> 61b905da33ae25edb6b9d2a5de21e34c3a77efe3
> - Initialize 'fp->jited' because of
> f8bbbfc3b97f4c7a6c7c23185e520b22bfc3a21d
> ---

(snip)

> diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
> new file mode 100644
> index 0000000..a12f843
> --- /dev/null
> +++ b/arch/mips/net/bpf_jit.c

(snip)

> +#ifdef CONFIG_CPU_LITTLE_ENDIAN
> +                       /* This needs little endian fixup */
> +                       if (config_enabled(CPU_MIPSR1)) {

Hm, looking at arch/mips/Kconfig, this will falsely identify CPU_BMIPS
as R2 as it does not select CPU_MIPSR1.

How about "if (cpu_has_mips_r1)"? There are some targets that have
both R1 and R2 cores (e.g. bcm47xx), and even if we built the kernel
for R1, it does not prevent us from emitting R2 instructions because
we do this at runtime when we can check for it.

> +                               /* Get first byte */
> +                               emit_andi(r_tmp_imm, r_A, 0xff, ctx);
> +                               /* Shift it */
> +                               emit_sll(r_tmp, r_tmp_imm, 8, ctx);
> +                               /* Get second byte */
> +                               emit_srl(r_tmp_imm, r_A, 8, ctx);
> +                               emit_andi(r_tmp_imm, r_tmp_imm, 0xff, ctx);
> +                               /* Put everyting together in r_A */
> +                               emit_or(r_A, r_tmp, r_tmp_imm, ctx);
> +                       } else {
> +                               /* R2 and later have the wsbh instruction */
> +                               emit_wsbh(r_A, r_A, ctx);
> +                       }
> +#endif


Regards
Jonas
