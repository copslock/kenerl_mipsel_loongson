Received:  by oss.sgi.com id <S553750AbQJaSCb>;
	Tue, 31 Oct 2000 10:02:31 -0800
Received: from gateway-490.mvista.com ([63.192.220.206]:5116 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553716AbQJaSCS>;
	Tue, 31 Oct 2000 10:02:18 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e9VI0D309991;
	Tue, 31 Oct 2000 10:00:13 -0800
Message-ID: <39FF091F.E6457945@mvista.com>
Date:   Tue, 31 Oct 2000 10:02:07 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     Nicu Popovici <octavp@isratech.ro>
CC:     linux-mips@oss.sgi.com
Subject: Re: MIPS ftp problem!
References: <39FF1A83.387D0E1F@isratech.ro>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Nicu Popovici wrote:
> 
> Hello,
> 
> I have a problem with the mips machine. I have an Atlas board and when I
> do ftp on the mips machine from a intel one and I try to transfer files
> ( it works very very slow 0,0234 bytes/s). The same is happening when I
> try to make ftp from the mips machine on a intel box ( all running Linux
> ).
> 
> Thanks,
> Nicu

Nicu,

I had the similar problems for several times.  Most of the times it
turned out to be interrupt problems.  Basically the ether interrupt is
not interrupting the CPU.  Sometimes CPU detects the ether interrupt
later through some other interrupts.  For one time it was a hardware
setup problem (bus frequency is set too high). 

I also had one problem with /etc/nssswitch.conf, which cuases all
network apps pause for a long time during startup.

Hope this helps.

Jun
