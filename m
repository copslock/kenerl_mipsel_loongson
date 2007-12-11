Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Dec 2007 21:09:05 +0000 (GMT)
Received: from rs25s3.datacenter.cha.cantv.net ([200.44.33.4]:2215 "EHLO
	rs25s3.datacenter.cha.cantv.net") by ftp.linux-mips.org with ESMTP
	id S20021565AbXLKVIz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 11 Dec 2007 21:08:55 +0000
Received: from [192.168.0.2] (dC9D088C0.dslam-04-10-6-02-1-01.apr.dsl.cantv.net [201.208.136.192])
	by rs25s3.datacenter.cha.cantv.net (8.13.8/8.13.0/3.0) with ESMTP id lBBL7ZBT024341;
	Tue, 11 Dec 2007 16:37:37 -0430
X-Matched-Lists: []
Message-ID: <475EC648.8030906@kanux.com>
Date:	Tue, 11 Dec 2007 13:18:00 -0400
From:	Ricardo Mendoza <ricmm@kanux.com>
User-Agent: Thunderbird 2.0.0.0 (X11/20070601)
MIME-Version: 1.0
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
CC:	linux-mips@linux-mips.org
Subject: Re: Still no 2.6.24 on ip32 [was: Re: 2.6.24-rc1 does not boot on
 SGI]
References: <1193468825.7474.6.camel@scarafaggio> <20071029.000713.59464443.anemo@mba.ocn.ne.jp> <1193599031.14874.1.camel@scarafaggio> <20071029150625.GB4165@linux-mips.org> <1194268551.4842.3.camel@scarafaggio> <1194281699.4192.3.camel@casa> <1197287929.17265.6.camel@scarafaggio> <475D7FE2.7080703@kanux.com> <1197371095.7889.24.camel@scarafaggio> <475E9012.1010504@kanux.com> <20071211204437.GA14243@eppesuigoccas.homedns.org>
In-Reply-To: <20071211204437.GA14243@eppesuigoccas.homedns.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV version 0.91.2, clamav-milter version 0.91.2 on 10.128.1.89
X-Virus-Status:	Clean
Return-Path: <ricmm@kanux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17779
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ricmm@kanux.com
Precedence: bulk
X-list: linux-mips

Giuseppe Sacco wrote:

> On Tue, Dec 11, 2007 at 09:26:42AM -0400, Ricardo Mendoza wrote:
>> Giuseppe Sacco wrote:
>>
>>> I just checked that my repository is up to date, so my problem is still
>>> there (thus I don't know if it is the same problem you fixed).
>>>
>>> BTW, what was the problem you fixed? I would like to have a look to it,
>>> to better understand what's going on there.
>> Well I just updated to see if anything had broken in the past few days,
>> but I don't seem to be hitting that error of yours. Could you send your
>> config to see if I can reproduce it?
> 
> Yes, sure: http://eppesuigoccas.homedns.org/~giuseppe/debian/config-2.6.24-rc4-ip32.bz2
> but please note that the problem is present in every kernel since 2.6.24-rc1
> 
> my boot stanza in arcboot is:
> 
> label=test
>   image=/boot/vmlinux-2.6.24-rc4-gs1
>   append="root=/dev/sda1 ro video=gbefb:1024x768-16@60 debug initcall_debug console=tty0 console=ttyS1,115200"

Ran it without problems, can't get into much detail right now but I the
problem you are seeing is more than likely caused by your other patch to
serial_core.c.


     Ricardo
