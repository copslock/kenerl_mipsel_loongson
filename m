Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Oct 2007 15:36:39 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:31297 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S28574151AbXJ2Pg3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 29 Oct 2007 15:36:29 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id D62703ECB; Mon, 29 Oct 2007 08:35:56 -0700 (PDT)
Message-ID: <4725FDE5.70407@ru.mvista.com>
Date:	Mon, 29 Oct 2007 18:36:05 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Roel Kluin <12o3l@tiscali.nl>, linux-mips@linux-mips.org
Subject: Re: [PATCH] fix post-fence error
References: <47228018.8020202@tiscali.nl> <472328C2.4000002@ru.mvista.com> <47232C2D.8010002@tiscali.nl> <20071029150233.GA4165@linux-mips.org>
In-Reply-To: <20071029150233.GA4165@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17290
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ralf Baechle wrote:

>>Sergei Shtylyov wrote:

>>>   Could also add spaces between the operands and operators (like
>>>above/below), while at it...

>>like this?

> Thanks. I didn't like the magic numbers in the code so I went for below
> patch instead.

> Cheers,

>   Ralf

> From: Ralf Baechle <ralf@linux-mips.org>

> [MIPS] IRIX: Fix off-by-one error in signal compat code.

> Based on original patch by Roel Kluin <12o3l@tiscali.nl>.

> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

    I'm afraid this new patch is wrong...

> diff --git a/arch/mips/kernel/irixsig.c b/arch/mips/kernel/irixsig.c
> index a0a9105..5052f47 100644
> --- a/arch/mips/kernel/irixsig.c
> +++ b/arch/mips/kernel/irixsig.c
> @@ -24,8 +24,12 @@
>  
>  #define _BLOCKABLE (~(_S(SIGKILL) | _S(SIGSTOP)))
>  
> +#define _IRIX_NSIG		128
> +#define _IRIX_NSIG_BPW		BITS_PER_LONG
> +#define _IRIX_NSIG_WORDS	(_IRIX_NSIG / _IRIX_NSIG_BPW)
> +
>  typedef struct {
> -	unsigned long sig[4];
> +	unsigned long sig[_IRIX_NSIG_WORDS];
>  } irix_sigset_t;
>  
>  struct sigctx_irix5 {
> @@ -527,7 +531,7 @@ asmlinkage int irix_sigpoll_sys(unsigned long __user *set,
>  
>  		expire = schedule_timeout_interruptible(expire);
>  
> -		for (i=0; i<=4; i++)
> +		for (i=0; i < _IRIX_NSIG_BPW; i++)

    Did you mean _IRIX_NSIG_WORDS? :-/

>  			tmp |= (current->pending.signal.sig[i] & kset.sig[i]);
>  
>  		if (tmp)

WBR, Sergei
