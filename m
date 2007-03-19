Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 13:55:24 +0000 (GMT)
Received: from hu-out-0506.google.com ([72.14.214.238]:8442 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20021868AbXCSNy6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Mar 2007 13:54:58 +0000
Received: by hu-out-0506.google.com with SMTP id 22so5917441hug
        for <linux-mips@linux-mips.org>; Mon, 19 Mar 2007 06:53:57 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=UcuI1BpGuqKjJlHe3xrPCSefEDEdTfy9Bb9UizBz5aRce9cYaOdk2oZLf38Dj5DU8MaX+Z08Q5fDsrH56ZKutXUYLmMM14pzoZF7pofmtB0FDI5eI+Anveit1Udgt8G95NU4peC1jzmEk7s5laJQl1nte5SfYYBdFzwRemvS6mQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=o/S9JYjvPQNy+Y4ofeks0zMCd334QiBPpOPpP4Xawuoil8hU6b0nKoATFyyFiGRdLtZFBfsBt5hq+bTIVCNppfNd+3phghMqRlW02YjLBVkEPjJRGn4yAnswT91pQa7BZXFU3K/E7bqaaB5uZdkXZpTCcWh8v8rIKAUHEikj0Lw=
Received: by 10.67.97.7 with SMTP id z7mr9856123ugl.1174312437497;
        Mon, 19 Mar 2007 06:53:57 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id k2sm4992673ugf.2007.03.19.06.53.56;
        Mon, 19 Mar 2007 06:53:56 -0700 (PDT)
Message-ID: <45FE95EE.5030108@innova-card.com>
Date:	Mon, 19 Mar 2007 14:53:50 +0100
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Kumba <kumba@gentoo.org>
CC:	Linux MIPS List <linux-mips@linux-mips.org>,
	Arnaud Giersch <arnaud.giersch@free.fr>
Subject: Re: IP32 prom crashes due to __pa() funkiness
References: <45D8B070.7070405@gentoo.org>	<cda58cb80703010139y3e5bbb8eqa4d25b75ba658a22@mail.gmail.com>	<45FC46F0.3070300@gentoo.org> <87irczzglc.fsf@groumpf.homeip.net> <45FC9E39.7010506@gentoo.org>
In-Reply-To: <45FC9E39.7010506@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Kumba wrote:
> Arnaud Giersch wrote:
>>
>> I don't know if it is the RightWay(TM), but I am running here a fresh
>> IP32 kernel (l.m.o git updated yesterday).  It was compiled with
>> CONFIG_BUILD_ELF64=n, and I am using vmlinux.
>>
>> $ file /boot/vmlinux-2.6.21-rc3-g839fd555
>> /boot/vmlinux-2.6.21-rc3-g839fd555: ELF 64-bit MSB executable, MIPS,
>> MIPS-IV version 1 (SYSV), statically linked, not stripped
>>
>> If it makes a difference, I am using arcboot.
> 
> I suppose then the question is, which is better for IP32? 

That's the question I was wondering during my first reply to your initial
post...

> CONFIG_BUILD_ELF64=y or CONFIG_BUILD_ELF64=n.  The reason the o64 hack
> used to exist, if my memory serves me correctly, was that someone once
> said that when built and run as a pure 64bit binary converted to 32bit
> via objcopy, 6 extra insns were run every cycle (I think), introducing
> unneeded slowdown.  This changed to 2 insns by going the o64 route,

OK that's the reason why the last patch you applied has no effect. If
you're using 'objcopy' your kernel can still be miss configured.

BTW, does your gcc support '-sym32' switch ?

> which involved CONFIG_BUILD_ELF64=n.  So 4 less insns technically
> resulted in a quicker kernel, though the layman might not notice such. 
> I believe that all changed at some point, which is why
> CONFIG_BUILD_ELF64=y was an A-OK thing prior to the __pa() introduction.
> 

My current feeling is that __pa() introduction now breaks configs
which were initialy _broken_, IMHO. CPHYSADDR() hide them because it
can happily convert any virutal address form both CKSEG0 or XKPHYS.

It may be a good thing to crash at this point. CONFIG_BUILD_ELF64 is
used in some others places, where it can introduce some others bugs
harder to find (if miss configured of course). The sad thing is that
the kernel does not report any useful messages. That's why I think
adding some specific sanity checks for 64 bit kernels in boot mem init
code may be usefull.

> Now I guess we're back to CONFIG_BUILD_ELF64=n?  I guess the real
> question is, which way is the OneWay(TM), RightWay(TM) and OnlyWay(TM)?
> 

Now it's clear that CONFIG_BUILD_ELF64 is really confusing. I would say
that whatever the value of CONFIG_BUILD_ELF64, your kernel should run
fine. BUT it really depends on your kernel load address:

if CONFIG_BUILD_ELF64=y then kernel load address must be in XKPHYS
if CONFIG_BUILD_ELF64=n then kernel load address must be in CKSEG0

All others configs (I think) are buggy...

That's said, it seems that IPxx kernels are really special
beasts. Take from MIPS makefile:

"""
Some machines like the Indy need 32-bit ELF binaries for booting
purposes.
"""

So I dunno if this statement is still correct but it sounds that you
have no other choice thatn CONFIG_BUILD_ELF64=n and load address in
CKSEG0.

I'm sorry but my IPxx background is 0 ;)

 		Franck
