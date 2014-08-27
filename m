Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Aug 2014 03:45:12 +0200 (CEST)
Received: from mail-we0-f177.google.com ([74.125.82.177]:57486 "EHLO
        mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006947AbaH0BpLlLpgO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Aug 2014 03:45:11 +0200
Received: by mail-we0-f177.google.com with SMTP id w62so15490787wes.36
        for <linux-mips@linux-mips.org>; Tue, 26 Aug 2014 18:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=cKC/8VlEd/NAud15G1PcL5qY+k9yEITm7xgVhaARBjE=;
        b=YzdnYv/yi7wC0JOhdY+AtE8VESTvwzMA+P2ed0tMZRmLoETPceNXFLjBrTJZAAo/83
         iMJPbZk74bQa+wxX1mW6TvZ9JTo0F+ekwJ07+OV20EJfetJeRRhyw+SaAmq8gJo+iZum
         MgnmjzhU3GNlnMGFM9JUsn9/+ak01xvgp473wcIoLizD4h75MXTzMYqML7c27Jq1eTwF
         vpKmD4iNHbIC9NPo6BUHy9EAAjNPFhkMs41ubsVyJIj4xTQR6E9+AhryvfwhwNHq9Le0
         cFurU4I6luMqGhuMVUJ31H7WC2W9MNTLISWuv2rG1BVHv25v+scQ+XitAacSTT/bGKKA
         dmMg==
X-Gm-Message-State: ALoCoQnF0PbAY5oUlUtdjJo4Yu2oxBpeD08GbtOrNZEelK1yGPJmDlGeGUn0itsuZFX5xWLIRhK6
MIME-Version: 1.0
X-Received: by 10.180.160.229 with SMTP id xn5mr2302075wib.64.1409103906446;
 Tue, 26 Aug 2014 18:45:06 -0700 (PDT)
Received: by 10.194.47.42 with HTTP; Tue, 26 Aug 2014 18:45:06 -0700 (PDT)
In-Reply-To: <CALCETrUaZ8w92g96SmFEZDE0Jr+0Moeo+S24-TyW8crrK5reSg@mail.gmail.com>
References: <CALCETrUaZ8w92g96SmFEZDE0Jr+0Moeo+S24-TyW8crrK5reSg@mail.gmail.com>
Date:   Tue, 26 Aug 2014 18:45:06 -0700
Message-ID: <CAMEtUuwZPn+hY6BTz6jj+TJHFWjhyOVFZGj_Brw9DE9YjiTbrQ@mail.gmail.com>
Subject: Re: Post-merge-window ping (Re: [PATCH v4 0/5] x86: two-phase syscall
 tracing and seccomp fastpath)
From:   Alexei Starovoitov <ast@plumgrid.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>, X86 ML <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Frederic Weisbecker <fweisbec@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <ast@plumgrid.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ast@plumgrid.com
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

On Tue, Aug 26, 2014 at 6:32 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Mon, Jul 28, 2014 at 8:38 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>> This applies to:
>> git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git seccomp-fastpath
>>
>> Gitweb:
>> https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git/log/?h=seccomp/fastpath
>
> Hi all-
>
> AFAIK the only thing that's changed since I submitted it is that the
> 3.17 merge window is closed.  Kees rebased the tree this applies to,
> but I think the patches all still apply.  What, if anything, do I need
> to do to help this along for 3.18?
>

+1
I think it's not just an optimization of seccomp path, but I feel
in the future it will help me speedup syscall tracepoints which
are quite slow right now comparing to kprobes...
