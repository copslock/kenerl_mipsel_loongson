Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jul 2014 09:00:17 +0200 (CEST)
Received: from qmta11.westchester.pa.mail.comcast.net ([76.96.59.211]:33856
        "EHLO QMTA11.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859946AbaGLHAOVREdI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 Jul 2014 09:00:14 +0200
Received: from omta24.westchester.pa.mail.comcast.net ([76.96.62.76])
        by QMTA11.westchester.pa.mail.comcast.net with comcast
        id RJyc1o0011ei1Bg5BK07EG; Sat, 12 Jul 2014 07:00:07 +0000
Received: from [192.168.1.13] ([50.190.84.14])
        by omta24.westchester.pa.mail.comcast.net with comcast
        id RK071o0050JZ7Re3kK070W; Sat, 12 Jul 2014 07:00:07 +0000
Message-ID: <53C0DCE4.7010906@gentoo.org>
Date:   Sat, 12 Jul 2014 02:59:48 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: FIX ME in mc146818rtc.h
References: <CAPDOMVhOpxBrjJNxM7wbomvmwe9Mxb+vh0zvsEA0bd6b0XNQNA@mail.gmail.com>
In-Reply-To: <CAPDOMVhOpxBrjJNxM7wbomvmwe9Mxb+vh0zvsEA0bd6b0XNQNA@mail.gmail.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1405148407;
        bh=WKZeOd1wfgfwgmiNqBUeo6FRiM7AJD8Qf2W0HCv+XO4=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=mgwT+0OpsXEwVzADefnrfOI3GxZvUW9pAvYcBfB/xBMCAFqUApYAjZPXbJ3LNhp1v
         W89CUarOFV/bFEGNKPIpn1lHa1SazZ2t2jS8h1/0yx6U1Wm5r2AVKU6i0bpqkVBsRs
         RYDtvOZbVl9s6p1F6M2BWsuVApse9IctC7wyjHju8Q1IBw4RbxFKSLR0niWeQz0O3k
         8m0K9F7sNRuuT58tdNV0WZV0S82619zTo/Q47sQZ+WkrVOP6MUnvcWGXpfgxvQrRqm
         t93U752ziN0p6vIcf7oHDL0Okdr12FeqPCRJZL6lDOzHtgjl5OhfLe1fX8gT6hkf98
         0rUrLbryV1jkA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41155
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

On 07/12/2014 01:50, Nick Krause wrote:
> Hey Ralf and other Mips  developers ,
> I was wondering about the fix me in this file and how you want to fix this.
> Cheers Nick
> 

# find . -name mc146818rtc.h
./include/linux/mc146818rtc.h
./arch/alpha/include/asm/mc146818rtc.h
./arch/mips/include/asm/mach-loongson/mc146818rtc.h
./arch/mips/include/asm/mach-rm/mc146818rtc.h
./arch/mips/include/asm/mach-jazz/mc146818rtc.h
./arch/mips/include/asm/mach-malta/mc146818rtc.h
./arch/mips/include/asm/mach-ip32/mc146818rtc.h
./arch/mips/include/asm/mach-dec/mc146818rtc.h
./arch/mips/include/asm/mc146818rtc.h
./arch/mips/include/asm/mach-generic/mc146818rtc.h
./arch/m32r/include/asm/mc146818rtc.h
./arch/frv/include/asm/mc146818rtc.h
./arch/parisc/include/asm/mc146818rtc.h
./arch/arm/include/asm/mc146818rtc.h
./arch/sh/include/asm/mc146818rtc.h
./arch/powerpc/include/asm/mc146818rtc.h
./arch/m68k/include/asm/mc146818rtc.h
./arch/mn10300/include/asm/mc146818rtc.h
./arch/ia64/include/asm/mc146818rtc.h
./arch/x86/include/asm/mc146818rtc.h
./arch/sparc/include/asm/mc146818rtc.h

Which copy are you referring to?

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
