Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Aug 2004 23:31:43 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:4856 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225257AbUHEWbh>;
	Thu, 5 Aug 2004 23:31:37 +0100
Received: from [10.0.10.221] (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id PAA22714;
	Thu, 5 Aug 2004 15:31:33 -0700
Message-ID: <4112B545.8090103@mvista.com>
Date: Thu, 05 Aug 2004 15:31:33 -0700
From: Pete Popov <ppopov@mvista.com>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: G H <giles67@yahoo.com>
CC: linux-mips@linux-mips.org
Subject: Re: do_ri failure in cache flushing routines
References: <20040805201643.6422.qmail@web50806.mail.yahoo.com>
In-Reply-To: <20040805201643.6422.qmail@web50806.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

G H wrote:

> At the moment I don't have the board set up for using kgdb and it's 
> complicated by the fact that we only have one serial console port. But 
> I am looking into setting it up for kgdb now.

A single serial port will work fine.

>  
> As far as stressing the system, it doesn't have enough resources ( 
> disk space ) to be able to compile the kernel, but we did write a 
> simple program that would stress the system by spawning multiple 
> threads, each one performing floating point calculations. With this 
> test, top reported a load average of over 400 and we have 
> seen no failure so far.

You can use an NFS mounted root fs to do native builds, assuming you 
have a native toolchain. That's an excellent stress test.

Pete

>
> */Pete Popov <ppopov@mvista.com>/* wrote:
>
>     G H wrote:
>
>     > I've not had much response to this question so I would like to
>     > rephrase it :
>     >
>     > Can anyone think of any possible scenario where do_ri could
>     occur in
>     > blast_icache32() ??
>     >
>     > Is this possibly a cache synchronisation problem ??
>     >
>
>     Could be a hardware memory glitch. I would use kgdb to put a
>     breakpoint
>     there and see what the data in memory looks like when this happens --
>     look for memory corruption, etc.
>
>     Pete
>
>     > TIA
>     >
>     > >While testing out an amd au1500 based board I have been getting "
>     > do_ri " exceptions >that always occur in the cache flushing
>     routines.
>     > More often than not in >blast_icache_32().
>     >
>     > >So far this has mainly happened after running the board for
>     days on
>     > end while running >multiple telnet sessions t! o it. It has
>     sometimes (
>     > quite rarely ) happened after a few >hours to a day of multiple
>     telnet
>     > session use.
>     >
>     > __________________________________________________
>     > Do You Yahoo!?
>     > Tired of spam? Yahoo! Mail has the best spam protection around
>     > http://mail.yahoo.com
>     >
>
> ------------------------------------------------------------------------
> Do you Yahoo!?
> Yahoo! Mail Address AutoComplete 
> <http://us.rd.yahoo.com/mail_us/taglines/aac/*http://promotions.yahoo.com/new_mail/static/ease.html> 
> - You start. We finish. 
