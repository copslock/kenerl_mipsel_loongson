Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Oct 2010 23:10:17 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9929 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491190Ab0JVVKN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Oct 2010 23:10:13 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cc1fdd60000>; Fri, 22 Oct 2010 14:10:46 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 22 Oct 2010 14:10:33 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 22 Oct 2010 14:10:33 -0700
Message-ID: <4CC1FDB1.8050404@caviumnetworks.com>
Date:   Fri, 22 Oct 2010 14:10:09 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Wu Zhangjin <wuzhangjin@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org, rostedt@goodmis.org
Subject: Re: [RFC 2/2] MIPS: tracing/ftrace: Fixes mcount_regex for modules
References: <cover.1287779153.git.wuzhangjin@gmail.com> <485f5af61fae72dc9c1f0e31b1b5f1f57a5e7ed8.1287779153.git.wuzhangjin@gmail.com>
In-Reply-To: <485f5af61fae72dc9c1f0e31b1b5f1f57a5e7ed8.1287779153.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Oct 2010 21:10:33.0164 (UTC) FILETIME=[906230C0:01CB722D]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28207
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 10/22/2010 01:58 PM, Wu Zhangjin wrote:
> From: Wu Zhangjin<wuzhangjin@gmail.com>
>
> In some situations(with related kernel config and gcc options), the
> modules may have the same address space as the core kernel space, so
> mcount_regex for modules should also match R_MIPS_26.
>

I think Steve is rewriting this bit to be a pure C program.  Is this 
file even used anymore?  If so for how long?

David Daney

> Signed-off-by: Wu Zhangjin<wuzhangjin@gmail.com>
> ---
>   scripts/recordmcount.pl |   46 +++++++++++++++++++++++++++++-----------------
>   1 files changed, 29 insertions(+), 17 deletions(-)
>
> diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
> index e67f054..e9c1a0f 100755
> --- a/scripts/recordmcount.pl
> +++ b/scripts/recordmcount.pl
> @@ -299,14 +299,33 @@ if ($arch eq "x86_64") {
>       $cc .= " -m64";
>       $objcopy .= " -O elf64-sparc";
>   } elsif ($arch eq "mips") {
> -    # To enable module support, we need to enable the -mlong-calls option
> -    # of gcc for module, after using this option, we can not get the real
> -    # offset of the calling to _mcount, but the offset of the lui
> -    # instruction or the addiu one. herein, we record the address of the
> -    # first one, and then we can replace this instruction by a branch
> -    # instruction to jump over the profiling function to filter the
> -    # indicated functions, or swith back to the lui instruction to trace
> -    # them, which means dynamic tracing.
> +    #<For kernel>
> +    # To disable tracing, just replace "jal _mcount" with nop;
> +    # to enable tracing, replace back. so, the offset 14 is
> +    # needed to be recorded.
> +    #
> +    #     10:   03e0082d        move    at,ra
> +    #     14:   0c000000        jal     0
> +    #                    14: R_MIPS_26   _mcount
> +    #                    14: R_MIPS_NONE *ABS*
> +    #                    14: R_MIPS_NONE *ABS*
> +    #     18:   00020021        nop
> +    #
> +    #<For module>
> +    #
> +    # If no long call(-mlong-calls), the same to kernel.
> +    #
> +    # If the module space differs from the kernel space, long
> +    # call is needed, as a result, the address of _mcount is
> +    # needed to be recorded in a register and then jump from
> +    # module space to kernel space via "jalr<register>". To
> +    # disable tracing, "jalr<register>" can be replaced by
> +    # nop; to enable tracing, replace it back. Since the
> +    # offset of "jalr<register>" is not easy to be matched,
> +    # the offset of the 1st _mcount below is recorded and to
> +    # disable tracing, "lui v1, 0x0" is substituted with "b
> +    # label", which jumps over "jalr<register>"; to enable
> +    # tracing, replace it back.
>       #
>       #       c:	3c030000 	lui	v1,0x0
>       #			c: R_MIPS_HI16	_mcount
> @@ -318,19 +337,12 @@ if ($arch eq "x86_64") {
>       #			10: R_MIPS_NONE	*ABS*
>       #      14:	03e0082d 	move	at,ra
>       #      18:	0060f809 	jalr	v1
> +    #   label:
>       #
> -    # for the kernel:
> -    #
> -    #     10:   03e0082d        move    at,ra
> -    #	  14:   0c000000        jal     0<loongson_halt>
> -    #                    14: R_MIPS_26   _mcount
> -    #                    14: R_MIPS_NONE *ABS*
> -    #                    14: R_MIPS_NONE *ABS*
> -    #	 18:   00020021        nop
>       if ($is_module eq "0") {
>   	    $mcount_regex = "^\\s*([0-9a-fA-F]+): R_MIPS_26\\s+_mcount\$";
>       } else {
> -	    $mcount_regex = "^\\s*([0-9a-fA-F]+): R_MIPS_HI16\\s+_mcount\$";
> +	    $mcount_regex = "^\\s*([0-9a-fA-F]+): R_MIPS_(HI16|26)\\s+_mcount\$";
>       }
>       $objdump .= " -Melf-trad".$endian."mips ";
>
