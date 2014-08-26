Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2014 15:17:06 +0200 (CEST)
Received: from qmta05.westchester.pa.mail.comcast.net ([76.96.62.48]:54643
        "EHLO qmta05.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006877AbaHZNREkAkXt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Aug 2014 15:17:04 +0200
Received: from omta12.westchester.pa.mail.comcast.net ([76.96.62.44])
        by qmta05.westchester.pa.mail.comcast.net with comcast
        id jQBp1o0040xGWP855RGyXw; Tue, 26 Aug 2014 13:16:58 +0000
Received: from [192.168.1.13] ([50.190.84.14])
        by omta12.westchester.pa.mail.comcast.net with comcast
        id jRGx1o0100JZ7Re3YRGy0s; Tue, 26 Aug 2014 13:16:58 +0000
Message-ID: <53FC88C8.6000209@gentoo.org>
Date:   Tue, 26 Aug 2014 09:16:56 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: 16k or 64k PAGE_SIZE and "illegal instruction" (signal -4) errors
References: <53FC5300.4070902@gentoo.org> <20140826102004.GA22221@linux-mips.org> <53FC6A50.9090709@gentoo.org> <20140826120326.GB24146@linux-mips.org>
In-Reply-To: <20140826120326.GB24146@linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1409059018;
        bh=7gp1G6u+QgQQ0fxh7XnDNCs3uwuZFkDZFuiYlCjs+IU=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=o04sf6UzO85cynPOKfH6eYKrp5OHUPReI9+02Ooex/4TVY99zw3somRFNr7+GnzM2
         Of7tBWwWnZTgKfEhFFJ+Nu7f5KuCqjTO3HGSuH+23WsS0nuDrwgtZOfdYw2k6ZeZAx
         hUBWqsZFmiTdBPJooJKhvobFQiE6E3GB14hhrECvWnIlga4fp4273qrff5+fISv4G1
         avITkjkjevdPS/tHELSSmFFAqdJrAVTKt9x2Xqtga9tE9G/d5fozSgW2QhgX/evNFS
         GmWdmW8FvyyP5H+2lXKc50+kIhJUmX9Wkec9mLepszjf1262EeHUylRzxqb42dZMAV
         VC/N+toDBJXTw==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42259
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

On 08/26/2014 08:03, Ralf Baechle wrote:
> On Tue, Aug 26, 2014 at 07:06:56AM -0400, Joshua Kinard wrote:
> 
>> o32 userland is the primary on both systems.  However, the last SIGILL was
>> under the 64k PAGE_SIZE kernel inside of an n32 chroot compiling the 'boost'
>> package on the Octane, which I restarted that and it's not complained since.
>>  Also got SIGILL on the 16k PAGE_SIZE kernel when I booted 16k PAGE_SIZE the
>> first time and ran 'ps'.  Subsequent runs of 'ps' didn't reproduce the
>> error.  Also saw SIGILLs in the bootlog of the 16k PAGE_SIZE kernel when
>> "rm" was ran once (couldn't reproduce) and when mdadm tried to put one of
>> the arrays back together.  Subsequent runs using similar argument lines
>> don't reproduce once I got to a root shell.
>>
>> Being it's a Gentoo install...the o32 userland is pretty fresh.  Especially
>> on the Octane, where I literally rebuilt the old userland over 2-3 times
>> just to make sure all the old 5-year cruft was gone.  The n32 userland
>> chroot is brand-spanking new.  gcc-4.7.x only for now on both, because of
>> PR61538 in gcc.  Latest binutils.
>>
>> The O2 is chugging away happily so far in updating a bunch of packages.  So
>> I am leaning towards this being another quirk I have to hunt down in the
>> Octane's code again.  There isn't much in the Octane-specific code that
>> deals with memory, though -- it seems the higher-level MIPS memory code
>> handles most things just fine.
> 
> Can you enable core dumps?  I'm wondering about the EPC of the crashed
> process.  If it's at a function entry or the beginning of a page that
> might indicate there is an issue with flushing caches after the containing
> page got loaded.  Also interesting to know if this possibly happened in a
> signal trampoline or VDSO.
> 
> These are just the usual suspects - nothing indicates this case is actually
> related.

(Missed the reply all on the last one)

Enabled coredumps and got the 'shash' program to fail a second time (first
program to do so)...so I'll rebuild that with debugging symbols and try to
trip it up again later on.

Is a core file from a binary w/o debugging of any value?

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
