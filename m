Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6MB7g113501
	for linux-mips-outgoing; Sun, 22 Jul 2001 04:07:42 -0700
Received: from post.webmailer.de (natpost.webmailer.de [192.67.198.65])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6MB7dV13495
	for <linux-mips@oss.sgi.com>; Sun, 22 Jul 2001 04:07:40 -0700
Received: from scotty.mgnet.de (pD957B5B4.dip.t-dialin.net [217.87.181.180])
	by post.webmailer.de (8.9.3/8.8.7) with SMTP id NAA27005
	for <linux-mips@oss.sgi.com>; Sun, 22 Jul 2001 13:07:37 +0200 (MET DST)
Received: (qmail 24496 invoked from network); 22 Jul 2001 11:07:36 -0000
Received: from spock.mgnet.de (192.168.1.4)
  by scotty.mgnet.de with SMTP; 22 Jul 2001 11:07:36 -0000
Date: Sun, 22 Jul 2001 13:07:29 +0200 (CEST)
From: Klaus Naumann <spock@mgnet.de>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: linux-mips@oss.sgi.com
Subject: Re: I2 R10K status?
In-Reply-To: <20010722043347.J16278@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.LNX.4.21.0107221305590.24307-100000@spock.mgnet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, 22 Jul 2001, Thiemo Seufer wrote:

> Florian Lohoff wrote:
> > On Fri, Jul 20, 2001 at 10:01:55PM +0200, Thiemo Seufer wrote:
> > > processes crash due to unaligned access/illegal instruction in
> > > kernel space. The serial console drops characters on high
> > > throughput.
> 
> I've tested the serial console now with 38400 baud also,
> the characteristics of the dropouts didn't change.

ok - when I have time next week I'll read through sgiserial.c 
and clean it up a bit ... maybe I find the bug ...

> Well, then it's at least not a bug of mine. :-)

No. :-)



-- 
Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
Nickname    : Spock             | Org.: Mad Guys Network
Phone / FAX : ++49/177/7862964  | E-Mail: (spock@mgnet.de)
PGP Key     : www.mgnet.de/keys/key_spock.txt
