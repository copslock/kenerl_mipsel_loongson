Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2003 18:00:58 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:1022 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225193AbTGWRAu>;
	Wed, 23 Jul 2003 18:00:50 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h6NH0hq17393;
	Wed, 23 Jul 2003 10:00:43 -0700
Date: Wed, 23 Jul 2003 10:00:43 -0700
From: Jun Sun <jsun@mvista.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: [patch] Generic time fixes
Message-ID: <20030723100043.M3135@mvista.com>
References: <20030722181430.I3135@mvista.com> <Pine.GSO.3.96.1030723164616.26641A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1030723164616.26641A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Jul 23, 2003 at 04:52:31PM +0200
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 23, 2003 at 04:52:31PM +0200, Maciej W. Rozycki wrote:
> On Tue, 22 Jul 2003, Jun Sun wrote:
> 
> > > > Isn't it cool to take care of the board-specific with the same interface
> > > > kernel time system uses?  Every MIPS board gets a basic RTC driver for free!
> > > 
> > >  Well, I'm not that convinced.  What's wrong with making real support for
> > > the RTC chip instead?
> > >
> > 
> > Nothing wrong with full RTC driver support - it is just that when
> > 30+ MIPS boards don't have to add #ifdef's to rtc.c and mc146818rtc.h
> > and hwclock still works people start appreciate more about the
> > existence of rtc_set_time().
> 
>  Hmm, but how many different RTC chips are out there?  I agree the current
> rtc.c/mc146818rtc.h implementation sucks, but it should be fixed and not
> worked around.
>

Most people seem to be happy with getting hwclock working.  rtc_set_time()
does allow a low-oevrhead way to implement a generic rtc driver which
makes hwclock happy.

I like see mc146818rtc related RTC go away eventually, but we don't have to 
agree on that right now.

> > If you really want, how about the following change:
> > 
> > 1) add set_rtc_mmss() function pointer in asm/time.h.
> > 2) set it equal to set_rtc_time in time_init().  Board can override
> >    this decision in board_timer_setup() for better performance.
> > 3) RTC update is changed to call set_rtc_mmss()
> > 
> > How does this sound?  It leaves all existing code unchanged, while
> > gives a way for optimization.  The default setting of set_rtc_mmss
> > to set_rtc_time makes logical sense too, because set_rtc_mmss is really
> > a "back door" version of set_rtc_time().
> 
>  That's just fine for me.
>

Something like the attached patch looks good to me.

Board now has the choice to implement either rtc_set_time, or
rtc_set_mmss, or both, or none.  Of course there are different
implications for each choice.  I probably should update the readme
a little too.

You can either include it in your next patch (if one is coming).  Or
just let me know and I will flesh it out and check it in.

Jun

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=junk

diff -Nru link/arch/mips/kernel/time.c.orig link/arch/mips/kernel/time.c
--- link/arch/mips/kernel/time.c.orig	Wed Jul 16 10:52:57 2003
+++ link/arch/mips/kernel/time.c	Wed Jul 23 09:52:53 2003
@@ -61,6 +61,7 @@
 
 unsigned long (*rtc_get_time)(void) = null_rtc_get_time;
 int (*rtc_set_time)(unsigned long) = null_rtc_set_time;
+int (*rtc_set_mmss)(unsigned long);
 
 
 /*
@@ -370,12 +371,16 @@
 	    xtime.tv_sec > last_rtc_update + 660 &&
 	    xtime.tv_usec >= 500000 - ((unsigned) tick) / 2 &&
 	    xtime.tv_usec <= 500000 + ((unsigned) tick) / 2) {
-		if (rtc_set_time(xtime.tv_sec) == 0) {
+		int ret;
+		if (rtc_set_mmss)
+			ret = rtc_set_mmss(xtime.tv_sec);
+		else
+			ret = rtc_set_time(xtime.tv_sec);
+		if (ret == 0) 
 			last_rtc_update = xtime.tv_sec;
-		} else {
-			last_rtc_update = xtime.tv_sec - 600;
+		else 
 			/* do it again in 60 s */
-		}
+			last_rtc_update = xtime.tv_sec - 600;
 	}
 	read_unlock (&xtime_lock);
 
diff -Nru link/include/asm-mips/time.h.orig link/include/asm-mips/time.h
--- link/include/asm-mips/time.h.orig	Wed Jul 16 11:49:53 2003
+++ link/include/asm-mips/time.h	Wed Jul 23 09:51:58 2003
@@ -27,9 +27,12 @@
  * RTC ops.  By default, they point a no-RTC functions.
  *	rtc_get_time - mktime(year, mon, day, hour, min, sec) in seconds.
  *	rtc_set_time - reverse the above translation and set time to RTC.
+ *	rtc_set_mmss - similar to rtc_set_time, but only mim and sec need
+ *			to be set.  Used by RTC sync-up.
  */
 extern unsigned long (*rtc_get_time)(void);
 extern int (*rtc_set_time)(unsigned long);
+extern int (*rtc_set_mmss)(unsigned long);
 
 /*
  * to_tm() converts system time back to (year, mon, day, hour, min, sec).

--FL5UXtIhxfXey3p5--
