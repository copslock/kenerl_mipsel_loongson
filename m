Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2H92LJ24935
	for linux-mips-outgoing; Sun, 17 Mar 2002 01:02:21 -0800
Received: from pandora.research.kpn.com (IDENT:root@pandora.research.kpn.com [139.63.192.11])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2H92H924932
	for <linux-mips@oss.sgi.com>; Sun, 17 Mar 2002 01:02:17 -0800
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by pandora.research.kpn.com (8.11.6/8.9.3) with ESMTP id g2H93ip21618;
	Sun, 17 Mar 2002 10:03:44 +0100
Received: (from karel@localhost)
	by sparta.research.kpn.com (8.8.8+Sun/8.8.8) id KAA13373;
	Sun, 17 Mar 2002 10:03:44 +0100 (MET)
From: Karel van Houten <vhouten@kpn.com>
Message-Id: <200203170903.KAA13373@sparta.research.kpn.com>
Subject: Re: DECStation kernel boot failure
To: jbglaw@lug-owl.de (Jan-Benedict Glaw)
Date: Sun, 17 Mar 2002 10:03:44 +0100 (MET)
Cc: linux-mips@oss.sgi.com
In-Reply-To: <20020316221346.GE25044@lug-owl.de> from "Jan-Benedict Glaw" at Mar 16, 2002 11:13:46 PM
X-Url: http://www-lsdm.research.kpn.com/~karel
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> > Does the copy on my website still work ?
> > 
> > http://www.skynet.ie/~airlied/mips/declance_2_3_48.c
> > 
> > It was never merged as to do it properly required a re-write of the
> > driver, which I never got around to, and I only had a DS5000/200, I still
> > have one, but no build system at the moment ...
> 
> When I looked at that driver, the diff was quite small and only
> included changes to in-driver code parts. So I _think_ it could
> even run these days. I started to work on it some year ago, but
> my changes are lost now - my laptop was stolen this week.

It does still work with 2.4.16 / 2.4.17. It's included in
my precompiled DS5000/200 kernels at my website.

-- 
Karel van Houten

----------------------------------------------------------
The box said "Requires Windows 95 or better."
I can't understand why it won't work on my Linux computer. 
----------------------------------------------------------
