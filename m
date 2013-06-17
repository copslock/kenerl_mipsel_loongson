Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jun 2013 19:03:13 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:42346 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6835849Ab3FQRDKnzQgD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Jun 2013 19:03:10 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5HH35Bk019187;
        Mon, 17 Jun 2013 19:03:06 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5HH34Dc019186;
        Mon, 17 Jun 2013 19:03:04 +0200
Date:   Mon, 17 Jun 2013 19:03:04 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org, sibyte-users@bitmover.com,
        Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 5/7] drivers: watchdog: sb_wdog: Fix 32bit linking
 problems
Message-ID: <20130617170304.GF10408@linux-mips.org>
References: <1371477641-7989-1-git-send-email-markos.chandras@imgtec.com>
 <1371477641-7989-6-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1371477641-7989-6-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Mon, Jun 17, 2013 at 03:00:39PM +0100, Markos Chandras wrote:

> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
> Cc: sibyte-users@bitmover.com
> Cc: Wim Van Sebroeck <wim@iguana.be>
> ---
>  drivers/watchdog/sb_wdog.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/sb_wdog.c b/drivers/watchdog/sb_wdog.c
> index 25c7a3f..2ea0427 100644
> --- a/drivers/watchdog/sb_wdog.c
> +++ b/drivers/watchdog/sb_wdog.c
> @@ -170,6 +170,7 @@ static long sbwdog_ioctl(struct file *file, unsigned int cmd,
>  						unsigned long arg)
>  {
>  	int ret = -ENOTTY;
> +	u64 tmp_user_dog;
>  	unsigned long time;
>  	void __user *argp = (void __user *)arg;
>  	int __user *p = argp;
> @@ -208,7 +209,9 @@ static long sbwdog_ioctl(struct file *file, unsigned int cmd,
>  		 * get the remaining count from the ... count register
>  		 * which is 1*8 before the config register
>  		 */
> -		ret = put_user(__raw_readq(user_dog - 8) / 1000000, p);
> +		tmp_user_dog = __raw_readq(user_dog - 8);
> +		tmp_user_dog = do_div(tmp_user_dog, 1000000);
> +		ret = put_user(tmp_user_dog, p);

In effect the code with your change now does:

		ret = put_user(__raw_readq(user_dog - 8) % 1000000, p);

No good.

		tmp_user_dog = __raw_readq(user_dog - 8);
		do_div(tmp_user_dog, 1000000);
		ret = put_user(tmp_user_dog, p);

Should to the right thing.

I'm not surprised you're finding bugs in 32 bit Sibyte kernel.  At heart,
the Sibyte SOCs are 64 bit and their architecture limits them to support
256MB memory with a 32 bit kernel without highmem.  Highmem though
supported is stupid and leaves as the only sane option 64 bit kernels
and virtually every user has done that, not last to get full fp performance
which is only available with the N32 / N64 ABIs.  Oh, and of course many
registers need to be accessed 64 bit wide, which on a 32 bit kernel
requires a local_irq_disable ...  local_irq_enable around the actual
access.

In short, nobody but a few diehard backward folks have ever been using
32 bit kernels on Sibyte hardware, so finding such an issue is not really
a surprise.

  Ralf
