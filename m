Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Nov 2011 06:08:40 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:54717 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903632Ab1KFFIe convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 6 Nov 2011 06:08:34 +0100
Received: by wyf28 with SMTP id 28so4562908wyf.36
        for <multiple recipients>; Sat, 05 Nov 2011 22:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=uS5+6uZxL7nKBOvXPdv6CTOxTsIgL6vn5vMASGdFDc0=;
        b=WRt0KAzzZ1tvVE/JNyuYAttTB7G7wo33xAGmhFJ1nthtQlUfFPjSya/5hur/fO0jfh
         g35AU86ZHKbB4ZGFjO4IBUhK9Zcf+d+61lBVyzkTn50EwgqRDPVKTF69hONf9XeczzG3
         5pshUymMS7uXpSeakqZkor8tRnBnM0m2iytGY=
MIME-Version: 1.0
Received: by 10.216.24.41 with SMTP id w41mr2381628wew.69.1320556108604; Sat,
 05 Nov 2011 22:08:28 -0700 (PDT)
Received: by 10.216.45.11 with HTTP; Sat, 5 Nov 2011 22:08:28 -0700 (PDT)
In-Reply-To: <20111104145627.GA13043@linux-mips.org>
References: <CAJd=RBAQpea=wr2Nv6U1yRAH1bwaCvMxpnjfnKdhzAN3mtbK7A@mail.gmail.com>
        <4EAAD55D.4070106@gmail.com>
        <20111104145627.GA13043@linux-mips.org>
Date:   Sun, 6 Nov 2011 13:08:28 +0800
Message-ID: <CAJd=RBCJv-pCbu_8yMpvVPHxAYDXhwnmBZJSkmAVu+8VoZGUCg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Keep TLB cache hot while flushing
From:   Hillf Danton <dhillf@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 31412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhillf@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4492

On Fri, Nov 4, 2011 at 10:56 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, Oct 28, 2011 at 09:16:29AM -0700, David Daney wrote:
>
>> >If we only flush the TLB of the given huge page, the TLB cache remains hot for
>> >the relevant mm as it is, and less will be refilled after flush, huge or not.
>> >
>> >As always all comments and ideas welcome.
>> >
>>
>> I haven't tested it, but it looks correct.  When I wrote the
>> original flush_tlb_mm(), I was in a hurry and was more concerned
>> about maintaining TLB consistency, rather than performance.
>
> Yes, looks sane and like an obvious performance improvment.  but as always
> with TLB stuff I'm paranoid so I've applied this to my 3.3 queue for it to
> be tested well.
>

Thanks Ralf and David:)

> Hillf, do you have any benchmark numbers for this?
>

Simple application related to libhugetlbfs works as it was after this patch
applied. Unlike x86, MIPS box is rare resource, and I have to ask David, the
author of MIPS huge TLB, to benchmark this patch, and to test GUP on Cavium
chips as well.

Btw, the patch for THP is prepared, and I am chasing box for test. Would you
please, David, take a look at it before posting?

Thanks

Hillf
