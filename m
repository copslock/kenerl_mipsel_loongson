Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBUNRGj21624
	for linux-mips-outgoing; Sun, 30 Dec 2001 15:27:16 -0800
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBUNRAg21620
	for <linux-mips@oss.sgi.com>; Sun, 30 Dec 2001 15:27:10 -0800
Received: from uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA07237
	for <linux-mips@oss.sgi.com>; Fri, 28 Dec 2001 07:26:34 -0800 (PST)
	mail_from (ralf@linux-mips.net)
Received: from eddie (root@eddie.uni-koblenz.de [141.26.4.17])
	by uni-koblenz.de (8.9.3/8.9.3) with SMTP id QAA02043
	for <linux-mips@oss.sgi.com>; Fri, 28 Dec 2001 16:23:23 +0100 (MET)
Received: from dea.linux-mips.net by eddie (SMI-8.6/KO-2.0)
	id QAA23484; Fri, 28 Dec 2001 16:23:20 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fBSEtKX01726;
	Fri, 28 Dec 2001 12:55:20 -0200
Date: Fri, 28 Dec 2001 12:55:20 -0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
Cc: linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: weekly O2 patches ;)
Message-ID: <20011228125520.A1323@dea.linux-mips.net>
References: <Pine.LNX.4.21.0112221928160.13229-300000@melkor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0112221928160.13229-300000@melkor>; from vivien.chappelier@enst-bretagne.fr on Sat, Dec 22, 2001 at 07:28:44PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Dec 22, 2001 at 07:28:44PM +0100, Vivien Chappelier wrote:

> diff -Naur linux/arch/mips64/mm/r4xx0.c linux.patch/arch/mips64/mm/r4xx0.c
> --- linux/arch/mips64/mm/r4xx0.c	Sun Dec  9 15:47:14 2001
> +++ linux.patch/arch/mips64/mm/r4xx0.c	Thu Dec 20 19:04:46 2001
> @@ -2141,9 +2141,17 @@
>  	unsigned long flags, addr, begin, end, pow2;
>  	int tmp;
>  
> -	tmp = ((config >> 17) & 1);
> +	/* XXX: disabling secondary cache for now */
> +	change_cp0_config(CONF_SE, 0);	
> +
> +	tmp = ((config >> 17) & 1); /* check if cache present */
>  	if(tmp)
>  		return 0;
> +
> +	tmp = ((config >> 12) & 1); /* check if cache enabled */
> +	if(!tmp)
> +		return 0;
> +
>  	tmp = ((config >> 22) & 3);
>  	switch(tmp) {
>  	case 0:

Perfect.  You just broke R4000SC / R4400SC.

  Ralf
