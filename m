Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Dec 2009 18:55:10 +0100 (CET)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:52274 "EHLO
        hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493244AbZLCRzG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Dec 2009 18:55:06 +0100
Received: from [192.168.23.10] (really [74.67.89.75])
          by hrndva-omta01.mail.rr.com with ESMTP
          id <20091203175454480.KXKO3094@hrndva-omta01.mail.rr.com>;
          Thu, 3 Dec 2009 17:54:54 +0000
Subject: Re: [PATCH v9 04/10] tracing: add dynamic function tracer support
 for MIPS
From:   Steven Rostedt <rostedt@goodmis.org>
Reply-To: rostedt@goodmis.org
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Nicholas Mc Guire <der.herr@hofr.at>, zhangfx@lemote.com,
        Ingo Molnar <mingo@elte.hu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
In-Reply-To: <6a25a6132d64830bbd7339fe8b3841a51d02ac6d.1258719323.git.wuzhangjin@gmail.com>
References: <adf867c5a6864fa196c667d3f09a6a694f3903c5.1258719323.git.wuzhangjin@gmail.com>
         <51e30436a435480f1f0dec146a82f2b250900690.1258719323.git.wuzhangjin@gmail.com>
         <267c0824194b659b46fc038ba43492df30369fec.1258719323.git.wuzhangjin@gmail.com>
         <6a25a6132d64830bbd7339fe8b3841a51d02ac6d.1258719323.git.wuzhangjin@gmail.com>
Content-Type: text/plain
Organization: Kihon Technologies Inc.
Date:   Thu, 03 Dec 2009 12:54:53 -0500
Message-Id: <1259862893.12870.141.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.3 
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

On Fri, 2009-11-20 at 20:34 +0800, Wu Zhangjin wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 

> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/Kconfig              |    2 +
>  arch/mips/include/asm/ftrace.h |    9 +++
>  arch/mips/kernel/Makefile      |    3 +-
>  arch/mips/kernel/ftrace.c      |  112 ++++++++++++++++++++++++++++++++++++++++
>  arch/mips/kernel/mcount.S      |   29 ++++++++++


>  scripts/recordmcount.pl        |   54 +++++++++++++++++++


>  6 files changed, 208 insertions(+), 1 deletions(-)
>  create mode 100644 arch/mips/kernel/ftrace.c
> 



> diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
> index 24604d4..9d80d0d 100755
> --- a/scripts/recordmcount.pl
> +++ b/scripts/recordmcount.pl
> @@ -295,6 +295,60 @@ if ($arch eq "x86_64") {
>      $ld .= " -m elf64_sparc";
>      $cc .= " -m64";
>      $objcopy .= " -O elf64-sparc";
> +
> +} elsif ($arch eq "mips") {
> +    # To enable module support, we need to enable the -mlong-calls option
> +    # of gcc for module, after using this option, we can not get the real
> +    # offset of the calling to _mcount, but the offset of the lui
> +    # instruction or the addiu one. herein, we record the address of the
> +    # first one, and then we can replace this instruction by a branch
> +    # instruction to jump over the profiling function to filter the
> +    # indicated functions, or swith back to the lui instruction to trace
> +    # them, which means dynamic tracing.
> +    #
> +    #       c:	3c030000 	lui	v1,0x0
> +    #			c: R_MIPS_HI16	_mcount
> +    #			c: R_MIPS_NONE	*ABS*
> +    #			c: R_MIPS_NONE	*ABS*
> +    #      10:	64630000 	daddiu	v1,v1,0
> +    #			10: R_MIPS_LO16	_mcount
> +    #			10: R_MIPS_NONE	*ABS*
> +    #			10: R_MIPS_NONE	*ABS*
> +    #      14:	03e0082d 	move	at,ra
> +    #      18:	0060f809 	jalr	v1
> +    #
> +    # for the kernel:
> +    #
> +    #     10:   03e0082d        move    at,ra
> +    #	  14:   0c000000        jal     0 <loongson_halt>
> +    #                    14: R_MIPS_26   _mcount
> +    #                    14: R_MIPS_NONE *ABS*
> +    #                    14: R_MIPS_NONE *ABS*
> +    #	 18:   00020021        nop
> +    if ($is_module eq "0") {
> +	    $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s_mcount\$";
> +    } else {
> +	    $mcount_regex = "^\\s*([0-9a-fA-F]+): R_MIPS_HI16\\s+_mcount\$";
> +    }
> +    $objdump .= " -Melf-trad".$endian."mips ";
> +
> +    if ($endian eq "big") {
> +	    $endian = " -EB ";
> +	    $ld .= " -melf".$bits."btsmip";
> +    } else {
> +	    $endian = " -EL ";
> +	    $ld .= " -melf".$bits."ltsmip";
> +    }
> +
> +    $cc .= " -mno-abicalls -fno-pic -mabi=" . $bits . $endian;
> +    $ld .= $endian;
> +
> +    if ($bits == 64) {
> +	    $function_regex =
> +		"^([0-9a-fA-F]+)\\s+<(.|[^\$]L.*?|\$[^L].*?|[^\$][^L].*?)>:";
> +	    $type = ".dword";
> +    }
> +
>  } else {
>      die "Arch $arch is not supported with CONFIG_FTRACE_MCOUNT_RECORD";
>  }

This only adds MIPS arch support to recordmcount.pl, and does not touch
any other arch or generic code. Thus, I consider this arch specific
code.

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
