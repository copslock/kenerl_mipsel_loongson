Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 May 2016 21:08:56 +0200 (CEST)
Received: from resqmta-ch2-10v.sys.comcast.net ([69.252.207.42]:49959 "EHLO
        resqmta-ch2-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27031518AbcEWTIyolvP9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 May 2016 21:08:54 +0200
Received: from resomta-ch2-15v.sys.comcast.net ([69.252.207.111])
        by comcast with SMTP
        id 4vC9bIIhKpUrh4vDbbpeFD; Mon, 23 May 2016 19:08:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1464030527;
        bh=Wn9LsZahRc09DnS+8iv+JeG6e1hiyGHa/laRQgtnRcU=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=JRnoabagXafqfrDSssDKtKSehu7pfRV+Vma7XhVvQDTT7gnxJ3iQB6q3Fw1SsJj1Z
         s5+xLmIlklih8zfJz+NweaED2DG11pDxYghLbCp0EGrgkRffO7CTFCkgQ1lj0FUpEg
         Q7zZZJqzf1HXi9JWaHQszo3TXCtaUXbe258r1Np4PIy8FNIRCJkHJMxumPckwmYB41
         Bd2C3CysqBQyUqMgKNqIKEnWzv6cJ3Df5+0Bypt3E36vBOdiaJHg/ilUh2aLg7AYG2
         fTveTvJAXGJ7k9E/pqa7AS7c0VzavCnRAstrstNrRmJNKE9u/M0S+lwEWOjHb2svCw
         /UYR3t/SCVe+A==
Received: from [192.168.1.13] ([76.106.83.43])
        by resomta-ch2-15v.sys.comcast.net with comcast
        id xv8m1s0040w5D3801v8mFa; Mon, 23 May 2016 19:08:47 +0000
Subject: Re: THP broken on OCTEON?
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        David Daney <ddaney.cavm@gmail.com>
References: <20160523151346.GA23204@ak-desktop.emea.nsn-net.net>
 <20160523152007.GB28729@linux-mips.org> <57432E02.9000008@gmail.com>
 <20160523185226.GA1253@raspberrypi.musicnaut.iki.fi>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        linux-mips@linux-mips.org, "Hill, Steven" <Steven.Hill@cavium.com>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <57435538.7030503@gentoo.org>
Date:   Mon, 23 May 2016 15:08:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:44.0) Gecko/20100101
 Thunderbird/44.0
MIME-Version: 1.0
In-Reply-To: <20160523185226.GA1253@raspberrypi.musicnaut.iki.fi>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53622
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

On 05/23/2016 14:52, Aaro Koskinen wrote:
> On Mon, May 23, 2016 at 09:21:22AM -0700, David Daney wrote:
>> On 05/23/2016 08:20 AM, Ralf Baechle wrote:
>>> On Mon, May 23, 2016 at 06:13:46PM +0300, Aaro Koskinen wrote:
>>>> I'm getting kernel crashes (see below) reliably when building Perl in
>>>> parallel (make -j16) on OCTEON EBH5600 board (8 cores, 4 GB RAM) with
>>>> Linux 4.6.
>>>>
>>>> It seems that CONFIG_TRANSPARENT_HUGEPAGE has something to do with the
>>>> issue - disabling it makes build go through fine.
>>>>
>>>> Any ideas?
>>>
>>> I thought it was working except on SGI Origin 200/2000 aka IP27 where
>>> Joshua Kinard (added to cc) was hitting issues as well.
>>>
>>> Joshua, does that similar to the issues you were hitting?
>>
>> There is nothing OCTEON specific in the THP code, or huge pages in general.
>>
>> That said, we have seen other THP related failures, and have never been able
>> to find the cause.
>>
>> If someone can come up with a reproducible test case that triggers quickly,
>> we can run it in our simulator and easily find the problem.
> 
> Trying to build Perl is a reliable reproducer. Is that too heavyweight
> for your simulator?
> 
> I was able to reproduce this also on EdgeRouter Pro, but there the kernel
> does not fail, only compiler dies with SIGBUS:
> 
> [  315.095264] Data bus error, epc == 0000000000a801c4, ra == 0000000000a80624
> 
> And without THP the build is fine.
> 
> I also tried CN68XX board with 16 GB RAM and also there I get SIGBUS failure
> instead of Machine Check.

SIGBUS is closer to what I was seeing on IP30/IP27, but there's two different
SIGBUS errors in MIPS, a Data Bus Error (DBE) and Instruction Bus Error (IBE).
 I've only seen IBEs result from using THP on Octane/IP30 and Origin/Onyx2/IP27.

Also CC'ing Alastair Bridgewater (nyef), who was working on bringing up the
IP35 hardware (Origin 300/350), as he had been working on tracing down some
possible issues in the TLB code.  He had a small test case at the below address
(use annotation #2), but I don't know if he got any further on debugging it.

http://paste.lisp.org/display/305809#2

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
