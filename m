Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6M2Xrx32379
	for linux-mips-outgoing; Sat, 21 Jul 2001 19:33:53 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6M2XpV32376
	for <linux-mips@oss.sgi.com>; Sat, 21 Jul 2001 19:33:51 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (8.9.3/8.9.3) with ESMTP id EAA25424
	for <linux-mips@oss.sgi.com>; Sun, 22 Jul 2001 04:33:50 +0200 (MDT)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.22 #1 (Debian))
	id 15O93z-0000x1-00
	for <linux-mips@oss.sgi.com>; Sun, 22 Jul 2001 04:33:47 +0200
Date: Sun, 22 Jul 2001 04:33:47 +0200
To: linux-mips@oss.sgi.com
Subject: Re: I2 R10K status?
Message-ID: <20010722043347.J16278@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010722033038.B10591@paradigm.rfc822.org>
User-Agent: Mutt/1.3.18i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Florian Lohoff wrote:
> On Fri, Jul 20, 2001 at 10:01:55PM +0200, Thiemo Seufer wrote:
> > processes crash due to unaligned access/illegal instruction in
> > kernel space. The serial console drops characters on high
> > throughput.

I've tested the serial console now with 38400 baud also,
the characteristics of the dropouts didn't change.

> This is true for all sgis IMHO - I have seen this before on the
> Indy and Indigo2 - This is a bug in the sgiserial.c - I have tried
> to find it before but havent been successfull.

Well, then it's at least not a bug of mine. :-)

> Another bug lets
> the serial to freeze completely which prevents serial console
> machines from reboot as the and print to the console blocks.
> 
> This has been fixed somewhere in the 2.4 area.

I haven't encountered this yet, so the fix seems to work for
64bit, too.


Thiemo
