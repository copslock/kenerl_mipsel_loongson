Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2007 20:59:31 +0100 (BST)
Received: from proxima.lp0.eu ([85.158.45.36]:26811 "EHLO proxima.lp0.eu")
	by ftp.linux-mips.org with ESMTP id S20021939AbXEKT73 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2007 20:59:29 +0100
Received: from redrum.lp0.eu ([2001:4b10:1005:0:202:44ff:fe50:91af]:54706 ident=byte)
	by proxima.lp0.eu with esmtps (TLSv1:AES256-SHA:256)
	id 1HmbDt-0000j5-OT; Fri, 11 May 2007 20:56:18 +0100
Message-ID: <4644CA60.8080809@simon.arlott.org.uk>
Date:	Fri, 11 May 2007 20:56:16 +0100
From:	Simon Arlott <simon@fire.lp0.eu>
User-Agent: Thunderbird 1.5.0.5 (X11/20060819)
MIME-Version: 1.0
To:	Simon Arlott <simon@fire.lp0.eu>
CC:	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org, trivial@kernel.org
Subject: Re: [PATCH] spelling fixes: arch/mips/
References: <4644C721.501@simon.arlott.org.uk>
In-Reply-To: <4644C721.501@simon.arlott.org.uk>
X-Enigmail-Version: 0.94.1.2
OpenPGP: id=89C93563
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15049
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: simon@fire.lp0.eu
Precedence: bulk
X-list: linux-mips

On 11/05/07 20:42, Simon Arlott wrote:
> diff --git a/arch/mips/kernel/semaphore.c b/arch/mips/kernel/semaphore.c
> index 1265358..b363604 100644
> --- a/arch/mips/kernel/semaphore.c
> +++ b/arch/mips/kernel/semaphore.c
> @@ -33,7 +33,7 @@
>  *    return old_count;
>  *
>  * On machines without lld/scd we need a spinlock to make the 
> manipulation of
> - * sem->count and sem->waking atomic.  Scalability isn't an issue because
> + * sem->count and sem->waking atomic.  Scalibility isn't an issue because
>  * this lock is used on UP only so it's just an empty variable.
>  */
> static inline int __sem_update_count(struct semaphore *sem, int incr)

I thought I'd reverted that mistake... it was correct already, too many 
"capability" fixes confusing me :/

-- 
Simon Arlott
