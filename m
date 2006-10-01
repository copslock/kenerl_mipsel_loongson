Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Oct 2006 15:31:02 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:29126 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037855AbWJAObB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 1 Oct 2006 15:31:01 +0100
Received: from localhost (p3194-ipad03funabasi.chiba.ocn.ne.jp [219.160.83.194])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id ED740A675; Sun,  1 Oct 2006 23:30:54 +0900 (JST)
Date:	Sun, 01 Oct 2006 23:33:06 +0900 (JST)
Message-Id: <20061001.233306.126574447.anemo@mba.ocn.ne.jp>
To:	girishvg@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, clameter@sgi.com
Subject: Re: [PATCH] fix size of zones_size and zholes_size array
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <E3B3A030-E8D0-4BC3-8924-E88B3B43E53F@gmail.com>
References: <20060930.033406.104030456.anemo@mba.ocn.ne.jp>
	<E3B3A030-E8D0-4BC3-8924-E88B3B43E53F@gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

CC-d to Christoph Lameter.

On Sat, 30 Sep 2006 03:41:39 +0900, girish <girishvg@gmail.com> wrote:
> On Sep 30, 2006, at 3:34 AM, Atsushi Nemoto wrote:
> 
> > The commit f06a96844a577c43249fce25809a4fae07407f46 broke mips.
> >
> > Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> >
> > diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
> > index a624778..2f346d1 100644
> > --- a/arch/mips/mm/init.c
> > +++ b/arch/mips/mm/init.c
> > @@ -357,10 +357,10 @@ static int __init page_is_ram(unsigned l
> >
> >  void __init paging_init(void)
> >  {
> > -	unsigned long zones_size[] = { 0, };
> > +	unsigned long zones_size[MAX_NR_ZONES] = { 0, };
> >  	unsigned long max_dma, high, low;
> >  #ifndef CONFIG_FLATMEM
> > -	unsigned long zholes_size[] = { 0, };
> > +	unsigned long zholes_size[MAX_NR_ZONES] = { 0, };
> >  	unsigned long i, j, pfn;
> >  #endif
> 
> Nemoto~san, this was your patch earlier.
> 
>   void __init paging_init(void)
>   {
> -	unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
> +	unsigned long zones_size[] = { [0 ... MAX_NR_ZONES - 1] = 0 };
>   	unsigned long max_dma, high, low;
> +#ifdef CONFIG_SPARSEMEM
> +	unsigned long zholes_size[] = { [0 ... MAX_NR_ZONES - 1] = 0 };
> +	unsigned long i, j, pfn;
> +#endif

Yes.  This is correct.  And then there was a conflict on this commit.

> commit f06a96844a577c43249fce25809a4fae07407f46
> Author: Christoph Lameter <clameter@sgi.com>
> Date:   Mon Sep 25 23:31:10 2006 -0700
>     [PATCH] reduce MAX_NR_ZONES: fix MAX_NR_ZONES array initializations

Perhaps his original patch was:

-	unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
+	unsigned long zones_size[MAX_NR_ZONES] = {0, };

This conflicted with my change.  Unfortunately the conflict was
resolved in wrong way, thus now we have this line:

	unsigned long zones_size[] = { 0, };

This time my patch is trying to get the original target.

---
Atsushi Nemoto
