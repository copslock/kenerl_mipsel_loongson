Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jan 2015 19:15:15 +0100 (CET)
Received: from mail-ie0-f181.google.com ([209.85.223.181]:48101 "EHLO
        mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010966AbbAZSPNtMehh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Jan 2015 19:15:13 +0100
Received: by mail-ie0-f181.google.com with SMTP id rp18so10268001iec.12;
        Mon, 26 Jan 2015 10:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=d2g7Q/KXiSZQS5TPtnL4ct/j/NdjW7O7H/s7/T5WfxU=;
        b=fihiUW+4C7ZcCbz64WVE8MHFF/WDHzumR/PGpPpesundMYq6HZmNZ5wR3LZrorK2yJ
         vlH5g94+U4AUOOyr3l4buLY6nhho4xJfnnWBTHn5lrXxOLFlskGDtBdXFty8SI01RUat
         m361sqIxrQx9ezBX9eadShn5ac0eXWSYLokNQ5mppj7SUPLTqAZjuv6DUWusWmibbIzw
         JaL20dAMkH+MUdkN0OFhOcl4s5N9qGPt1PnZjCHY1qXtkuSi+yinTmL4twMxdL54ZVxj
         0MVN1f6sj8eQ3pHZMBQjvJKw3VIelCaU4uoPblOkcUtSYotxmFIHUfwzDckL0LH/I28E
         TILQ==
X-Received: by 10.107.137.231 with SMTP id t100mr19524822ioi.78.1422296106859;
        Mon, 26 Jan 2015 10:15:06 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id k18sm6178438igt.5.2015.01.26.10.15.05
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 Jan 2015 10:15:06 -0800 (PST)
Message-ID: <54C68429.4030701@gmail.com>
Date:   Mon, 26 Jan 2015 10:15:05 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Joshua Kinard <kumba@gentoo.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Display CPU byteorder in /proc/cpuinfo
References: <54BCC827.3020806@gentoo.org> <54BEDF3C.6040105@gmail.com> <54BF12B9.8000507@gentoo.org> <alpine.LFD.2.11.1501210347180.28301@eddie.linux-mips.org> <20150126131621.GB31322@linux-mips.org> <alpine.LFD.2.11.1501261358540.28301@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1501261358540.28301@eddie.linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 01/26/2015 06:53 AM, Maciej W. Rozycki wrote:
> On Mon, 26 Jan 2015, Ralf Baechle wrote:
>
>>>   Well, several MIPS processors can reverse the user-mode endianness via
>>> the CP0.Status.RE bit; though as you may be aware it has never been
>>> implemented for Linux.  Otherwise it would obviously have to be a
>>> per-process property (and execve(2) could flip it back).
>>
>> As posted previously that was why I removed it from /proc/cpuinfo.  And
>> yes, I had a simple prototype to use the RE feature.  Even in the limited
>> form I had it was impressively ugly and it became clear it would never
>> be upstreamable.
>
>   Out of curiosity -- what was there that made it so ugly?  The need for
> case-by-case individual handling of byte-swapping the qualifying members
> of syscall and signal data structures such as `struct stat'?  Obviously
> not alignment trap fixups, these are trivial to handle.  And I think
> pretty much everything else is endianness-agnostic.
>

I think *nothing* is endianness-agnostic.  The instruction set reference 
manual (MD00087 MIPS® Architecture For Programmers Volume II-A: The 
MIPS64® Instruction Set, Revision 5.02) is a little cryptic, but I think 
looking at the LB instruction shows how it works.  OCTEON is known to 
implement this and has been verified to work this way.

aligned 64-bit loads and stores are endianness invariant.

32-bit loads and stores have even and odd words swapped in the opposite 
endianness (low order 3 address bits are XOR 4).

16-bit loads and stores half words scrambled in the opposite endianness 
(low order 3 address bits are XOR 6).

8-bit loads and stores are scrambled such that the low order 3 address 
bits are XOR 7 in the opposite endianness.

The result that all byte array data is scrambled when switching endianness.

This means that all read(), write() and similar calls could *not* access 
the user data in-place in the kernel.  The kernel would have to  swap 
around the bytes before using it.  mmap() of the same file in processes 
of opposite endianness would be impossible, as one of the processes 
would see scrambled data.

For this reason, it really only makes sense to have the kernel and 
user-space use the same endianness.

And because kernel and userspace must have the same endianness, the 
endianness can be probed in userspace without consulting the kernel.

David Daney
