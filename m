Received:  by oss.sgi.com id <S553901AbRBFUYS>;
	Tue, 6 Feb 2001 12:24:18 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:46864 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553664AbRBFUYD>;
	Tue, 6 Feb 2001 12:24:03 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 76545808; Tue,  6 Feb 2001 21:23:51 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id D7497EEAC; Tue,  6 Feb 2001 21:24:07 +0100 (CET)
Date:   Tue, 6 Feb 2001 21:24:07 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Klaus Naumann <spock@mgnet.de>
Cc:     linux-mips@oss.sgi.com
Subject: Re: netbooting indy - update, elf2ecoff?
Message-ID: <20010206212407.E4098@paradigm.rfc822.org>
References: <Pine.GSO.4.10.10102060732080.15534-100000@escobaria.sonytel.be> <Pine.LNX.4.21.0102061905330.8851-100000@spock.mgnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0102061905330.8851-100000@spock.mgnet.de>; from spock@mgnet.de on Tue, Feb 06, 2001 at 07:07:47PM +0100
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Feb 06, 2001 at 07:07:47PM +0100, Klaus Naumann wrote:
> On Tue, 6 Feb 2001, Geert Uytterhoeven wrote:
> 
> > However, /dev/console must _not_ be a symlink, but a character special device
> > with major 5 minor 1 (cfr. Documentation/devices.txt).
> 
> Unless you're using Linux/MIPS :)
> The console implementation is horrible broken, so
> this means that under most circumstances the 5,1 device doesn't
> work. So the only option is to make /dev/console a symlink to /dev/ttyS0.

This has nothing to do with "Linux/Mips" and is definitly not true
on all subarchs. It might be true on SGI machines but i dont even
there its necessary.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
