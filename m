Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Dec 2009 18:45:26 +0100 (CET)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:62576 "EHLO
        hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493618AbZLCRpX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Dec 2009 18:45:23 +0100
Received: from [192.168.23.10] (really [74.67.89.75])
          by hrndva-omta04.mail.rr.com with ESMTP
          id <20091203174515542.GLGK18441@hrndva-omta04.mail.rr.com>;
          Thu, 3 Dec 2009 17:45:15 +0000
Subject: Re: [PATCH v9 03/10] tracing: add an endian argument to
 scripts/recordmcount.pl
From:   Steven Rostedt <rostedt@goodmis.org>
Reply-To: rostedt@goodmis.org
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Nicholas Mc Guire <der.herr@hofr.at>, zhangfx@lemote.com,
        Ingo Molnar <mingo@elte.hu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Wu Zhangjin <wuzj@lemote.com>
In-Reply-To: <267c0824194b659b46fc038ba43492df30369fec.1258719323.git.wuzhangjin@gmail.com>
References: <adf867c5a6864fa196c667d3f09a6a694f3903c5.1258719323.git.wuzhangjin@gmail.com>
         <51e30436a435480f1f0dec146a82f2b250900690.1258719323.git.wuzhangjin@gmail.com>
         <267c0824194b659b46fc038ba43492df30369fec.1258719323.git.wuzhangjin@gmail.com>
Content-Type: text/plain
Organization: Kihon Technologies Inc.
Date:   Thu, 03 Dec 2009 12:45:14 -0500
Message-Id: <1259862314.12870.138.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.3 
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

On Fri, 2009-11-20 at 20:34 +0800, Wu Zhangjin wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> MIPS and some other architectures need this argument to handle
> big/little endian respectively.
> 
> Signed-off-by: Wu Zhangjin <wuzj@lemote.com>

I don't think I acked this version. But just to make it official:

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

> ---
>  scripts/Makefile.build  |    1 +
>  scripts/recordmcount.pl |    6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 341b589..0b94d2f 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -207,6 +207,7 @@ endif
>  
>  ifdef CONFIG_FTRACE_MCOUNT_RECORD
>  cmd_record_mcount = set -e ; perl $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
> +	"$(if $(CONFIG_CPU_BIG_ENDIAN),big,little)" \
>  	"$(if $(CONFIG_64BIT),64,32)" \
>  	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC)" "$(LD)" "$(NM)" "$(RM)" "$(MV)" \
>  	"$(if $(part-of-module),1,0)" "$(@)";
> diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
> index f0d1445..24604d4 100755
> --- a/scripts/recordmcount.pl
> +++ b/scripts/recordmcount.pl
> @@ -113,13 +113,13 @@ $P =~ s@.*/@@g;
>  
>  my $V = '0.1';
>  
> -if ($#ARGV != 10) {
> -	print "usage: $P arch bits objdump objcopy cc ld nm rm mv is_module inputfile\n";
> +if ($#ARGV != 11) {
> +	print "usage: $P arch endian bits objdump objcopy cc ld nm rm mv is_module inputfile\n";
>  	print "version: $V\n";
>  	exit(1);
>  }
>  
> -my ($arch, $bits, $objdump, $objcopy, $cc,
> +my ($arch, $endian, $bits, $objdump, $objcopy, $cc,
>      $ld, $nm, $rm, $mv, $is_module, $inputfile) = @ARGV;
>  
>  # This file refers to mcount and shouldn't be ftraced, so lets' ignore it
