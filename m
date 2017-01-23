Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2017 03:24:45 +0100 (CET)
Received: from resqmta-ch2-06v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:38]:41035
        "EHLO resqmta-ch2-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991970AbdAWCYgZxL4z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Jan 2017 03:24:36 +0100
Received: from resomta-ch2-17v.sys.comcast.net ([69.252.207.113])
        by resqmta-ch2-06v.sys.comcast.net with SMTP
        id VUJ4cbJmLTERUVUJ8cKrNe; Mon, 23 Jan 2017 02:24:34 +0000
Received: from [192.168.1.13] ([73.201.78.97])
        by resomta-ch2-17v.sys.comcast.net with SMTP
        id VUJ7cW6o9mqJQVUJ7cOhFn; Mon, 23 Jan 2017 02:24:34 +0000
Subject: Re: gcc-6.3.x miscompiling code for IP27?
To:     linux-mips@linux-mips.org
References: <ee417407-6877-f49c-5893-f3b3dbc2d103@gentoo.org>
 <44d9e9df-2d77-df23-266b-9cb90b0db4c9@gentoo.org>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <1cbb8434-d7ef-36e2-1f3e-ccbb5c52ce85@gentoo.org>
Date:   Sun, 22 Jan 2017 21:24:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <44d9e9df-2d77-df23-266b-9cb90b0db4c9@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHxg5FkA6+nTbViYjAYl62zZBAWe+Xla7HfwKFLuSg07omuOwIKs09pUM7ImbkZVRyBOHvkO2YcGjh3qKT6yFKQh95cYXnBdNSgI/Js99t6j+9aDsKP+
 VeAs2EPymt6CMoCl9R5zO6dl9plhsK7MTIrYlU7IP92lzEDkLhZZI39h
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56461
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

On 01/22/2017 20:03, Joshua Kinard wrote:
> On 01/22/2017 18:28, Joshua Kinard wrote:
>> I think I've run into a really odd gcc-6.3.x miscompile bug here on IP27.
>> But I'm not sure.  I've reproduced the issue on 4.9.5, 4.8.17, and now
>> 4.7.10 (which I KNOW should boot).  If I recompile the same 4.7.10 kernel
>> with gcc-5.4.0, though, it boots as expected.  The fault appears to be in
>> the assembly for _raw_spin_lock_irq.
>>
> 
> Figured it out.  Not 100% sure WHY, but gcc-6.3.x is causing kbuild to parse
> the arch/mips/sgi-ip32/Platform file for some reason on both IP27 and IP30
> builds, and is thusly appending -mr10k-cache-barrier=load-store to the kernel
> CFLAGS.  It did this on my Octane's kernel as well, but the Octane seems to be
> unaffected by the extraneous cache barriers.  I sent a fix in for this a long
> time ago, but it never got accepted.  So I'll try again...
> 

Nope.  I was wrong.  Still happens even after fixing the erroneous
mr10k-cache-barrier thing.  I'll send a patch in for that later now, but
looking at other sections of disassembly, I am see a pattern of this "sd
zero,..." instruction being placed at the beginning of most functions, before
most "daddiu" instructions.  I even test-compiled a vanilla kernel as well, and
the same issue is happening there when looking at disassembly (test boot also
Oopses):

Examples:

a80000000001c400 <run_init_process>:
a80000000001c400:       ffa0bff0        sd      zero,-16400(sp)
a80000000001c404:       67bdfff0        daddiu  sp,sp,-16

a80000000001d740 <per_cpu_init>:
a80000000001d740:       ffa0bfc0        sd      zero,-16448(sp)
a80000000001d744:       2405ffc9        li      a1,-55
a80000000001d748:       67bdffc0        daddiu  sp,sp,-64

a80000000001cea0 <ip27_be_handler>:
a80000000001cea0:       ffa0bfe0        sd      zero,-16416(sp)
a80000000001cea4:       67bdffe0        daddiu  sp,sp,-32

a8000000000256c0 <__compute_return_epc>:
a8000000000256c0:       ffa0bff0        sd      zero,-16400(sp)
a8000000000256c4:       67bdfff0        daddiu  sp,sp,-16

a80000000001c5b0 <name_to_dev_t>:
a80000000001c5b0:       ffa0bf90        sd      zero,-16496(sp)
a80000000001c5b4:       3c05a800        lui     a1,0xa800
a80000000001c5b8:       3c020074        lui     v0,0x74
a80000000001c5bc:       64a50000        daddiu  a1,a1,0
a80000000001c5c0:       64424840        daddiu  v0,v0,18496
a80000000001c5c4:       0005283c        dsll32  a1,a1,0x0
a80000000001c5c8:       67bdff90        daddiu  sp,sp,-112


I am not sure what to call this.  This is definitely not happening with a
gcc-5.4.x-built kernel, so it's a code-generation issue of some kind:

a80000000001c400 <run_init_process>:
a80000000001c400:	67bdfff0 	daddiu	sp,sp,-16
a80000000001c404:	3c02007b 	lui	v0,0x7b

a80000000001cec0 <ip27_be_handler>:
a80000000001cec0:	67bdffe0 	daddiu	sp,sp,-32
a80000000001cec4:	ffb00000 	sd	s0,0(sp)

a80000000001c5a0 <name_to_dev_t>:
a80000000001c5a0:	3c05a800 	lui	a1,0xa800
a80000000001c5a4:	3c020075 	lui	v0,0x75
a80000000001c5a8:	64a50000 	daddiu	a1,a1,0
a80000000001c5ac:	64423f40 	daddiu	v0,v0,16192
a80000000001c5b0:	0005283c 	dsll32	a1,a1,0x0
a80000000001c5b4:	67bdff90 	daddiu	sp,sp,-112


Oddly enough, Octane is definitely not bothered by this extraneous
store-doubleword instruction.  Only IP27 appears to be, which may explain why
it's gone unnoticed thus far.  Maybe NUMA-related?

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
