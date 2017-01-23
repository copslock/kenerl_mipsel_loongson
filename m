Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2017 19:01:09 +0100 (CET)
Received: from resqmta-ch2-03v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:35]:46039
        "EHLO resqmta-ch2-03v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992136AbdAWSBCcIVRN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Jan 2017 19:01:02 +0100
Received: from resomta-ch2-05v.sys.comcast.net ([69.252.207.101])
        by resqmta-ch2-03v.sys.comcast.net with SMTP
        id Viunc5w0HMppVVivMcI6RM; Mon, 23 Jan 2017 18:01:00 +0000
Received: from [192.168.1.13] ([73.201.78.97])
        by resomta-ch2-05v.sys.comcast.net with SMTP
        id VivKcL86Z2Tt2VivLc1Dlp; Mon, 23 Jan 2017 18:01:00 +0000
Subject: Re: gcc-6.3.x miscompiling code for IP27?
To:     linux-mips@linux-mips.org
References: <ee417407-6877-f49c-5893-f3b3dbc2d103@gentoo.org>
 <44d9e9df-2d77-df23-266b-9cb90b0db4c9@gentoo.org>
 <1cbb8434-d7ef-36e2-1f3e-ccbb5c52ce85@gentoo.org>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <62c49213-812b-a9c2-b1a6-797ecdfa2829@gentoo.org>
Date:   Mon, 23 Jan 2017 13:00:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <1cbb8434-d7ef-36e2-1f3e-ccbb5c52ce85@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMbSgL5D3TeFloqyUtqciw6mjc0NDt3i81U8HE0zg1c1SP17/XH+kOB1/tcdpmtNbIp4pRE7FtUNz/wApjqYvDXIA60AmTLqjKJqoaYdM1Aw8hMNU3vJ
 BYFj/Eub5+3O/DuzM2xVewqAPPmbEkIXxKie1kWzv8MrB67mvOG1RqZJ
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56471
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

On 01/22/2017 21:24, Joshua Kinard wrote:
> On 01/22/2017 20:03, Joshua Kinard wrote:
>> On 01/22/2017 18:28, Joshua Kinard wrote:
>>> I think I've run into a really odd gcc-6.3.x miscompile bug here on IP27.
>>> But I'm not sure.  I've reproduced the issue on 4.9.5, 4.8.17, and now
>>> 4.7.10 (which I KNOW should boot).  If I recompile the same 4.7.10 kernel
>>> with gcc-5.4.0, though, it boots as expected.  The fault appears to be in
>>> the assembly for _raw_spin_lock_irq.

[snip]

> I am not sure what to call this.  This is definitely not happening with a
> gcc-5.4.x-built kernel, so it's a code-generation issue of some kind:

With some help from the gcc mailing list, the "sd" instructions emitted at the
beginning of every function is from the -fstack-check flag.  It enables
stack-probing to ensure there is sufficient space on the stack, else it'll
trigger a SEGV.  My guess is for IP27, at this early point in boot, the memory
system isn't up and running yet, due to IP27's somewhat-unique nature.  Thus,
this stack-probe will fail and trigger the NULL deref in _raw_spin_lock_irq().

The workaround I am going to go with is to add -fno-stack-check to IP27's
arch/mips/sgi-ip27/Platform file to disable stack-checking.  As far as I can
tell, this solves the issue on IP27 by not emitted these instructions anymore
(verified w/ objdump).  Not sure where this flag is getting set from.  Could be
set in my distro's toolchain somewhere.  But since at least IP30 is not
affected, I am going to assume it's specific to IP27 for now.

I'll send a patch in later this week...

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
