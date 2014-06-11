Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2014 00:23:15 +0200 (CEST)
Received: from mail-ve0-f171.google.com ([209.85.128.171]:53454 "EHLO
        mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6854780AbaFKWXG5ozBN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Jun 2014 00:23:06 +0200
Received: by mail-ve0-f171.google.com with SMTP id jz11so907926veb.2
        for <linux-mips@linux-mips.org>; Wed, 11 Jun 2014 15:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=+nATPwoFBVCTLHsdjA4E3C7oYoudOcl18HGs7DFtOqk=;
        b=QukpmYxMjXTsJKNexix28C+z9e4jNOy3Rp5Wp79wjHzAWEgdtohLn3zb/Xt63m51yL
         R+ub8/Ea6euCFHSgB04vNv1YH0uRN8ts3tIpLt9Ao0U6OEWa1GhWWKiHY0hRDykEpGZ8
         jovtnD0y0HV5xDN6+AP6JzoN3+UZXptryXaSp5PB0N4CoXVZ8mQi+n5kOg+vUFKeQn6N
         qN3MZFihqc0+nX/Q+OkfeJC1GIjujUertS3ewOlQIcen/XyQb6EFXcrliPP3s/WpF2Jp
         2vFOiZqDTbrPgCtexKa9u19AKyZs+cYly4RYkbxLxIwY4yUP81tRd8R8HH7TJtL7fzC+
         04jw==
X-Gm-Message-State: ALoCoQkuIlIpSW6nBgA464LEaXXvpzHt2U5g1OdNucawunq3O2y74awgdPyn3vZwU2WoeyvvcimF
X-Received: by 10.52.138.14 with SMTP id qm14mr4223117vdb.49.1402525381041;
 Wed, 11 Jun 2014 15:23:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.58.91.40 with HTTP; Wed, 11 Jun 2014 15:22:40 -0700 (PDT)
In-Reply-To: <5398D59A.3030900@zytor.com>
References: <cover.1402517933.git.luto@amacapital.net> <9e11cd988a0f120606e37b5e275019754e2774da.1402517933.git.luto@amacapital.net>
 <CAADnVQKt5FnShkZeQewbfnU1kHM-gLs3hCZMf5xcgFzyRDLX7A@mail.gmail.com>
 <CALCETrXoqqKC=T5Wvj+CDYQFte1s_=npDvQ2UYW0j=AanEgR1g@mail.gmail.com> <5398D59A.3030900@zytor.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 11 Jun 2014 15:22:40 -0700
Message-ID: <CALCETrVMxkHcPXsEGtEc0Pr=Z80CzC0zWaQ9OdVdxi1CGuB4kQ@mail.gmail.com>
Subject: Re: [RFC 5/5] x86,seccomp: Add a seccomp fastpath
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>, X86 ML <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org,
        linux-arch <linux-arch@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40499
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

On Wed, Jun 11, 2014 at 3:18 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 06/11/2014 02:56 PM, Andy Lutomirski wrote:
>>
>> 13ns is with the simplest nonempty filter.  I hope that empty filters
>> don't work.
>>
>
> Why wouldn't they?

Is it permissible to fall off the end of a BPF program?  I'm getting
EINVAL trying to install an actual empty filter.  The filter I tested
with was:

#include <unistd.h>
#include <linux/filter.h>
#include <linux/seccomp.h>
#include <sys/syscall.h>
#include <err.h>
#include <sys/prctl.h>
#include <stddef.h>
#include <stdio.h>

int main(int argc, char **argv)
{
    int rc;

    struct sock_filter filter[] = {
        BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_ALLOW),
    };

    struct sock_fprog prog = {
        .len = (unsigned short)(sizeof(filter)/sizeof(filter[0])),
        .filter = filter,
    };

    if (argc < 2) {
        printf("Usage: null_seccomp PATH ARGS...\n");
        return 1;
    }

    if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0))
        err(1, "PR_SET_NO_NEW_PRIVS");
    if (prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog))
        err(1, "PR_SET_SECCOMP");

    execv(argv[1], argv + 1);
    err(1, argv[1]);
}


--Andy
