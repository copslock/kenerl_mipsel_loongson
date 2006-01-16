Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2006 16:24:56 +0000 (GMT)
Received: from Jg555.com ([64.30.195.78]:22183 "EHLO jg555.com")
	by ftp.linux-mips.org with ESMTP id S8133509AbWAPQYg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Jan 2006 16:24:36 +0000
Received: from [172.16.0.55] ([::ffff:172.16.0.55])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Mon, 16 Jan 2006 08:28:08 -0800
  id 001F0A6F.43CBC998.00007288
Message-ID: <43CBC97E.3090800@jg555.com>
Date:	Mon, 16 Jan 2006 08:27:42 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	Martin Michlmayr <tbm@cyrius.com>
CC:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Tulip RaQ2 64 Bit Fix
References: <4393CD9F.3090305@jg555.com> <20051205114456.GA2728@linux-mips.org> <20060116160355.GB28383@deprecation.cyrius.com>
In-Reply-To: <20060116160355.GB28383@deprecation.cyrius.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

Martin Michlmayr wrote:
> * Ralf Baechle <ralf@linux-mips.org> [2005-12-05 11:44]:
>   
>>> The attached patch allows the tulip driver to work with the RaQ2's
>>> network adapter. Without the patch under a 64 bit build, it will
>>> never negotiate and will drop packets. This driver is part of
>>> Linux Parisc, by Grant Grundler. It's currently in -mm, but Jeff
>>> Garzick will not apply it to the main tree.
>>>       
>> Why?
>>     
>
> Jim, I don't think you ever responded to this.
>
> Do you know the status of this patch?
>   
Jeff Garzick refuses to apply it do to spinlocks. Andrew Morton is 
including in his tree because it fixes issue with Parisc and with MIPS 
based builds. So it's kinda of what is the right thing to do. I also use 
this driver on my x86 builds, and it actually performs better. Here is a 
little history of how Grant made the driver.

Grant Grundler is the network maintainer for Parisc Linux.
He discovered that the tulip driver didn't perform that well. He 
researched the manufactures documentation and found out how to fix the 
driver to work to its optimum performance. He did this back in 2003, has 
submitted it to Jeff Garzick several times with no response. Around late 
2004, I started to do test builds on 64 bit on my RaQ2 and discovered 
that the driver would not auto-negotiate transfer speeds. Talked to 
numerous people, then someone put me in touch with Grant. I tested the 
driver for about 2 weeks, ask Grant why it wasn't sent upstream, he told 
me about the spinlock issue. I then contacted Andrew Morton, explained 
everything as I am here, and he agreed it was needed and tried to get 
Jeff to add it. Jeff sends back a one liner say doing to it's use of 
spinlocks it's not accepted.

That's the gory history.

-- 
----
Jim Gifford
maillist@jg555.com
