Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jun 2014 22:41:31 +0200 (CEST)
Received: from mail-vc0-f178.google.com ([209.85.220.178]:61630 "EHLO
        mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825887AbaFMUl2XRxGd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Jun 2014 22:41:28 +0200
Received: by mail-vc0-f178.google.com with SMTP id ij19so2816154vcb.23
        for <linux-mips@linux-mips.org>; Fri, 13 Jun 2014 13:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=dGENIU2zy0iTloSfFoTbdfEdaBn8qjYcPiVMNIEuVKQ=;
        b=mljIwkA7vn901WC0vB0AKbM1nv6Ul9V0xKcBqafh0vqdCQpDah5WjZmAXYrcvQ1RCl
         FxP/IclSqIHpNjxsnbaGFkheD4GV/+41HaR1ptCB6BOzkbNp7Jf4wrX/1hR+aYKHpo+j
         ajEZsgiRWxL3tkxX17cXvS/XQAiumpDGBzAd1gpNLJeHwJcL4Aw2Aa+3RKvl0eG246/M
         kQac1sr7rtRc/E2l8i/oGCwe88nWYCzEK4PqHDyzgfUjG/p0AC75HAXgmyHLI47ggUyy
         wmMLPcTugpTsHNSOQq29tRIGpNjNtMBzjs/QCIJx/m/iTwrJzaQPU/ZJc3eqHh6Zkk9I
         c8Pg==
X-Gm-Message-State: ALoCoQm/waR3kjYwI9IuvYbvSF6U9xTU+jJnrha8sgLdwNplZcnYFiuICNlcqVaybzg96Qd4i/pF
X-Received: by 10.221.40.193 with SMTP id tr1mr2752435vcb.31.1402692082182;
 Fri, 13 Jun 2014 13:41:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.58.91.40 with HTTP; Fri, 13 Jun 2014 13:41:02 -0700 (PDT)
In-Reply-To: <1402457121-8410-7-git-send-email-keescook@chromium.org>
References: <1402457121-8410-1-git-send-email-keescook@chromium.org> <1402457121-8410-7-git-send-email-keescook@chromium.org>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 13 Jun 2014 13:41:02 -0700
Message-ID: <CALCETrVYVB0pMj61T9ZCAhgL6WYHAdDjiDe81O0e4tTQLtjDiQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/9] seccomp: add "seccomp" syscall
To:     Kees Cook <keescook@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        David Drysdale <drysdale@google.com>,
        Alexei Starovoitov <ast@plumgrid.com>,
        John Johansen <john.johansen@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org,
        linux-arch <linux-arch@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@amacapital.net
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

On Tue, Jun 10, 2014 at 8:25 PM, Kees Cook <keescook@chromium.org> wrote:
> This adds the new "seccomp" syscall with both an "operation" and "flags"
> parameter for future expansion. The third argument is a pointer value,
> used with the SECCOMP_SET_MODE_FILTER operation. Currently, flags must
> be 0. This is functionally equivalent to prctl(PR_SET_SECCOMP, ...).

Question for the linux-abi people:

What's the preferred way to do this these days?  This syscall is a
general purpose "adjust the seccomp state" thing.  The alternative
would be a specific new syscall to add a filter with a flags argument.

--Andy
