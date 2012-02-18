Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Feb 2012 08:12:33 +0100 (CET)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:62432 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901167Ab2BRHM2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 18 Feb 2012 08:12:28 +0100
Received: by vbbfs19 with SMTP id fs19so3553857vbb.36
        for <linux-mips@linux-mips.org>; Fri, 17 Feb 2012 23:12:22 -0800 (PST)
Received-SPF: pass (google.com: domain of dhillf@gmail.com designates 10.52.28.167 as permitted sender) client-ip=10.52.28.167;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of dhillf@gmail.com designates 10.52.28.167 as permitted sender) smtp.mail=dhillf@gmail.com; dkim=pass header.i=dhillf@gmail.com
Received: from mr.google.com ([10.52.28.167])
        by 10.52.28.167 with SMTP id c7mr5583953vdh.96.1329549142676 (num_hops = 1);
        Fri, 17 Feb 2012 23:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vWOHIIWiSdQweA71n8SaZ1RMGpd4ClwjynZvQ0+SxAI=;
        b=bJNOL5qZzplGl4aBddsMYYai7VcM70WO1OmY61ZLUgNh17/BcidhgNdgBbAWzkRtHD
         Mc66HB7X4xwuiEZMS6xgDlh5r5R2BaeocD4iQimrDP0xbblu1IPSUYucARD7HIpUBBZ+
         ssEZu2Iyp1XQdDt9WyrYs67vn1DAdETESguL0=
MIME-Version: 1.0
Received: by 10.52.28.167 with SMTP id c7mr4525908vdh.96.1329549142627; Fri,
 17 Feb 2012 23:12:22 -0800 (PST)
Received: by 10.220.68.77 with HTTP; Fri, 17 Feb 2012 23:12:22 -0800 (PST)
In-Reply-To: <CAOGqxeWjtr=SOY83ZFEdwJXXatqLLEN6SHre9-0DfeJfcyBhKQ@mail.gmail.com>
References: <CAOGqxeWjtr=SOY83ZFEdwJXXatqLLEN6SHre9-0DfeJfcyBhKQ@mail.gmail.com>
Date:   Sat, 18 Feb 2012 15:12:22 +0800
Message-ID: <CAJd=RBAmVcJBS_WdUwBYVDAOz+rBvxNER=Q1r7Q0cyuWiQ1gcQ@mail.gmail.com>
Subject: Re: Stack unwind across signal frame
From:   Hillf Danton <dhillf@gmail.com>
To:     Alan Cooper <alcooperx@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 32467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhillf@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sat, Feb 18, 2012 at 5:13 AM, Alan Cooper <alcooperx@gmail.com> wrote:
> This problem ends up breaking pthread cleanup for C++ programs because
> the cleanup is done using a class with the expectation that the
> destructor will be called when the thread gets canceled by a cancel
> signal. This seems like a big problem for all current MIPS kernels so
> I was wondering if I'm missing something?
>
> If this is correct, then it seems like the best solution would be to
> add the VDSO eh_frame info to MIPS.
>
Feel free to send a patch after testing;)
