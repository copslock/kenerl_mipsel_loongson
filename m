Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Feb 2015 17:40:50 +0100 (CET)
Received: from mail-qa0-f43.google.com ([209.85.216.43]:49763 "EHLO
        mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014898AbbBCQksaA5xS convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Feb 2015 17:40:48 +0100
Received: by mail-qa0-f43.google.com with SMTP id v10so34590502qac.2
        for <linux-mips@linux-mips.org>; Tue, 03 Feb 2015 08:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=SrkctTwalqwGYTjXBKpkOPEKVd1JyntR7EX7GVp4klc=;
        b=ogHw2rjKHqmbrlWz43o4/pZ8b7RdYbbuCgZriIReiHJA8zGrYD3s49y2pjnUoHp04g
         zN8LxZaJ0kpk8x7wle5OrRMUo9h4X81M079t1jiXzTiMOKqoLVj8EGBuR5aemR583KFX
         acXvRyU0IyNcgj3ibKJlJFfv/aj4pn5+Rm0R8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=SrkctTwalqwGYTjXBKpkOPEKVd1JyntR7EX7GVp4klc=;
        b=nHvQ2IuP46s+Sz5g6CTLoqL1No8Ed8kgN1lpr+CCulcwGr5YtlHFkh3Umyce5Zc/lv
         62Kk+7c+m84Ls+zYJOLFw2p/luODXQ1aEsCLmB4zJaoLdKCVuM0Tm6ctshMljQtH1KJu
         GHI2Un607vEwVwDt/F7JxzW7+aIgDdf+7DRYhC2V2u7uEUJWARugo8l/TM8achY3oAZ8
         VT0AEjeGYYOrK8dW1xlE2au2HdC1dSz2kycrL8vfuy2I4zRUQbFJDSjqmIlesAdHhcZs
         Pj/WpwfgkfimXvxK1EArsv3mHFW+gY7Sbc/Y/I/lz18rcRojeAq+dcNh1OiBx2aA0S+m
         F5AA==
X-Gm-Message-State: ALoCoQkYRd0Smnld0GU/xDeViFU/0TYxAX8l/mk7gs3PCUuvO+c/GpXDErX8GLKRcKxCIDqvnGF7
X-Received: by 10.140.84.136 with SMTP id l8mr50766967qgd.86.1422981642581;
        Tue, 03 Feb 2015 08:40:42 -0800 (PST)
Received: from mail-qa0-f41.google.com (mail-qa0-f41.google.com. [209.85.216.41])
        by mx.google.com with ESMTPSA id r6sm21714892qal.17.2015.02.03.08.40.41
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 03 Feb 2015 08:40:41 -0800 (PST)
Received: by mail-qa0-f41.google.com with SMTP id bm13so34580235qab.0;
        Tue, 03 Feb 2015 08:40:41 -0800 (PST)
X-Received: by 10.224.11.5 with SMTP id r5mr52458259qar.67.1422981641132; Tue,
 03 Feb 2015 08:40:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.36.210 with HTTP; Tue, 3 Feb 2015 08:40:21 -0800 (PST)
In-Reply-To: <yw1xsien9gna.fsf@unicorn.mansr.com>
References: <54CEACC1.1040701@gmail.com> <CAJiQ=7AQuP1JsiApEs4yAR449w6-pcR_qqhSqKdpqNHL5L1mRQ@mail.gmail.com>
 <yw1xwq409odv.fsf@unicorn.mansr.com> <54D017D4.70200@gmail.com>
 <alpine.LFD.2.11.1502030930000.22715@eddie.linux-mips.org>
 <CAJiQ=7DWiSEeBUiKCPZKn8fUwxUdOrCqMLDYFTaXSMTGsJCJOA@mail.gmail.com> <yw1xsien9gna.fsf@unicorn.mansr.com>
From:   Kevin Cernekee <cernekee@chromium.org>
Date:   Tue, 3 Feb 2015 08:40:21 -0800
Message-ID: <CAJiQ=7B10R7___tMSoVsygzFbLfvpjCMyjFK6FDQQALsbpjDoA@mail.gmail.com>
Subject: Re: Few questions about porting Linux to SMP86xx boards
To:     =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Oleg Kolosov <bazurbat@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Jim Quinlan <jim2101024@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <cernekee@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@chromium.org
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

On Tue, Feb 3, 2015 at 7:08 AM, Måns Rullgård <mans@mansr.com> wrote:
> Kevin Cernekee <cernekee@chromium.org> writes:
>> On Tue, Feb 3, 2015 at 3:39 AM, Maciej W. Rozycki <macro@linux-mips.org> wrote:
>>>  For the record -- the exact address `__fast_iob' reads from does not
>>> really matter, all it has to guarantee is no side effects on read access.
>>> Using the base of KSEG1 was therefore a natural choice for legacy MIPS
>>> processors that set the architecture back at the time this code was added,
>>> as the presence of exception vectors there guaranteed this area of the
>>> address space behaved like RAM so the same location did for any system.
>>>
>>>  With the introduction of revision 2 of the MIPS architecture the CP0
>>> EBase register was added and consequently there is no longer a guarantee
>>> that exception vectors reside at the base of KSEG1.  Using the value read
>>> from CP0.EBase to determine a usable address might therefore be a better
>>> idea, although the current revision of the MIPS architecture specification
>>> that includes segmentation control makes it a bit complicated.  Using a
>>> dummy page mapped uncached instead might work the best.
>>
>> Would something like this work, assuming __fast_iob() doesn't get
>> called before mem_init()?
>>
>> CKSEG1ADDR((void *)empty_zero_page)
>>
>> It is currently a GPL export, so maybe that would need to change to
>> allow non-GPL drivers to use iob().  But that's still easier than
>> allocating another dummy page.
>
> The 86xx has a 64k remappable block at CPU physical address zero, so one
> option would be to simply point this at some actual memory and leave the
> macro alone.  There doesn't seem to be anything useful in that bus
> address range anyway.  Reading returns zeros, and writes have no
> apparent effect.  Maybe it's even safe to do a dummy read from there in
> iob().

IIRC, one of the special operating modes on BCM7435 allows
partitioning the hardware in a way that prohibits accesses to PA 0.
Not sure how widely it is used, however.  I've also seen other
embedded MIPS systems that don't have RAM at PA 0, but they didn't run
Linux.

So there are two paths forward:

1) Make SMP86xx behave like other currently-supported CPUs, i.e. use
the remap registers to configure the chip so that uncached reads from
PA 0 do something sensible.  This sounds like the easiest fix.

2) Agree to support memory configurations where PA 0 doesn't map to
RAM, changing __fast_iob (and maybe other code) accordingly.
