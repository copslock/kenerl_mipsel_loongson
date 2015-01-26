Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jan 2015 21:13:11 +0100 (CET)
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35479 "EHLO
        mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007098AbbAZUNJvQKjK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Jan 2015 21:13:09 +0100
Received: by mail-ig0-f176.google.com with SMTP id hl2so343566igb.3;
        Mon, 26 Jan 2015 12:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=kZDnkIzuGbG2msI4P17tZsawuDttKdT2Kppxr9DXixc=;
        b=g5JK3PNz5ea9NL9sm6baStutm2kPNJDf3Cc5USkLi7yCTBPxP9bI52nHfXGzxX8kSu
         fO9fwblUGui0WqW/0lL8id1NbPn3EwQFmqJ/3MllZKOWwLgbHjowXQckNOMIG7a9/t0J
         Kp1mfj7rDMcv1dhTTSBpyN5TvwVC+Bbw2HT10y3ZVMchdOs6hzogG6Ra7y7bfzKh3j7w
         m9n0vX0NGAaeH2pTy+wufNiNYPB/P07wBPaf/et/05c0KhfnHFmJGwjorYsEi4dA0NLr
         9jhx20+/5/CR2Ep1+qcI+aIKOKVvWBHrPLGTqK5+cS1yOur2HrOGcaHNkKMsF7VxJTxT
         Bmhg==
X-Received: by 10.107.5.85 with SMTP id 82mr20905364iof.41.1422303183943;
        Mon, 26 Jan 2015 12:13:03 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id la3sm6344971igb.0.2015.01.26.12.13.02
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 Jan 2015 12:13:03 -0800 (PST)
Message-ID: <54C69FCE.80002@gmail.com>
Date:   Mon, 26 Jan 2015 12:13:02 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Joshua Kinard <kumba@gentoo.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Display CPU byteorder in /proc/cpuinfo
References: <54BCC827.3020806@gentoo.org> <54BEDF3C.6040105@gmail.com> <54BF12B9.8000507@gentoo.org> <alpine.LFD.2.11.1501210347180.28301@eddie.linux-mips.org> <20150126131621.GB31322@linux-mips.org> <alpine.LFD.2.11.1501261358540.28301@eddie.linux-mips.org> <54C68429.4030701@gmail.com> <alpine.LFD.2.11.1501261904310.28301@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1501261904310.28301@eddie.linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45489
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

On 01/26/2015 11:39 AM, Maciej W. Rozycki wrote:
> On Mon, 26 Jan 2015, David Daney wrote:
>
>>>    Out of curiosity -- what was there that made it so ugly?  The need for
>>> case-by-case individual handling of byte-swapping the qualifying members
>>> of syscall and signal data structures such as `struct stat'?  Obviously
>>> not alignment trap fixups, these are trivial to handle.  And I think
>>> pretty much everything else is endianness-agnostic.
>>>
>>
>> I think *nothing* is endianness-agnostic.  The instruction set reference
>> manual (MD00087 MIPS® Architecture For Programmers Volume II-A: The MIPS64®
>> Instruction Set, Revision 5.02) is a little cryptic, but I think looking at
>> the LB instruction shows how it works.  OCTEON is known to implement this and
>> has been verified to work this way.
>>
>> aligned 64-bit loads and stores are endianness invariant.
>>
>> 32-bit loads and stores have even and odd words swapped in the opposite
>> endianness (low order 3 address bits are XOR 4).
>>
>> 16-bit loads and stores half words scrambled in the opposite endianness (low
>> order 3 address bits are XOR 6).
>>
>> 8-bit loads and stores are scrambled such that the low order 3 address bits
>> are XOR 7 in the opposite endianness.
>>
>> The result that all byte array data is scrambled when switching endianness.
>
>   But that does not matter as long as the endianness used for reads and one
> used for writes is the same.  Which is going to be the case for user
> software as long as it does not call into the kernel.  The two key points
> are syscalls and signals.  Ah, and the binary loader (e.g. ELF) has to
> byte-swap structures in executable and shared library headers too.
>
>> This means that all read(), write() and similar calls could *not* access the
>> user data in-place in the kernel.  The kernel would have to  swap around the
>> bytes before using it.  mmap() of the same file in processes of opposite
>> endianness would be impossible, as one of the processes would see scrambled
>> data.
>
>   Well, read(2), write(2) and similar calls operate on byte streams, these
> are endianness agnostic (like the text of this e-mail for example is --
> it's stored in memory of a byte-addressed computer the same way regardless
> of its processor's endianness).

This is precisely the point I was attempting to make.  What you say here 
is *not* correct with respect to MIPS as specified in the architecture 
reference mentioned above.  The byte streams are scrambled up when 
viewed from contexts of opposite endianness.

Byte streams are *not* endian agnostic, but aligned 64-bit loads and 
stores are.

It is bizarre, and perhaps almost mind bending, but that seems to be how 
it is specified.  Certainly the OCTEON implementation works this way.


>  You're right about this specific use case
> of mmap(2), but why would you want sharing endianness-specific data
> between two processes of the opposite endiannesses in the first place?

The whole point is that the result of mmap() of a page of a file must 
yield the same contents as a read() of the same page.  The scrambling of 
byte streams would make any file containing ASCII text appear as 
gibberish when mmaped.


> It's already no different to copying such a binary file between systems of
> the opposite endiannesses -- you need to use export/import tools and a
> portable data encoding format such as XDR or text.  This is how you can
> for example make RPC calls between systems of the opposite endiannesses.
>
>   In the simplest scenario you'd run all your userland with the same
> endianness anyway -- e.g. because you want to validate your user software,
> but only have a machine whose bootstrap endianness is hardwired and cannot
> be set to match your requirement.
>
>> For this reason, it really only makes sense to have the kernel and user-space
>> use the same endianness.
>>
>> And because kernel and userspace must have the same endianness, the endianness
>> can be probed in userspace without consulting the kernel.
>
>   Well, I maintain that it's only data structures passed around syscalls
> and signal handlers that matter here.  Their contents will be interpreted
> differently by the kernel and by user code and therefore have to be
> byte-swapped in transit.  There is no issue with integers passed via
> registers, that have no endianness defined.  And we are also lucky enough
> not to swap register pairs for double-precision integers depending on the
> endianness, unlike with ABIs for some other processor architectures.
>
>    Maciej
>
>
