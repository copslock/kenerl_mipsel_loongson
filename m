Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2011 00:57:41 +0200 (CEST)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:54226 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491181Ab1C2W5i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Mar 2011 00:57:38 +0200
Received: by iyb39 with SMTP id 39so742993iyb.36
        for <linux-mips@linux-mips.org>; Tue, 29 Mar 2011 15:57:30 -0700 (PDT)
Received: by 10.43.44.137 with SMTP id ug9mr143743icb.175.1301439450135; Tue,
 29 Mar 2011 15:57:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.231.15.76 with HTTP; Tue, 29 Mar 2011 15:57:10 -0700 (PDT)
X-Originating-IP: [217.65.98.56]
In-Reply-To: <4D8ED363.9050001@gmail.com>
References: <AANLkTinDFQFLiHZoKw2kPpVov80xc08FFxLjYsORKyKd@mail.gmail.com> <4D8ED363.9050001@gmail.com>
From:   Gergely Kis <gergely@homejinni.com>
Date:   Wed, 30 Mar 2011 00:57:10 +0200
Message-ID: <AANLkTinJdwqL=OrCYfUcrd7j-h9vtT0F02T8ntzxQbK8@mail.gmail.com>
Subject: Re: Oprofile callgraph support on the MIPS architecture
To:     David Daney <david.s.daney@gmail.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <gergely@homejinni.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29620
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gergely@homejinni.com
Precedence: bulk
X-list: linux-mips

Dear David,

On Sun, Mar 27, 2011 at 8:04 AM, David Daney <david.s.daney@gmail.com> wrote:
[...]
>
>> You may download the code and access the documentation on the following
>> URL:
>> http://oss.homejinni.com/redmine/projects/mips-oprofile
>>
>
> Instructions for submitting patches may be found here:
>
> http://git.linux-mips.org/?p=linux.git;a=tree;f=Documentation/development-process;hb=f70c04ff7ad61bca1ed06390558568c6c8074139

Thank you for the pointer, we of course plan to submit the patch using
the proper process. We only wanted to announce that we are working on
this.

>
> That said, how do you handle the case of getting a fault while reading
> code/data while unwinding?
>
In case there is a fault, we basically return to the caller, so the
building of the callgraph is stopped. We looked at the ARM version and
they handled this case in a similar way.

> Also I don't see how you handle these cases:
>
> o Leaf functions where neither the $ra is saved to the stack, nor the stack
> pointer adjusted.
>
We currently don't have a special handling for this, but we plan to
try to detect the prologue of leaf functions as well, if possible.
This detection process will probably never be
100% accurate, but we have found the call graph outputs even in their
current form useful.

Oprofile call graphs are not always accurate anyways, because of the
statistical nature of oprofile.

> o Functions where $sp is adjusted several times (use of alloca() or VLAs).
>
> o Functions with multiple return points (i.e. 'jr $ra' in the middle of a
> function).
Yes, this is a shortcoming in the current implementation, we are
already working on changing the prologue detection to detect the exact
combination of the prologue instructions.

We are also looking at the stack unwinding function used to display
the kernel stacktraces when an oops or other error condition occurs,
to see if we can refactor it to suit our needs as well. This way a
single solution for stack walking could be included in the kernel.

>
> o Functions with more than 1024 instructions.
Currently we set this (arbitrary) limit. We can probably change it, or
make it configurable, but until we are using heuristics to detect the
function boundaries, I think we should have a maximum number of
allowed steps for the stack walking functions.

What do you think?

Thank you,
Gergely Kis
