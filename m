Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 May 2016 21:40:51 +0200 (CEST)
Received: from resqmta-ch2-03v.sys.comcast.net ([69.252.207.35]:33444 "EHLO
        resqmta-ch2-03v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027124AbcEWTkuPRC9Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 May 2016 21:40:50 +0200
Received: from resomta-ch2-19v.sys.comcast.net ([69.252.207.115])
        by comcast with SMTP
        id 4vhYbSmETLCmU4viVbhQFR; Mon, 23 May 2016 19:40:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1464032443;
        bh=pUHuviLY6Y1KDPrjO20lJLmCiroDi/yMBs2axcIpvz4=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=D+ENvnXGcNO/OFMl8DRyrgQGMqrLpL14qOptR2e4k6D9wFcstIOUO4DDX4e5GJT1J
         DOstAQURLY8ngXe8H7SV49Htslhs51yu4ZTSefDQkEVhe53VZUpRVd5VCz5krXbOHU
         J/E2I6pgQkMGDjHRfWSrK/CwRpL7JPFihkUOGou2vzglk02QzP1KGaJSP9TYj9b2ue
         KBZHsA5wZ4Hen5bk5No3nX0c5basFkNUcFXiPVUU/NcRp8Po5ZhIIp0AnQgUvmO8zk
         4Dco6Udu1G5v53tc9r8xlM9/1zqVAgrAD5l80aWvU2MwjjI4Yx5clo0pdArurkBljD
         +kGA6sgdNHJbg==
Received: from [192.168.1.13] ([76.106.83.43])
        by resomta-ch2-19v.sys.comcast.net with comcast
        id xvgi1s00D0w5D3801vgi1j; Mon, 23 May 2016 19:40:43 +0000
Subject: Re: THP broken on OCTEON?
To:     Ralf Baechle <ralf@linux-mips.org>
References: <20160523151346.GA23204@ak-desktop.emea.nsn-net.net>
 <20160523152007.GB28729@linux-mips.org> <5743529A.4070506@gentoo.org>
 <20160523192219.GB24125@linux-mips.org>
Cc:     linux-mips@linux-mips.org
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <57435CB4.5080609@gentoo.org>
Date:   Mon, 23 May 2016 15:40:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:44.0) Gecko/20100101
 Thunderbird/44.0
MIME-Version: 1.0
In-Reply-To: <20160523192219.GB24125@linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53624
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

On 05/23/2016 15:22, Ralf Baechle wrote:
> On Mon, May 23, 2016 at 02:57:30PM -0400, Joshua Kinard wrote:
> 
>> NAK, this issue looks completely different to IP30/IP27.  In this case, it
>> looks like the hardware is detecting the case where multiple TLB entries match
>> and it's killing the machine to avoid hardware damage.  I don't want to know
>> how the SGI systems handle this scenario (does the R10000 do a TLB shutdown??).
> 
> The R10000 detects if duplicate entries when writing to the TLB and
> invalidates the previous entry.  That is, there will never be duplicate
> entries in the TLB and of course no TLB shutdown.
> 
> That's the theory.  I'm wondering how well that is going to work if
> the entries are having a different page size.
> 
> And Aaro doesn't always get machine checks so it's not like always a
> duplicate entry is written.
> 
>> On IP30, using THP usually results in instruction bus errors (IBE), after a set
>> time, depending on the machine's configuration (<2GB RAM, virtually instant on
>> userland init; >2GB RAM, might survive for a few minutes, even getting all the
>> way to runlevel 3 randomly).
>>
>> IP27 was somewhat similar to IP30, in that THP usually results in IBEs after a
>> few seconds of hitting userland bringup (bash is pretty quick at triggering an
>> IBE), but I haven't tried experimenting with varying the amount of RAM in that
>> machine, due to the fragility of pulling the nodeboards out constantly.  I also
>> haven't tried THP since refactoring/rewriting the IP27 code back in Feb to see
>> if I magically fixed it...

For IP30, I created a BUGS file in my local source (also in the IP30 patch I
still maintain) that documented some combinations of settings that affected THP
on the platform.  Most importantly, using a different PAGE_SIZE than 4KB also
required setting MAX_ZONE_ORDER to a decent value, too, else on Octane, it'd
hit IBEs at soon as the kernel executed /sbin/init.  Also depended on the
amount of RAM in that system:

>>2GB RAM:
>  - In order to use more than 2GB RAM in IP30/Octane requires selecting
>    VERY specific values for certain Kconfig options.  Specifically,
>    the following options under the "Kernel type" submenu:
>      - PAGE_SIZE
>      - Maximum Zone Order
>      - Transparent Hugepages (THP)
> 
>    A table of the specific settings is below:
>     PAGE_SIZE | Zone Order | THP
>    -----------|------------|-----
>        4KB    | 11 to 13   |  N
>       16KB    | 12 Only    |  Y
>       64KB*   | 14 Only    |  Y
> 
>    Any other configuration of these three options will likely lead to
>    Instruction Bus Errors (IBEs) when the kernel loads userland up (when it
>    execve()'s /sbin/init).  Even then, however, the machine will still be
>    very unstable (depending on the operations it does).  Heavy disk I/O
>    still seems capable of crashing the machine due to either NULL pointer
>    dereferences, unhandled kernel unaligned accesses, or Instruction Bus
>    Errors.
> 
>    * Impact users cannot currently use an Impact board with 64KB PAGE_SIZE,
>      THP, and >2GB RAM.  This will trigger a NULL pointer deference in
>      impact_resize_kpool() (when called initially from impact_common_probe()
>      to set the initial 64KB kpool on pool '0') due to (possibly) vzalloc()
>      returning a NULL pointer when allocating kpool_virt[pool].
> 
>    * THP still has issues on R1x000 CPUs, so user beware.  YMMV.


Might try some of those combinations and see if things improve on the Octeon?
IP27 was equally affected by this, minus the bits about RAM and Impact Gfx.
turning off THP, IP30 can run 64KB PAGE_SIZE without issue (compiles of
packages is actually sped up quite significantly under >4KB PAGE_SIZE).

IP27 has a bug in it somewhere that causes an immediate Oops on 64KB PAGE_SIZE
that I haven't traced down yet (I have the Oops saved somewhere if needed).  So
I use 16KB on that system.

An O2 w/ an RM7000 has virtually no issues at all with 64KB or 16KB PAGE_SIZE
and THP, though it's been several months since I last booted my O2.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
