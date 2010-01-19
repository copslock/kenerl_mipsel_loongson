Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jan 2010 10:56:04 +0100 (CET)
Received: from chipmunk.wormnet.eu ([195.195.131.226]:55770 "EHLO
        chipmunk.wormnet.eu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491791Ab0ASJ4A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jan 2010 10:56:00 +0100
Received: by chipmunk.wormnet.eu (Postfix, from userid 1000)
        id 182E184879; Tue, 19 Jan 2010 09:55:57 +0000 (GMT)
Date:   Tue, 19 Jan 2010 09:55:57 +0000
From:   Alexander Clouter <alex@digriz.org.uk>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH v1] MIPS: fix vmlinuz build when only 32bit math shell
        is available
Message-ID: <20100119095556.GF32413@chipmunk>
References: <42fa29d2007a40a31a0bb8fbf1091e11eb9b5ac2.1263893871.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42fa29d2007a40a31a0bb8fbf1091e11eb9b5ac2.1263893871.git.wuzhangjin@gmail.com>
Organization: diGriz
X-URL:  http://www.digriz.org.uk/
X-JabberID: alex@digriz.org.uk
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 25609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 12401

Hi,

* Wu Zhangjin <wuzhangjin@gmail.com> [2010-01-19 17:43:09+0800]:
> 
> Does this revision work for you?
>
> Changes from v0:
> 
> 	- Revert the '-n "$(VMLINUX_SIZE)"' to avoid the error of "make clean"
> 	- Consider more situations of the VMLINUX_LOAD_ADDRESS
> 
> [snipped]
>
> So, we can split the original 64bit string to two parts, and only
> calculate the low 32bit part, which is big enough(about 4095 M) for a
> normal linux kernel image file, now, we calculate the
> VMLINUZ_LOAD_ADDRESS like this:
>
As a passing query, why do we have the high 32bit (0xffffffff....) spiel 
if later we can just make VMLINU[XZ]_LOAD_ADDRESS the low half?  I see 
the output of 'nm' shows:
----
alex@berk:/usr/src/wag54g/linux$ nm vmlinux | head -n1
941019e4 t .ex0
alex@berk:/usr/src/wag54g/linux$ nm vmlinuz | head -n1
944abb50 B .heap
----

However I am guessing it's some 64bit CPU requirement as my x86_64 
kernel seems to have 0xffffffff....  Which raises the question, why is 
AR7 not just using VMLINUX_LOAD_ADDRESS=0x94100000?

> 1. Append "the high 32bit of VMLINUX_LOAD_ADDRESS" as the prefix if it
> exists.
> 
> 2. Get the sum of "the low 32bit of VMLINUX_LOAD_ADDRESS + VMLINUX_SIZE"
> with printf "%08x" (08 herein is used to prefix the result with 0...)
> 
> The corresponding shell script is:
> 
>   A=$VMLINUX_LOAD_ADDRESS;
>   # Append "the high 32bit of VMLINUX_LOAD_ADDRESS" as the prefix if it exists.
>   [ "${A:0:10}" != "${A}" ] && echo -n ${A:2:8};
>   # Get the sum of "the low 32bit of VMLINUX_LOAD_ADDRESS + VMLINUX_SIZE"
>   printf "%08x" $(($VMLINUX_SIZE + 0x${A:(-8)}))
> 
Eugh, bash-ism's...
----
alex@berk:/usr/src/wag54g/linux$ bash -c 'A=1234567890; echo ${A:0:5}'
12345
alex@berk:/usr/src/wag54g/linux$ dash -c 'A=1234567890; echo ${A:0:5}'
dash: Bad substitution
----

Your 'punishment', use Plan9 for a period of no less than a week! :)

You have to use the pattern matching approach I used in my original 
patch, that's portable.  Look at 'man 1 dash' and search for 'substr' 
for more details.

Cheers

-- 
Alexander Clouter
.sigmonster says: I'm not prejudiced, I hate everyone equally.
