Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6JKOUa18888
	for linux-mips-outgoing; Thu, 19 Jul 2001 13:24:30 -0700
Received: from post.webmailer.de (natpost.webmailer.de [192.67.198.65])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6JKOSV18882
	for <linux-mips@oss.sgi.com>; Thu, 19 Jul 2001 13:24:28 -0700
Received: from scotty.mgnet.de (pD90249E9.dip.t-dialin.net [217.2.73.233])
	by post.webmailer.de (8.9.3/8.8.7) with SMTP id WAA19984
	for <linux-mips@oss.sgi.com>; Thu, 19 Jul 2001 22:24:21 +0200 (MET DST)
Received: (qmail 2618 invoked from network); 19 Jul 2001 20:24:12 -0000
Received: from spock.mgnet.de (192.168.1.4)
  by scotty.mgnet.de with SMTP; 19 Jul 2001 20:24:12 -0000
Date: Thu, 19 Jul 2001 22:24:06 +0200 (CEST)
From: Klaus Naumann <spock@mgnet.de>
To: Robert Einsle <robert@einsle.de>
cc: linux-mips@oss.sgi.com
Subject: Re: Probs running ntp on an indy
In-Reply-To: <20010719192614.A22495@tuvok.allgaeu.org>
Message-ID: <Pine.LNX.4.21.0107192223140.8136-100000@spock.mgnet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 19 Jul 2001, Robert Einsle wrote:

> Hy
> 
> Is it possible to run ntp on an indy??
> 
> while running ntpdate i got the error
> 
> ntpdate[621]: poll(): nfound = 0, error: Operation not permitted
> 
> the same thing happens while running ntpd

I know the problem but no solution. I suspect that it's a
problem of the poll function in Big Endian environments, because
I can reproduce this on my Indigo2 and on an Ultra 1 as well.

		CU, Klaus


-- 
Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
Nickname    : Spock             | Org.: Mad Guys Network
Phone / FAX : ++49/177/7862964  | E-Mail: (spock@mgnet.de)
PGP Key     : www.mgnet.de/keys/key_spock.txt
