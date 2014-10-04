Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Oct 2014 18:28:08 +0200 (CEST)
Received: from mail-vc0-f175.google.com ([209.85.220.175]:58414 "EHLO
        mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010519AbaJDQ2FY0zGH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Oct 2014 18:28:05 +0200
Received: by mail-vc0-f175.google.com with SMTP id id10so1754983vcb.20
        for <multiple recipients>; Sat, 04 Oct 2014 09:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gvaS6tRFMfbup2LDrZajewdbEGiTNnWB70caPJutIrI=;
        b=qMV1PoroHiSDpsCQdN+iAyA4+AJzFmgjlGy3leAZ13Toysv3E3FnAgUDlcH1A2EC2x
         zXc7LLBEo8ZwaYTf88W5PvmBU4hAv9RGNclslzB38pS7xuJKvmzCsN3wXI9HSezW8rsR
         9tKRn1jsKGZRoC03I0hmaBsvEs9GszPqV6B4hGicO8/wOBDDytHdsMMhWH8nb9MsU0MV
         hLGR18qnixjYiMG79c9WO3BAX0RV7auD01E75CMJRcuM5hfR7S9qH6RRezIVpMDfcKm2
         RZLbU549563ydgn159PftTYq5r5Qboy4DWU+O/mmNA+/oPbkx4XWE82MCSkx9+f6DZFG
         ouxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gvaS6tRFMfbup2LDrZajewdbEGiTNnWB70caPJutIrI=;
        b=Zoub5bYpW4vPbQSgF4wj43aSAsa/2n7OZjjwh6Uk4UlEYnV2JzGmabuNtKoVaNED1o
         qG/S/eFU7EK05qlzJRT6CqkJTPc9Y1gq8lmqGNmltQmmEs8vOJ5jJwZgvUhlFZP7YFAH
         T0ECu4nzU+luYapEECUYQXDeBldT108paNOf8=
MIME-Version: 1.0
X-Received: by 10.220.99.71 with SMTP id t7mr9517028vcn.8.1412440079279; Sat,
 04 Oct 2014 09:27:59 -0700 (PDT)
Received: by 10.220.3.148 with HTTP; Sat, 4 Oct 2014 09:27:59 -0700 (PDT)
In-Reply-To: <vi8ojsasknll8us53fy9myb8.1412439420039@email.android.com>
References: <20141004030438.28569.85536.stgit@linux-yegoshin>
        <20141004082307.GS10583@worktop.programming.kicks-ass.net>
        <CA+55aFynSp90n=jdUdmY7nq-9t4pHS82Tj-WfZOBfot7ip0hBw@mail.gmail.com>
        <vi8ojsasknll8us53fy9myb8.1412439420039@email.android.com>
Date:   Sat, 4 Oct 2014 09:27:59 -0700
X-Google-Sender-Auth: yV-MScZqvL-kBcDRi9G1NoFUpNs
Message-ID: <CA+55aFxqip0m=Ohd-+VDEkzahhLDe+fj9kXY0bbQY8YMBTEc4A@mail.gmail.com>
Subject: Re: [PATCH 0/3] MIPS executable stack protection
From:   Linus Torvalds <torvalds@linux-foundation.org>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Zubair Kakakhel <Zubair.Kakakhel@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Davidlohr Bueso <davidlohr@hp.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        "chenhc@lemote.com" <chenhc@lemote.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        James Hogan <James.Hogan@imgtec.com>,
        Kees Cook <keescook@chromium.org>,
        "alex@alex-smith.me.uk" <alex@alex-smith.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Crispin <blogic@openwrt.org>,
        "jchandra@broadcom.com" <jchandra@broadcom.com>,
        Paul Burton <Paul.Burton@imgtec.com>,
        Qais Yousef <Qais.Yousef@imgtec.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "lars.persson@axis.com" <lars.persson@axis.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus971@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42956
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@linux-foundation.org
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

On Sat, Oct 4, 2014 at 9:17 AM, Leonid Yegoshin
<Leonid.Yegoshin@imgtec.com> wrote:
> Linus, it works on CPU with hardware page table walker - MIPS P5600 aka Apache.
>
> I was involved in architecture development of HTW and took care of it.

Ok, as long as it works architecturally, per-thread TLB fills are fine by me.

             Linus
