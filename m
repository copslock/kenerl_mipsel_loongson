Received:  by oss.sgi.com id <S553991AbQLARzB>;
	Fri, 1 Dec 2000 09:55:01 -0800
Received: from u-207-10.karlsruhe.ipdial.viaginterkom.de ([62.180.10.207]:48905
        "EHLO u-207-10.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553988AbQLARyx>; Fri, 1 Dec 2000 09:54:53 -0800
Received: (ralf@lappi) by bacchus.dhis.org id <S869503AbQLARxV>;
	Fri, 1 Dec 2000 18:53:21 +0100
Date:	Fri, 1 Dec 2000 18:53:21 +0100
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Cc:	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com,
        Klaus Naumann <spock@mgnet.de>,
        Jesse Dyson <jesse@winston-salem.com>
Subject: Re: Indigo2 Kernel Boots!!!
Message-ID: <20001201185321.A3211@bacchus.dhis.org>
References: <001901c05b67$8c88ab60$0deca8c0@Ulysses> <XFMail.001201163348.Harald.Koerfgen@home.ivm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <XFMail.001201163348.Harald.Koerfgen@home.ivm.de>; from Harald.Koerfgen@home.ivm.de on Fri, Dec 01, 2000 at 04:33:48PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Dec 01, 2000 at 04:33:48PM +0100, Harald Koerfgen wrote:

> > Having been through the exercise a dozen or more times with
> > the SGI 2.2 kernel distributions for the Indy, I would be fascinated
> > to know what bug I was painting over, and where the correct
> > procedure was documented.
> 
> linux/Documentation/serial-console.txt

In addition let me add some word about what the term console actually is,
this commonly seems to cause confusition because the word is used with two
different meanings:

 1) The device on which you login in single user mode, that's usually some
    kind of serial device at ttyS0 or a virtual console, that is with keyboard
    and some kind of text terminal.
 2) The second is the device which the kernel prints all the printk messages
    and data sent to /dev/console to.  The two often often but not always
    refer to the same actual device.

/dev/console (as chardev 5/1) differs from another device in some important
ways:

 - When opened by a process without controlling tty it will not become a
   CTTY even if the NOCTTY flag is not set.
 - It will never block but rather loose data.  This may sound like a
   disadvantage but it's actually very important for proper operation.  For
   example, if /dev/console'd block due to a serial console with hardware
   handshaking enabled (DON'T) syslogd writing to it may also block for an
   unbounded time and thus as soon as /dev/log is full all services trying to
   log via syslog(3) will also freeze.

   Syslogd actually tries to be clever about avoiding this from happening
   but fails to handle one case correctly, so this is a real world scenario.

 - It uses different routines to access the console device than normal
   write access to i.e. ttyS0.

The most common problem is that CONFIG_SERIAL_CONSOLE wasn't configured;
some drivers are simply buggy and don't properly register the console
on startup.  Dunno what the problem was in your case, Kevin.

  Ralf
