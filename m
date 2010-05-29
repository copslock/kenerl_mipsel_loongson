Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 May 2010 05:11:06 +0200 (CEST)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:57740 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491031Ab0E2DLC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 29 May 2010 05:11:02 +0200
Received: by gwj18 with SMTP id 18so1614016gwj.36
        for <multiple recipients>; Fri, 28 May 2010 20:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=OMhuh2pz33scESQ32n7uo1PIF7H4GcNdVxOCCKh7YhQ=;
        b=vyyMNZ/0nxJ71oVsN3GOyccF53SQ/JEchdIzNkNbaJPu4VKjs0955snNJo92k+o1tV
         Xz81dTvC828ISrFezAYo6ddd7C/mSFW81oIVmDpb8UOuz8vKSFyGO+NZnoAoba5L4Hwm
         H9+j5URHyWYI4Czi2yE62yxjbocw5ma1nr/4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=KklzFuHH0RphUDVlgscrDFAjMVV+f1AurO58yZEt76UPa75T53VA/uGaS2a1Y+bm7z
         Qz9Vs5K+BfRVSPaz1DGfryLiqQEYbJtD5zUmU/lAqDng0adFRqbGdJPna4LRYIwY9RGj
         cs8ijuO3lKukIo5/RgWXyTIucxp+jyjrnEjXw=
MIME-Version: 1.0
Received: by 10.151.29.9 with SMTP id g9mr2168894ybj.46.1275102656702; Fri, 28 
        May 2010 20:10:56 -0700 (PDT)
Received: by 10.150.157.8 with HTTP; Fri, 28 May 2010 20:10:56 -0700 (PDT)
In-Reply-To: <4BFEF6CE.3040002@gmail.com>
References: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com>
        <1274965420-5091-8-git-send-email-dengcheng.zhu@gmail.com>
        <4BFEF6CE.3040002@gmail.com>
Date:   Sat, 29 May 2010 11:10:56 +0800
Message-ID: <AANLkTikePMXqTj0HkynYS2ZwA2JvL3tYL0yDKHGYDz06@mail.gmail.com>
Subject: Re: [PATCH v5 07/12] MIPS/Perf-events: add raw event support for 
        mipsxx 24K/34K/74K/1004K
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     David Daney <david.s.daney@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26907
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

2010/5/28 David Daney <david.s.daney@gmail.com>:
> Should this just be folded into the other patches?
[DC]: OK.


> I would also reiterate that perhaps the generic support functions be
> separated from the processor specific event definitions.
[DC]: Which generic support functions in perf_event_mipsxx.c? Please refer
to my reply for [6/12].


Deng-Cheng
