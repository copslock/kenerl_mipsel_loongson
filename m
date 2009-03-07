Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Mar 2009 09:37:36 +0000 (GMT)
Received: from fnoeppeil36.netpark.at ([217.175.205.164]:55176 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S21366536AbZCGJhc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 7 Mar 2009 09:37:32 +0000
Received: (qmail 20076 invoked from network); 7 Mar 2009 10:37:31 +0100
Received: from scarran.roarinelk.net (192.168.0.242)
  by fnoeppeil36.netpark.at with SMTP; 7 Mar 2009 10:37:31 +0100
Date:	Sat, 7 Mar 2009 10:37:31 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Kevin Hickey <khickey@rmicorp.com>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	Kevin Hickey <khickey@rmicorp.com>
Subject: Re: [PATCH 08/10] Alchemy: DB1300 blink leds on timer tick
Message-ID: <20090307103731.4660e57f@scarran.roarinelk.net>
In-Reply-To: <be27dee4c591cdb1ea1b9517bee2b825657024f5.1236354153.git.khickey@rmicorp.com>
References: <1236356409-32357-1-git-send-email-khickey@rmicorp.com>
	<788248524efc28ba2608ed79bfb7080ee476b12d.1236354153.git.khickey@rmicorp.com>
	<0b447f7e26be90a9179bdf89ca2cfd1f34c5d16e.1236354153.git.khickey@rmicorp.com>
	<7afc5c84989c4bc0f94181397369f284f2bb6924.1236354153.git.khickey@rmicorp.com>
	<0946334bbaf9883076889fe060a362b72d31e6f4.1236354153.git.khickey@rmicorp.com>
	<394c116b9fa5bd1865ac21d11185f09e07bd2ab5.1236354153.git.khickey@rmicorp.com>
	<7e632686ab9b29a94eefeb2e5dca8b091a956b95.1236354153.git.khickey@rmicorp.com>
	<df58b8408730cf0eee532a93f0b6234ac709663c.1236354153.git.khickey@rmicorp.com>
	<be27dee4c591cdb1ea1b9517bee2b825657024f5.1236354153.git.khickey@rmicorp.com>
Organization: Private
X-Mailer: Claws Mail 3.7.0 (GTK+ 2.14.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22030
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Fri,  6 Mar 2009 10:20:07 -0600
Kevin Hickey <khickey@rmicorp.com> wrote:

> Blinks the dots on the hex display on the DB1300 board every 1000 timer ticks.
> This can help tell the difference between a soft and hard hung board.
> 
> Signed-off-by: Kevin Hickey <khickey@rmicorp.com>
> ---
>  arch/mips/alchemy/common/time.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/alchemy/common/time.c b/arch/mips/alchemy/common/time.c
> index f58d4ff..2b2f6bf 100644
> --- a/arch/mips/alchemy/common/time.c
> +++ b/arch/mips/alchemy/common/time.c
> @@ -39,6 +39,10 @@
>  #include <asm/time.h>
>  #include <asm/mach-au1x00/au1000.h>
>  
> +#ifdef CONFIG_MIPS_DB1300
> +#include <dev_boards.h>
> +#endif
> +
>  /* 32kHz clock enabled and detected */
>  #define CNTR_OK (SYS_CNTRL_E0 | SYS_CNTRL_32S)
>  
> @@ -60,6 +64,11 @@ static struct clocksource au1x_counter1_clocksource = {
>  static int au1x_rtcmatch2_set_next_event(unsigned long delta,
>  					 struct clock_event_device *cd)
>  {
> +#ifdef CONFIG_MIPS_DB1300
> +	static u8 dots = 1;
> +	static u32 delayer = 0;
> +#endif
> +
>  	delta += au_readl(SYS_RTCREAD);
>  	/* wait for register access */
>  	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_M21)
> @@ -67,6 +76,13 @@ static int au1x_rtcmatch2_set_next_event(unsigned long delta,
>  	au_writel(delta, SYS_RTCMATCH2);
>  	au_sync();
>  
> +#ifdef CONFIG_MIPS_DB1300
> +	if (++delayer % 1000 == 0) {
> +		db_set_hex_dots(dots++);
> +		dots %= 4;
> +	}
> +#endif
> +
>  	return 0;
>  }
>  

Please don't do that.  I'd still like to get all devboard hackery out
of code in common/ (at least for mainline kernels; what you do to the
RMI-sources I don't care about).

(btw, I made something similar for the DB1200 a while ago:
 http://mlau.at/files/au1xxx-updates/4040-Alchemy-DB1200-cpu-idle-counter.patch
)

Best regards,
	Manuel Lauss
