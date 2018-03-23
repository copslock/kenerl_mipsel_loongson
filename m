Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 19:36:43 +0100 (CET)
Received: from mail-it0-x229.google.com ([IPv6:2607:f8b0:4001:c0b::229]:35343
        "EHLO mail-it0-x229.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990423AbeCWSggr7zY2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Mar 2018 19:36:36 +0100
Received: by mail-it0-x229.google.com with SMTP id v194-v6so3760820itb.0;
        Fri, 23 Mar 2018 11:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=TNNhblvLssJsX5pGNIUKtzxVMLbCrnWTp248qdBPfdc=;
        b=rdamqlNypWBF3QGTqZOpt8P+JmbP7r1HVCB1DFqlb/9O7xAdymLZPtZ0au4W8ZBMBM
         Cv4vtGqa5cNPRIBmSEXHoHLFdzneYlfarh98B1KQYVv8mDhTKe0r/dJYP2HAuggNZeUh
         u4TeDLxCD+jqjb84FZd+WkGCKV/3aMiPqsHmjJOOOBE3nFceNY7Lar9ShQCPg9rXd185
         jLXQb3LfMlyFm9Bz/3bz/TKFKknldIv6FlMGeKKvLYmQ0afQkc5ltqlj42sdqNGmQuAn
         17MUXfoqiQN1IpnkZMX9Kcc3HsrtmlfUWTOGDJbqUOPprHF6c7gMnxoSgj3LC1H92rpK
         +55g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=TNNhblvLssJsX5pGNIUKtzxVMLbCrnWTp248qdBPfdc=;
        b=Dzq7ZTGhHUwE1nJOEVdpEGnpSeftjvdiMkIfxHbSGZJ1zwb3Dewdwcb3w3y5Tg9A6y
         RaxK0b2M4Zf7oM/3Zb47Q41YGsO934WtFyfcgbHefNfnOTF2zPIv9uOiV1bwMa2VRD45
         SD7DcFNt5zXXQKJg/67rFTCfrXB2SugrKKbnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=TNNhblvLssJsX5pGNIUKtzxVMLbCrnWTp248qdBPfdc=;
        b=s9DKP71cZdaJSrUOgrgJYiHOzIF5MwIQJlIzuSxidlm5V1+Gkm9qf2cXq0xc7nOvxc
         mwO1fTJv1vWktpv8K4D28eF3kq/VE16bCzARjp9nYjaC5Tv2aaGxMOY7Jevqn9Ufuqjw
         BFaFTCHSzD2z7OJgATju5wIpONdAtNwpy1zeahmSRFxhnR8lvjSO3NwuoQgC0MbKu1Ow
         Rzvsfdby9wRNex14cKxQwTO5VmXFuUaF4b2ARrjCrwWYsYffSt6ip5OPQzy6cjcELP+O
         juyuiFgtB95Lbxrp7nNfYwQNi0mId2e/4K+wx4s/HsfcigW4S9SouKby49Jrh5ROLaOW
         4alA==
X-Gm-Message-State: AElRT7GBDWX1MJ4c1aSsTcugdZCYM7v0wrUQ8pCKdtYjE9ATwh1n48/2
        9v16v7R7wp6Sa6IZU7zm21+Tb+guMN9AUCogit+udA==
X-Google-Smtp-Source: AG47ELtrLCUbuUNlSi98rM4oenFUUK5+osgMCdhUHw0sSLz+f3ce/HFSLvrdCxkg30UyGDc8Hik5lpNDuCJ+K12UQ84=
X-Received: by 2002:a24:c581:: with SMTP id f123-v6mr6912679itg.113.1521830190408;
 Fri, 23 Mar 2018 11:36:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.95.15 with HTTP; Fri, 23 Mar 2018 11:36:29 -0700 (PDT)
In-Reply-To: <20180323102601.GA11796@saruman>
References: <20180323102601.GA11796@saruman>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Mar 2018 11:36:29 -0700
X-Google-Sender-Auth: BtLk_pSXOoV5p6WiGB2ILBL7rK0
Message-ID: <CA+55aFwERU7m_DYffR=xcUmb1_mzzqwU2gK7xOck8X4N9CtLCw@mail.gmail.com>
Subject: Re: [GIT PULL] MIPS fixes for 4.16-rc7
To:     James Hogan <jhogan@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <linus971@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63175
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

On Fri, Mar 23, 2018 at 3:26 AM, James Hogan <jhogan@kernel.org> wrote:
>
>  arch/mips/lantiq/Kconfig        |  2 ++
>  arch/mips/lantiq/xway/sysctrl.c |  6 ++---
>  arch/mips/ralink/mt7621.c       | 50 +++++++++++++++++++++--------------------
>  arch/mips/ralink/reset.c        |  7 ------
>  4 files changed, 31 insertions(+), 34 deletions(-)

Odd. This didn't match for me. It turns out that's because you have
the patience diff enabled.

Normally the patience diff generates moire legible diffs, but in this
case the default diff actually seems better.

You don't have to do anything about your config, I realize that some
people and projects prefer patience-dff. I just found it interesting
how *completely* different the diffs look. Normally the differences
are subtler.

                Linus
