Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Mar 2015 20:00:03 +0100 (CET)
Received: from mail-vc0-f173.google.com ([209.85.220.173]:52678 "EHLO
        mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008511AbbCKTAAvtAod (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Mar 2015 20:00:00 +0100
Received: by mail-vc0-f173.google.com with SMTP id hy10so3739997vcb.4
        for <linux-mips@linux-mips.org>; Wed, 11 Mar 2015 11:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=fGiWOgdnSGWqgtkswLwrg8Fb26jdUJ5fEGIfJ2wI+t0=;
        b=EhO0vQp9vy1qIwiGsdEskxH6LIBt+MChUM8jghFqWpP0PYUeSupG8b8eDDOhveAhg4
         R0WDid4Z2de58u7c/oHbDBCPhgXHHX6Cs7DeOm8ll+noCs49uj4Enola2lLbGOhzKpzE
         IgoNAhotanFfL6ykAtj/JTPwUAioKB7UBAzjXRmCTFCWSd5polgLAv78zuQRuLfYsuMu
         jdR8YKV36jHXxMD7IDQGBwD1Oqd52F/+e+yWEk0WXtSFL9jIGSJVN96uNm1AUHm9FbY8
         CHVlcrVeCimVk88ns2ELlRvWql4Oj6F7n0E4jX6nM7Iea5YGsECLTFiOs1bNmj3PBsER
         Au2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=fGiWOgdnSGWqgtkswLwrg8Fb26jdUJ5fEGIfJ2wI+t0=;
        b=aFqG3z1J494wyNyUUU3Do+Lkk7MxXj28gRbEpq6yYD5g6XGePiURxlizkbDQNVszGd
         ZwXLS53uhRh8tH+bNuU0jczvnS6ckunCc7oBEKwcbACnvSGtPCmYSCbwoSm7puB3W0EN
         B0kLPxraoIZPyXkqxwIe29JdpZT+lYkZ23cZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=fGiWOgdnSGWqgtkswLwrg8Fb26jdUJ5fEGIfJ2wI+t0=;
        b=ELsWg7hPxV1GY6GVOd9M+xHT9I4ohC5+GmggCqxsAGoG4CN+e3BW/R7QWmbcIsvOIl
         VVmfxqf4MTDRbGEz6wK2HWpMd5ii6zWzHJIJW5x4BgozrqIH0sYcnZYA9jVR8Fm0f5HV
         AUHrxZa+137xeSRLEX7jHaHTfP7Gl1G/miavipulwWxmbaatVYcDfuLSakeAy4uBbdde
         dG09mnydzhPXm5XSxEPoH/FsOAe8u0isHyd2N3r9K31FbchSb6g67aXwfPLOXNSKX0sb
         3FaCuuVRbB5vKTjRGwNmMLzdCyPVHgdTVBHw/IevG8w+BKOC0PzEGoxEdpf8/qJxhYB/
         pMFA==
X-Gm-Message-State: ALoCoQng4HumJjq2EQKo/GsYVniraKZTutW6y/bAoh2ekTCfGKVu2z+/PEpmeJhH6F5lTqSfzVg5
MIME-Version: 1.0
X-Received: by 10.52.103.10 with SMTP id fs10mr44829384vdb.58.1426100395279;
 Wed, 11 Mar 2015 11:59:55 -0700 (PDT)
Received: by 10.52.172.35 with HTTP; Wed, 11 Mar 2015 11:59:55 -0700 (PDT)
In-Reply-To: <1425518828-16017-1-git-send-email-keescook@chromium.org>
References: <1425518828-16017-1-git-send-email-keescook@chromium.org>
Date:   Wed, 11 Mar 2015 11:59:55 -0700
X-Google-Sender-Auth: _V2hF6Rc6Mb1S7ii_RxC2oU2I-M
Message-ID: <CAGXu5j+PMBEPLTLiDVZ9XvnT9a2P+tOGPLXfE865crteeChDFQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] switch to using asm-generic for seccomp.h
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@arm.linux.org.uk>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S. Miller" <davem@davemloft.net>,
        "x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Daniel Borkmann <dborkman@redhat.com>,
        Laura Abbott <lauraa@codeaurora.org>,
        James Hogan <james.hogan@imgtec.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-parisc <linux-parisc@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46340
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

On Wed, Mar 4, 2015 at 5:27 PM, Kees Cook <keescook@chromium.org> wrote:
> Most architectures don't need to do much special for the strict-mode
> seccomp syscall entries. Remove the redundant headers and reduce the
> others.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Hi Andrew,

Just a quick ping: are you able to pick up this series, or should I
try to get this in on a per-arch basis?

Thanks!

-Kees

> ---
> v3:
> - split patch series by architecture
> - fix up architectures that need sigreturn overrides (ingo)
> v2:
> - use Kbuild "generic-y" instead of explicit #include lines (sfr)
>



-- 
Kees Cook
Chrome OS Security
