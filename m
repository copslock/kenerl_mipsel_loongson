Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6JKpR521187
	for linux-mips-outgoing; Thu, 19 Jul 2001 13:51:27 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6JKpPV21179
	for <linux-mips@oss.sgi.com>; Thu, 19 Jul 2001 13:51:25 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 7A6D47FA; Thu, 19 Jul 2001 22:51:24 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id C768843E3; Thu, 19 Jul 2001 22:51:37 +0200 (CEST)
Date: Thu, 19 Jul 2001 22:51:37 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Klaus Naumann <spock@mgnet.de>
Cc: Robert Einsle <robert@einsle.de>, linux-mips@oss.sgi.com
Subject: Re: Probs running ntp on an indy
Message-ID: <20010719225137.B1599@paradigm.rfc822.org>
References: <20010719192614.A22495@tuvok.allgaeu.org> <Pine.LNX.4.21.0107192223140.8136-100000@spock.mgnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.21.0107192223140.8136-100000@spock.mgnet.de>; from spock@mgnet.de on Thu, Jul 19, 2001 at 10:24:06PM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jul 19, 2001 at 10:24:06PM +0200, Klaus Naumann wrote:
> I know the problem but no solution. I suspect that it's a
> problem of the poll function in Big Endian environments, because
> I can reproduce this on my Indigo2 and on an Ultra 1 as well.

I remember seeing a patch concerning this problem - Something with
rtsignals - But i cant seem to find it anymore.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
