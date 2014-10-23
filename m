Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2014 05:13:36 +0200 (CEST)
Received: from resqmta-ch2-07v.sys.comcast.net ([69.252.207.39]:44909 "EHLO
        resqmta-ch2-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011350AbaJWDNedqFXn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Oct 2014 05:13:34 +0200
Received: from resomta-ch2-13v.sys.comcast.net ([69.252.207.109])
        by resqmta-ch2-07v.sys.comcast.net with comcast
        id 6TCv1p0032N9P4d01TDRul; Thu, 23 Oct 2014 03:13:25 +0000
Received: from [192.168.1.13] ([69.251.152.165])
        by resomta-ch2-13v.sys.comcast.net with comcast
        id 6TDN1p00B3aNLgd01TDNlw; Thu, 23 Oct 2014 03:13:25 +0000
Message-ID: <54487246.605@gentoo.org>
Date:   Wed, 22 Oct 2014 23:13:10 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: Single MIPS kernel
References: <20141022083437.GB18581@linux-mips.org>         <5447F155.60106@gmail.com> <20141022192018.GD12502@linux-mips.org>         <1414016140.5994.9.camel@decadent.org.uk>         <20141022232233.GF12502@linux-mips.org> <1414026131.5994.20.camel@decadent.org.uk>
In-Reply-To: <1414026131.5994.20.camel@decadent.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1414034005;
        bh=dVIYJRXn7eiW+jsBgNbqt9nFy8K7zRkPdOVpqHWoSQ4=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=MMFGbOfdKhcZ2Phcy2rNZpXnoSwkLV9Ewh+fIAF6s7PPmBM8YXGY8AUTa1F2neUtv
         Vgwgy6lR5+Zz4T5fDrNqXknte1FI2hA63wt6zGLWP7lleXGlEKrn5BDSMHAJ7UG7eN
         iXOe1ssYC3hpgsPwAG845kwDitRErxOAfClgATSwdYzskeSaOFFHrykpsXHfkepnFp
         CXoRC7NojzuxE82mCj/JNzExlgLaX4NzOsFcWi5IvMG8RV10TgScYmUdWVT2QNy3ZE
         Yb4Sx/2Vef64MOj0O4ZgZJK0EMsKAARBkk+HOl0IxIj3gcD5gOUNaikgiahGhg5rSk
         UXWUv2JNiyWQQ==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43516
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

On 10/22/2014 21:02, Ben Hutchings wrote:
> On Thu, 2014-10-23 at 01:22 +0200, Ralf Baechle wrote:
>> On Wed, Oct 22, 2014 at 11:15:40PM +0100, Ben Hutchings wrote:
>>
>>>>
>>>> That's probably more of an implementation detail.  I'm more concerned about
>>>> the overall bloat.  I think many embedded users are so addivted to benchmark
>>>> results that this going to make or break the whole scheme.
>>>
>>> If you can make relocation a configuration option (as on x86), it would
>>> allow distributions to build multiplatform kernels without preventing
>>> embedded users from building a kernel optimised for their specific
>>> system.  But I know very little about MIPS or how intrusive the changes
>>> for relocation would have to be.  Perhaps it would be too much of a
>>> maintenance burden to make this an option.
>>
>> The scope of the changes is relativly limited - we're much more concerned
>> about the impact on binary size, memory size or performance of the
>> various approaches under discussion.
>>
>> I wonder kernels for which platforms would Debian want to unify?
> 
> I don't have high expectations for being able to unify those we
> currently support.  Realistically, I expect that most development effort
> will go into new platforms.  (What we saw with ARM was that
> multi-platform was implemented for most ARMv7 platforms (for which we
> now need only 2 configurations) but only slowly for older chips (4
> configurations, and that's after dropping 2 platforms).)
> 
> Anyway, we have one 32-bit configuration for each byte order
> (4kc-malta), and the following 64-bit configurations:
> 
> [big-endian]
> r4k-ip22:      CONFIG_SGI_IP22, CONFIG_CPU_R4X00
> r5k-ip32:      CONFIG_SGI_IP32, CONFIG_CPU_R5000

As far as I know, IRIX includes kernels specific to each SGI system (IPxx), but
it seems they're CPU agnostic.  They are relocatable, though.  Been awhile
since I watched sash boot followed by an IRIX kernel, but it does 3-4
relocations before finally booting.  So a relocatable MIPS kernel on the SGI
platforms seems possible.  Probably requires arcane knowledge of ARCS, though.

Bootloader-wise, Stan's 'arcload' can handle booting multiple kernels across
various SGI platforms.  We used it on the Gentoo SGI LiveCD back in 2006 to
create a single CD that could boot on IP22, IP27, IP30, & IP32, using different
kernels for each system and CPU (I think there was one volume header slot left
at the end for arcload itself).

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
