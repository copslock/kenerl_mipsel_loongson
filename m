Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Mar 2006 22:21:09 +0100 (BST)
Received: from baldrick.bootc.net ([83.142.228.48]:26594 "EHLO
	baldrick.bootc.net") by ftp.linux-mips.org with ESMTP
	id S8133574AbWC2VU7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Mar 2006 22:20:59 +0100
Received: from [192.168.1.6] (cpc3-hudd6-0-0-cust471.hudd.cable.ntl.com [86.3.1.216])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by baldrick.bootc.net (Postfix) with ESMTP id C549C1400BEC;
	Wed, 29 Mar 2006 22:31:33 +0100 (BST)
In-Reply-To: <20060329160337.GI31939@networkno.de>
References: <44299EE6.7010309@bootc.net> <20060328235827.GC31939@networkno.de> <671FD00E-F2EB-4D8C-A391-5393096BC43D@bootc.net> <20060329160337.GI31939@networkno.de>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E9A44E96-DD59-4543-AC62-586BFDB6E720@bootc.net>
Cc:	linux-mips@linux-mips.org
Content-Transfer-Encoding: 7bit
From:	Chris Boot <bootc@bootc.net>
Subject: Re: Emulating MIPS -- please help!
Date:	Wed, 29 Mar 2006 22:31:31 +0100
To:	Thiemo Seufer <ths@networkno.de>
X-Mailer: Apple Mail (2.746.3)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at bootc.plus.com
Return-Path: <bootc@bootc.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bootc@bootc.net
Precedence: bulk
X-list: linux-mips

On 29 Mar 2006, at 17:03, Thiemo Seufer wrote:

> On Wed, Mar 29, 2006 at 04:47:23PM +0100, Chris Boot wrote:
> [snip]
>> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
>> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
>> Memory: 128480k/131072k available (907k kernel code, 2556k reserved,
>> 172k data, 96k init, 0k highmem)
>> Mount-cache hash table entries: 512
>> Checking for 'wait' instruction...  available.
>>
>> At this stage it gets stuck and I have to kill qemu. Any ideas how to
>> debug this?
>
> Familiar symptom, I fixed it but don't remember offhand which patch
> contains the fix. It was either related to TLB emulation or to
> kernel-mode/user-mode mismatch.

Well, I added a few more patches and it finally boots now, but it  
can't mount the root FS off the RAMDISK. I'm not sure if this is a  
side-effect of the previous initrd problem or what, but it feels good  
to be getting further...

>> I've only applied the elf-loader patch since I was having
>> trouble applying some of the others to my Ubuntu qemu 0.8.0.
>
> The patches are for upstream CVS.

Hmm, well I might give it a shot and see what happens. I'd rather  
stick with a stable version, but if it gets me somewhere it's  
probably worth it.

Thanks very much,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/
