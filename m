Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jun 2003 20:37:28 +0100 (BST)
Received: from kauket.visi.com ([IPv6:::ffff:209.98.98.22]:46792 "HELO
	mail-out.visi.com") by linux-mips.org with SMTP id <S8224827AbTFJTh0>;
	Tue, 10 Jun 2003 20:37:26 +0100
Received: from mehen.visi.com (mehen.visi.com [209.98.98.97])
	by mail-out.visi.com (Postfix) with ESMTP
	id D69B436FB; Tue, 10 Jun 2003 14:37:28 -0500 (CDT)
Received: from mehen.visi.com (localhost [127.0.0.1])
	by mehen.visi.com (8.12.9/8.12.5) with ESMTP id h5AJbGwK081188;
	Tue, 10 Jun 2003 14:37:16 -0500 (CDT)
	(envelope-from erik@greendragon.org)
Received: (from www@localhost)
	by mehen.visi.com (8.12.9/8.12.5/Submit) id h5AJbE75081187;
	Tue, 10 Jun 2003 19:37:14 GMT
X-Authentication-Warning: mehen.visi.com: www set sender to erik@greendragon.org using -f
Received: from stpns.guidant.com (stpns.guidant.com [132.189.76.10]) 
	by my.visi.com (IMP) with HTTP 
	for <longshot@imap.visi.com>; Tue, 10 Jun 2003 19:37:14 +0000
Message-ID: <1055273834.3ee6336a57461@my.visi.com>
Date: Tue, 10 Jun 2003 19:37:14 +0000
From: "Erik J. Green" <erik@greendragon.org>
To: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Subject: Re: Linux on Indigo2 (IP28) - R10000
References: <3EDD28A400000BAC@cpfe4.be.tisc.dk>
In-Reply-To: <3EDD28A400000BAC@cpfe4.be.tisc.dk>
MIME-Version: 1.0
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 132.189.76.10
Return-Path: <erik@greendragon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2588
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: erik@greendragon.org
Precedence: bulk
X-list: linux-mips

Quoting "mleopold@tiscali.dk" <mleopold@tiscali.dk>:

> > > Btw: I also got my hands on an Octane (IP30) with an R10000 (195 Mhz)
> -
> > > I haven't tried to install on this one, but that might be interesting
> too..
> > This one is also I/O coherent, so chances are much better than for IP28.
> 
> Are you saying I might get this one working with the Debian boot-images
> that I already tried, or?

That's pretty unlikely.  I am currently working on the Octane in what little
spare time I can wrest away from work.  On the good side, the octane peripherals
seem generally the same as the Origin, so I'm finding a lot of similarities in
the hardware for console and network (IOC3 chip), for instance.  The memory map
is different though, which means that barring some kernel hacking you won't get
a kernel to boot on it from any existing boot image.  I haven't gotten to the
point of trying to make the video hardware work, although I do have a PCI
shoebox I might try a Radeon PCI card in eventually.

Feel free to join in hacking on it, you might be better at it than I am =)


Erik



-- 
Erik J. Green
erik@greendragon.org
