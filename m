Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Jul 2010 02:26:15 +0200 (CEST)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:35828 "EHLO
        hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492348Ab0GJA0L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Jul 2010 02:26:11 +0200
X-Authority-Analysis: v=1.1 cv=eWk9bc5BAcy1KEyGm/gc5mmqTM7Cp/ADlcqpp9MTMWU= c=1 sm=0 a=FRz5Z-s_pikA:10 a=uEzv4HemXiYA:10 a=7U3hwN5JcxgA:10 a=Q9fys5e9bTEA:10 a=gMqfjgEr1zLu/65IO0LwxA==:17 a=enOvQawGAAAA:8 a=meVymXHHAAAA:8 a=pGLkceISAAAA:8 a=fLbG0_AyAAAA:8 a=WPyIoOwQAAAA:8 a=JthM5FLITNI90Auf7SkA:9 a=PdYW2Q_PvQN3CrIXJFoA:7 a=PcINbpXVotJABtRA0vZcE26HmBwA:4 a=PUjeQqilurYA:10 a=bkT6KWdcy0IA:10 a=jeBq3FmKZ4MA:10 a=MSl-tDqOz04A:10 a=CO1XcZHhRtcA:10 a=1DbiqZag68YA:10 a=NfQ4XEVMfFwRZDAQ:21 a=RlLd5cM5IF2OoY7G:21 a=gMqfjgEr1zLu/65IO0LwxA==:117
X-Cloudmark-Score: 0
X-Originating-IP: 74.67.89.75
Received: from [74.67.89.75] ([74.67.89.75:60417] helo=[192.168.23.10])
        by hrndva-oedge04.mail.rr.com (envelope-from <rostedt@goodmis.org>)
        (ecelerity 2.2.2.39 r()) with ESMTP
        id 5E/8C-00342-B1EB73C4; Sat, 10 Jul 2010 00:26:04 +0000
Subject: Re: [PATCH] tracing: recordmcount.pl: Fix $mcount_regex for MIPS.
From:   Steven Rostedt <rostedt@goodmis.org>
Reply-To: rostedt@goodmis.org
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Li Hong <lihong.hi@gmail.com>, Ingo Molnar <mingo@elte.hu>,
        Matt Fleming <matt@console-pimps.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
In-Reply-To: <1278712325-12050-1-git-send-email-ddaney@caviumnetworks.com>
References: <1278712325-12050-1-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset="ISO-8859-15"
Organization: Kihon Technologies Inc.
Date:   Fri, 09 Jul 2010 20:26:02 -0400
Message-ID: <1278721562.1537.169.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27361
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

On Fri, 2010-07-09 at 14:52 -0700, David Daney wrote:
> I found this issue in a locally patched 2.6.32.x, current kernels have
> moved the offending code to an __init function which is skipped by
> recordmcount.pl, so the bug is not currently being exercised.
> However, I think the patch is still a good idea, to avoid future
> problems if _mcount were to ever have its address taken in normal
> code.
> 
> This is what I originally saw:
> 
>     Although arch/mips/kernel/ftrace.c is built without -pg, and thus
>     contains no calls to _mcount, it does use the address of _mcount
>     in ftrace_make_nop().  This was causing relocations to be emitted
>     for _mcount which recordmcount.pl erronously took to be _mcount
>     call sites.  The result was that the text of ftrace_make_nop()
>     would be patched with garbage leading to a system crash.
> 
> In non-module code, all _mcount call sites will have R_MIPS_26
> relocations, so we restrict $mcount_regex to only match on these.
> 

I'd like to get an Acked-by from Ralf and Wu before pulling this.

Thanks,

-- Steve

> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Li Hong <lihong.hi@gmail.com>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Matt Fleming <matt@console-pimps.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> ---
>  scripts/recordmcount.pl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
> index f3c9c0a..0171060 100755
> --- a/scripts/recordmcount.pl
> +++ b/scripts/recordmcount.pl
> @@ -326,7 +326,7 @@ if ($arch eq "x86_64") {
>      #                    14: R_MIPS_NONE *ABS*
>      #	 18:   00020021        nop
>      if ($is_module eq "0") {
> -	    $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s_mcount\$";
> +	    $mcount_regex = "^\\s*([0-9a-fA-F]+): R_MIPS_26\\s+_mcount\$";
>      } else {
>  	    $mcount_regex = "^\\s*([0-9a-fA-F]+): R_MIPS_HI16\\s+_mcount\$";
>      }
