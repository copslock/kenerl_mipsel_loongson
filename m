Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 May 2011 06:35:57 +0200 (CEST)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:36932 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490987Ab1ESEfw convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 May 2011 06:35:52 +0200
Received: by bwz1 with SMTP id 1so2549628bwz.36
        for <multiple recipients>; Wed, 18 May 2011 21:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=z1awzvvE3yClg8lODOXQ+zBFmDzc7XAbDj+NNGZtgwg=;
        b=RE3PyW+G+Qotq3eQ7sEPS6L3HCFv15/j5N5JgAXYw60otfJ6/z7vRcpRL3XE9rm/JP
         6uA7yllUNLhR+Vm8V/kopdwmUb+H2QVthw8FkiFh1HL+YuBpbifyEZYJLNoUPcnETIcz
         OZgAsDP8cZf1A5hkWLlQEqZ+1WgzLV9HxLoc4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BFR6Y33Zl6ggwKh6hSCm3Q24YuGTDjscKWLuG1zc3EC6HP09habJ2nx34xq7/2F6Zq
         HxEwQxrf1LqkpugQhR0I4KTR1sj6+IRFkRxB7md2mCu2N+YoA4Ku8pwXMZo2y117aAqW
         /4b8LA9O4l4VYK57JyRV2L9hc3sxAACMwGNgI=
MIME-Version: 1.0
Received: by 10.205.82.80 with SMTP id ab16mr2649058bkc.66.1305779745211; Wed,
 18 May 2011 21:35:45 -0700 (PDT)
Received: by 10.204.164.130 with HTTP; Wed, 18 May 2011 21:35:45 -0700 (PDT)
In-Reply-To: <AANLkTimy6FPdgW=f8HOTBd6ORKmjvX3KFONXesacJ6Ms@mail.gmail.com>
References: <AANLkTimkh2QLvupu+62NGrKfqRb_gC7KLCAKkEoS9N9N@mail.gmail.com>
        <20110325172709.GC8483@linux-mips.org>
        <AANLkTimy6FPdgW=f8HOTBd6ORKmjvX3KFONXesacJ6Ms@mail.gmail.com>
Date:   Thu, 19 May 2011 10:05:45 +0530
Message-ID: <BANLkTimysdkBnr0LEdOsiT+Z3O-w-KO7=g@mail.gmail.com>
Subject: Re: flush_kernel_vmap_range() invalidate_kernel_vmap_range() API not
 exists for MIPS
From:   naveen yadav <yad.naveen@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <yad.naveen@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yad.naveen@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

Have you got time to look into this issue.

Regards


On Tue, Mar 29, 2011 at 11:24 AM, naveen yadav <yad.naveen@gmail.com> wrote:
> I am sorry, Yes they are VIPT,
>
>
> On Fri, Mar 25, 2011 at 10:57 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
>> On Fri, Mar 25, 2011 at 02:38:13PM +0530, naveen yadav wrote:
>>
>>> We are working on 2.6.35.9 linux kernel on MIPS 34kce core and our
>>> cache is VIVT having cache aliasing .
>>
>> No, they're VIPT unless you successfully modified your 34K core to
>> change it from a less than perfect cache design to the most lunatic
>> cache policy known to man kind ...
>>
>>> When I check the implementation on ARM I can check the implemenation
>>> exists , but there is not similar implementation exists on MIPS.
>>> These API's are used by XFS module:
>>>
>>> static inline void flush_kernel_vmap_range(void *vaddr, int size)
>>> static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
>>> static inline void flush_kernel_dcache_page(struct page *page)
>>
>> A known problem for (too ...) long.  I'll finally take care of it.
>>
>>  Ralf
>>
>
