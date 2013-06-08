Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 22:16:34 +0200 (CEST)
Received: from mail-we0-f180.google.com ([74.125.82.180]:57262 "EHLO
        mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825887Ab3FHUQdHBF1J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 22:16:33 +0200
Received: by mail-we0-f180.google.com with SMTP id w56so3863765wes.39
        for <multiple recipients>; Sat, 08 Jun 2013 13:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=giLbHgVXgJhMqVPMQE+7Tdb/gH9iT0SSVs3Itw7fr24=;
        b=cKM3rmWEEsMI+QrOOLmB+0rrZHPM0WyDCeO5dGy03z/0z+cwoNxKpklrQC4sk9JZGf
         Dkd5ibUhOnu2X2jsErF1yj+gHYZmSzDOl7MPvX9EYyflIcU7Dgil3ShWlh4mxxrI4FRx
         8E5TFPjkgXVCzbJuJbt+OFZdezFA3K2AJKefL9CwrYc/csF0T+jMQ3pCcvCLZ71OVPKs
         qwd4PBPnI91qTCr6/UqQ1bEe6TMYPWYStavWVy42PGxdOXxsR+CEk/pd/8miwkdvuimb
         4umMipxi57F0DF1CsGapZT0TpzPH8ApkPu0B7LuNEdguVsuSfWSiagbTATADEVocMfcP
         YiuQ==
X-Received: by 10.180.126.101 with SMTP id mx5mr1477536wib.48.1370722587431;
 Sat, 08 Jun 2013 13:16:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.216.70.146 with HTTP; Sat, 8 Jun 2013 13:15:47 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.03.1306081907130.21418@linux-mips.org>
References: <1369315716-7408-1-git-send-email-manuel.lauss@gmail.com> <alpine.LFD.2.03.1306081907130.21418@linux-mips.org>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Sat, 8 Jun 2013 22:15:47 +0200
Message-ID: <CAOLZvyG+eVq_6QQL=vo21oK9kkADaThWVAE4=3b4usaPuZNFFQ@mail.gmail.com>
Subject: Re: [PATCH v2] MIPS: Alchemy: fix wait function
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

On Sat, Jun 8, 2013 at 8:18 PM, Maciej W. Rozycki <macro@linux-mips.org> wrote:
> On Thu, 23 May 2013, Manuel Lauss wrote:
>
>> Only an interrupt can wake the core from 'wait', enable interrupts
>> locally before executing 'wait'.
>>
>> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
>> ---
>> Ralf made me aware of the race in between enabling interrupts and
>> entering wait.  While this patch does not eliminate it, it shrinks it
>> to 1 instruction.  It's not perfect, but lets Alchemy boot until a
>> more sophisticated solution (like __r4k_wait) can be implemented
>> without having to duplicate the interrupt exception handler.
>
>  I suggest double-checking with Alchemy documentation, but I doubt there
> is a race here, the write-back pipeline stage of MTC0 should overlap with
> the execution stage of WAIT, so assuming interrupts were previously
> disabled there should be no window between setting CP0.Status.IE and
> executing WAIT that would permit an interrrupt exception to be taken.

That was my thinking as well.  The Alchemy manuals (at least the ones I have)
don't specify the stage where c0 writes complete or 'wait' executes, but the
wording on how and when exceptions are raised makes me believe the
scheme above is race-free.


>  There is a bug in your change however.
[...]
>  You can't just take $8 away under the feet of GCC without telling the
> compiler, it may be storing some data there across the asm.  Rather than
> picking an arbitrary register as a clobber I suggest using an output
> register constraint associated with a scratch variable (depending on
> register usage GCC may possibly be able to reuse the same register both
> for input and for output).

I've fixed that, and sent out a new patch.

Thank you very much!
        Manuel
