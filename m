Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3P8VHwJ012128
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 25 Apr 2002 01:31:17 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3P8VHRD012127
	for linux-mips-outgoing; Thu, 25 Apr 2002 01:31:17 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3P8VEwJ012123
	for <linux-mips@oss.sgi.com>; Thu, 25 Apr 2002 01:31:14 -0700
Received: from galadriel.physik.uni-konstanz.de (galadriel.physik.uni-konstanz.de [134.34.144.79])
	by gandalf.physik.uni-konstanz.de (Postfix) with ESMTP
	id 581C78D35; Thu, 25 Apr 2002 10:31:42 +0200 (CEST)
Received: from agx by galadriel.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 170efG-0006S0-00; Thu, 25 Apr 2002 10:31:42 +0200
Date: Thu, 25 Apr 2002 10:31:42 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Dani Eichhorn <dani.eichhorn@squix.ch>, linux-mips@oss.sgi.com
Subject: Re: Challenge S crashes configuring the base system
Message-ID: <20020425103142.A24749@galadriel.physik.uni-konstanz.de>
Mail-Followup-To: Dani Eichhorn <dani.eichhorn@squix.ch>,
	linux-mips@oss.sgi.com
References: <OBEHJEMLCCGNNEAACCLCAEAICCAA.dani.eichhorn@squix.ch> <20020421131051.A12044@gandalf.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020421131051.A12044@gandalf.physik.uni-konstanz.de>; from agx@sigxcpu.org on Sun, Apr 21, 2002 at 01:10:51PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Apr 21, 2002 at 01:10:51PM +0200, Guido Guenther wrote:
[..snip..] 
> It doesn't really "crash". The porblem is that the installer doesn't
> correctly detect the serial console and therefore displays everything on
> tty1 not ttyS0. Boot with /bin/bash as init (use "boot init=/bin/bash"
I just doublechecked this on an Indy. The installer detects the serial
console with either console=ttyS0 as kernel command line argument or
"console=d1" as prom var correctly. Can you try another installation and
save /var/log/messages as well as /target/etc/inittab before you reboot
from the installer?
 -- Guido 
