Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Dec 2002 02:21:07 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:1272 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225256AbSLQCVG>;
	Tue, 17 Dec 2002 02:21:06 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id gBH2KoD28742;
	Mon, 16 Dec 2002 18:20:50 -0800
Date: Mon, 16 Dec 2002 18:20:50 -0800
From: Jun Sun <jsun@mvista.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: IDE module problem
Message-ID: <20021216182050.D11575@mvista.com>
References: <Pine.GSO.3.96.1021211181032.22157L-100000@delta.ds2.pg.gda.pl> <25550.1039661797@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <25550.1039661797@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Thu, Dec 12, 2002 at 01:56:37PM +1100
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 899
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 12, 2002 at 01:56:37PM +1100, Keith Owens wrote:
> On Wed, 11 Dec 2002 18:20:30 +0100 (MET), 
> "Maciej W. Rozycki" <macro@ds2.pg.gda.pl> wrote:
> >On Wed, 11 Dec 2002, Jun Sun wrote:
> >
> >> > > This is because arch/mips/lib/Makefile says:
> >> > > 
> >> > > obj-$(CONFIG_IDE)               += ide-std.o ide-no.o
> >> > [...]
> >> > > 3) use some smart trick in Makefile so that we include those
> >> > > two files only if CONFIG_IDE is 'y' or 'm'.  (How?)
> >> > 
> >> >  obj-$(CONFIG_IDE_MODULE)
> >> 
> >> This does not work.  Apparently, CONFIG_IDE_MODULE is not created 
> >> for makefile part.
> >
> > Indeed -- my fault.  Variables such as $(CONFIG_IDE) are four-state and
> >for the module case they are simply set to "m".  But then you can use
> >"ifeq ($(CONFIG_IDE),m)".  Another approach is to invent an additional
> >variable automatically set to "y" whenever CONFIG_IDE is enabled. 
> 
> obj-$(subst m,y,$(CONFIG_IDE)) += ide-std.o ide-no.o
> 
> ide-std.o ide-no.o are built in if CONFIG_IDE is m or y.
> 

This is the most clean solution so far.  Anybody would object
this change?

See the attached patch.

Jun

--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="021216-ide-module-obj.patch"

diff -Nru linux/arch/mips/lib/Makefile.orig linux/arch/mips/lib/Makefile
--- linux/arch/mips/lib/Makefile.orig	Sat Sep 28 15:28:38 2002
+++ linux/arch/mips/lib/Makefile	Mon Dec 16 18:13:43 2002
@@ -18,7 +18,7 @@
 endif
 
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy-no.o floppy-std.o
-obj-$(CONFIG_IDE)		+= ide-std.o ide-no.o
+obj-$(subst m,y,$(CONFIG_IDE))	+= ide-std.o ide-no.o
 obj-$(CONFIG_PC_KEYB)		+= kbd-std.o kbd-no.o
 
 include $(TOPDIR)/Rules.make
diff -Nru linux/arch/mips64/lib/Makefile.orig linux/arch/mips64/lib/Makefile
--- linux/arch/mips64/lib/Makefile.orig	Sat Sep 28 15:28:38 2002
+++ linux/arch/mips64/lib/Makefile	Mon Dec 16 18:17:20 2002
@@ -11,7 +11,7 @@
 	  strnlen_user.o watch.o
 
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy-no.o floppy-std.o
-obj-$(CONFIG_IDE)		+= ide-std.o ide-no.o
+obj-$(subst m,y,$(CONFIG_IDE))	+= ide-std.o ide-no.o
 obj-$(CONFIG_PC_KEYB)		+= kbd-std.o kbd-no.o
 
 include $(TOPDIR)/Rules.make

--LpQ9ahxlCli8rRTG--
