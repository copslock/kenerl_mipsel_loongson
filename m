Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2016 07:06:45 +0200 (CEST)
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36586 "EHLO
        mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011414AbcC3FGn20fjN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Mar 2016 07:06:43 +0200
Received: by mail-ig0-f171.google.com with SMTP id nk17so92815565igb.1
        for <linux-mips@linux-mips.org>; Tue, 29 Mar 2016 22:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=go1QoYC6qw1XoC+hT2yN5wnA1IyMAaRpzTPA/gj4hcc=;
        b=lrAaCscVjXm49MgvdeXEo3PPUhcRW/aOEH7D7/CwaNwluj7AWdTBQdjnTn1aiWk7lt
         8pUVmKmq3HOlSo2eNZWLV6FVkOWthhdBJD92yJCIHHQ10sRY8AEWC3jU9MNDWCHPo0xg
         Nj9v+UwJiaPnfacX7VHsPdhTXqlM2AOPYpN4LjapfRX1H6SXoQyhB3u+wOL3AvVKiT22
         OyeZXnVhzgV3RfSc4Mgqc42XWYMcDJ77tTq61v8vJeTlersW5Ofibj54BnSUyqf7Ylpe
         tPhDndDiKPpz3BCV5CeLbS1oBccyP6AQQJtUKttduXFq0Vc5Uzgzspv5OKC4v7Of9PTL
         OAcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=go1QoYC6qw1XoC+hT2yN5wnA1IyMAaRpzTPA/gj4hcc=;
        b=nELBT+Akhop5C6JlwRkiHjcrnLwoI2yk+pVD4MluQR2DN2xDhpL+5w4Kz5X0pSIFlc
         I+tEIr10saQuiPoHU/aksViNIrGVPlzH+8RGbjwlEsPKA1De448eUP4IBiTqyag6sPDX
         NvkPgQ3k3GdDKihzvXsIzZe59HfD7EVz+vXQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=go1QoYC6qw1XoC+hT2yN5wnA1IyMAaRpzTPA/gj4hcc=;
        b=gLm3LpD9VaQw4uMrMA7T+cEDeXm9eBiY2ADyf8gaZ5nHS+rIcMMOHxmplbrCeeJXO3
         gChheDcTtosPiJbzq1sRjgyhUeuYxqIRVVpSzSlY1IKJn+loyZfATQ6SSPlspHYnYqLy
         kt0qf1j2O5TJUeuIExU8Fbvgdo20N1QKMCkpY1oI0KR7+/8NZPu0nnYtBDR7J9ZjFJCA
         3ASAlZ9wquBwg/SNicnEkeMhe3mCZE9BswpQU2R9C2DAapV1RUkNNFTiEV4BYvxrSYmg
         I6HNA//VYGQKaTXZ3A8wpRhgjsnPWjgWcBscp1G2q49UYt1Kj0BYaPBNj56Rvksjvn6W
         MTzQ==
X-Gm-Message-State: AD7BkJLJPJRUqxoDf9/BlC/L77CD1tIWlt3KbUhuJAXWCTdJNsFd5sjQ09EL0xch1zVAsGPeGCv9gEa49irKUdlF
MIME-Version: 1.0
X-Received: by 10.50.60.72 with SMTP id f8mr6956325igr.1.1459314397300; Tue,
 29 Mar 2016 22:06:37 -0700 (PDT)
Received: by 10.64.25.129 with HTTP; Tue, 29 Mar 2016 22:06:37 -0700 (PDT)
In-Reply-To: <1459240534-8658-1-git-send-email-matt.redfearn@imgtec.com>
References: <1459240534-8658-1-git-send-email-matt.redfearn@imgtec.com>
Date:   Tue, 29 Mar 2016 22:06:37 -0700
X-Google-Sender-Auth: 2GBH4YJv9TXQ13HXJiuxqdhg5fo
Message-ID: <CAGXu5jLJEHzB3ST63g0fApVP4-OWwCT5UcqguAMNoGy-aQXgew@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] MIPS seccomp_bpf self test and fixups
From:   Kees Cook <keescook@chromium.org>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     IMG-MIPSLinuxKerneldevelopers@imgtec.com,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Eric B Munson <emunson@akamai.com>,
        James Hogan <james.hogan@imgtec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kselftest@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        "Amanieu d'Antras" <amanieu@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alex Smith <alex.smith@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52733
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

On Tue, Mar 29, 2016 at 1:35 AM, Matt Redfearn <matt.redfearn@imgtec.com> wrote:
> These patches imporve seccomp support on MIPS.
>
> Firstly support is added for building the seccomp_bpf self test for
> MIPS. The
> initial results of these tests were:
>
> 32bit kernel O32 userspace before: 48 / 48 pass
> 64bit kernel O32 userspace before: 47 / 48 pass
>  Failures: TRAP.Handler
> 64bit kernel N32 userspace before: 44 / 48 pass
>  Failures: global.mode_strict_support, TRAP.handler,
> TRACE_syscall.syscall_redirected, TRACE_syscall.syscall_dropped
> 64bit kernel N64 userspace before: 46 / 48 pass
>  Failures: TRACE_syscall.syscall_redirected,
> TRACE_syscall.syscall_dropped
>
> The subsequent patches fix issues that were causing the above tests to
> fail. With
> these fixes, the results are:
> 32bit kernel O32 userspace after: 48 / 48
> 64bit kernel O32 userspace after: 48 / 48
> 64bit kernel N32 userspace after: 48 / 48
> 64bit kernel N64 userspace after: 48 / 48
>
> Thanks,
> Matt
>
> Changes in v2:
> - Tested on additional platforms
> - Replace __NR_syscall which isn't defined for N32 / N64 ABIs
>
> Matt Redfearn (6):
>   selftests/seccomp: add MIPS self-test support
>   MIPS: Support sending SIG_SYS to 32bit userspace from 64bit kernel
>   MIPS: scall: Handle seccomp filters which redirect syscalls
>   seccomp: Get compat syscalls from asm-generic header
>   MIPS: seccomp: Support compat with both O32 and N32
>   secomp: Constify mode1 syscall whitelist
>
>  arch/mips/include/asm/seccomp.h               | 47 +++++++++++++++------------
>  arch/mips/kernel/scall32-o32.S                | 11 +++----
>  arch/mips/kernel/scall64-64.S                 |  3 +-
>  arch/mips/kernel/scall64-n32.S                | 14 +++++---
>  arch/mips/kernel/scall64-o32.S                | 14 +++++---
>  arch/mips/kernel/signal32.c                   |  6 ++++
>  include/asm-generic/seccomp.h                 | 14 ++++++++
>  kernel/seccomp.c                              | 13 ++------
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 30 +++++++++++++++--
>  9 files changed, 101 insertions(+), 51 deletions(-)

Thanks for digging into this! Consider all the seccomp pieces:

Acked-by: Kees Cook <keescook@chromium.org>

Probably best to carry it all in the MIPS tree, but if you want to me
take pieces of it into my seccomp tree, I can do that. Up to you. :)

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
