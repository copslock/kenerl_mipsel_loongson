Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 May 2009 16:24:22 +0100 (BST)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:63765 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024691AbZE2PYQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 29 May 2009 16:24:16 +0100
Received: from gandalf ([74.67.89.75]) by hrndva-omta01.mail.rr.com
          with ESMTP
          id <20090529152410101.DXQV15535@hrndva-omta01.mail.rr.com>;
          Fri, 29 May 2009 15:24:10 +0000
Date:	Fri, 29 May 2009 11:24:09 -0400 (EDT)
From:	Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To:	wuzhangjin@gmail.com
cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	Wu Zhangjin <wuzj@lemote.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH v2 2/6] mips dynamic function tracer support
In-Reply-To: <a00a91f6fc79b7d20b5b2193086e879dcafded46.1243604390.git.wuzj@lemote.com>
Message-ID: <alpine.DEB.2.00.0905291122260.31247@gandalf.stny.rr.com>
References: <cover.1243604390.git.wuzj@lemote.com> <a00a91f6fc79b7d20b5b2193086e879dcafded46.1243604390.git.wuzj@lemote.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips


On Fri, 29 May 2009, wuzhangjin@gmail.com wrote:
> diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
> index 409596e..a5d2ace 100755
> --- a/scripts/recordmcount.pl
> +++ b/scripts/recordmcount.pl
> @@ -213,6 +213,17 @@ if ($arch eq "x86_64") {
>      if ($is_module eq "0") {
>          $cc .= " -mconstant-gp";
>      }
> +
> +} elsif ($arch eq "mips") {
> +	$mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s_mcount\$";
> +	$ld .= " -melf".$bits."btsmip";
> +
> +	$cc .= " -mno-abicalls -fno-pic ";
> +
> +    if ($bits == 64) {
> +		$type = ".dword";
> +    }
> +
>  } else {
>      die "Arch $arch is not supported with CONFIG_FTRACE_MCOUNT_RECORD";
>  }
> @@ -441,12 +452,12 @@ if ($#converts >= 0) {
>      #
>      # Step 5: set up each local function as a global
>      #
> -    `$objcopy $globallist $inputfile $globalobj`;
> +    `$objcopy $globallist $inputfile $globalobj 2>&1 >/dev/null`;
>  
>      #
>      # Step 6: Link the global version to our list.
>      #
> -    `$ld -r $globalobj $mcount_o -o $globalmix`;
> +    `$ld -r $globalobj $mcount_o -o $globalmix 2>&1 >/dev/null`;

We still need to find out why these are giving errors. I don't like the 
idea of hiding errors that might be useful. The better way is to change 
the code to avoid having any warnings or errors.

-- Steve


>  
>      #
>      # Step 7: Convert the local functions back into local symbols
> @@ -454,7 +465,7 @@ if ($#converts >= 0) {
>      `$objcopy $locallist $globalmix $inputfile`;
>  
>      # Remove the temp files
> -    `$rm $globalobj $globalmix`;
> +    `$rm $globalobj $globalmix 2>&1 >/dev/null`;
>  
>  } else {
>  
> -- 
> 1.6.0.4
> 
> 
