Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBDIT4p21475
	for linux-mips-outgoing; Thu, 13 Dec 2001 10:29:04 -0800
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBDISro21472
	for <linux-mips@oss.sgi.com>; Thu, 13 Dec 2001 10:28:53 -0800
Received: from agx by gandalf.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 16EZf7-0001yq-00; Thu, 13 Dec 2001 18:28:49 +0100
Date: Thu, 13 Dec 2001 18:28:49 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: Florian Lohoff <flo@rfc822.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: Current CVS on Indigo2 fail
Message-ID: <20011213182849.A7585@gandalf.physik.uni-konstanz.de>
Mail-Followup-To: Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
References: <20011213123522.GA32232@paradigm.rfc822.org> <20011213135229.C14699@gandalf.physik.uni-konstanz.de> <20011213134827.GA5630@paradigm.rfc822.org> <20011213150622.A13394@galadriel.physik.uni-konstanz.de> <20011213171043.GD25296@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011213171043.GD25296@paradigm.rfc822.org>; from flo@rfc822.org on Thu, Dec 13, 2001 at 06:10:43PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Dec 13, 2001 at 06:10:43PM +0100, Florian Lohoff wrote:
> On Thu, Dec 13, 2001 at 03:06:22PM +0100, Guido Guenther wrote:
> > > Definitly ? Mind sending me (the list) the patches too ?
> > an old version is at:
> >  http://honk.physik.uni-konstanz.de/~agx/linux-mips/unsorted-patches/newport-dont-crash-i2-2001-03-25.diff
> > This currently doesn't apply cleanly due to the arch/mips/kernel/sgi to
> > arch/mips/sgi-ip22 movement, but that's just a one line change. I'll
> > update it when back home.
> 
> It solved the issue ... Here is the patch against current cvs
Which is exactly what I sent to Ralf just yesterday evening ;-)
 -- Guido

> 
> 
> Index: arch/mips/config.in
> ===================================================================
> RCS file: /cvs/linux/arch/mips/config.in,v
> retrieving revision 1.154.2.3
> diff -u -r1.154.2.3 config.in
> --- arch/mips/config.in	2001/12/11 18:39:48	1.154.2.3
> +++ arch/mips/config.in	2001/12/13 18:10:33
> @@ -556,11 +556,10 @@
>     comment 'SGI Character devices'
>     if [ "$CONFIG_VT" = "y" ]; then
>        tristate 'SGI Newport Console support' CONFIG_SGI_NEWPORT_CONSOLE
> -      if [ "$CONFIG_SGI_NEWPORT_CONSOLE" != "y" ]; then
> -	 define_bool CONFIG_DUMMY_CONSOLE y
> -      else
> +      if [ "$CONFIG_SGI_NEWPORT_CONSOLE" = "y" ]; then
>  	 define_bool CONFIG_FONT_8x16 y
>        fi
> +      define_bool CONFIG_DUMMY_CONSOLE y
>     fi
>     endmenu
>  fi
> Index: arch/mips/sgi-ip22/ip22-setup.c
> ===================================================================
> RCS file: /cvs/linux/arch/mips/sgi-ip22/ip22-setup.c,v
> retrieving revision 1.1.2.1
> diff -u -r1.1.2.1 ip22-setup.c
> --- arch/mips/sgi-ip22/ip22-setup.c	2001/12/07 15:45:29	1.1.2.1
> +++ arch/mips/sgi-ip22/ip22-setup.c	2001/12/13 18:10:33
> @@ -182,19 +182,23 @@
>  
>  #ifdef CONFIG_VT
>  #ifdef CONFIG_SGI_NEWPORT_CONSOLE
> -	conswitchp = &newport_con;
> +	if( mips_machtype == MACH_SGI_INDY ) {
> +		conswitchp = &newport_con;
>  
> -	screen_info = (struct screen_info) {
> -		0, 0,		/* orig-x, orig-y */
> -		0,		/* unused */
> -		0,		/* orig_video_page */
> -		0,		/* orig_video_mode */
> -		160,		/* orig_video_cols */
> -		0, 0, 0,	/* unused, ega_bx, unused */
> -		64,		/* orig_video_lines */
> -		0,		/* orig_video_isVGA */
> -		16		/* orig_video_points */
> -	};
> +		screen_info = (struct screen_info) {
> +			0, 0,		/* orig-x, orig-y */
> +			0,		/* unused */
> +			0,		/* orig_video_page */
> +			0,		/* orig_video_mode */
> +			160,		/* orig_video_cols */
> +			0, 0, 0,	/* unused, ega_bx, unused */
> +			64,		/* orig_video_lines */
> +			0,		/* orig_video_isVGA */
> +			16		/* orig_video_points */
> +		};
> +	} else {
> +		conswitchp = &dummy_con;
> +	}
>  #else
>  	conswitchp = &dummy_con;
>  #endif
> 
> Flo
> -- 
> Florian Lohoff                  flo@rfc822.org             +49-5201-669912
> Nine nineth on september the 9th              Welcome to the new billenium



-- 
This kind of limitation can lead administrators to do irrational things,
      like install Windows. Clearly a fix was required. (lwn.net)
