Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Mar 2005 02:27:18 +0000 (GMT)
Received: from rwcrmhc13.comcast.net ([IPv6:::ffff:204.127.198.39]:1486 "EHLO
	rwcrmhc13.comcast.net") by linux-mips.org with ESMTP
	id <S8225525AbVCHC1C>; Tue, 8 Mar 2005 02:27:02 +0000
Received: from [192.168.1.4] (pcp05077810pcs.waldrf01.md.comcast.net[68.54.246.193])
          by comcast.net (rwcrmhc13) with ESMTP
          id <200503080226550150040cc6e>; Tue, 8 Mar 2005 02:26:55 +0000
Message-ID: <422D0D64.2080402@gentoo.org>
Date:	Mon, 07 Mar 2005 21:26:44 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	freshy98 <freshy98@gmx.net>
CC:	Jim Gifford <maillist@jg555.com>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IPTables 1.3.x fails on RaQ2
References: <422C8D6A.6060904@jg555.com> <422C9142.8090007@gmx.net>
In-Reply-To: <422C9142.8090007@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7394
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

freshy98 wrote:
> Jim,
> 
> I am running iptables-1.2.11-r3 on my Gentoo installed Cobalt Qube2 and 
> it compiles alright.
> If I remember correctly I have tried a higher version which failed on 
> cpu-feature-overrides.h too.
> 
> My kernel is linux-2.6.10-20050115 which is in the Portage tree of 
> Gentoo and is based upon CVS.
> So far this machines runs for 14 days without a problem.
> It runs iptables with shorewall.
> 
> Regards,
> 
> Tom
> 
> 
> Jim Gifford wrote:
> 
>> I've been trying to figure out why the current iptables fails on the 
>> 2.6.9 and 2.6.11 MIPS builds. It seems that a file 
>> cpu-features-overrides.h is missing for the Cobalt builds. Are their 
>> plans for one, or is there a patch out there so we can get it added. 
>> Here is the error message on the IPTables build, I still don't 
>> understand why they are checking for that myself.
>>
>> # ./iptables install
>>        Verifying iptables-1.3.1.tar.bz2
>>                Downloading iptables-1.3.1.tar.bz2
>>                Creating Local SHA1 file for iptables-1.3.1.tar.bz2
>>                Installing iptables-1.3.1
>>                        Unpacking iptables-1.3.1.tar.bz2
>> Making dependencies: please wait...
>> Something wrong... deleting dependencies.
>> make: *** [cpu-feature-overrides.h] Error 1
>>                -----Error at Build has occured-----
>> Exiting


This is a headers problem, mainly in 2.6.  2.6 isn't safe out-of-the-box for 
userland consumption.  I've been toying with some 2.6.10 headers from LMO cvs 
on the gentoo side of things, where we have an "appCompat" patch that plugs up 
a alot of the leaky holes in 2.6.x headers, but I still have to analyze the 
patch and add in some mips-specific bits before these headers can be 
considered remotely sane for even testing.

Those running other distros will probably need similar modifications to their 
headers to make them userland-friendly.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: small 
hands do them because they must, while the eyes of the great are elsewhere." 
--Elrond
