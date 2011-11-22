Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2011 01:37:59 +0100 (CET)
Received: from mail-ww0-f41.google.com ([74.125.82.41]:36208 "EHLO
        mail-ww0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903815Ab1KVAhx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Nov 2011 01:37:53 +0100
Received: by wwf25 with SMTP id 25so6253621wwf.0
        for <multiple recipients>; Mon, 21 Nov 2011 16:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=LLvRq5LFS8S3WAns+aGJkw4ZapStJMpHr8e/QznUFHU=;
        b=W+OLZkZTa1PvmprJwl7jvUCrvoZiDiTHZBSrOLZIw0B42E+eZBoeiDSwFL4HUsKcez
         dvpPWvLcfaVLwcA80Xqqkch+JYj844pXtgxgG4j7uyJEyb+yObkvbIou6DVH0ZO5LUc3
         LIZGnxP6sc/lRXzcA0Xj2qtWi8CiPmYqHAB0k=
Received: by 10.216.133.12 with SMTP id p12mr2333112wei.99.1321922268052; Mon,
 21 Nov 2011 16:37:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.216.151.168 with HTTP; Mon, 21 Nov 2011 16:37:27 -0800 (PST)
In-Reply-To: <4ECAE314.9060209@gmail.com>
References: <1321567050-13197-1-git-send-email-ddaney.cavm@gmail.com>
 <alpine.DEB.2.00.1111171520130.20133@chino.kir.corp.google.com>
 <alpine.DEB.2.00.1111171522131.20133@chino.kir.corp.google.com>
 <4ECACF68.3020701@gmail.com> <CA+55aFwZxqHfEOemj+OJNKCj2toqGf3rkK-9iuS39L7iZsoH1Q@mail.gmail.com>
 <4ECAE314.9060209@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Nov 2011 16:37:27 -0800
X-Google-Sender-Auth: ZVbI40hThMRpq-xDucOMUX9jilU
Message-ID: <CA+55aFx==PGGLX9YXv1GOeTja4W0PSW8U4i8zkmtiZwqmFwHFw@mail.gmail.com>
Subject: Re: [patch] hugetlb: remove dummy definitions of HPAGE_MASK and HPAGE_SIZE
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        linux-arch@vger.kernel.org, Robin Holt <holt@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 31909
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@linux-foundation.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18076

On Mon, Nov 21, 2011 at 3:47 PM, David Daney <ddaney.cavm@gmail.com> wrote:
>
> These symbols are on dead code paths, so they are eliminated by the
> compiler's Dead Code Elimination (DCE) optimizations, and the BUG() code
> never gets emitted to the final executable.

If you are so damn sure of that, then DON'T MAKE IT A BUG_ON! If you
are 100% syre, then you might as well leave out the BUG_ON() entirely.

Seriously. What's so hard to understand?

Either you are 100% sure, or you are not. If you are 100% sure, then
the BUG_ON() is pointless. And if you are not, then the BUG_ON() is
*wrong*.

Notice? The BUG_ON() is never *ever* valid. You cannot have it both
ways. So stop pushing crap, already!

So what are non-crap solutions?

 - the current one: error out at compile time (early) if somebody uses
them in invalid contexts.

   This seems to be a good case, especially since apparently no actual
current code wants to use them outside of the existing #ifdef's. And
there is no reason to think that some random MIPS-only future code is
a good enough reason to re-introduce these things

 - if you really want to use them, but expect the compiler to always
compile them away as dead code, use a non-existing function linkage,
so that you at least get a static failure at link-time for incorrect
code, rather than some random BUG_ON() at run-time that may be
impossible to find.

See? There are real solutions. BUG_ON() is not one of them.

                  Linus
