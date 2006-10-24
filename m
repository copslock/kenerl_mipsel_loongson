Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Oct 2006 14:40:06 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:32975 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20039677AbWJXNj7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Oct 2006 14:39:59 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id D6B183EBE; Tue, 24 Oct 2006 06:39:42 -0700 (PDT)
Message-ID: <453E179B.50205@ru.mvista.com>
Date:	Tue, 24 Oct 2006 17:39:39 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] rest of works for migration to GENERIC_TIME
References: <20061023.033407.104640794.anemo@mba.ocn.ne.jp> <20061024.002127.74752850.anemo@mba.ocn.ne.jp>
In-Reply-To: <20061024.002127.74752850.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

>>Since we already moved to GENERIC_TIME, we should implement
>>alternatives of old do_gettimeoffset routines to get sub-jiffies
>>resolution from gettimeofday().  This patch includes:

> Take 2.  Changes from previous patch are:

> * Update against current git tree.
> * Just fix sb1250_hpt_setup typo.
> * Remove hack from jmr3927_hpt_read, bcm1480_hpt_read and add comments.

> Subject: [PATCH] rest of works for migration to GENERIC_TIME

> Since we already moved to GENERIC_TIME, we should implement
> alternatives of old do_gettimeoffset routines to get sub-jiffies
> resolution from gettimeofday().  This patch includes:

> * MIPS clocksource support (based on works by Manish Lachwani).
> * remove unused gettimeoffset routines and related codes.
> * remove unised 64bit do_div64_32().
> * simplify mips_hpt_init. (no argument needed, __init tag)

    It looks like this change might have broken some code...

> * simplify c0_hpt_timer_init. (no need to write to c0_count)
> * remove some hpt_init routines.
> * mips_hpt_mask variable to specify bitmask of hpt value.
> * convert jmr3927_do_gettimeoffset to jmr3927_hpt_read.
> * convert ip27_do_gettimeoffset to ip27_hpt_read.
> * convert bcm1480_do_gettimeoffset to bcm1480_hpt_read.
> * simplify sb1250 hpt functions. (no need to subtract and shift)

> Other than board independent part are not tested.  Please test if you
> have those platforms.  Thank you.

> diff --git a/arch/mips/dec/time.c b/arch/mips/dec/time.c
> index 4cf0c06..69e424e 100644
> --- a/arch/mips/dec/time.c
> +++ b/arch/mips/dec/time.c
> @@ -160,11 +160,6 @@ static unsigned int dec_ioasic_hpt_read(
>  	return ioasic_read(IO_REG_FCTR);
>  }
>  
> -static void dec_ioasic_hpt_init(unsigned int count)
> -{
> -	ioasic_write(IO_REG_FCTR, ioasic_read(IO_REG_FCTR) - count);
> -}
> -
>  
>  void __init dec_time_init(void)
>  {
> @@ -174,11 +169,9 @@ void __init dec_time_init(void)
>  	mips_timer_state = dec_timer_state;
>  	mips_timer_ack = dec_timer_ack;
>  
> -	if (!cpu_has_counter && IOASIC) {
> +	if (!cpu_has_counter && IOASIC)
>  		/* For pre-R4k systems we use the I/O ASIC's counter.  */
>  		mips_hpt_read = dec_ioasic_hpt_read;
> -		mips_hpt_init = dec_ioasic_hpt_init;
> -	}

    With mips_hpt_init() handler gone, how the initial value is loaded here?

WBR, Sergei
