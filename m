Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2006 15:48:12 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:44305 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133495AbWAPPry (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Jan 2006 15:47:54 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 8232A64D54; Mon, 16 Jan 2006 15:51:23 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id D70938517; Mon, 16 Jan 2006 15:51:10 +0000 (GMT)
Date:	Mon, 16 Jan 2006 15:51:10 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Kaj-Michael Lang <milang@tal.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix serial console detection
Message-ID: <20060116155110.GC26771@deprecation.cyrius.com>
References: <Pine.LNX.4.61.0502141602080.24829@tori.tal.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0502141602080.24829@tori.tal.org>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9893
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Kaj-Michael Lang <milang@tal.org> [2005-02-14 16:08]:
> In ip22-setup.c the checks for serial/graphics console logic does
> not check if ARCS console=g but the machine is using serial console, as
> it does if no keyboard is attached.
> 
> This patch adds a check if ConsoleOut is serial. There might also be 
> support for other graphics than Newport soon...

Ralf, are there any objections to this patch or did you simply forget
to apply it?

> Index: arch/mips/sgi-ip22/ip22-setup.c
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/sgi-ip22/ip22-setup.c,v
> retrieving revision 1.44
> diff -u -r1.44 ip22-setup.c
> --- arch/mips/sgi-ip22/ip22-setup.c	10 Dec 2004 13:31:42 -0000	1.44
> +++ arch/mips/sgi-ip22/ip22-setup.c	14 Feb 2005 13:57:33 -0000
> @@ -56,6 +56,7 @@
>  static int __init ip22_setup(void)
>  {
>  	char *ctype;
> +	char *cserial;
> 
>  	board_be_init = ip22_be_init;
>  	ip22_time_init();
> @@ -81,9 +82,14 @@
>  	/* ARCS console environment variable is set to "g?" for
>  	 * graphics console, it is set to "d" for the first serial
>  	 * line and "d2" for the second serial line.
> +	 *
> +	 * Need to check if the case is 'g' but no keyboard:
> +	 * (ConsoleIn/Out = serial )
>  	 */
>  	ctype = ArcGetEnvironmentVariable("console");
> -	if (ctype && *ctype == 'd') {
> +	cserial = ArcGetEnvironmentVariable("ConsoleOut");
> +
> +	if ( (ctype && *ctype == 'd') || (cserial && *cserial == 's')) {
>  		static char options[8];
>  		char *baud = ArcGetEnvironmentVariable("dbaud");
>  		if (baud)
> @@ -91,7 +97,7 @@
>  		add_preferred_console("ttyS", *(ctype + 1) == '2' ? 1 : 0,
>  				      baud ? options : NULL);
>  	} else if (!ctype || *ctype != 'g') {
> -		/* Use ARC if we don't want serial ('d') or Newport ('g'). */
> +		/* Use ARC if we don't want serial ('d') or Graphics ('g'). 
> */
>  		prom_flags |= PROM_FLAG_USE_AS_CONSOLE;
>  		add_preferred_console("arc", 0, NULL);
>  	}
> 

-- 
Martin Michlmayr
http://www.cyrius.com/
