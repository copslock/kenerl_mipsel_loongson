Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6HK5hk30240
	for linux-mips-outgoing; Tue, 17 Jul 2001 13:05:43 -0700
Received: from holly.csn.ul.ie (holly.csn.ul.ie [136.201.105.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6HK5fV30237
	for <linux-mips@oss.sgi.com>; Tue, 17 Jul 2001 13:05:41 -0700
Received: from skynet.csn.ul.ie (skynet [136.201.105.2])
	by holly.csn.ul.ie (Postfix) with ESMTP
	id D5B7D2B6F4; Tue, 17 Jul 2001 21:05:34 +0100 (IST)
Received: by skynet.csn.ul.ie (Postfix, from userid 2139)
	id 9501DA8A5; Tue, 17 Jul 2001 21:05:33 +0100 (IST)
Received: from localhost (localhost [127.0.0.1])
	by skynet.csn.ul.ie (Postfix) with ESMTP
	id 8E9FCA8A4; Tue, 17 Jul 2001 21:05:33 +0100 (IST)
Date: Tue, 17 Jul 2001 21:05:33 +0100 (IST)
From: Dave Airlie <airlied@csn.ul.ie>
X-X-Sender:  <airlied@skynet>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Harald Koerfgen <hkoerfg@web.de>, Ralf Baechle <ralf@uni-koblenz.de>,
   <linux-mips@fnet.fr>, <linux-mips@oss.sgi.com>
Subject: Re: [patch] 2.4.5: DECstation LK201 keyboard non-functional
In-Reply-To: <Pine.GSO.3.96.1010716195815.12988F-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.32.0107172102470.3817-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Well that file you've moved is still a DEC specific file .. all the arch
non-specific stuff is in drivers/char/dz.c and drivers/tc/zs.c already..
the decserial.c file does nothing for any other arch but the DECstation..

I'd rather it was fixed with the serial.c file in the old place... but
hey I'm not exactly contributing a fix here so feel free to ignore this
rant :-)

Dave.



On Mon, 16 Jul 2001, Maciej W. Rozycki wrote:

> Hi,
>
>  Since 2.4.5 there is a problem with the LK201 driver.  The driver gets
> never registered.  It happens because chr_dev_init() got converted to
> __initcall() and is no longer invoked before rs_init() for the DECstation
> (chr_dev_init() calls tty_init() which registers the LK201 hook via
> kbd_init()).
>
>  The following patch fixes the problem.  It makes the DECstation's object
> file that provides rs_init() be included in the DRIVERS list as SERIAL.
> It is on the CORE_FILES list of Makefile targets now.  The patch looks
> bigger than it really is -- apart from trivial Makefile changes, it's
> merely an arch/mips/dec/serial.c to drivers/char/decserial.c rename.
>
>  Note while putting a file away from an arch-specific tree into a generic
> driver one might seem a bad move, it really is the right thing in this
> case.  The point is the decserial.c device is not arch-specific at all,
> i.e. no more than the 8250 serial.c device is.  DEC used the devices in a
> number of their systems, including DECstations (onboard SCC and DZ11 and
> TURBOchannel PMAC-A DZ11 devices), DEC 3000 Alpha systems (onboard SCC and
> PMAC-A devices) and VAXstations (onboard DZ11 and PMAC-A devices).  Thus I
> believe they should be treated as generic devices, especially as the VAX
> and the DEC 3000 Alpha (to some extent) Linux ports are underway.
>
>  Please apply the patch.
>
>   Maciej
>
>

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person
