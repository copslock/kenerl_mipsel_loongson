Received:  by oss.sgi.com id <S553726AbQLNSal>;
	Thu, 14 Dec 2000 10:30:41 -0800
Received: from hermes.research.kpn.com ([139.63.192.8]:38406 "EHLO
        hermes.research.kpn.com") by oss.sgi.com with ESMTP
	id <S553740AbQLNSaP>; Thu, 14 Dec 2000 10:30:15 -0800
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
 by research.kpn.com (PMDF V5.2-31 #42699)
 with ESMTP id <01JXPF643VDO0017QU@research.kpn.com> for
 linux-mips@oss.sgi.com; Thu, 14 Dec 2000 19:30:13 +0100
Received: (from karel@localhost)	by sparta.research.kpn.com (8.8.8+Sun/8.8.8)
 id TAA01589; Thu, 14 Dec 2000 19:30:12 +0100 (MET)
X-URL:  http://www-lsdm.research.kpn.com/~karel
Date:   Thu, 14 Dec 2000 19:30:12 +0100 (MET)
From:   Karel van Houten <K.H.C.vanHouten@research.kpn.com>
Subject: Re: Cannot type on DECstation prom
In-reply-to: <20001214115451.A10322@web1.lanscape.net>
To:     tbm@lanscape.net (Martin Michlmayr)
Cc:     linux-mips@oss.sgi.com
Message-id: <200012141830.TAA01589@sparta.research.kpn.com>
MIME-version: 1.0
X-Mailer: ELM [version 2.5 PL2]
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> I recently got a DECstation 5000/125 and I'm trying to get Linux to run.
> I'm using minicom and while I get output from the machine, I can not
> type anything on the prom.  When I power the machine on, I get:
> 
> .....
> 
> The funny thing is that I _can_ type when NetBSD is being started.  But
> nothing happens on the prom.
> 

These DECStations require full modem control signals on the
prom console. I would build a D25 serial modem-faker cable:

 1 ------------------- 1

 2 -------\ /--------- 2
           X
 3 -------/ \--------- 3

 4 -+               +- 4
    |               |
 5 -+               +- 5

 6 -+               +- 6
    |               |
 7 -)---------------)- 7
    |               |
 8 -+               +- 8
    |               |
20 -+               +- 20

This should work.

-- 
Karel van Houten

----------------------------------------------------------
The box said "Requires Windows 95 or better."
I can't understand why it won't work on my Linux computer. 
----------------------------------------------------------
