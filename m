Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Feb 2006 08:35:04 +0000 (GMT)
Received: from [213.189.19.80] ([213.189.19.80]:30727 "EHLO mail.kpsws.com")
	by ftp.linux-mips.org with ESMTP id S8133447AbWBMIeA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 13 Feb 2006 08:34:00 +0000
Received: (qmail 32688 invoked by uid 89); 13 Feb 2006 08:40:06 -0000
Received: from unknown (HELO mail.kpsws.com) (127.0.0.1)
  by localhost with SMTP; 13 Feb 2006 08:40:06 -0000
Received: from 194.171.252.101
        (SquirrelMail authenticated user pulsar@kpsws.com)
        by mail.kpsws.com with HTTP;
        Mon, 13 Feb 2006 09:40:06 +0100 (CET)
Message-ID: <40646.194.171.252.101.1139820006.squirrel@mail.kpsws.com>
In-Reply-To: <1139587262.12521.12.camel@localhost.localdomain>
References: <20060210.005104.63742308.anemo@mba.ocn.ne.jp> 
     <13126.194.171.252.101.1139502756.squirrel@mail.kpsws.com> 
     <1139587262.12521.12.camel@localhost.localdomain>
Date:	Mon, 13 Feb 2006 09:40:06 +0100 (CET)
Subject: Re: changing the page properties to cached/uncached
From:	"Niels Sterrenburg" <pulsar@kpsws.com>
To:	"Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc:	pulsar@kpsws.com, linux-mips@linux-mips.org
Reply-To: pulsar@kpsws.com
User-Agent: SquirrelMail/1.4.0
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Return-Path: <pulsar@kpsws.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pulsar@kpsws.com
Precedence: bulk
X-list: linux-mips

> On Iau, 2006-02-09 at 17:32 +0100, Niels Sterrenburg wrote:
>> - Do not use swapping in the system
>> - Limit Linux memory usage via the mem= option in the kernel command
>> line.
>> - From MIPS user space: do a mmap for the shared memory area.
>> - From MIPS user space: call (our selfwritten) shmemipc driver with the
>> request to set the mapped pages to cached (by passing virtual address
>> and
>> length).
>> - From kernel space: find the vma for the supplied virtual address range
>> and change cache properties of all pages in that virtual range.
>
> You don't need to worry about swapping. You can simply mark the pages in
> question reserved just as i386 does with the 640K-1Mb hole or since when
> a page has a use count it won't swap out, mark it as having a user. In
> your case the "user" is the DSP so you just need to account fine

Ok, swapping is not (yet) relevant for us, but I'll keep it in mind.

> You can provide your own "nopage" method. Good example is
> sound/oss/via82cxxx_audio.c
>
So if I understand correctly I can implement my own nopage routine
as part of my driver mmap functionanlity (via initializing vm_ops in mmap).

When an mmap on my driver is done to a virtual area for which nopage's
exist then my nopage routine is called, right ?

Then I can handle tha cache properties while creating the page(s), right ?

In the case of the via82cxxx_aucio.c it grabs a dma page, claims it
and returns it, right ?

If all my above interpretations are correct, how can I then toggle the
page caching properties:
- on which level should I do that: pte/page level or vma level ?

regards,

Niels
