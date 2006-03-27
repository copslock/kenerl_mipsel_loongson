Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Mar 2006 09:24:15 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:26093 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133406AbWC0IYG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Mar 2006 09:24:06 +0100
Received: (qmail 10408 invoked from network); 27 Mar 2006 12:34:18 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 27 Mar 2006 12:34:18 -0000
Message-ID: <4427A31F.9080801@ru.mvista.com>
Date:	Mon, 27 Mar 2006 12:32:31 +0400
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Freddy Spierenburg <freddy@dusktilldawn.nl>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] small time list process error in prom_getenv()
References: <20060327074352.GC4781@dusktilldawn.nl>
In-Reply-To: <20060327074352.GC4781@dusktilldawn.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Freddy Spierenburg wrote:

> I found a small time bug in prom_getenv() for which I like to
> share the fix with y'all.
> 
> prom_envp is an array with two elements per environment variable.
> So for instance element 0 is memsize and element 1 is 0x08000000
> for the environment variable memsize=0x08000000.
> 
> The code for prom_getenv() only skips one element when it's in
> search for the next environment variable. It should of course
> step two elements.

> I found this error in two files and for both I include a patch to
> fix the problem.

    I'm seeing such code in 3 files (arch/mips/ite-boards/generic/pmon_prom.c)
but that doesn't mean all of'em are incorrect. Alachemy code is though, since 
hose target use YAMON which passes environment args the described way. Though 
really, that code may be written this way on purpose -- like to fit both 
PMON's and YAMON's way of passing the environment...

> Signed-off-by: Freddy Spierenburg <freddy@dusktilldawn.nl>

    NAK. 'val' field of 't_env_var' should be uncommented instead.

> ------------------------------------------------------------------------
> 
> diff -Naur linux.orig/arch/mips/philips/pnx8550/common/prom.c linux/arch/mips/philips/pnx8550/common/prom.c
> --- linux.orig/arch/mips/philips/pnx8550/common/prom.c	2006-03-22 15:25:58.000000000 +0000
> +++ linux/arch/mips/philips/pnx8550/common/prom.c	2006-03-22 15:25:23.000000000 +0000
> @@ -70,7 +70,7 @@
>  		if(strncmp(envname, env->name, i) == 0) {
>  			return(env->name + strlen(envname) + 1);
>  		}
> -		env++;
> +		env+=2;
>  	}
>  	return(NULL);
>  }

    Not sure what loader the Philips target uses...

> ------------------------------------------------------------------------
> 
> diff -Naur linux.orig/arch/mips/au1000/common/prom.c linux/arch/mips/au1000/common/prom.c
> --- linux.orig/arch/mips/au1000/common/prom.c	2006-03-22 15:11:09.000000000 +0000
> +++ linux/arch/mips/au1000/common/prom.c	2006-03-22 15:16:22.000000000 +0000
> @@ -97,7 +97,7 @@
>  		if(strncmp(envname, env->name, i) == 0) {
>  			return(env->name + strlen(envname) + 1);

                         return env->val;

>  		}
> -		env++;
> +		env+=2;

    Should be left alone.

>  	}
>  	return(NULL);
>  }

WBR, Sergei
