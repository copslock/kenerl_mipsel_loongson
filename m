Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Sep 2016 15:17:47 +0200 (CEST)
Received: from mail-vk0-f46.google.com ([209.85.213.46]:36257 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992990AbcIINRlAaXyZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Sep 2016 15:17:41 +0200
Received: by mail-vk0-f46.google.com with SMTP id m62so14102178vkd.3
        for <linux-mips@linux-mips.org>; Fri, 09 Sep 2016 06:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t7b7VMrky80Xgjrh6/Z/b+dpnJDyZs3yNaENY596d18=;
        b=esvIEcNHN8OlqeUYUxBARWdWNdQYHClemDt1qBT/3NrKZiejGJbDaubdHnsFPJa+P9
         062/A14e4lSFCupOAcqPFeXWXde7DoFXsMlVW3vf/JggQgEFni4l+VB7ReznrcXqFUzN
         1EOJxom8PK/lnVqsODnrFEDCd0GmQUFHVFxwpKQOi9VRSo8zDSNT1sduwQt3k9Oa2aXZ
         2HHQHWzQYcbRniTOfJ3W2SdaD1r8GqEuEIHRxJWZYpqm5sLbtYONy5SedM2W/R+uWArc
         9wvOrtl5Kg7WykVqFBuXgRxnSRlTwfTu3r69ln94GJn5PYFtyXUVENrITGxk/LTGk6w9
         6K3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t7b7VMrky80Xgjrh6/Z/b+dpnJDyZs3yNaENY596d18=;
        b=W8lcXdJA5VKMOCG2PuiDRiC4BaI9sQBDpaU/1ziLK12pvEXzDdyqx7Mogdn62qCw3h
         gCUOb5/+Zrlv7sy3p1cLCuxMSN+1z82cSneL+tilTfRG6h2fUO3wpHixlnaiGmadlq1j
         g8j9KUTUs2QiFqC26zpR6ltNILI771Cx4Z735QQUNJiTanLN1IaEgrzOF7fNtgnQZhhg
         VOtxe438eOppoNUVjef8iGlT2wFYobmQgg6jT1B2bZgMilJLFesnGlPy9e2uGHUb1wGb
         fRpp1KGccfHYbk6VYNY6VDqqfF+zaF4nDOlxPJJlWkv5Zt7b5XDA7+fAeqv9HYoPv/3d
         xemA==
X-Gm-Message-State: AE9vXwM9aj8lURBINF5Ft12V3nX+exK/alFfwx7WnA5rZqW710WISUQCkgbZKAXJhF+BvZx2rC9PsCrKfURF5A==
X-Received: by 10.31.219.194 with SMTP id s185mr2006988vkg.31.1473427055110;
 Fri, 09 Sep 2016 06:17:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.242.73 with HTTP; Fri, 9 Sep 2016 06:17:13 -0700 (PDT)
In-Reply-To: <20160909123652.GA1846@jhogan-linux.le.imgtec.org>
References: <CAFwMWxtUHa_Av34RrzFp3Dar0y-ghQRJNeXeUqYeUo3149zOsw@mail.gmail.com>
 <20160909123652.GA1846@jhogan-linux.le.imgtec.org>
From:   Sagar Borikar <sagar.borikar@gmail.com>
Date:   Fri, 9 Sep 2016 06:17:13 -0700
Message-ID: <CAFwMWxsQ6tpj7D1NnatEeVis32pRwKRsKkPXFgGrkvyCES0yHA@mail.gmail.com>
Subject: Re: highmem issues with 3.14.10 (LST)
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <sagar.borikar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sagar.borikar@gmail.com
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

Thanks James.

On Fri, Sep 9, 2016 at 5:36 AM, James Hogan <james.hogan@imgtec.com> wrote:
> Hi Sagar,
>
> On Thu, Sep 08, 2016 at 08:33:57PM -0700, Sagar Borikar wrote:
>> Hello,
>>
>> I am upgrading kernel for a MIPS Interaptive CPU from 3.10.60 to
>> 3.14.10 (stable) from:
>> https://www.linux-mips.org/wiki/Malta_Linux_Repository
>
> Unfortunately that wiki page needs updating.
>
> If you're upgrading anyway, I think we'd recommend switching all the way
> to a recent mainline kernel release / stable branch, e.g. 4.4 (LTS) or
> 4.7 (and maybe update to 4.9 (LTS) when it is released or when 4.7 goes
> EOL). I think all the stuff you'll need for interAptiv should be in
> mainline now anyway.

I see. We generally upgrade to malta repo as its maintained by mips
(imgtec). I presume you are referring to kernel.org. I think linux-mti
is having  4.1.7 as stable, right?

>
>>
>>  The platform has non-contiguous low memory and high memory. After the
>> upgrade, highmem is not getting enabled due to max_low_pfn and
>> highend_pfn not being the same.
>>
>> The commit cce335ae47e231398269fb05fa48e0e9cbf289e0 introduced the
>> change apparently for sibyte platform. That change doesn't hold good
>> for all platforms where the high memory and low memory is sparsed.
>>
>> If I comment out only following change in arch/mips/mm/init.c, highmem
>> gets initialized properly.
>>
>> 296     if (cpu_has_dc_aliases && max_low_pfn != highend_pfn) {
>> 297         printk(KERN_WARNING "This processor doesn't support highmem."
>> 298                " %ldk highmem ignored\n",
>> 299                (highend_pfn - max_low_pfn) << (PAGE_SHIFT - 10));
>> 300         max_zone_pfns[ZONE_HIGHMEM] = max_low_pfn;
>> 301         lastpfn = max_low_pfn;
>> 302     }
>
> I don't think we ever supported DCache aliasing + highmem in
> combination.

Interesting. We are currently running 3.10.60 and apparently it seems
to work. Are you saying it may cause any issues? So far we haven't
seen any problems. What kind of issues it might end up into?

>
> If you want to use that memory your options are probably:
> - increase the page size to avoid dcache aliasing.

Ok thanks. I would need to experiment with this but I am bit baffled
how its working in 3.10.60.
Generally, is there any reference platforms based on interaptiv which
uses highmem and dcache aliasing? I might have missed but couldn't
find any platform which comes close in both trees.

> - OR use EVA to increase the size of lowmem, which at the moment is a
>   bit more involved. How much RAM do you have, and what does your
>   physical memory map look like?

Total memory is 2GB. memory map looks like this:

low mem(~66MB) :

 * 0x04300000 +-----------------+
 *                    |     Linux       |
 * 0x00043000 +-----------------+

high mem (128MB):

 * 0x28000000 +-----------------+
 *                   |     linuxhi     |
 * 0x20000000 +-----------------+

Rest of the blocks are reserved.

Thanks
Sagar

>
> Cheers
> James
>
>>
>> So wanted to know whether there is additional change required in
>> platform to work with above codebase.
>> Secondly, when the system proceeds (with commented code above), it
>> seems execve causes panic in copy_strings:
>>
>> Kernel bug detected[#1]:
>> CPU: 0 PID: 177 Comm: mcp Not tainted 3.14.10 #19
>> task: 82c99070 ti: 829b0000 task.ti: 829b0000
>> $ 0   : 00000000 81a40018 00000001 00000528
>> $ 4   : 806805b0 00000294 00000000 81c76000
>> $ 8   : 82c99070 fe001ffc 00000000 805d0000
>> $12   : 00000000 00000000 00000000 00000001
>> $16   : 8214a760 00000000 81a40010 82c2c580
>> $20   : ffffffff 7fff7000 00000000 00000008
>> $24   : 00000000 801182a0
>> $28   : 829b0000 829b1e78 8214a760 801bb0bc
>> Hi    : 000000e1
>> Lo    : 00077c44
>> epc   : 801bb014 copy_strings+0x304/0x394
>>     Not tainted
>> ra    : 801bb0bc copy_strings_kernel+0x18/0x2c
>> Status: 1100fc03        KERNEL EXL IE
>> Cause : 10800034
>> PrId  : 0001a020 (MIPS interAptiv)
>> Modules linked in:
>> Process mcp (pid: 177, threadinfo=829b0000, task=82c99070, tls=770b82f0)
>> Stack : 00000080 00000000 00000000 00000000 00000017 829b1e98 00000000 00000000
>>           8214a760 82bba0b0 fe001000 00000ff4 80000000 00000080
>> 82bba0b0 81a40000
>>           80b12b00 00000001 80b12b00 7fe5e66c 81c40000 801bb0bc
>> 80b12b00 82c2c630
>>           82c2c580 00000080 82c2c580 801bc4d4 00000003 8013452c
>> 7649e000 7648fa08
>>           82c99234 00000000 00000601 80b12b34 7649e000 7648fa08
>> 7649e000 7fe5dc50
>>          ...
>> Call Trace:
>> [<801bb014>] copy_strings+0x304/0x394
>> [<801bb0bc>] copy_strings_kernel+0x18/0x2c
>> [<801bc4d4>] do_execve+0x2fc/0x4c4
>> [<8010d37c>] handle_sys+0x11c/0x140
>> Code: 0806ec05  00000000  24020001 <00020336> 0c045e64  02002021
>> 0c0651dd  02002021  0806ec1d
>> ---[ end trace ed487c3c490d886b ]---
>> BUG: Bad rss-counter state mm:828bd6a0 idx:1 val:2
>>
>> This panic occurs only when I spawn nested fork/execve. If I spawn the
>> process directly without nesting, I don't see this panic.
>>
>> Looks like there are several reports about "Bad rss-counter state"
>> panic with 3.14-stable. But I couldn't find any concrete solution to
>> the panic.
>>
>> Any pointers?
>>
>> Thanks
>>
>> Sagar
>>
