Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAREulh18523
	for linux-mips-outgoing; Tue, 27 Nov 2001 06:56:47 -0800
Received: from dvmwest.gt.owl.de (dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAREuio18520
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 06:56:44 -0800
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 580DCA059; Tue, 27 Nov 2001 14:56:42 +0100 (CET)
Date: Tue, 27 Nov 2001 14:56:42 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: debian-mips@lists.debian.org, debian-boot@lists.debian.org,
   linux-mips@oss.sgi.com
Subject: Re: failed installation debian-mipsel (Decstation 5000/150)
Message-ID: <20011127145641.K4739@lug-owl.de>
Mail-Followup-To: debian-mips@lists.debian.org,
	debian-boot@lists.debian.org, linux-mips@oss.sgi.com
References: <20011126234617.D13081@paradigm.rfc822.org> <Pine.GSO.3.96.1011127132516.440C-100000@delta.ds2.pg.gda.pl> <20011127134930.A7022@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011127134930.A7022@paradigm.rfc822.org>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux mail 2.4.15-pre2 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 2001-11-27 13:49:30 +0100, Florian Lohoff <flo@rfc822.org>
wrote in message <20011127134930.A7022@paradigm.rfc822.org>:
> On Tue, Nov 27, 2001 at 01:43:10PM +0100, Maciej W. Rozycki wrote:
> > > At least this should be mentioned:
> > > 
> > > echo 4096 >/proc/sys/net/ipv4/neigh/eth0/retrans_time
> > 
> >  Is it needed for TFTP?  What for?
> 
> The decstation fails to answer ARP requests while downloading. From
> kernel 2.2 on the arp entries expire faster which lets the tftp download
> fail somewhere in the middle.

Provide a static ARP entry. Won't expire ever:-)

MfG, JBG

-- 
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	http://lug-owl.de/~jbglaw/software/snapshot2cvs/
