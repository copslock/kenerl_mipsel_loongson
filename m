Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Nov 2004 01:19:25 +0000 (GMT)
Received: from rwcrmhc11.comcast.net ([IPv6:::ffff:204.127.198.35]:47031 "EHLO
	rwcrmhc11.comcast.net") by linux-mips.org with ESMTP
	id <S8224905AbUKPBTU>; Tue, 16 Nov 2004 01:19:20 +0000
Received: from [192.168.1.4] (pcp05077810pcs.waldrf01.md.comcast.net[68.54.246.193])
          by comcast.net (rwcrmhc11) with ESMTP
          id <2004111601191201300cuogpe>; Tue, 16 Nov 2004 01:19:13 +0000
Message-ID: <4199561E.9040500@gentoo.org>
Date: Mon, 15 Nov 2004 20:21:34 -0500
From: Kumba <kumba@gentoo.org>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: [PATCH]: Rewrite of arch/mips/ramdisk/
References: <4196FE7C.9040309@gentoo.org> <20041114085202.GA30480@lst.de> <419794FB.6020104@gentoo.org> <4197B286.4060503@gentoo.org> <20041115175514.GA6069@linux-mips.org>
In-Reply-To: <20041115175514.GA6069@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6339
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> 
> I guess you and many others don't realize the speed of the Linux evolution
> these days.  Between 2.6.10-rc1 and 2.6.10-rc2 there's about 9MB of
> patches.  Even if much of the code is not changing - the halftime for
> patches has reduced quite a bit ...

I'm aware of the speed at which the kernel changes.  What I didn't expect was 
that I picked the one time to try and fix mips embedded ramdisks with a more 
permanent fix at the same time someone else did -- just the someone else had a 
much better idea that applied more globally.  Call it bad timing with a little 
bit of coincidence mixed in.

I'll have to figure out how this CONFIG_INITRAMFS_SOURCE works now (it doesn't 
look like the Kconfig bits are in yet, a quick grep only shows mentions in 
defconfigs), and then see how it can replace the older embedded ramdisk idea.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: small 
hands do them because they must, while the eyes of the great are elsewhere." 
--Elrond
