Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2R2sas16996
	for linux-mips-outgoing; Tue, 26 Mar 2002 18:54:36 -0800
Received: from zoetrope (mail@h24-77-117-155.vc.shawcable.net [24.77.117.155])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2R2sVq16993
	for <linux-mips@oss.sgi.com>; Tue, 26 Mar 2002 18:54:31 -0800
Received: from lattice (helo=localhost)
	by zoetrope with local-esmtp (Exim 3.34 #1 (Debian))
	id 16q3cM-0002FV-00
	for <linux-mips@oss.sgi.com>; Tue, 26 Mar 2002 18:56:54 -0800
Date: Tue, 26 Mar 2002 18:56:54 -0800 (PST)
From: blaine <lattice@altern.org>
X-X-Sender: lattice@zoetrope
To: linux-mips@oss.sgi.com
Subject: Parallel Port support on Indy?
Message-ID: <Pine.LNX.4.44.0203261847100.7969-100000@zoetrope>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi there;

  I've recently acquired an Indy, and I'd like to use it as my closet
firewall/webserver/printer box. I've been able to install debian/woody
without event, and the linux_2_4 tag from sgi's cvs compiles fine,
giving me OSS sound support with the HAL2 and enabling the Vino video
system. X came working out of the box...

The only thing I *can't* do with the Indy is use the parallel port,
which, in my case, is the most important thing... As far as I can tell
from reading around, the Indy supports a standard SPP parallel port
(plus a bunch of extra modes that haven't been implemented in linux,
afaict), but has a different base i/o address in addition to having the
data and control addresses at different offsets. I tried playing around
with the constants in [header file that controls that stuff in
include/linux], and managed to get the parport_pc module to stop causing
a [non-fatal] kernel oops. Now it just says something is wrong. ;-)

I would like to pursue fixing this, but being a student and not having
any experience playing with low-level hardware or kernel hacking are
conspiring against me. Is getting parport support on the Indy a major
undertaking, or are there just a few tweaks that need to be made to
existing drivers?

Any help on this would be most appreciated.
Thanks,

blaine cook.

     _                                  .
    ( o> - INDEED.                     .o.
    ///\                                 \/
___`\V_/__http://www.yellow5.com/pokey/__/____
