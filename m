Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Sep 2014 07:18:55 +0200 (CEST)
Received: from resqmta-ch2-03v.sys.comcast.net ([69.252.207.35]:44034 "EHLO
        resqmta-ch2-02v.sys.comcast.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27008535AbaI2FSyA2H9b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Sep 2014 07:18:54 +0200
Received: from resomta-ch2-20v.sys.comcast.net ([69.252.207.116])
        by resqmta-ch2-02v.sys.comcast.net with comcast
        id wtJm1o0022XD5SV01tJmpB; Mon, 29 Sep 2014 05:18:46 +0000
Received: from [192.168.1.13] ([69.251.152.165])
        by resomta-ch2-20v.sys.comcast.net with comcast
        id wtJl1o0013aNLgd01tJlck; Mon, 29 Sep 2014 05:18:46 +0000
Message-ID: <5428EBB4.7090509@gentoo.org>
Date:   Mon, 29 Sep 2014 01:18:44 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: gcc-4.8+ and R10000+
References: <540C165F.7030307@gentoo.org> <alpine.LFD.2.11.1409282017540.21156@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1409282017540.21156@eddie.linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1411967926;
        bh=lrcMj/LOIYLqQsdY+UiCoKDgfNf9GeHJaE6uYQ9Baus=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=c4ltfpgnsAPGdYIHxjerCTOqfciofL+EutVpwvqrpS+G1qQR/wjcI93mKNBO5ccsV
         3VZS2ZQQgDvkLAtM45iZzi4B5VoXKXiBEnsrYU+S0/tiyLBmZ+a4Nh9MGwlPQ8fANR
         jt+Lrem/XyXPYDprz3L2yidl4h4E/t1+SxftHzvWQONF00Xtfg5xOg/pQZ8s1yg79N
         Cxs1o+NgoCnh3XYK+T3NzqTFpEduDwctIJ8h29faaFU+mM1W5dt1Ph8D5/ivw/ZeQy
         e5VTgz51lSyWJWJ/ADkLvWwKZb/JXwuOwWjz+xPf9Jyndfnh7u5MpFMQhKQxysia3f
         iqxu8Dl+t22Rw==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42873
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

On 09/28/2014 15:34, Maciej W. Rozycki wrote:
> Joshua,
> 
>  I can't help you with the problem, but I can confirm one of your guesses:
> 
>> I am guessing at a few things here:
>>
>> - Because ll/sc are atomic, gdb doesn't let you step through them, which is
>> why the instruction pointer jumps over the 'li' and 'sc' insns.
> 
> -- this is exactly the case, GDB tries to be smart enough and when it sees 
> an LL or LLD instruction it examines code that follows to find a matching 
> SC or SCD instruction and any other exit points from the atomic section 
> and sets internal breakpoints correctly to let the code fragment run at 
> the full speed even if single stepping.  Otherwise the exception taken at 
> each single step would cause the conditional store instruction to always 
> fail -- which might not be a big issue if you were knowingly stepping code 
> e.g. with `stepi', but would cause big harm in implicit stepping through 
> unknown or unrelated code such as when a software watchpoint is active.
> 
>  See `deal_with_atomic_sequence' in gdb/mips-tdep.c if curious about the 
> details.

Ah ha, that does explain it!  Though I don't think it's an issue with ll/sc in
the R10000.  It's something with gcc's builtin __atomic_* functions I think,
though I still haven't ruled the kernel out yet, either.  I have no way to step
through the kernel syscall to make that determination, though, so I'm focusing
more on gcc as time permits.  Hopefully, the gcc maintainers will find time to
look into PR61538 some more soon.

Thanks!

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
