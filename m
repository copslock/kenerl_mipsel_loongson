Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 May 2016 20:57:50 +0200 (CEST)
Received: from resqmta-ch2-07v.sys.comcast.net ([69.252.207.39]:60687 "EHLO
        resqmta-ch2-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027124AbcEWS5pdrpc9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 May 2016 20:57:45 +0200
Received: from resomta-ch2-14v.sys.comcast.net ([69.252.207.110])
        by comcast with SMTP
        id 4utbbVQM0p1Be4v2nbDZgS; Mon, 23 May 2016 18:57:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1464029857;
        bh=Sqiy+gSrhkXMjeD3Mj0FRo4GvGljfqF8hHXTMdMG3ew=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=XH76Sjw3kSF5MED/yqqh1D6sVAOX6wpAuefCAkUPXa8YbP7v3JW6UZ/0h3QL36+z8
         voFwWoY8Q4KobazQGixgATI5QQNVF9BzmycmyTDRoeXaf48LIwHgGj9wlnvnHVS4yL
         II4aWTaz2nUmC5p7anXEVtEb0D+rDZIKAG83NUIUtA5YAX55eu7GfQirhgIePCzuJW
         qvvIx0C7FNWyxcYVkdKUEjaWwda1HMKR8Tfmin2arZppDWdKeia+HlWUon9waI9+K0
         ux8guUJCle02BE3yvnoucdqE48pWeh0F2YI75CBV7XlzzkW4iXaqgK8+kz1HO9rQY+
         F1VVMOIDb2Oyg==
Received: from [192.168.1.13] ([76.106.83.43])
        by resomta-ch2-14v.sys.comcast.net with comcast
        id xuxc1s00P0w5D3801uxdZ2; Mon, 23 May 2016 18:57:37 +0000
Subject: Re: THP broken on OCTEON?
To:     linux-mips@linux-mips.org
References: <20160523151346.GA23204@ak-desktop.emea.nsn-net.net>
 <20160523152007.GB28729@linux-mips.org>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <5743529A.4070506@gentoo.org>
Date:   Mon, 23 May 2016 14:57:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:44.0) Gecko/20100101
 Thunderbird/44.0
MIME-Version: 1.0
In-Reply-To: <20160523152007.GB28729@linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53620
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

On 05/23/2016 11:20, Ralf Baechle wrote:
> On Mon, May 23, 2016 at 06:13:46PM +0300, Aaro Koskinen wrote:
> 
>> I'm getting kernel crashes (see below) reliably when building Perl in
>> parallel (make -j16) on OCTEON EBH5600 board (8 cores, 4 GB RAM) with
>> Linux 4.6.
>>
>> It seems that CONFIG_TRANSPARENT_HUGEPAGE has something to do with the
>> issue - disabling it makes build go through fine.
>>
>> Any ideas?
> 
> I thought it was working except on SGI Origin 200/2000 aka IP27 where
> Joshua Kinard (added to cc) was hitting issues as well.
> 
> Joshua, does that similar to the issues you were hitting?
> 
>   Ralf

NAK, this issue looks completely different to IP30/IP27.  In this case, it
looks like the hardware is detecting the case where multiple TLB entries match
and it's killing the machine to avoid hardware damage.  I don't want to know
how the SGI systems handle this scenario (does the R10000 do a TLB shutdown??).

On IP30, using THP usually results in instruction bus errors (IBE), after a set
time, depending on the machine's configuration (<2GB RAM, virtually instant on
userland init; >2GB RAM, might survive for a few minutes, even getting all the
way to runlevel 3 randomly).

IP27 was somewhat similar to IP30, in that THP usually results in IBEs after a
few seconds of hitting userland bringup (bash is pretty quick at triggering an
IBE), but I haven't tried experimenting with varying the amount of RAM in that
machine, due to the fragility of pulling the nodeboards out constantly.  I also
haven't tried THP since refactoring/rewriting the IP27 code back in Feb to see
if I magically fixed it...

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
