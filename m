Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Apr 2012 05:32:10 +0200 (CEST)
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37911 "EHLO
        mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901162Ab2DTDbw convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Apr 2012 05:31:52 +0200
Received: by wibhj13 with SMTP id hj13so203011wib.6
        for <multiple recipients>; Thu, 19 Apr 2012 20:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=8FwXxm+WvxrMAhBYvHruxaW+jhinBcJb69k6moG6XOY=;
        b=n7wcdRY1tQDd/nQGHdm0jE/A6Rnbkt16CICUwbw3yOSVFSLtxHKaFGDCiyaPsq/Vn0
         ci2Vehqti7vQpDTgTu0n0KXuOgseosas582phSvWggAUdc3TLs+ObmpjOX+f8RKx9X0U
         NcrUI9Eoe+1Y5xBJM+6fqgec4zwLs4SPWSmCW1Y46sF4DQxZZQXNCbZqBwV+uk1gQxhM
         2T5iWSZpne+TFqLXz/dATP9obmd0NFjCZ6kkCSLYbHkyfnrFVnZblW0hesf2ykhdSV5F
         rA+VZiMpG+s71/ogQtrLGVZs7Fie7V2ZzCL/exb/nJIdo0y7zlamr4G+9nlvelW3pgOf
         xiHw==
Received: by 10.180.92.130 with SMTP id cm2mr11066626wib.4.1334892706700; Thu,
 19 Apr 2012 20:31:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.216.221.167 with HTTP; Thu, 19 Apr 2012 20:31:26 -0700 (PDT)
In-Reply-To: <4F90D564.3090508@gmail.com>
References: <1334872799-14589-1-git-send-email-ddaney.cavm@gmail.com>
 <1334872799-14589-2-git-send-email-ddaney.cavm@gmail.com> <4F90BF8D.7030209@zytor.com>
 <4F90D564.3090508@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Apr 2012 20:31:26 -0700
X-Google-Sender-Auth: USVa9jjoSVK7eSDuOJ-VMhazYAM
Message-ID: <CA+55aFyijf43qSu3N9nWHEBwaGbb7T2Oq9A=9EyR=Jtyqfq_cQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] scripts: Add sortextable to sort the kernel's
 exception table.
To:     David Daney <david.s.daney@gmail.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Michal Marek <mmarek@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Daney <david.daney@cavium.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 32988
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@linux-foundation.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, Apr 19, 2012 at 8:17 PM, David Daney <david.s.daney@gmail.com> wrote:
>
> I hadn't considered that the image was relocatable.  Our MIPS kernels never
> have relocations.
>
> I am working on a version of this that handles the relocations.  It
> shouldn't be too difficult.

It might be better to just make the rule be that we don't have
relocations there - make everything relative to the start of the code
segment or something.

On x86, we already use that _ASM_EXTABLE() macro to hide the
differences between x86-64 and x86-32. So it should be be somewhat
easy to make that same macro make it relative to the code start, and
at the same time also make the exception table perhaps be two 32-bit
words rather than two pointers.

So it would shrink the exception table and avoid relocations at the
same time. Win-win. No?

                      Linus
