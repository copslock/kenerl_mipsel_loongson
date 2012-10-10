Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2012 18:57:12 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:57047 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822664Ab2JJQ5FR10FU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Oct 2012 18:57:05 +0200
Received: by mail-pa0-f49.google.com with SMTP id bi5so842701pad.36
        for <linux-mips@linux-mips.org>; Wed, 10 Oct 2012 09:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=8rwlX3/Ys23WeF7LhTs2iWyuwbrVtKnxzt67StNQmgU=;
        b=y3YbCJJ57gV6LS6vIzp8HIKU7S4yth+cJlrqvR6fXZKK5ynUVUVBvQOiJmYbv3+XDo
         xJHrhBIwMxe52R/L2H7tPn/DjecoSjwVgXLjXrcDgKl9zSohYmdW5Fhh1AfD6EyjlctC
         g5MDCrpe3+XL22xgrte7cFlN6il0S+KJSQ2pS0/9x4kvZDB5Ehbbr2Io+oWb50Mf6QlD
         pu/QWQVJ+q5DoPwhc4Z/Bks8jGD5Td4vptDpJc35MBxKUtWQBEBN8RsvRDALVnAD1m4O
         LM+vpbKqozs4qcXbs8ntgEM6YMwKLW9sJGonbeUW6v/m+5G23zxy4EKYFh/5ud7h0DRg
         +h+Q==
Received: by 10.66.87.133 with SMTP id ay5mr63917513pab.59.1349888218351;
        Wed, 10 Oct 2012 09:56:58 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id gk5sm1278962pbc.21.2012.10.10.09.56.56
        (version=SSLv3 cipher=OTHER);
        Wed, 10 Oct 2012 09:56:57 -0700 (PDT)
Message-ID: <5075A8D8.2080704@gmail.com>
Date:   Wed, 10 Oct 2012 09:56:56 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120828 Thunderbird/15.0
MIME-Version: 1.0
To:     Rich Felker <dalias@aerifal.cx>
CC:     linux-mips@linux-mips.org,
        "Pinski, Andrew" <Andrew.Pinski@caviumnetworks.com>
Subject: Re: 2GB userspace limitation in ABI N32
References: <CAMJ=MEfFsJH6Cqkow7-w3a352iYiWWi+ubOSJaqhh2bp2MqPZg@mail.gmail.com> <20121010080756.GC6740@linux-mips.org> <20121010125700.GR254@brightrain.aerifal.cx>
In-Reply-To: <20121010125700.GR254@brightrain.aerifal.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34675
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 10/10/2012 05:57 AM, Rich Felker wrote:
> On Wed, Oct 10, 2012 at 10:07:56AM +0200, Ralf Baechle wrote:
>> On Wed, Oct 10, 2012 at 08:32:47AM +0200, Ronny Meeus wrote:
>>
>>> I have a legacy application that we want to port to a MIPS (Cavium)
>>> architecture from a PPC based one.
>>> The board has 4GB memory of which we actually need almost 3GB in
>>> application space. On the PPC this is no issue since the split
>>> user/kernel is 3GB/1GB.
>>> We have to use the N32 ABI Initial tests on MIPS showed me the
>>> user-space limit of 2GB.
>>> We do not want to port the application to a 64bit
>>>
>>> Now the question is: are there any workarounds, tricks existing to get
>>> around this limitation?
>>> I found some mailthreads on this subject (n32-big ABI -
>>> http://gcc.gnu.org/ml/gcc/2011-02/msg00278.html,
>>> http://elinux.org/images/1/1f/New-tricks-mips-linux.pdf) but is looks
>>> like this is not accepted by the community. Is there any process
>>> planned or made in this area?
>>
>> I think limited time and gain killed the propoosed ABI rather than
>> theoretical issues raised.

Ralf, I and others have put some thought into doing this in the past. 
This is a rough plan for how it would be done:

1) Define a special ELF section/program header similar to GNU_STACK that 
would be used to mark binaries that could use the 4GB n32 extension. 
Modify GNU gas and ld to mark the binaries and properly propagate the 
markers.

2) Add a n32-4GB option to GCC.  In this mode pointers would be zero 
extended when loaded in to registers.  I have a, currently broken, 
prototype of this implemented.

3) Modify the Linux kernel.
3a) Add a thread_info flag to mark threads that use 4GB of address 
space, TASK_SIZE would then depend on this as well as the other TIF_* 
flags that it currently uses.

3b) Fix up the ELF loader to set the 4GB flag based on the program 
header from #1.

3c) Audit n32 system call entry points for places where pointers are 
sign extended.  Change them to zero extend.  There are not many of these.

4) Rebuild all system libraries to support n32-4G.

The only disadvantage of doing this is that the code will be slightly 
larger/slower as it takes three instructions to load a zero extended 
32-bit pointer verses two for n32-2GB.


>>  Other architectures such as i386 - well,
>> IIRC any 32-bit ABI with more than 2GB userspace and a signed
>> ptrdiff_t - are suffering from them as well.
>
> There's no issue with ptrdiff_t being signed 32-bit as long as the
> implementation does not allow individual objects larger than 2GB.
> Taking differences between pointers into different objects is UB.
>

No problem here.  We can just keep loading the VDSO at the 2GB point in 
the address space.  That will break things up so that all possible 
objects are smaller than 2GB.
