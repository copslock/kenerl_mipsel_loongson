Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jan 2012 05:52:59 +0100 (CET)
Received: from mail-we0-f177.google.com ([74.125.82.177]:53294 "EHLO
        mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903546Ab2ADEwy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Jan 2012 05:52:54 +0100
Received: by wera10 with SMTP id a10so10792942wer.36
        for <multiple recipients>; Tue, 03 Jan 2012 20:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=B+Hs1D3cBDglGrIUVjtR/d91C5Uedcun7kJFDPEenF4=;
        b=pb7+iipf79zPMYREc0agwjI4x+Pu0FR+poVp1pXkJ195Gi47LIh8iIWFx5u7AMt6o1
         5M2g+cmqz5akFHGGlpeiPqnXEK2Qm4uE6tJSHz9VH+YBx+mrZ00WYhyP53V5rzrdH7hI
         agA6ZuJExBqjg48Hpin61qex+iYTgIVKPjMvY=
MIME-Version: 1.0
Received: by 10.216.134.156 with SMTP id s28mr35993147wei.12.1325652768539;
 Tue, 03 Jan 2012 20:52:48 -0800 (PST)
Received: by 10.181.13.169 with HTTP; Tue, 3 Jan 2012 20:52:48 -0800 (PST)
In-Reply-To: <CAFPAmTSi0i4q+mZ3KwVpEXiSoZ0=BeWUQgeSghd0PWPN+NojfA@mail.gmail.com>
References: <1324639362-18220-1-git-send-email-consul.kautuk@gmail.com>
        <CAFPAmTSi0i4q+mZ3KwVpEXiSoZ0=BeWUQgeSghd0PWPN+NojfA@mail.gmail.com>
Date:   Wed, 4 Jan 2012 10:22:48 +0530
Message-ID: <CAFPAmTR8hNzF0D+-XhbWDuhXosZLKj7xznr8jpg3x0=9XQFHDw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mips: fault.c: Port OOM changes to do_page_fault
From:   Kautuk Consul <consul.kautuk@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>, Ingo Molnar <mingo@elte.hu>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        "Mohd. Faris" <mohdfarisq2010@gmail.com>,
        Kautuk Consul <consul.kautuk@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 32209
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: consul.kautuk@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

>
> However, since the generic part of the kernel(mm/filemap.c) now
> supports killable and
> retryable page fault handling, I thought that this change would be
> valid for MIPS too.


Did anyone get a chance to review this patch?
