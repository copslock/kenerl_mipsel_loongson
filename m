Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6I95bq15318
	for linux-mips-outgoing; Wed, 18 Jul 2001 02:05:37 -0700
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6I95ZV15313
	for <linux-mips@oss.sgi.com>; Wed, 18 Jul 2001 02:05:35 -0700
Received: from agx by gandalf.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 15MnGp-0003ZD-00; Wed, 18 Jul 2001 11:05:27 +0200
Date: Wed, 18 Jul 2001 11:05:27 +0200
From: Guido Guenther <guido.guenther@gmx.net>
To: Robert Einsle <robert@einsle.de>
Cc: linux-mips@oss.sgi.com
Subject: Re: Booting an SGI Indy from Harddisk
Message-ID: <20010718110527.B13569@gandalf.physik.uni-konstanz.de>
Mail-Followup-To: Robert Einsle <robert@einsle.de>, linux-mips@oss.sgi.com
References: <20010718093458.A27749@tuvok.allgaeu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010718093458.A27749@tuvok.allgaeu.org>; from robert@einsle.de on Wed, Jul 18, 2001 at 09:34:58AM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jul 18, 2001 at 09:34:58AM +0200, Robert Einsle wrote:
> Hy all
> 
> I've a little Problem booting an SGI Indy from Harddisk.
> There is Linux Debian installen, and i made with dvhtool
> an korrekt Startfile.
> While starting, the indy loads the Kernel, and boots.
> But then, it mounts my root-Partition from the remote
> Server where i had the install-Partition. 
> How can I tell the Indy to boot from /dev/sda1
> I think i must set an StartOS ... but i dont knew
> what, and i don't knew where to search.
> TNX for help.
http://honk.physik.uni-konstanz.de/linux-mips/indy-boot/indy-hd-boot-micro-howto.html
 -- Guido
