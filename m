Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9QGd5823884
	for linux-mips-outgoing; Fri, 26 Oct 2001 09:39:05 -0700
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9QGd0023881;
	Fri, 26 Oct 2001 09:39:00 -0700
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f9QGcqE0004503;
	Fri, 26 Oct 2001 09:38:52 -0700
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f9QGcopD004499;
	Fri, 26 Oct 2001 09:38:51 -0700
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Fri, 26 Oct 2001 09:38:50 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
cc: ralf@oss.sgi.com, linux-mips@oss.sgi.com
Subject: Re: [PATCH] Various diffs that fix things.
In-Reply-To: <20011026.103741.41627158.nemoto@toshiba-tops.co.jp>
Message-ID: <Pine.LNX.4.10.10110260938230.2184-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Thank you for the below patch. Applied :-) 

> diff -urP -x CVS -x .cvsignore linux-sgi-cvs/include/asm-mips/cpu.h linux.new/include/asm-mips/cpu.h
> --- linux-sgi-cvs/include/asm-mips/cpu.h	Mon Oct 22 10:30:09 2001
> +++ linux.new/include/asm-mips/cpu.h	Fri Oct 26 10:31:19 2001
> @@ -55,6 +55,7 @@
>  #define PRID_IMP_R4640		0x2200
>  #define PRID_IMP_R4650		0x2200		/* Same as R4640 */
>  #define PRID_IMP_R5000		0x2300
> +#define PRID_IMP_TX49		0x2d00
>  #define PRID_IMP_SONIC		0x2400
>  #define PRID_IMP_MAGIC		0x2500
>  #define PRID_IMP_RM7000		0x2700
> @@ -87,6 +88,12 @@
>  #define PRID_REV_TX3912 	0x0010
>  #define PRID_REV_TX3922 	0x0030
>  #define PRID_REV_TX3927 	0x0040
> +#define PRID_REV_TX3927B 	0x0041
> +#define PRID_REV_TX39H3TEG 	0x0050
> +#define PRID_REV_TX4955		0x0011
> +#define PRID_REV_TX4955A	0x0020
> +#define PRID_REV_TX4927		0x0021
> +#define PRID_REV_TX4927R2	0x0022
>  
>  #ifndef  _LANGUAGE_ASSEMBLY
>  /*
> ---
> Atsushi Nemoto
> 
