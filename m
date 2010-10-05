Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Oct 2010 02:06:38 +0200 (CEST)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:40464 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491156Ab0JEAGf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Oct 2010 02:06:35 +0200
Received: by qwe4 with SMTP id 4so121754qwe.36
        for <multiple recipients>; Mon, 04 Oct 2010 17:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=9QPwEJkwfq5pVnaxkOa0zuZffhJy9EAzTZxDnfi2eZQ=;
        b=E8LEzSmHwalNQ4i9IJW2XkEmXPAxSNJo1gBESTKtpDnCaiaIJVy3Cnxfd9bZEeHFt/
         7f9b9RR/WXoXLCRUThS+1I+SBaOuUq+b6lSTB6aB6RQHnaP5eMWCUmL2kb2mxJhRU9ZW
         +LculLCJaKTRwQp2/rUZu5dn7v3Aeu+xHRLkc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=pTmfUbnpgYkiA58lP8KEmqJkB8ycdboz9OnsN25jFyA464fZFWthsmPCCHjcFUVHoo
         f17T2njM0T5+47Ge1TvGoxLiEv5PRWJFhAmGnpi7wSxLFuB9kLmIf/DN7XqsU1FV6VTO
         uhsCAiyWUS4tZTn8IYBNLw8lFBIJhW54UGx5U=
MIME-Version: 1.0
Received: by 10.224.20.166 with SMTP id f38mr7505172qab.82.1286237186738; Mon,
 04 Oct 2010 17:06:26 -0700 (PDT)
Received: by 10.229.25.208 with HTTP; Mon, 4 Oct 2010 17:06:26 -0700 (PDT)
In-Reply-To: <20101004193329.GF1670@console-pimps.org>
References: <1285837760-10362-1-git-send-email-dengcheng.zhu@gmail.com>
        <20101004193329.GF1670@console-pimps.org>
Date:   Tue, 5 Oct 2010 08:06:26 +0800
Message-ID: <AANLkTimygG29VWat0XoNBxOPeB4+vdSoQdO5+G=emecz@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] MIPS performance event support v7
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     Matt Fleming <matt@console-pimps.org>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

I have a question about your "generalise" patchset: Do you see any issues
or needed changes for the existing x86 (or sparc) Perf and Oprofile code by
merging your patchset?


Deng-Cheng


2010/10/5 Matt Fleming <matt@console-pimps.org>:
> On Thu, Sep 30, 2010 at 05:09:14PM +0800, Deng-Cheng Zhu wrote:
>> o Remove function code from pmu.h, keep them duplicated in Oprofile and
>> Perf-events. The duplication would be resolved by the idea of using
>> Perf-events as the Oprofile backend. I'll submit a separate patchset to
>> do this after this one gets merged.
>
> I dunno if you're aware of this but I've been working on a perf
> backend for OProfile. Currently only ARM and SH are making use of it,
>
> http://marc.info/?l=linux-arm-kernel&m=128435815708349&w=2
>
> It would be trivial to add MIPS support but I suspect that would
> require you to rework this patch series. However, what we should try
> to avoid is duplicating any effort of getting perf and OProfile
> working together.
>
> Would you mind waiting for my patch series to be merged before
> starting work on your perf-OProfile patchset for MIPS? Alternatively,
> you can base your work on,
>
> git://git.kernel.org/pub/scm/linux/kernel/git/mfleming/sh-2.6.git perf-oprofile
>
