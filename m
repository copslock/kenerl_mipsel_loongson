Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 May 2017 14:47:38 +0200 (CEST)
Received: from resqmta-ch2-12v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:44]:53370
        "EHLO resqmta-ch2-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993552AbdEVMraPuyHN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 May 2017 14:47:30 +0200
Received: from resomta-ch2-05v.sys.comcast.net ([69.252.207.101])
        by resqmta-ch2-12v.sys.comcast.net with SMTP
        id CmkAdobRvdlFQCmkAd7omp; Mon, 22 May 2017 12:47:26 +0000
Received: from [192.168.1.13] ([76.106.92.144])
        by resomta-ch2-05v.sys.comcast.net with SMTP
        id Cmk7dC9k5xrGZCmk8dPv30; Mon, 22 May 2017 12:47:26 +0000
Subject: Re: [PATCH 00/21] MIPS memblock: Remove bootmem code and switch to
 NO_BOOTMEM
To:     Serge Semin <fancer.lancer@gmail.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc:     ralf@linux-mips.org, paul.burton@imgtec.com, rabinv@axis.com,
        matt.redfearn@imgtec.com, james.hogan@imgtec.com,
        alexander.sverdlin@nokia.com, robh+dt@kernel.org,
        frowand.list@gmail.com, Sergey.Semin@t-platforms.ru,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
 <be0b6614-708d-a32a-029d-7e606a673e5b@imgtec.com>
 <20170522102643.GA17763@mobilestation>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <ef3d7a8c-2a73-2082-0d64-bdb4f95df204@gentoo.org>
Date:   Mon, 22 May 2017 08:47:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20170522102643.GA17763@mobilestation>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDeWWR2Wt0bgSXlqGfKFYfFIxsRThwP0XaVZPHGJj1a+dJ4PyGLihhdGH2zgfM9X0pPozdbcp32UWTesVY+oKBoGoGXOuw5Up3Wl7EqOvRvskSVzlJzW
 XBC7CVT+qhWdTRyKYu7b8A4bOvMGsytLBPj8TXM7eWl/WP2XH/8lNDZYrCgUeqL3JfhHhksVMoBz7jAkCFeXToEqBpwzWGMNwiBeVHUpthB2rIcWDi178PUr
 ktLal1c3OdCIl7b/qIIP2CtGEKRAwkZhmi058DC5ocd102Yn6JIun6lliObohJqVPlqCvKnOYhtegwr81kfGi/gvoy3NDrdvn6zo43+A0C6Ths2ujDY6lmLm
 S7yd0iQORvctgk4LzZVZhvQqHuaZ9wwGIPP5KZjlapXwY39Y/navWm8VPJF5LX9PBaEN0+yBitJGYii+F0p0bB1S+UKbaGhgTbjP8kpEtmv9uG2T9ZvZiua/
 jeNgmUVfksCzuOqUmC5vPTXSlNiVN5vwwqgc4H3KOPJDpiLEY1PhugHYQ729CjzTy1XOptNiMZkEyiL13MxB/LWD1Z85t6BLXTMQ/ydfBrBGYBVuNIBIATNa
 k+wXR5k5wwNWGKRvWfTSZjE9poLnhH5wO69VuJImSNVzJF3dvi9Y82MbIE8cXAldaMM=
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57933
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

On 05/22/2017 06:26, Serge Semin wrote:
> On Mon, May 22, 2017 at 11:48:36AM +0200, Marcin Nowakowski <marcin.nowakowski@imgtec.com> wrote:
> 
> Hello Marcin,
> 
>> Hi Serge,
>>
>> On 19.12.2016 03:07, Serge Semin wrote:
>>> Most of the modern platforms supported by linux kernel have already
>>> been cleaned up of old bootmem allocator by moving to nobootmem
>>> interface wrapping up the memblock. This patchset is the first
>>> attempt to do the similar improvement for MIPS for UMA systems
>>> only.
>>>
>>> Even though the porting was performed as much careful as possible
>>> there still might be problem with support of some platforms,
>>> especially Loonson3 or SGI IP27, which perform early memory manager
>>> initialization by their self.
>>>
>>> The patchset is split so individual patch being consistent in
>>> functional and buildable ways. But the MIPS early memory manager
>>> will work correctly only either with or without the whole set being
>>> applied. For the same reason a reviewer should not pay much attention
>>> to methods bootmem_init(), arch_mem_init(), paging_init() and
>>> mem_init() until they are fully refactored.
>>>
>>> The patchset is applied on top of kernel v4.9.
>>
>> Have you progressed any further with these patches?
>> They would definitely be useful to include for MIPS arch, so can you let us
>> know if you are planning to send any updated version?
>>
>> thanks,
>> Marcin
> 
> Sorry for such a long delay with response. I have been really busy
> during last three months. Alas I'll still be busy for next 1-2
> months as well. You know how it usually works with urgent projects.
> One needs to do this thing, then that thing, and at some point I just
> forgot about this thread.
> 
> Regarding the patchset. I'm still pretty much eager to make it being
> part of kernel MIPS arch. But there was a problem I outlined
> in the patchset header message, which I can't fix by myself.
> Particulary It's connected with Loonson3 or SGI IP27 code alteration,
> so to make it free of ancient boot_mem_map dependencies (see the
> patchset header message). Without a help from someone, who has
> Loonson64 and SGI IP27 hardware and strong desire to make it free of
> old bootmem allocator, it is useless to make any progress from my
> side. That's why Ralf moved this email-thread into RFC actually.
> Anyway If either you or someone else has got such hardware and is
> interested in the cooperation, I'll be more than happy to push
> my efforts forward with this patchset contribution. But only after
> I got a bit less busy with my work. As I said it will happen within
> next 1-2 months. So do you have the hardware and desire to be part
> of this?
> 
> Regards,
> -Sergey

I have an SGI Onyx2 and just recently acquired a working SGI Origin 200.  The
Onyx2 has NUMA issues yet to be hunted down, but I got ~3 days uptime out of
the Origin 200 running compiles before powering it down.  Mainline needs 2-3
small patches to make IP27 workable, last I tested.

I'd have to look at the IP27 code again and see if I can make sense of what
it's doing.  I think it dealt with either setting up memory for an initrd
(which I haven't used in over a decade), or it's for the NUMA stuff to discover
all memory on each node.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
