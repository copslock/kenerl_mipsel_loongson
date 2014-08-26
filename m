Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2014 13:07:07 +0200 (CEST)
Received: from qmta02.westchester.pa.mail.comcast.net ([76.96.62.24]:40791
        "EHLO qmta02.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006855AbaHZLHFcp9xk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Aug 2014 13:07:05 +0200
Received: from omta13.westchester.pa.mail.comcast.net ([76.96.62.52])
        by qmta02.westchester.pa.mail.comcast.net with comcast
        id jP2i1o00317dt5G51P6zJs; Tue, 26 Aug 2014 11:06:59 +0000
Received: from [192.168.1.13] ([50.190.84.14])
        by omta13.westchester.pa.mail.comcast.net with comcast
        id jP6y1o00H0JZ7Re3ZP6yrF; Tue, 26 Aug 2014 11:06:59 +0000
Message-ID: <53FC6A50.9090709@gentoo.org>
Date:   Tue, 26 Aug 2014 07:06:56 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: 16k or 64k PAGE_SIZE and "illegal instruction" (signal -4) errors
References: <53FC5300.4070902@gentoo.org> <20140826102004.GA22221@linux-mips.org>
In-Reply-To: <20140826102004.GA22221@linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1409051219;
        bh=/eoWN6EeARwMiwr/LQX9etDcMKGLBDWDGHh56nJL2nQ=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=Ss0L9P/akPfHz6aSuWBmp19yyLUZeefQWWTWDs6iYOSteEeAaqtLeAfUqma5gWsen
         OITAHzOovHa9rzW9CLwEjvpWLPEBH/o4kABcUv1t94AY/o9/wLuDEIx92PjYotZ/e+
         NxPh0DE5hQ+YMMATQ6yw88Xd98WEV7IG2hEDfM9SV0mZUFe8mXLYg+N9OchgbmN/iH
         iSP9tb1xsIJQYjk8iryh+2v9LJrC44ojxPueNxMJpL4v0BvCEOQH8/UnsplBWXb2kC
         d75voftRUhO9Rk4cql95T5suzVv+/EultRiszHtyI09uiJ7h5XeJzP+Gp+mjJaJRtk
         YZJth5St0z+bQ==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42253
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

On 08/26/2014 06:20, Ralf Baechle wrote:
> On Tue, Aug 26, 2014 at 05:27:28AM -0400, Joshua Kinard wrote:
> 
>> Okay, so from the "make kmap cache coloring aware" thread, I've been playing
>> with larger PAGE_SIZE values on the Octane and O2 for the last few hours.
>> 16k and 64k used to, in the past, never get far after init (usually died
>> *at* init)  That appears to have changed now.  Most programs seem to
>> JustWork(), but very randomly, I am getting a signal -4, illegal instruction
>> (SIGILL) on the Octane.  Both systems are running kernels w/ 64k PAGE_SIZE
>> at the moment.
>>
>> I cannot reproduce it on demand, so I'm not really sure what the cause could
>> be.  PAGE_SIZE should be largely transparent to userland these days, so I am
>> wondering if this might be more oddities w/ an R14000 CPU.
> 
> This sound very unlikely as the CPU was primarily designed to run IRIX and
> SGI's systems were using 16k or even 64k page size.
> 
> What userland are you running and how old is it?  Are you seeing different
> results for 16k and 64k?

o32 userland is the primary on both systems.  However, the last SIGILL was
under the 64k PAGE_SIZE kernel inside of an n32 chroot compiling the 'boost'
package on the Octane, which I restarted that and it's not complained since.
 Also got SIGILL on the 16k PAGE_SIZE kernel when I booted 16k PAGE_SIZE the
first time and ran 'ps'.  Subsequent runs of 'ps' didn't reproduce the
error.  Also saw SIGILLs in the bootlog of the 16k PAGE_SIZE kernel when
"rm" was ran once (couldn't reproduce) and when mdadm tried to put one of
the arrays back together.  Subsequent runs using similar argument lines
don't reproduce once I got to a root shell.

Being it's a Gentoo install...the o32 userland is pretty fresh.  Especially
on the Octane, where I literally rebuilt the old userland over 2-3 times
just to make sure all the old 5-year cruft was gone.  The n32 userland
chroot is brand-spanking new.  gcc-4.7.x only for now on both, because of
PR61538 in gcc.  Latest binutils.

The O2 is chugging away happily so far in updating a bunch of packages.  So
I am leaning towards this being another quirk I have to hunt down in the
Octane's code again.  There isn't much in the Octane-specific code that
deals with memory, though -- it seems the higher-level MIPS memory code
handles most things just fine.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
