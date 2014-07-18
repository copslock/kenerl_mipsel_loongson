Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Jul 2014 00:16:48 +0200 (CEST)
Received: from mail-oa0-f41.google.com ([209.85.219.41]:63972 "EHLO
        mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861349AbaGRWQnsHihl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 Jul 2014 00:16:43 +0200
Received: by mail-oa0-f41.google.com with SMTP id j17so4286492oag.14
        for <linux-mips@linux-mips.org>; Fri, 18 Jul 2014 15:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=vEB1nE4gf4ceogyWtKQvTGHCl+Kw8wKx1sAstUYK/WE=;
        b=Jj2MkfQCuH1Pd2L4G4JQmPh8NT9s6fJ4TYZlV4En/mjej0+Q/3FGMPesi0mSPopIXR
         0MVmax4IRq+00A6OPLb18vyFGO8WswAc56BY/ZW5yUmKzt5IFuohIGk+Aaysa4HqwK2Y
         oekfqaHY/DUFu4F9m0SdySUiwrfhh3sXvruqZtjirNL0qmDHZNmqJu4oa+8RdsjG6IKY
         XUOyeinHxShgouIihb7NgNRRy+zfDJxWrouVkhk6nOJ9g1wPWR2z9saB3hIy30MPmccf
         VxZB19MA0v9+IjP2qki7zThl+jJy43F8fltryj5p8BB96yYlWpH2oG7xpDxGO1Arphdm
         R8HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=vEB1nE4gf4ceogyWtKQvTGHCl+Kw8wKx1sAstUYK/WE=;
        b=Vwm9DtdiDfVhElRNYQOU/BzOR7nDUOJFcR7zpP7uQmuuOo+CQahiPodArVCsfctcXA
         uC702NrcLpWrOgYuC5ab03v/e+uyvu/fqdz0WiQoESHZMJuFqK2teB5tSK96SKSLvybd
         IfipLnU8QyN3cdshj/IQSN0jADlkXPfXbcSYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=vEB1nE4gf4ceogyWtKQvTGHCl+Kw8wKx1sAstUYK/WE=;
        b=K9PpYoxzjkIO6RtPVdWZucrY4FwmzWgHOiivdZVeFBIRY9e8sePWEBK29QNdiaQrDh
         Z1rqSi1SfnT0e4GujGvYw/fu0DM3Rs7/tBKhx80gbu4ymEDxYa7jyNqGCv47j9SgQuZF
         w7hNH2v5kz/9KPL290fu0EeeY+c9GuiM8BNkNuKzmYQp6AsfOLW5da3kF/zaX1SBqNrZ
         /T1VLVZ3nJz8YizFk/j6ypQsckaUFfzMBSSu0l6gbPWIA9PHfxGD5bT7H5q/bRLW+GQo
         stJ0xZ1lbmkAfL/7qVsNxLqp0ATIGUuQDC6Zx3fL7nunNoJpgRrWeNVnAKiMkejW67pV
         Pc4Q==
X-Gm-Message-State: ALoCoQnHhqO9jc5GF1ATZp+d9W+TUvrdylh9L9xDVTBane1NYU9ItGojRx1ev0p7SsLz5q9P7KLr
MIME-Version: 1.0
X-Received: by 10.182.65.167 with SMTP id y7mr11386337obs.29.1405721797331;
 Fri, 18 Jul 2014 15:16:37 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Fri, 18 Jul 2014 15:16:37 -0700 (PDT)
In-Reply-To: <ce65e0e8be18ae8fab437899db44ca41c912b506.1405717901.git.luto@amacapital.net>
References: <cover.1405717901.git.luto@amacapital.net>
        <ce65e0e8be18ae8fab437899db44ca41c912b506.1405717901.git.luto@amacapital.net>
Date:   Fri, 18 Jul 2014 15:16:37 -0700
X-Google-Sender-Auth: auFrg7iRndBxfdaZhWqZ6GqINV4
Message-ID: <CAGXu5jLsnSujJdZmA=nzHw1_K3eYhSiUEnntJ3S2hCZ8DFVYpg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] seccomp: Allow arch code to provide seccomp_data
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@plumgrid.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41342
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

On Fri, Jul 18, 2014 at 2:18 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> populate_seccomp_data is expensive: it works by inspecting
> task_pt_regs and various other bits to piece together all the
> information, and it's does so in multiple partially redundant steps.
>
> Arch-specific code in the syscall entry path can do much better.
>
> Admittedly this adds a bit of additional room for error, but the
> speedup should be worth it.

I still think we should gain either a note in the
HAVE_ARCH_SECCOMP_FILTER help text in arch/Kconfig, or possibly a new
section in Documentation/prctl/seccomp.txt (or similar) on how do
implement filter support for an architecture, that mentions the
arch-supplied seccomp_data and how two-phase can be done.

-Kees

-- 
Kees Cook
Chrome OS Security
