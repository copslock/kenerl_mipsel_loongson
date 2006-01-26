Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2006 01:25:05 +0000 (GMT)
Received: from rtsoft2.corbina.net ([85.21.88.2]:23431 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133528AbWAZBYq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jan 2006 01:24:46 +0000
Received: (qmail 26622 invoked from network); 26 Jan 2006 01:29:07 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 26 Jan 2006 01:29:07 -0000
Message-ID: <43D826A3.80505@ru.mvista.com>
Date:	Thu, 26 Jan 2006 04:32:19 +0300
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MostaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Alexey Dobriyan <adobriyan@gmail.com>
CC:	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernle.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] mips: gdb-stub.c: fix parse error before ; token
References: <20060126012925.GB11091@mipter.zuzino.mipt.ru>
In-Reply-To: <20060126012925.GB11091@mipter.zuzino.mipt.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Alexey Dobriyan wrote:


> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  arch/mips/kernel/gdb-stub.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/arch/mips/kernel/gdb-stub.c
> +++ b/arch/mips/kernel/gdb-stub.c
> @@ -178,7 +178,7 @@ int kgdb_enabled;
>   */
>  static DEFINE_SPINLOCK(kgdb_lock);
>  static raw_spinlock_t kgdb_cpulock[NR_CPUS] = {
> -	[0 ... NR_CPUS-1] = __RAW_SPIN_LOCK_UNLOCKED;
> +	[0 ... NR_CPUS-1] = __RAW_SPIN_LOCK_UNLOCKED,
>  };
>  
>  /*

    I have already posted this patch, to no avail so far -- Ralf doesn't use 
KGDB. ;-)

http://www.linux-mips.org/archives/linux-mips/2006-01/msg00027.html

(forgot to sign-off it as usual)

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

WBR, Sergei
