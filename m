Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2011 01:55:45 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:49591 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903815Ab1KVAzi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Nov 2011 01:55:38 +0100
Received: by wwp14 with SMTP id 14so9135385wwp.24
        for <multiple recipients>; Mon, 21 Nov 2011 16:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=UR59dpucMtx33HLIdlDQGxv38z8nmrF82d7082OOOXY=;
        b=q0GjJTyiDOXuIkldwUlhmgGYFwIC5bn06QuG+khH3e2fyDtlefnMw3qUMOJ51WzEkJ
         XMFFIjgQokioLkZ4TuYLkqXF5uC/zzS3I5Ul6U7HwzZDXGhOBYq7gCELhfrikAVpthD4
         qmTZFixFYqLC5KfFFqZasY4BApImVJO4w6O8Q=
Received: by 10.227.198.213 with SMTP id ep21mr10417039wbb.18.1321923333103;
 Mon, 21 Nov 2011 16:55:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.216.151.168 with HTTP; Mon, 21 Nov 2011 16:55:13 -0800 (PST)
In-Reply-To: <4ECAF15E.1070008@caviumnetworks.com>
References: <1321567050-13197-1-git-send-email-ddaney.cavm@gmail.com>
 <alpine.DEB.2.00.1111171520130.20133@chino.kir.corp.google.com>
 <alpine.DEB.2.00.1111171522131.20133@chino.kir.corp.google.com>
 <4ECACF68.3020701@gmail.com> <CA+55aFwZxqHfEOemj+OJNKCj2toqGf3rkK-9iuS39L7iZsoH1Q@mail.gmail.com>
 <4ECAE314.9060209@gmail.com> <CA+55aFx==PGGLX9YXv1GOeTja4W0PSW8U4i8zkmtiZwqmFwHFw@mail.gmail.com>
 <4ECAF15E.1070008@caviumnetworks.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Nov 2011 16:55:13 -0800
X-Google-Sender-Auth: r5e_ivVufvRtZuHx83ZZAzJUmAk
Message-ID: <CA+55aFyiV-W_7zOuu26jsUsCDTxHh41z8sEgL0D94xFooAJxFA@mail.gmail.com>
Subject: Re: [patch] hugetlb: remove dummy definitions of HPAGE_MASK and HPAGE_SIZE
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Robin Holt <holt@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 31911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@linux-foundation.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18091

On Mon, Nov 21, 2011 at 4:48 PM, David Daney <ddaney@caviumnetworks.com> wrote:
>
> Really Linus, did you read the other half of the message you quoted?

Sorry no. It was just an automatic reaction along the lines of "oh
christ, is this argument still going on"?

I'm ok with magic gcc function attributes, although I still don't see
why you need that symbol so badly.

Quite frankly, some MIPS-only patch is *not* important-enough to worry
about this. I'd rather have the simpler "that symbol doesn't exist,
and MIPS just needs an #ifdef".

I realize that we *used* to have code that did that

   if (something_that_evaluates_to_zero) {
       .. use HPAGE_MASK ..

but considering that we don't have that any more and people are happy,
I'm not all that convinced that we need to try to re-introduce it.

                     Linus
