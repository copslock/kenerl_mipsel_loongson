Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9OJnf701277
	for linux-mips-outgoing; Wed, 24 Oct 2001 12:49:41 -0700
Received: from smtp.lynuxworks.com ([207.21.185.24])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9OJnYD01274;
	Wed, 24 Oct 2001 12:49:34 -0700
Received: from lnxw.com (mastika.Lynx.com [172.17.127.85])
	by smtp.lynuxworks.com (8.11.2/8.9.3) with ESMTP id f9OJn8518872;
	Wed, 24 Oct 2001 12:49:08 -0700
Message-ID: <3BD71A69.99A23D18@lnxw.com>
Date: Wed, 24 Oct 2001 12:45:45 -0700
From: Petko Manolov <pmanolov@Lnxw.COM>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12 i686)
X-Accept-Language: en, bg
MIME-Version: 1.0
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
CC: ralf@oss.sgi.com, linux-mips@oss.sgi.com, kevink@mips.com
Subject: Re: Malta probs
References: <20011023224718.A6283@dea.linux-mips.net>
		<3BD5E193.BB41A907@lnxw.com>
		<20011024024308.A21460@dea.linux-mips.net> <20011024.220729.39150004.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Atsushi Nemoto wrote:
> 
> In current CVS, All handle_xxx exception handler seems to be complied
> with ".set mips3".  Here is a patch.  I think this patch solves the
> problem reported by Petko.

Yes, Atsushi is right. Adding .set mips0 solved the problem, but
after applying Ralf's patch to tlb-r4k.c

Ralf, i think the patch worth applying to the CVS tree.



	Petko

> diff -urP -x CVS -x .cvsignore linux-sgi-cvs/arch/mips/kernel/entry.S linux.new/arch/mips/kernel/entry.S
> --- linux-sgi-cvs/arch/mips/kernel/entry.S      Mon Oct 22 10:29:56 2001
> +++ linux.new/arch/mips/kernel/entry.S  Wed Oct 24 21:55:16 2001
> @@ -180,6 +180,7 @@
>                 END(except_vec3_r4000)
> 
>                 __FINIT
> +               .set    mips0
> 
>  /*
>   * Build a default exception handler for the exceptions that don't need
> ---
> Atsushi Nemoto
