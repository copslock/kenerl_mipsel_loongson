Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2007 14:18:00 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:44768 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20032164AbXKGOR6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 Nov 2007 14:17:58 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lA7EHvcV001868;
	Wed, 7 Nov 2007 14:17:57 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lA7EHvbx001867;
	Wed, 7 Nov 2007 14:17:57 GMT
Date:	Wed, 7 Nov 2007 14:17:57 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Fix and cleanup the MIPS part of the (ab)use of
	CLOCK_TICK_RATE.
Message-ID: <20071107141757.GB1022@linux-mips.org>
References: <S20025770AbXKAPqq/20071101154646Z+4363@ftp.linux-mips.org> <20071107.231036.75185559.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071107.231036.75185559.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 07, 2007 at 11:10:36PM +0900, Atsushi Nemoto wrote:

> The CLOCK_TICK_RATE is used for ACTHZ, TICK_NSEC, etc.
> 
> At least for i8253-free platforms, It looks a value multiple of HZ
> would be better for such constants, assuming we have dyntick or
> accurate HZ clockevents.
> 
> How about something like this?
> 
> diff --git a/include/asm-mips/timex.h b/include/asm-mips/timex.h
> index 5816ad1..e9622b6 100644
> --- a/include/asm-mips/timex.h
> +++ b/include/asm-mips/timex.h
> @@ -18,7 +18,11 @@
>   * So keeping it defined to the number for the PIT is the only sane thing
>   * for now.
>   */
> +#ifdef CONFIG_I8253
>  #define CLOCK_TICK_RATE 1193182
> +#else
> +#define CLOCK_TICK_RATE 1024000	/* multiple of HZ */
> +#endif

kernel/time/ntp.c:#define CLOCK_TICK_OVERFLOW   (LATCH * HZ - CLOCK_TICK_RATE)
kernel/time/ntp.c:                                      (s64)CLOCK_TICK_RATE)

drivers/char/vt_ioctl.c:                        arg = CLOCK_TICK_RATE / arg;
drivers/char/vt_ioctl.c:                        count = CLOCK_TICK_RATE / count;

There is so much abuse of this variable, it's not even funny.  It really
deserve to be taken out and shot.  And that's just two cases.

  Ralf
