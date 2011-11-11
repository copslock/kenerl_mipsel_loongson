Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2011 14:39:13 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:40490 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903966Ab1KKNjG convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Nov 2011 14:39:06 +0100
Received: by wwp14 with SMTP id 14so1745665wwp.24
        for <multiple recipients>; Fri, 11 Nov 2011 05:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ahZ4YIXWvY15vNjq86Bfiopz3TnoEBQb5+YfrJSlfDE=;
        b=cQhUrDX0vBBLD5OXHyN2fwbUf0kyDKLtLO8w4naHeLD0INn7SYZ9yTLVBA+yv2UUxR
         cd88rpT+tPAumY5GDclOtHbR0OSJCTnru3AmFvCovpkrWyeQLcHsIwWsBYusVaomU1hT
         Fp4NXn8gHtGq2AYeHixA4Z3CLelZEFfv2J8u4=
MIME-Version: 1.0
Received: by 10.227.204.135 with SMTP id fm7mr7972476wbb.2.1321018740261; Fri,
 11 Nov 2011 05:39:00 -0800 (PST)
Received: by 10.216.45.11 with HTTP; Fri, 11 Nov 2011 05:39:00 -0800 (PST)
In-Reply-To: <20111111125436.GD28303@linux-mips.org>
References: <cover.1321010998.git.jayachandranc@netlogicmicro.com>
        <7a1a9bad5b110e931f1662ebaae4c0164d4dcc84.1321011002.git.jayachandranc@netlogicmicro.com>
        <20111111125436.GD28303@linux-mips.org>
Date:   Fri, 11 Nov 2011 21:39:00 +0800
Message-ID: <CAJd=RBA6OBq9PucheeAmzcphPRMPyDdwOOKQuQh7Lq7p37-g4A@mail.gmail.com>
Subject: Re: [PATCH 12/12] MIPS: Netlogic: Mark Netlogic chips as SMT capable
From:   Hillf Danton <dhillf@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        "Jayachandran C." <jayachandranc@netlogicmicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 31560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhillf@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10296

With Jayachandran Cced

On Fri, Nov 11, 2011 at 8:54 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, Nov 11, 2011 at 05:11:08PM +0530, Hillf Danton wrote:
>> Date:   Fri, 11 Nov 2011 17:11:08 +0530
>> From: Hillf Danton <dhillf@gmail.com>
>
> Normally if you're resending other people's patches they should be sent
> out with your email in the email's From: header and with the patch
> author's name and Email address in a From: line in the first (important,
> otherwise git won't parse it right) of the body.  Somehow here Hillf
> ended up in the From: header which may be confusing, might upset him
> and might also trigger spam filters.
>
> No need to resend but you may want to fix that for the next batch of
> patches.
>
Hi  Ralf,

The patch was delivered by me, and reprepared under ideas and comments from
you and Jayachandran, thanks. It was fine tuned, and SOB, by Jayachandran, and
included in this patchset, which is far beyond my capability, for supporting
Netlogic chips. And please reconsider the patchset.

Thanks

Hillf
