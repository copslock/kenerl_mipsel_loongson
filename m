Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2014 14:03:46 +0200 (CEST)
Received: from qmta15.westchester.pa.mail.comcast.net ([76.96.59.228]:38764
        "EHLO qmta15.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006855AbaHZMDgxEnF6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Aug 2014 14:03:36 +0200
Received: from omta05.westchester.pa.mail.comcast.net ([76.96.62.43])
        by qmta15.westchester.pa.mail.comcast.net with comcast
        id jPlo1o0050vyq2s5FQ3W3b; Tue, 26 Aug 2014 12:03:30 +0000
Received: from [192.168.1.13] ([50.190.84.14])
        by omta05.westchester.pa.mail.comcast.net with comcast
        id jQ3W1o00T0JZ7Re3RQ3Wtu; Tue, 26 Aug 2014 12:03:30 +0000
Message-ID: <53FC7790.80602@gentoo.org>
Date:   Tue, 26 Aug 2014 08:03:28 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: 16k or 64k PAGE_SIZE and "illegal instruction" (signal -4) errors
References: <53FC5300.4070902@gentoo.org> <20140826102004.GA22221@linux-mips.org> <alpine.LFD.2.11.1408261126000.18483@eddie.linux-mips.org> <20140826114925.GA24146@linux-mips.org>
In-Reply-To: <20140826114925.GA24146@linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1409054610;
        bh=z+IwJmivRkcKYulPYRP/Ce/xtTELiUxyG7ruEfPM9y4=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=n4GY5pfifXbFRGkoKLNN7cv9peuhbWXkzDNlrVx5jMe8R2Z30jDLOkh93NjcShheG
         j6nRzTF/MnBTarTnWjDRKUr+WdAAX9GrTngjim05tHyvI2GIg3I8FWUwlGjypUPc68
         dYjw/T5y5SRi4mZ1aGL2SW+lCzc2GNK9bo4/wptu3Sp8uyZ8IW8WyMraMvtaEIPuTH
         GLckHvjRY/lQtH3SIrmkh4Gxtfn2ICmC4mASdC775YuueDcS14PDChRdPMsc/7Skr7
         OKOpaUTsyBRq1AK64TKfWiDVd2MUhZHfwmp0rrFbjt7F0/CMxB5qYj3VQGh/rl/ZO8
         E6O5pkrMvSd8w==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42257
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

On 08/26/2014 07:49, Ralf Baechle wrote:
> On Tue, Aug 26, 2014 at 11:42:30AM +0100, Maciej W. Rozycki wrote:
> 
>>>> I cannot reproduce it on demand, so I'm not really sure what the cause could
>>>> be.  PAGE_SIZE should be largely transparent to userland these days, so I am
>>>> wondering if this might be more oddities w/ an R14000 CPU.
>>>
>>> This sound very unlikely as the CPU was primarily designed to run IRIX and
>>> SGI's systems were using 16k or even 64k page size.
>>>
>>> What userland are you running and how old is it?  Are you seeing different
>>> results for 16k and 64k?
>>
>>  FWIW, I've been always using the 16k page size exclusively with my 64-bit 
>> userland and my SWARM board using the SB-1/BCM1250 processor (with either 
>> endianness) and never had issues even with stuff as intensive as native 
>> GCC bootstrapping (with all the languages enabled such as Ada and Java) or 
>> glibc builds.  It's been like 8 years now and quite recent kernels like 
>> from two months ago gave me no trouble either.  So it must be something 
>> specific to the configuration, my first candidates to look at would be the 
>> generated TLB and cache handlers, that are system-specific.
> 
> Generally the R10000 architecture is such that there is much less potencial
> for software bugs as well.  The TLB is nice, cleans up conflicting entries
> so no TLB shutdown or similar horrors possible.  And the caches while they
> suffer from cache aliases, will cleanup those aliases transparently to
> software, that is an OS can treat them as non-aliasing.  R10000 systems
> with the notable exception of the SGI O2 and Indigo² R10000 have fully
> coherent I/O.  Basically the only thing that needs to be done in software
> is I-cache coherency.  The I-cache snoops stores by remote CPUs but not
> by the local CPU itself so in a sense SMP is a simpler case than UP even.

Yeah, coherency shouldn't be a problem for the Octane.  hardware-coherent
like IP27.

The icache snooping fix is already enabled in
arch/mips/include/asm/mach-ip30/cpu-feature-overrides.h:

#define cpu_icache_snoops_remote_store 1

SMP is not working yet on IP30, though.  I gave up on that for now, because
I can't get the second CPU to start ticking properly.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
