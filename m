Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Mar 2005 17:35:31 +0000 (GMT)
Received: from mail.gmx.net ([IPv6:::ffff:213.165.64.20]:4235 "HELO
	mail.gmx.net") by linux-mips.org with SMTP id <S8225313AbVCGRfQ>;
	Mon, 7 Mar 2005 17:35:16 +0000
Received: (qmail invoked by alias); 07 Mar 2005 17:35:09 -0000
Received: from kf-pij-tg01-0933.dial.kabelfoon.nl (EHLO [192.168.1.61]) (62.45.179.166)
  by mail.gmx.net (mp027) with SMTP; 07 Mar 2005 18:35:09 +0100
X-Authenticated: #11016536
Message-ID: <422C9142.8090007@gmx.net>
Date:	Mon, 07 Mar 2005 18:37:06 +0100
From:	freshy98 <freshy98@gmx.net>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Jim Gifford <maillist@jg555.com>
CC:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IPTables 1.3.x fails on RaQ2
References: <422C8D6A.6060904@jg555.com>
In-Reply-To: <422C8D6A.6060904@jg555.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Return-Path: <freshy98@gmx.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freshy98@gmx.net
Precedence: bulk
X-list: linux-mips

Jim,

I am running iptables-1.2.11-r3 on my Gentoo installed Cobalt Qube2 and 
it compiles alright.
If I remember correctly I have tried a higher version which failed on 
cpu-feature-overrides.h too.

My kernel is linux-2.6.10-20050115 which is in the Portage tree of 
Gentoo and is based upon CVS.
So far this machines runs for 14 days without a problem.
It runs iptables with shorewall.

Regards,

Tom


Jim Gifford wrote:

> I've been trying to figure out why the current iptables fails on the 
> 2.6.9 and 2.6.11 MIPS builds. It seems that a file 
> cpu-features-overrides.h is missing for the Cobalt builds. Are their 
> plans for one, or is there a patch out there so we can get it added. 
> Here is the error message on the IPTables build, I still don't 
> understand why they are checking for that myself.
>
> # ./iptables install
>        Verifying iptables-1.3.1.tar.bz2
>                Downloading iptables-1.3.1.tar.bz2
>                Creating Local SHA1 file for iptables-1.3.1.tar.bz2
>                Installing iptables-1.3.1
>                        Unpacking iptables-1.3.1.tar.bz2
> Making dependencies: please wait...
> Something wrong... deleting dependencies.
> make: *** [cpu-feature-overrides.h] Error 1
>                -----Error at Build has occured-----
> Exiting
>
