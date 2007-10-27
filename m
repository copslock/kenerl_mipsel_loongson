Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Oct 2007 13:02:42 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:12550 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20029768AbXJ0MCd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 27 Oct 2007 13:02:33 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 8F87B3ECB; Sat, 27 Oct 2007 05:02:00 -0700 (PDT)
Message-ID: <472328C2.4000002@ru.mvista.com>
Date:	Sat, 27 Oct 2007 16:02:10 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Roel Kluin <12o3l@tiscali.nl>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix post-fence error
References: <47228018.8020202@tiscali.nl>
In-Reply-To: <47228018.8020202@tiscali.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Roel Kluin wrote:

> In the same file:

> typedef struct {
>         unsigned long sig[4];
> } irix_sigset_t;
> ---
> diff --git a/arch/mips/kernel/irixsig.c b/arch/mips/kernel/irixsig.c
> index a0a9105..d65c51c 100644
> --- a/arch/mips/kernel/irixsig.c
> +++ b/arch/mips/kernel/irixsig.c
> @@ -527,7 +527,7 @@ asmlinkage int irix_sigpoll_sys(unsigned long __user *set,
>  
>  		expire = schedule_timeout_interruptible(expire);
>  
> -		for (i=0; i<=4; i++)
> +		for (i=0; i<4; i++)

    Could also add spaces between the operands and operators (like 
above/below), while at it...

>  			tmp |= (current->pending.signal.sig[i] & kset.sig[i]);

WBR, Sergei
