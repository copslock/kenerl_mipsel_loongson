Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1FFIHI22635
	for linux-mips-outgoing; Fri, 15 Feb 2002 07:18:17 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1FFHg922629;
	Fri, 15 Feb 2002 07:17:43 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA05630;
	Fri, 15 Feb 2002 15:17:18 +0100 (MET)
Date: Fri, 15 Feb 2002 15:17:17 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Guido Guenther <agx@sigxcpu.org>
cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: ip22 watchdog timer
In-Reply-To: <20020215130613.A301@gandalf.physik.uni-konstanz.de>
Message-ID: <Pine.GSO.3.96.1020215150825.29773K-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 15 Feb 2002, Guido Guenther wrote:

> diff --exclude=CVS -Naur linux-2.4.17.orig/drivers/char/Config.in
> linux-2.4.17/drivers/char/Config.in
> --- linux-2.4.17.orig/drivers/char/Config.in    Sun Dec  2 12:34:40 2001
> +++ linux-2.4.17/drivers/char/Config.in Fri Feb 15 10:00:59 2002
> @@ -199,6 +199,7 @@
>     tristate '  SBC-60XX Watchdog Timer' CONFIG_60XX_WDT
>     tristate '  W83877F (EMACS) Watchdog Timer' CONFIG_W83877F_WDT
>     tristate '  ZF MachZ Watchdog' CONFIG_MACHZ_WDT
> +   tristate '  Indy/I2 Hardware Watchdog' CONFIG_INDYDOG
>  fi
>  endmenu

 This looks suspicious.  Haven't you meant "dep_tristate"?  Especially as
indydog.c doesn't seem to make any effort to validate it's running on the
system it thinks it is before poking random memory locations.  It won't
probably even compile for a non-MIPS kernel.

 BTW, why do people insist on sending patches as attachments -- it makes
commenting them helly twisted, sigh... 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
