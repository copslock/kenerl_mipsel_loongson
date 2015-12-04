Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2015 14:14:41 +0100 (CET)
Received: from resqmta-ch2-12v.sys.comcast.net ([69.252.207.44]:35341 "EHLO
        resqmta-ch2-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013216AbbLDNOjyi6Gv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Dec 2015 14:14:39 +0100
Received: from resomta-ch2-13v.sys.comcast.net ([69.252.207.109])
        by resqmta-ch2-12v.sys.comcast.net with comcast
        id pRER1r00C2N9P4d01REXV0; Fri, 04 Dec 2015 13:14:31 +0000
Received: from [192.168.1.13] ([76.106.83.43])
        by resomta-ch2-13v.sys.comcast.net with comcast
        id pREW1r0010w5D3801REWNb; Fri, 04 Dec 2015 13:14:31 +0000
Subject: Re: [PATCH 0/9] MIPS Relocatable kernel & KASLR
To:     Matt Redfearn <matt.redfearn@imgtec.com>
References: <1449137297-30464-1-git-send-email-matt.redfearn@imgtec.com>
 <5660C0D5.208@gentoo.org> <56614B70.9090700@imgtec.com>
Cc:     linux-mips@linux-mips.org
From:   Joshua Kinard <kumba@gentoo.org>
X-Enigmail-Draft-Status: N1110
Message-ID: <566191A4.1070003@gentoo.org>
Date:   Fri, 4 Dec 2015 08:14:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <56614B70.9090700@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1449234871;
        bh=3D9mCYS95VWkR/X2p2X7Owsy6PJx4K3nLDTrLeRRe7g=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=OWrfNQDRsR0FX2x0kDcZ0bdQ5s9RKH3r87MOzz3saiw486hY4JTQKM3u9ZiuweChM
         Fx7/2a5XNksVpCyQo7/gPertMmlnOlr2e6XIympPvG42u6L5nYfk+maiDMVPOSBzC0
         WzhfbVVjPP9OHIsq5/86wBf/gK9hW22NyLbpySg2lTgNufqiBA2fy0Egphct033Kvh
         OxH+ohNsV1mxQdiMgRCCn/QJnmqb1oWlysykvDTyNKgDTIM83HfqLM7Taascli9HYp
         uLDS1SYOp028xoII09pGa/E9MsXHh+XAwvGFs6T6OqTeHFTxuDK9tFdbpg7ximNKU5
         Zhh529zA1GFkQ==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50334
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips


Hazards shouldn't be an issue on the R10000-series of processors, as they
handle all hazards in hardware. So I guess that leaves just finding a
replacement for 'synci' on those CPUs, and then maybe relocs could be used on
at least IP27, IP28, and IP30 systems (and IP32, if we ever solve the coherency
issues there w/ R10K).

Not sure what benefit there would be, though.

--J



On 12/04/2015 03:14, Matt Redfearn wrote:
> Hi Joshua,
> The patch as it stands uses a couple of MIPS R2 additional instructions to deal
> with synchronizing icache. Firstly, the synci instruction to ensure that icache
> is in sync with the dcache after the relocated kernel has been written, and the
> jr.hb instruction to resolve any hazards created by writing the new kernel
> before jumping to it.
> 
> Thanks,
> Matt
> 
> On 03/12/15 22:23, Joshua Kinard wrote:
>> On 12/03/2015 05:08, Matt Redfearn wrote:
>>> This series adds the ability for the MIPS kernel to relocate itself at
>>> runtime, optionally to an address determined at random each boot. This
>>> series is based on v4.3 and has been tested on the Malta platform.
>> [snip]
>>
>>> * Relocation is currently supported on R2 of the MIPS architecture,
>>>    32bit and 64bit.
>> Out of curiosity, why is this capability restricted to MIPS R2 and higher?
>> IRIX kernels and the 'sash' tool were both relocatable on the older SGI
>> platforms.  Does the feature, as implemented, rely on R2-specific
>> instructions/capabilities, or only due to lack of testing on pre-R2 hardware?
>>
>> --J
>>
> 
> 


-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
