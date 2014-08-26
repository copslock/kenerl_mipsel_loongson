Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2014 19:45:57 +0200 (CEST)
Received: from mail-oi0-f45.google.com ([209.85.218.45]:42604 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006913AbaHZRpzvsX4t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Aug 2014 19:45:55 +0200
Received: by mail-oi0-f45.google.com with SMTP id h136so784658oig.18
        for <multiple recipients>; Tue, 26 Aug 2014 10:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=1NQ5z5XuBRYlK0BfboOOftWTvB2bgKz7RQFM/7c1E6E=;
        b=f8UJ6a5pQGgjIWH0BFGZr1bExPQhTD4LCkhY4SfTTALUyZIqX2fwrQ8GX6E+oPYfXW
         eoN77i7UxopAfufBdXJX8j/bcrv3cjfLAw37R+0kibJihmHsQWbTDjlcrYNUeyPVyS7n
         LfETqiAvPo+vIflPRYIXXRcxz32ZZDbI3ilJBiBwYfAj7Szp4b4bScTcZALtTjYEamff
         0kKXJ/qVVQ9XZvLromXmgAEWqJRUY6I6KOPZNpoMfrfHFklz6CiiIhf7cYzxuuGIfJlX
         LttC/vvnSa/ea3zX11zV0FsizkSWjWhNqhU4yVJu5hqD1Nmt+yw/0I5DFeyGncUoGHuV
         ty0w==
X-Received: by 10.60.123.19 with SMTP id lw19mr29286637oeb.22.1409075149619;
        Tue, 26 Aug 2014 10:45:49 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id yx3sm3568571obb.23.2014.08.26.10.45.48
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 26 Aug 2014 10:45:49 -0700 (PDT)
Message-ID: <53FCC7CB.8010701@gmail.com>
Date:   Tue, 26 Aug 2014 10:45:47 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Joshua Kinard <kumba@gentoo.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>,
        Marc Gauthier <marc@cadence.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Steven Hill <Steven.Hill@imgtec.com>
Subject: Re: [PATCH v4 0/2] mm/highmem: make kmap cache coloring aware
References: <1406941899-19932-1-git-send-email-jcmvbkbc@gmail.com> <20140825171600.GH25892@linux-mips.org> <53FBCD09.1050003@gentoo.org> <53FBD676.8080307@gmail.com> <53FBF3C3.90509@gentoo.org>
In-Reply-To: <53FBF3C3.90509@gentoo.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42263
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

On 08/25/2014 07:41 PM, Joshua Kinard wrote:
> On 08/25/2014 20:36, David Daney wrote:
>> On 08/25/2014 04:55 PM, Joshua Kinard wrote:
>>> On 08/25/2014 13:16, Ralf Baechle wrote:
>>>> On Sat, Aug 02, 2014 at 05:11:37AM +0400, Max Filippov wrote:
>>>>
>>>>> this series adds mapping color control to the generic kmap code, allowing
>>>>> architectures with aliasing VIPT cache to use high memory. There's also
>>>>> use example of this new interface by xtensa.
>>>>
>>>> I haven't actually ported this to MIPS but it certainly appears to be
>>>> the right framework to get highmem aliases handled on MIPS, too.
>>>>
>>>> Though I still consider increasing PAGE_SIZE to 16k the preferable
>>>> solution because it will entirly do away with cache aliases.
>>>
>>> Won't setting PAGE_SIZE to 16k break some existing userlands (o32)?  I use a
>>> 4k PAGE_SIZE because the last few times I've tried 16k or 64k, init won't
>>> load (SIGSEGVs or such, which panicks the kernel).
>>>
>>
>> It isn't supposed to break things.  Using "stock" toolchains should result
>> in executables that will run with any page size.
>>
>> In the past, some geniuses came up with some linker (ld) patches that, in
>> order to save a few KB of RAM, produced executables that ran only on 4K pages.
>>
>> There were some equally astute Debian emacs package maintainers that were
>> carrying emacs patches into Debian that would not work on non-4K page size
>> systems.
>>
>> That said, I think such thinking should be punished.  The punishment should
>> be to not have their software run when we select non-4K page sizes.  The
>> vast majority of prepackaged software runs just fine with a larger page size.
>
> Well, it does appear to mostly work now w/ 16k PAGE_SIZE.  The Octane booted
> into userland with just a couple of "illegal instruction" errors from 'rm'
> and 'mdadm'.  I wonder if that's tied to a hardcoded PAGE_SIZE somewhere.
> Have to dig around and find something that reproduces the problem on demand.
>

What does the output of "readelf -lW" look like for the failing 
programs?  If the "Offset" and "VirtAddr" constraints for the LOAD 
Program Headers are not possible to achieve with the selected PAGE_SIZE, 
you will see problems.  A "correct" toolchain will generate binaries 
that work with any PAGE_SIZE up to 64K.
