Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2K6Tfa20919
	for linux-mips-outgoing; Tue, 19 Mar 2002 22:29:41 -0800
Received: from post.webmailer.de (natpost.webmailer.de [192.67.198.65])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2K6TX920916
	for <linux-mips@oss.sgi.com>; Tue, 19 Mar 2002 22:29:34 -0800
Received: from excalibur.cologne.de (pD951145C.dip.t-dialin.net [217.81.20.92])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id HAA08176;
	Wed, 20 Mar 2002 07:30:57 +0100 (MET)
Received: from karsten by excalibur.cologne.de with local (Exim 3.12 #1 (Debian))
	id 16nZkt-0000C7-00; Wed, 20 Mar 2002 07:39:27 +0100
Date: Wed, 20 Mar 2002 07:39:27 +0100
From: Karsten Merker <karsten@excalibur.cologne.de>
To: David Christensen <dpchrist@holgerdanske.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Fw: hello
Message-ID: <20020320073927.A471@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	David Christensen <dpchrist@holgerdanske.com>,
	linux-mips@oss.sgi.com
References: <017701c1cf99$a7d9a890$0b01a8c0@w2k30g>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <017701c1cf99$a7d9a890$0b01a8c0@w2k30g>; from dpchrist@holgerdanske.com on Tue, Mar 19, 2002 at 02:55:22PM -0800
X-No-Archive: yes
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Mar 19, 2002 at 02:55:22PM -0800, David Christensen wrote:

> Which Linux distribution does MIPS use?  Since I'm going to be working
> on an Atlas board using software from MIPS, I would like to match things
> up exactly.

Several different - there is a Debian port (big and little endian),
H.J. Lu's RedHat mini-port (big endian AFAIK), Karel van Houten's 
RedHat-based rootfs (little endian), Keith M. Wesolwski's Simple
Linux (big-endian). I think the most complete of all is Debian.

> As an aside, is anybody using a VMware virtual machine for their
> development host?

Why should we? VMware emulates i386 on i386, so it would be of no
help for mips development.

> >> 3.  What is the preferred toolchain...

I always build natively:
gcc version 2.95.4 20011002 (Debian prerelease)
GNU ld version 2.11.93.0.2 20020207 Debian/GNU Linux

> > Yep - The Debian autobuilder run native on little and big endian.
> 
> Hmmm.  Do you mean GNU autoconf running natively on MIPS, or something
> running on a Debian x86 host, or something else?

The autobuilder is a system that checks for new Debian packages which
are not yet built for mips/mipsel and automatically builds and uploads
them into the Debian archive. It runs natively (in our case on a
Lasat Masquerade Pro for little endian and on an SGI Indigo2 for big 
endian).

Regards,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
