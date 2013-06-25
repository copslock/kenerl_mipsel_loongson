Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jun 2013 00:13:37 +0200 (CEST)
Received: from mail-bk0-f48.google.com ([209.85.214.48]:40847 "EHLO
        mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827823Ab3FYWNgPCPsi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Jun 2013 00:13:36 +0200
Received: by mail-bk0-f48.google.com with SMTP id jf17so4579105bkc.7
        for <linux-mips@linux-mips.org>; Tue, 25 Jun 2013 15:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:x-originating-ip:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :x-gm-message-state;
        bh=5DyGTim/yIitwhgXScoQLUQvA8bPTme+5tobLVbowWg=;
        b=kwTSvzTbwBzfirOzVvK9kTAQL4fLXaVR9l8+gcy3x2ECrZtc8vPhjn8dTkdTENVpkW
         fk/hs0apZevYL2ZlfCs9CKlhZ3x1iUNeKWOXXujgsmknUFLT1LRD0R8/caxqluonA5qQ
         Q2cj6Y0qY8eA+MUYLzNuMDRyG9w/n+IeOkJw+DDXZ/3H+59PQvLmfGhjCSEe6gQa6Aw2
         nFrC6rBPnPaU3+RHWhIoraVRJIgtetZNQQU0wwjvbKPMH+AaE8da6HasgGaHHE3Gc8qg
         e927PjHE9EQY/34gChnVvXYGnot1cqykdO3N2q6/KFtOsJYpfjGbAl8d6QLhDFen3NNQ
         azPQ==
MIME-Version: 1.0
X-Received: by 10.205.134.198 with SMTP id id6mr122653bkc.121.1372198410417;
 Tue, 25 Jun 2013 15:13:30 -0700 (PDT)
Received: by 10.204.188.143 with HTTP; Tue, 25 Jun 2013 15:13:30 -0700 (PDT)
X-Originating-IP: [212.159.75.221]
In-Reply-To: <20130625144015.1e4e70a0ac888f4ccf5c6a8f@linux-foundation.org>
References: <1371821962-9151-1-git-send-email-james.hogan@imgtec.com>
        <51C47864.9030200@gmail.com>
        <20130621202244.GA16610@redhat.com>
        <51C4BB86.1020004@caviumnetworks.com>
        <20130622190940.GA14150@redhat.com>
        <51C80CF0.4070608@imgtec.com>
        <20130625144015.1e4e70a0ac888f4ccf5c6a8f@linux-foundation.org>
Date:   Tue, 25 Jun 2013 23:13:30 +0100
X-Google-Sender-Auth: Y9pQ2NPq1hJRJdLYCH3Asj4-jTM
Message-ID: <CAAG0J9-5J6=c=1VxEW6FevMHKsjShtbjM8G6Q1vu1P+LurQqoQ@mail.gmail.com>
Subject: Re: [PATCH v3] kernel/signal.c: fix BUG_ON with SIG128 (MIPS)
From:   James Hogan <james.hogan@imgtec.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        David Daney <ddaney@caviumnetworks.com>,
        David Daney <ddaney.cavm@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        David Daney <david.daney@cavium.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Dave Jones <davej@redhat.com>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-Gm-Message-State: ALoCoQlPe01XDNpRtcRh7w7mTkrf+J8ZQ22wOoqOjzT9hySWs5+PU+Fdn63rLeQSsfDngAvXhhwD
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

On 25 June 2013 22:40, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Mon, 24 Jun 2013 10:10:08 +0100 James Hogan <james.hogan@imgtec.com> wrote:
>
>> On 22/06/13 20:09, Oleg Nesterov wrote:
>> > On 06/21, David Daney wrote:
>> >> I am proposing that we just reduce the number of usable signals such
>> >> that existing libc status checking macros/functions don't change in any
>> >> way.
>> >
>> > And I fully agree! Absolutely, sorry for confusion.
>> >
>> >
>> > What I tried to say, _if_ we change the ABI instead, lets make this
>> > change sane.
>>
>> I agree that this approach isn't very nice (I was really just trying to
>> explore the options) and reducing the number of signals is nicer. But is
>> anybody here confident enough that the number of signals changing under
>> the feet of existing binaries/libc won't actually break anything real?
>> I.e. anything trying to use SIGRTMAX() to get a lower priority signal.
>
> Meanwhile, unprivileged users can make a MIPS kernel go BUG.
>
> How much of a problem is this?  Obviously less of a problem with MIPS
> than it would be with some other CPU types, but I'd imagine it's still
> awkward in some environments.
>
> If this _is_ considered a problem, can we think of some nasty little
> hack which at least makes the effects less damaging, which we can also
> put into -stable kernels?

The first rfc patch I sent sort of satisfies that by passing 127 if
sig==128, or slightly better would be passing 126 if sig>=127 (so that
SIFSIGNALED returns true). Effectively #ifdef'ing it on _NSIG>127 as
this patch does may be preferable too.

That's probably the minimum change necessary to evade the BUG_ON
without removing it. The wait status code will still be wrong, but it
wasn't exactly right before so it's no worse.

IMO changing the ABI by reducing _NSIG to 127 or 126 isn't appropriate
for stable.

Cheers
James
