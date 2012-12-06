Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2012 00:46:37 +0100 (CET)
Received: from mail-gh0-f177.google.com ([209.85.160.177]:43118 "EHLO
        mail-gh0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831864Ab2LFXqgENiKH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Dec 2012 00:46:36 +0100
Received: by mail-gh0-f177.google.com with SMTP id g22so1182474ghb.36
        for <multiple recipients>; Thu, 06 Dec 2012 15:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=C8fytjMOHkHE5jAPCA4kxYlukDxaezm26ftd2Q3XZ+c=;
        b=b2SMt1OLpZm1Tx7CW/hmZlX2Gu3Ca6oEPHRIuRnzXtc5587qZNSSaosqtojN4bX9lK
         ausLv+S/mDc6ZSdze2bt8HZSiAc0Bprv+PkbAyl8/L4j9tfNlebQKeDtZYMedleER/9h
         h+nB9HOajRrm+GWJEJrK98hk5iQfYQKKpmoVrTJGZm+dVpy/pE4pX2PhBBTDuci2GF8G
         Z/Cgz7HMzQ+qJbGJXiskdvTQyes0LqIMfuISJDNHJ60p+Yvxvdb5MQ3GMtoEEX6ErubW
         UK9TQjfN0svKHPxpeossk6yUglwl6qHG+sS0jLjzfTZhVCd884DzyFzDHd4l2TLJ8dHR
         hP0Q==
Received: by 10.236.92.172 with SMTP id j32mr4884558yhf.37.1354837589608;
        Thu, 06 Dec 2012 15:46:29 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id n20sm10334376anl.19.2012.12.06.15.46.26
        (version=SSLv3 cipher=OTHER);
        Thu, 06 Dec 2012 15:46:27 -0800 (PST)
Message-ID: <50C12E52.7010802@gmail.com>
Date:   Thu, 06 Dec 2012 15:46:26 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Check BITS_PER_LONG instead of __SIZEOF_LONG__
References: <1354821137-7562-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1354821137-7562-1-git-send-email-geert@linux-m68k.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35202
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 12/06/2012 11:12 AM, Geert Uytterhoeven wrote:
> When building a 32-bit kernel for RBTX4927 with gcc version 4.1.2 20061115
> (prerelease) (Ubuntu 4.1.1-21), I get:
>
> arch/mips/lib/delay.c:24:5: warning: "__SIZEOF_LONG__" is not defined

Sorry, looks like it may have been added in GCC-4.3.  I didn't check any 
earlier versions when I made the original patch.



>
> As a consequence, __delay() always uses the 64-bit "dsubu" instruction.
>
> Replace the check for "__SIZEOF_LONG__ == 4" by "BITS_PER_LONG == 32" to
> fix this.
>
> Introduced by commit 5210edcd527773c227465ad18e416a894966324f ("MIPS: Make
> __{,n,u}delay declarations match definitions and generic delay.h")
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> --
> Untested on real hardware.
> Ralf, is this sufficient to prevent you from nuking RBTX4927 support? ;-)
> ---
>   arch/mips/lib/delay.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/mips/lib/delay.c b/arch/mips/lib/delay.c
> index dc81ca8..288f795 100644
> --- a/arch/mips/lib/delay.c
> +++ b/arch/mips/lib/delay.c
> @@ -21,7 +21,7 @@ void __delay(unsigned long loops)
>   	"	.set	noreorder				\n"
>   	"	.align	3					\n"
>   	"1:	bnez	%0, 1b					\n"
> -#if __SIZEOF_LONG__ == 4
> +#if BITS_PER_LONG == 32
>   	"	subu	%0, 1					\n"
>   #else
>   	"	dsubu	%0, 1					\n"
>
