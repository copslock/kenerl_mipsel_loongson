Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Nov 2002 23:23:21 +0100 (CET)
Received: from gateway-1237.mvista.com ([12.44.186.158]:31473 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S1121743AbSKGWXU>;
	Thu, 7 Nov 2002 23:23:20 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id gA7MN5N29499;
	Thu, 7 Nov 2002 14:23:05 -0800
Date: Thu, 7 Nov 2002 14:23:04 -0800
From: Jun Sun <jsun@mvista.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: make xmenuconfig is broken
Message-ID: <20021107142304.B27505@mvista.com>
References: <Pine.GSO.3.96.1021030135048.1859E-100000@delta.ds2.pg.gda.pl> <Pine.GSO.3.96.1021107201241.5894L-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1021107201241.5894L-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Nov 07, 2002 at 08:26:19PM +0100
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 603
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


Yes, this patch takes care of DECSTATION part of the xconfig problem. 
Thanks.

Now we still have IP22 config which needs to be fixed.  Any volunteers?

This is the additional hack needed that would make xconfig (serial/serial 
console options) work.

diff -Nru arch/mips/config-shared.in.orig arch/mips/config-shared.in
--- arch/mips/config-shared.in.orig     Thu Nov  7 14:14:09 2002
+++ arch/mips/config-shared.in  Thu Nov  7 14:17:33 2002
@@ -800,9 +800,9 @@
 fi
 endmenu
 
-if [ "$CONFIG_SGI_IP22" = "y" ]; then
-   source drivers/sgi/Config.in
-fi
+#if [ "$CONFIG_SGI_IP22" = "y" ]; then
+#   source drivers/sgi/Config.in
+#fi
 
 source drivers/usb/Config.in
 
Jun

On Thu, Nov 07, 2002 at 08:26:19PM +0100, Maciej W. Rozycki wrote:
> On Wed, 30 Oct 2002, Maciej W. Rozycki wrote:
> 
> > On Tue, 29 Oct 2002, Jun Sun wrote:
> > 
> > > My limited xconfig knowledge seems to tell me that moving to the generic
> > > config file is the only way to make it work.  If you know a better way to fix
> > > this, I will be happy to see it.
> [...]
> >  The problem is CONFIG_SERIAL having different meanings for the MIPS port. 
> > It causes annoyance with dynamic parsers (like `make config') and I'm not
> > surprised it breaks the xconfig static parser. 
> 
>  I renamed the guilty options and also I decided moving DECstation serial
> port configuration to drivers/char is the way to go.  As a side effect you
> now may build both the dz11/z8530 drivers and the i8250 one (as an advance
> towards a generic kernel).
> 
