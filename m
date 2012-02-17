Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2012 22:14:04 +0100 (CET)
Received: from mail-vx0-f177.google.com ([209.85.220.177]:52595 "EHLO
        mail-vx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903696Ab2BQVOA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Feb 2012 22:14:00 +0100
Received: by vcbf1 with SMTP id f1so3346191vcb.36
        for <linux-mips@linux-mips.org>; Fri, 17 Feb 2012 13:13:54 -0800 (PST)
Received-SPF: pass (google.com: domain of alcooperx@gmail.com designates 10.52.29.241 as permitted sender) client-ip=10.52.29.241;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of alcooperx@gmail.com designates 10.52.29.241 as permitted sender) smtp.mail=alcooperx@gmail.com; dkim=pass header.i=alcooperx@gmail.com
Received: from mr.google.com ([10.52.29.241])
        by 10.52.29.241 with SMTP id n17mr4914223vdh.123.1329513234604 (num_hops = 1);
        Fri, 17 Feb 2012 13:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=LppqU253m/LCE42418D3LZxx/9PAq2ucoAFMMsp94FY=;
        b=YgycvGy01Gwe5cjj2q0V8L2ZiYMO4r4VDGzZL6I0enewXyFwKnb5pfZtqPshsPTmWP
         MVVQjkysofpy7CN5YpOtkhs5FVYLewY1cg9QSYAq/uMHgaNJMn2SQraxI6feuQJQ9gA2
         RaFYMZJQlf3lIG+MIWdrBhAuUIyPEIeiVhiyg=
MIME-Version: 1.0
Received: by 10.52.29.241 with SMTP id n17mr3962855vdh.123.1329513234564; Fri,
 17 Feb 2012 13:13:54 -0800 (PST)
Received: by 10.220.89.12 with HTTP; Fri, 17 Feb 2012 13:13:54 -0800 (PST)
Date:   Fri, 17 Feb 2012 16:13:54 -0500
Message-ID: <CAOGqxeWjtr=SOY83ZFEdwJXXatqLLEN6SHre9-0DfeJfcyBhKQ@mail.gmail.com>
Subject: Stack unwind across signal frame
From:   Alan Cooper <alcooperx@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 32465
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alcooperx@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

I'm seeing a problem on both 2.6.37 and 3.3 MIPS kernels where I can't
unwind through a MIPS signal frame. It looks like this is caused by
the VDSO code that was added 2/2010. When the unwinder tries to find
the frame info for the caller of the signal handler (the trampoline in
VDSO), it can't find the eh_frame info because the address is in the
VDSO area and stops unwinding. It looks like other platforms solve
this by adding the eh_frame info for the VDSO area so the lookup
works.

This problem ends up breaking pthread cleanup for C++ programs because
the cleanup is done using a class with the expectation that the
destructor will be called when the thread gets canceled by a cancel
signal. This seems like a big problem for all current MIPS kernels so
I was wondering if I'm missing something?

If this is correct, then it seems like the best solution would be to
add the VDSO eh_frame info to MIPS.

Thanks
Al Cooper
