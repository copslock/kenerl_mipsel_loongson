Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Aug 2008 20:40:12 +0100 (BST)
Received: from sif.is.scarlet.be ([193.74.71.28]:11975 "EHLO sif.is.scarlet.be")
	by ftp.linux-mips.org with ESMTP id S20037030AbYHWTkE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 23 Aug 2008 20:40:04 +0100
Received: from [213.49.68.210] (ip-213-49-68-210.dsl.scarlet.be [213.49.68.210])
	(authenticated bits=0)
	by sif.is.scarlet.be (8.14.2/8.14.2) with ESMTP id m7NJdwlZ029814;
	Sat, 23 Aug 2008 21:39:59 +0200
Message-ID: <48B0678E.9010208@scarlet.be>
Date:	Sat, 23 Aug 2008 19:39:58 +0000
From:	Joel Soete <soete.joel@scarlet.be>
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
MIME-Version: 1.0
To:	Takashi Iwai <tiwai@suse.de>
CC:	"James.Bottomley" <James.Bottomley@HansenPartnership.com>,
	linux-mips <linux-mips@linux-mips.org>,
	ralf <ralf@linux-mips.org>,
	linux-parisc <linux-parisc@vger.kernel.org>
Subject: Re: [PATCH] mips: Add dma_mmap_coherent()
References: <K6047O$07C3A675C0E02FC7BE973C0D5DEF9AAA@scarlet.be> <s5hy72pmefh.wl%tiwai@suse.de>
In-Reply-To: <s5hy72pmefh.wl%tiwai@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-DCC-scarlet.be-Metrics: sif 20001; Body=6 Fuz1=6 Fuz2=6
Return-Path: <soete.joel@scarlet.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: soete.joel@scarlet.be
Precedence: bulk
X-list: linux-mips

Hello Takashi,

Takashi Iwai wrote:
> At Fri, 22 Aug 2008 13:04:36 +0100,
> Joel Soete wrote:
>> Hello Takashi et al.,
> ...
>> I build and boot successfully kernel 32bit including your patch on 2 systems
>> (a b2k using sba and a d380 using ccio).
> 
> Thanks for testing!
> 
welcome ;-)

>> I just noticed that the above code is ~ the same; otoh there is also a
>> iommu-helpers.h containing also common code to those 2 drivers. So may be for
>> easiest maintenance, could you merge and move this code in this 'helper' as
>> follow:
>> --- ./drivers/parisc/iommu-helpers.h.Orig	2008-08-01 12:57:22.000000000 +0000
>> +++ ./drivers/parisc/iommu-helpers.h	2008-08-22 08:07:26.000000000 +0000
> 
> That sounds like a good idea.
> 
> One concern is to define a non-inline function in *.h.  But,

Yes (I thought too but didn't find any other good reason then avoiding useless duplicate code)

> iommu-helper.h is included only by these two drivers, so there is no
> problem as now, although a comment would be more helpful.
> 
Yes I hope it will be enough for this stuff to be accepted ;-)

> 
>>> diff --git a/include/asm-parisc/dma-mapping.h b/include/asm-parisc/dma-mapping.h
>>> index 53af696..5b357b3 100644
>>> --- a/include/asm-parisc/dma-mapping.h
>>> +++ b/include/asm-parisc/dma-mapping.h
>> The small issue encountered: against latest Kyle git tree (dated 2008-07-29)
>> this file was moved in arch/parisc/include/asm.
> 
> Yes.  My patches are still based on older version (2.6.27-rc2 or so).
> 
> git cares renaming well, so it shouldn't be a big problem.
> I just tested it now and git-pull (oh now it's "git pull" :) renames
> it automatically indeed.
> 
Cool (tbh I know very few about git just git clone to grab a tree and git pull to get update from time to time ;-))

> 
> thanks,
> 
> Takashi
> --
Tx to your attention,
	J.
