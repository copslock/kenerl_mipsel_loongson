Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Mar 2015 16:19:28 +0100 (CET)
Received: from mail-vc0-f171.google.com ([209.85.220.171]:59020 "EHLO
        mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013978AbbCQPT0P0KQh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Mar 2015 16:19:26 +0100
Received: by mail-vc0-f171.google.com with SMTP id im6so2559284vcb.2
        for <linux-mips@linux-mips.org>; Tue, 17 Mar 2015 08:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=fjwfIknU/HHwUwpS1vO6Il3CvnSbJj70AMewKo8V7yE=;
        b=W1OjhBEp6ejMt3VkqCjB5i5MWdrre/Gg0Tt/bY+2TZPhFVsyU/XfjClmsdB981yvrl
         g3U1FimK81ugszipi6gU1fooTqm2NP5B8iV4VkkPKpZpNDh29T61e5T8yjPA4QJBruJ5
         KQeXI9O40DIgqYEAChrLVkBmOgtQla7xKFpZG4YEWrRb15zAKXvnjOvwzfZpSDAdacqK
         qP/ftLqE45IPRdvGe8fJ0tMiDcuxTH50NqAUhLziD/jW6W36Gg2OfZQUmAvYx9G6FCi7
         yPybuG1t0dD8sJbWxSS/SCD5jQ+8uxIvRmSbTLa0HgAuWI77tZh4C61ANpqUDG8MhY21
         OfBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=fjwfIknU/HHwUwpS1vO6Il3CvnSbJj70AMewKo8V7yE=;
        b=glxMNABXT3/iqBrIZ3aQvC9g25vxswTPqUZ7y9AuS2KaKWS/G8+Q0H0g3L5uL1BFCP
         8aQsHLrM/7kzK41yCncG9+MG+sS7douGMDU9ReuAMZVe4VYP2gTrhMw4xVzVyG5l38M3
         v25DS6NZQuOxDcalBWIN2W3a18ftUzLZKSHC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=fjwfIknU/HHwUwpS1vO6Il3CvnSbJj70AMewKo8V7yE=;
        b=LSQjIk67xGJPgIosHS0tshBCjNImcQbx35aZ+MRB9izq5xVGpSIao/Fdqf5eyfomqX
         ZtW+z3FZw1uxxA23nGAsMsbyEp06aylu4OAUHa8bikmuO/3xhSj1rQd6BR5lVR03GPNf
         e/YNPxT9VNqPQOMOEqIeb49beEsedwthj0q91ZTSPkIG6hWTHOTSj7idxTRwixvK1mRL
         910riAoteYrcQkIY8Mjz1ihtD9SRK5WvzszS3r7G5sgBwSCtH/YsAPSa33fpedi6Plv+
         DaTAd9IZ5lwpaXT2bgA1cqnJKjfq+zKgOu9450Kw2Xw73xmty6eSlFq/jMBggYqhy0OZ
         U6kg==
X-Gm-Message-State: ALoCoQkPVrR0QAW/O+Ad/n+tw9jSXagr9LZ9hmcTpm08qjzTZqOljso3y7g0oFO+6WRGudS4cw2s
MIME-Version: 1.0
X-Received: by 10.52.160.69 with SMTP id xi5mr13200602vdb.58.1426605561030;
 Tue, 17 Mar 2015 08:19:21 -0700 (PDT)
Received: by 10.52.172.35 with HTTP; Tue, 17 Mar 2015 08:19:20 -0700 (PDT)
In-Reply-To: <20150317144702.GN8399@arm.com>
References: <1425503454-7531-1-git-send-email-keescook@chromium.org>
        <1425503454-7531-4-git-send-email-keescook@chromium.org>
        <20150317144702.GN8399@arm.com>
Date:   Tue, 17 Mar 2015 08:19:20 -0700
X-Google-Sender-Auth: T07ytXwOJ9bMMZ_Y3kgrTmxcFM0
Message-ID: <CAGXu5jKHPL1V81wQ-gLAmGeMD9miM73X-QAL_RHbt+6hAEaAKg@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] arm64: standardize mmap_rnd() usage
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Ismael Ripoll <iripoll@upv.es>,
        Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "linux390@de.ibm.com" <linux390@de.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "David A. Long" <dave.long@linaro.org>,
        Andrey Ryabinin <a.ryabinin@samsung.com>,
        Arun Chandran <achandran@mvista.com>,
        Yann Droneaud <ydroneaud@opteya.com>,
        Min-Hua Chen <orca.chen@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Vineeth Vijayan <vvijayan@mvista.com>,
        Jeff Bailey <jeffbailey@google.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Borislav Petkov <bp@suse.de>,
        =?UTF-8?Q?Jan=2DSimon_M=C3=B6ller?= <dl9pf@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

On Tue, Mar 17, 2015 at 7:47 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Mar 04, 2015 at 09:10:47PM +0000, Kees Cook wrote:
>> In preparation for splitting out ET_DYN ASLR, this refactors the use of
>> mmap_rnd() to be used similarly to arm and x86. This additionally enables
>> mmap ASLR on legacy mmap layouts, which appeared to be missing on arm64,
>> and was already supported on arm. Additionally removes a copy/pasted
>> declaration of an unused function.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  arch/arm64/include/asm/elf.h |  1 -
>>  arch/arm64/mm/mmap.c         | 18 +++++++++++-------
>>  2 files changed, 11 insertions(+), 8 deletions(-)
>
> Looks fine to me:
>
>   Acked-by: Will Deacon <will.deacon@arm.com>
>
> Do you want me to pick this up, or are you taking it along with the rest of
> your series (it doesn't have any obvious dependencies to me)?

Thanks! Right now akpm is carrying it, since the series ends with
changes that depend on all the per-arch refactoring.

-Kees

-- 
Kees Cook
Chrome OS Security
