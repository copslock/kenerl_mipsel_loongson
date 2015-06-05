Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Jun 2015 01:34:15 +0200 (CEST)
Received: from resqmta-ch2-02v.sys.comcast.net ([69.252.207.34]:53149 "EHLO
        resqmta-ch2-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009385AbbFEXeOGpZFr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 6 Jun 2015 01:34:14 +0200
Received: from resomta-ch2-13v.sys.comcast.net ([69.252.207.109])
        by resqmta-ch2-02v.sys.comcast.net with comcast
        id cnZw1q0032N9P4d01na7tf; Fri, 05 Jun 2015 23:34:07 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-13v.sys.comcast.net with comcast
        id cna61q00D42s2jH01na6t5; Fri, 05 Jun 2015 23:34:07 +0000
Message-ID: <557231DD.8090006@gentoo.org>
Date:   Fri, 05 Jun 2015 19:33:49 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2 2/2]: MIPS: IP27: Xtalk detection cleanups
References: <556366E4.70407@gentoo.org> <20150605114127.GC26432@linux-mips.org>
In-Reply-To: <20150605114127.GC26432@linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1433547247;
        bh=MaPzGJLAPOyeyctqWtZyg4he2nwZ4SVxb+NhvGbMVKA=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=FDeythS+vP+zNefPUZiV49chSRPlumJfEDgXdYYL64+TE5YXzqjP61GKJkW7xlnrP
         x9KqyNt2RlxUdAJGf9dSxAJA4S+r85SKf+hSFGgU7Ckl0w6l+K2LHQX6FEa57940xN
         UoNkIyy1WvR+DbcwfBPzQIxESRm8kufYqfC+z4NB94u7f2ebBsAuPkfwess8dBMR2n
         tJ+l04crgjr5qgsxP/fwZF5Dxgd+NUqBZjDXgR0Utb94fsfWJZ+37XJixcpHXGN/n/
         DTXXCqGnbc42IUezX+mfakq1k1SQBGk01fawo99yNPeuz/+jdkOpNk+29+c+CeN1Co
         YRgdIGqwiAzFA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47891
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

On 06/05/2015 07:41, Ralf Baechle wrote:
> On Mon, May 25, 2015 at 02:16:04PM -0400, Joshua Kinard wrote:
> 
>> From: Joshua Kinard <kumba@gentoo.org>
>>
>> This is the second patch of two to clean up/update the Xtalk detection
>> code used by IP27 with some of the code used in the IP30 port.
>>
>> This specific patch replaces some of the IP27 Xtalk detection code with
>> methods used in the IP30 port, and converts the Xtalk devices into
>> platform devices.
> 
> Hm...  that all is good cleanup but registration as platform device doesn't
> help if there's no matching platform driver.  I assume you have something
> like that as part of your yet unpublished patches?

Kinda yeah.  It appears the original IP27 Xtalk code was only looking for
BRIDGE chips to identify and enumerate additional PCI buses.  At the time I
made this change, I modified a spare Impact board to fit the Onyx2 and
installed it.  It can boot the PROM on it and get a console, just the only odd
bit is the Onyx2's PROM never expected an Impact board, so it only says
"Welcome to", and nothing else at the bottom.

Linux sees the Impact board installed in the slot, but, for some reason, it was
not connecting the board to the impact driver and running the impact_probe
function, where I was anticipating additional errors to crop up.  I gave up at
that point and haven't had the time to finish chasing it down.  It's that, or
someone needs to help me write a driver for the InfiniteReality boards,
codename "Kona" :)

But the changes should enable IP27 to probe for XIO devices that don't have a
BRIDGE chip in front of them, which right now, is only the Impact (that I know
of).  I'm keeping an eye on eBay for other archaic XIO boards that may need
testing.  Just picked up an Onyx2 HD Video board of some kind.  I think it's
got a BRIDGE chip, though, so it might be PCI-based.

Impact itself needs more work before I can send that in.  I've been using
Stan's very original driver with some code clean-ups done by "Tanzy" in 2009
for the Octane, and then IP28 has a separate version from Peter Fuerst.  Those
need to be merged together so a single driver can work for both systems.

Same for Odyssey/VPro on Octane and maybe, IP35, but that's WAY down the road...

--J
