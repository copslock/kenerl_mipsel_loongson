Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Mar 2005 06:46:57 +0000 (GMT)
Received: from mail.gmx.net ([IPv6:::ffff:213.165.64.20]:44234 "HELO
	mail.gmx.net") by linux-mips.org with SMTP id <S8225552AbVCHGqk>;
	Tue, 8 Mar 2005 06:46:40 +0000
Received: (qmail invoked by alias); 08 Mar 2005 06:46:34 -0000
Received: from kf-pij-tg01-0933.dial.kabelfoon.nl (EHLO [192.168.1.61]) (62.45.179.166)
  by mail.gmx.net (mp018) with SMTP; 08 Mar 2005 07:46:34 +0100
X-Authenticated: #11016536
Message-ID: <422D4A49.9020504@gmx.net>
Date:	Tue, 08 Mar 2005 07:46:33 +0100
From:	freshy98 <freshy98@gmx.net>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Kumba <kumba@gentoo.org>
CC:	Jim Gifford <maillist@jg555.com>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IPTables 1.3.x fails on RaQ2
References: <422C8D6A.6060904@jg555.com> <422C9142.8090007@gmx.net> <422D0D64.2080402@gentoo.org> <422D2801.2060903@jg555.com> <422D3AC9.4020601@gentoo.org>
In-Reply-To: <422D3AC9.4020601@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Return-Path: <freshy98@gmx.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7397
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freshy98@gmx.net
Precedence: bulk
X-list: linux-mips

I do not use linux-headers-2.6.x on my Qube2, but iptables still b0rked 
on anything higher then 1.2.11-r3.
If I am correct then mips-headers is the equivelant of linux-headers? In 
that case I have 2.4.21-r3.

My Qube2 acts as my firewall and so I have tried several versions the 
first time I installed it.
At that time iptables wasn't marked stable on mips.


Kumba wrote:

> Jim Gifford wrote:
>
>> I just don't understand why iptables needs that file at all, I can't 
>> find anything in it that uses it. I'm going to search again, and I 
>> will post my results once I figure it out.
>
>
> iptables doesn't need it.  It's one of those funky #include chains.  
> include A includes B which includes C which includes Q and so on until 
> it tries including a file it can't find.  This is because there are a 
> series of mach-* machine subdirs in include/asm-mips that each contain 
> headers specific to a particular machine type (like spaces.h, among 
> other things).  I haven't delved into the specifics (someone else here 
> can explain it more), but when the kernel builds, based upon the 
> configuration of the kernel, it knows which include/asm-mips/mach-* 
> directory to look in to snag the headers it needs. Userland doesn't 
> know this, so for headers used in userland, you need to patch things 
> abit.  Otherwise, they break.
>
> http://tinyurl.com/5grah  <-- appCompat patch used in Gentoo's 
> linux-headers 2.6.10 ebuild.  It lacks mips-specific bits, but you can 
> look at how x86 handles some of its include/asm-i386/mach-* sections 
> for how we're working around these issues.  It's all a hack really, 
> until someone either fixes userland to never use kernel headers, or 
> the kernel-side finds a way to create userland-friendly headers (but I 
> don't see any of this happening anytime soon).
>
>
> --Kumba
>
