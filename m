Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Feb 2012 18:06:04 +0100 (CET)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:55011 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901351Ab2BRRGA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 18 Feb 2012 18:06:00 +0100
Received: by pbcun1 with SMTP id un1so5694934pbc.36
        for <linux-mips@linux-mips.org>; Sat, 18 Feb 2012 09:05:54 -0800 (PST)
Received-SPF: pass (google.com: domain of david.s.daney@gmail.com designates 10.68.195.73 as permitted sender) client-ip=10.68.195.73;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of david.s.daney@gmail.com designates 10.68.195.73 as permitted sender) smtp.mail=david.s.daney@gmail.com; dkim=pass header.i=david.s.daney@gmail.com
Received: from mr.google.com ([10.68.195.73])
        by 10.68.195.73 with SMTP id ic9mr43382716pbc.72.1329584754020 (num_hops = 1);
        Sat, 18 Feb 2012 09:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ofjvcW+huBFnj4YUG9kHeehWp+pd/TGS3sKdPTgy0Wk=;
        b=UAh1tx8YOKYypGYY/wdBezVVbG1fdYpvuVYjdlObAQPeBuNEb5yYl06Gc2IG2VGt3f
         ONBC0/xnTfCv5Thl+asNdV4xyH9awb91SSRnVFm1OsXwrZxZOP2GabS1aQ7CgXe92b75
         DnF+VzclYkSDlUv1rDiZEYRiNBSKsM9GBQBAE=
Received: by 10.68.195.73 with SMTP id ic9mr35456479pbc.72.1329584753984;
        Sat, 18 Feb 2012 09:05:53 -0800 (PST)
Received: from dd_xps.caveonetworks.com (ppp-67-124-89-155.dsl.pltn13.pacbell.net. [67.124.89.155])
        by mx.google.com with ESMTPS id y5sm8301394pbk.45.2012.02.18.09.05.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 18 Feb 2012 09:05:53 -0800 (PST)
Message-ID: <4F3FDA70.9060304@gmail.com>
Date:   Sat, 18 Feb 2012 09:05:52 -0800
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.1) Gecko/20120209 Thunderbird/10.0.1
MIME-Version: 1.0
To:     Alan Cooper <alcooperx@gmail.com>
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: Stack unwind across signal frame
References: <CAOGqxeWjtr=SOY83ZFEdwJXXatqLLEN6SHre9-0DfeJfcyBhKQ@mail.gmail.com>
In-Reply-To: <CAOGqxeWjtr=SOY83ZFEdwJXXatqLLEN6SHre9-0DfeJfcyBhKQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32468
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 02/17/2012 01:13 PM, Alan Cooper wrote:
> I'm seeing a problem on both 2.6.37 and 3.3 MIPS kernels where I can't
> unwind through a MIPS signal frame.
You don't tell us the version of the unwinder (likely from libgcc) you 
are using.  There was a lot of work in this area four or five years ago, 
I didn't take the time to do the required archaeology to determine the 
exact patch, but likely you are missing this.

>   It looks like this is caused by
> the VDSO code that was added 2/2010.
Some CPUs have errata necessitating a different signal frame layout, on 
these CPUs, you wouldn't be able to unwind either, even pre mips-vdso.

>   When the unwinder tries to find
> the frame info for the caller of the signal handler (the trampoline in
> VDSO), it can't find the eh_frame info because the address is in the
> VDSO area and stops unwinding. It looks like other platforms solve
> this by adding the eh_frame info for the VDSO area so the lookup
> works.

That's right.  However all 'modern' GCCs and GDBs can unwind through 
signal frames on all 2.4.x and later kernels.  I would recommend 
upgrading your GCC to 4.6.2, and see if you obtain better results.

> This problem ends up breaking pthread cleanup for C++ programs because
> the cleanup is done using a class with the expectation that the
> destructor will be called when the thread gets canceled by a cancel
> signal. This seems like a big problem for all current MIPS kernels so
> I was wondering if I'm missing something?

A modern libgcc I think.

>
> If this is correct, then it seems like the best solution would be to
> add the VDSO eh_frame info to MIPS.

Having a correct eh_frame in the vdso, would be nice, but is not the 
highest priority for me.


David Daney
