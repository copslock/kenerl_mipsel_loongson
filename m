Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2012 17:12:35 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:38657 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6872750Ab2JJPMXgnb26 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Oct 2012 17:12:23 +0200
Received: by mail-ob0-f177.google.com with SMTP id wd20so618862obb.36
        for <multiple recipients>; Wed, 10 Oct 2012 08:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pemOGcED5wy4tydJjXWikCgLWUfHxOpx1ROM4WgN5/g=;
        b=W57c3HxRwlPWMXwj1/CJuubf8G4GYKyxDHpHmaKMQKTImed++2tmP9DvokGHZAlA7W
         j0UBtyo7K/a46hQtNoCjSCaM7zV8m+pVUWhm5g9v+z0q/G89/vgB+3/OO/Iwd8NaycGS
         JP99VOo/IxAKEQC1GkmUH+WHV0K9WnWKCB/dTSsrnEReTerPlHYAL25crL++hHbEFWZy
         McVgz1WVF4nHKltDjJ3LX/zCDFm9ZGeo6BnMNs5hHquiv2+zcg26iZkDtd1oA8Lv4Wpw
         A64AErDJQVhqjBeBkr+eYRpFPblcjkMG+aiiLkQ8EEjtDBQqprBtZQpXCzqP8Hx7nxUn
         1AbQ==
MIME-Version: 1.0
Received: by 10.182.76.194 with SMTP id m2mr5336131obw.39.1349881936956; Wed,
 10 Oct 2012 08:12:16 -0700 (PDT)
Received: by 10.60.66.4 with HTTP; Wed, 10 Oct 2012 08:12:16 -0700 (PDT)
In-Reply-To: <20121010080756.GC6740@linux-mips.org>
References: <CAMJ=MEfFsJH6Cqkow7-w3a352iYiWWi+ubOSJaqhh2bp2MqPZg@mail.gmail.com>
        <20121010080756.GC6740@linux-mips.org>
Date:   Wed, 10 Oct 2012 17:12:16 +0200
Message-ID: <CAMJ=MEeSxpcLRCWmkOn7w4Ge1J9Bg7_bFN+Z8xPoYumGFddabA@mail.gmail.com>
Subject: Re: 2GB userspace limitation in ABI N32
From:   Ronny Meeus <ronny.meeus@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 34674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ronny.meeus@gmail.com
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

Do you have any clue (rough) on the amount of effort this change would cost?

About the limited gain we can discuss: if you have a large application
that has been created assuming 32bit and it needs to be ported to a
64bit architecture, I think the effort can be huge and the risk for
forgetting things is high. It will be very hard to check whether the
system behaves well under all conditions.

---
Ronny

On Wed, Oct 10, 2012 at 10:07 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Wed, Oct 10, 2012 at 08:32:47AM +0200, Ronny Meeus wrote:
>
>> I have a legacy application that we want to port to a MIPS (Cavium)
>> architecture from a PPC based one.
>> The board has 4GB memory of which we actually need almost 3GB in
>> application space. On the PPC this is no issue since the split
>> user/kernel is 3GB/1GB.
>> We have to use the N32 ABI Initial tests on MIPS showed me the
>> user-space limit of 2GB.
>> We do not want to port the application to a 64bit
>>
>> Now the question is: are there any workarounds, tricks existing to get
>> around this limitation?
>> I found some mailthreads on this subject (n32-big ABI -
>> http://gcc.gnu.org/ml/gcc/2011-02/msg00278.html,
>> http://elinux.org/images/1/1f/New-tricks-mips-linux.pdf) but is looks
>> like this is not accepted by the community. Is there any process
>> planned or made in this area?
>
> I think limited time and gain killed the propoosed ABI rather than
> theoretical issues raised.  Other architectures such as i386 - well,
> IIRC any 32-bit ABI with more than 2GB userspace and a signed
> ptrdiff_t - are suffering from them as well.
>
> Also there's limited gain and even more limited time to implement things ...
>
>   Ralf
