Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2008 17:32:13 +0100 (BST)
Received: from astoria.ccjclearline.com ([64.235.106.9]:20120 "EHLO
	astoria.ccjclearline.com") by ftp.linux-mips.org with ESMTP
	id S28581208AbYGPQcL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Jul 2008 17:32:11 +0100
Received: from cpe00195b4acfae-cm001868e2bdba.cpe.net.cable.rogers.com ([99.236.99.222] helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1KJ9vE-0007LS-FG; Wed, 16 Jul 2008 12:32:08 -0400
Date:	Wed, 16 Jul 2008 12:31:15 -0400 (EDT)
From:	"Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:	Adrian Bunk <bunk@kernel.org>
cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [2.6 patch] mips/sgi-ip22/ip28-berr.c: fix the build
In-Reply-To: <20080716162540.GB17329@cs181140183.pp.htv.fi>
Message-ID: <alpine.LFD.1.10.0807161230360.12718@localhost.localdomain>
References: <20080716162540.GB17329@cs181140183.pp.htv.fi>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <rpjday@crashcourse.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpjday@crashcourse.ca
Precedence: bulk
X-list: linux-mips

On Wed, 16 Jul 2008, Adrian Bunk wrote:

> Commit 52f4f6bbcff5510f662a002ec1219660ea25af62
> ([MIPS] Use kernel-supplied ARRAY_SIZE() macro.)
> causes the following compile error:
>
> <--  snip  -->
>
> ...
>   CC      arch/mips/sgi-ip22/ip28-berr.o
> /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/sgi-ip22/ip28-berr.c: In function 'ip28_be_interrupt':
> /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/sgi-ip22/ip28-berr.c:415: error: subscripted value is neither array nor pointer
> /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/sgi-ip22/ip28-berr.c:415: error: subscripted value is neither array nor pointer
> /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/sgi-ip22/ip28-berr.c:415: warning: type defaults to 'int' in declaration of 'type name'
> /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/sgi-ip22/ip28-berr.c:424: error: subscripted value is neither array nor pointer
> /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/sgi-ip22/ip28-berr.c:424: error: subscripted value is neither array nor pointer
> /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/sgi-ip22/ip28-berr.c:424: warning: type defaults to 'int' in declaration of 'type name'
> make[2]: *** [arch/mips/sgi-ip22/ip28-berr.o] Error 1
>
> <--  snip  -->
>
> Using ARRAY_SIZE in these places in arch/mips/sgi-ip22/ip28-berr.c was
> bogus, and therefore gets reverted by this patch.
>
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
>
> ---
>
>  arch/mips/sgi-ip22/ip28-berr.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --- a/arch/mips/sgi-ip22/ip28-berr.c
> +++ b/arch/mips/sgi-ip22/ip28-berr.c
> @@ -412,7 +412,7 @@ static int ip28_be_interrupt(const struct pt_regs *regs)
>  	 * Now we have an asynchronous bus error, speculatively or DMA caused.
>  	 * Need to search all DMA descriptors for the error address.
>  	 */
> -	for (i = 0; i < ARRAY_SIZE(hpc3); ++i) {
> +	for (i = 0; i < sizeof(hpc3)/sizeof(struct hpc3_stat); ++i) {
>  		struct hpc3_stat *hp = (struct hpc3_stat *)&hpc3 + i;
>  		if ((cpu_err_stat & CPU_ERRMASK) &&
>  		    (cpu_err_addr == hp->ndptr || cpu_err_addr == hp->cbp))
> @@ -421,7 +421,7 @@ static int ip28_be_interrupt(const struct pt_regs *regs)
>  		    (gio_err_addr == hp->ndptr || gio_err_addr == hp->cbp))
>  			break;
>  	}
> -	if (i < ARRAY_SIZE(hpc3)) {
> +	if (i < sizeof(hpc3)/sizeof(struct hpc3_stat)) {
>  		struct hpc3_stat *hp = (struct hpc3_stat *)&hpc3 + i;
>  		printk(KERN_ERR "at DMA addresses: HPC3 @ %08lx:"
>  		       " ctl %08x, ndp %08x, cbp %08x\n",

quite right, that was a really dumb transformation.  my bad.

rday
--

========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry:
    Have classroom, will lecture.

http://crashcourse.ca                          Waterloo, Ontario, CANADA
========================================================================
