Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2014 13:25:47 +0200 (CEST)
Received: from mail-lb0-f170.google.com ([209.85.217.170]:36749 "EHLO
        mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822674AbaDWLZpNbk7U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Apr 2014 13:25:45 +0200
Received: by mail-lb0-f170.google.com with SMTP id s7so638970lbd.15
        for <multiple recipients>; Wed, 23 Apr 2014 04:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=o2xfQpeYdr1zIOH/egJXtpG5eKdoGawoYCH0Yv/ZZoE=;
        b=KmfxLzV+NTHF4HIOJkdaFwQMlnYzSMf6v4tyVlVApnigJDi3ixW61Zso2Jbp3u1EAA
         Q3Ql/6nArSUwciF0JEfVhFotBbFxRioySgAj9VXhbc0K/E4YC+TtuBX7aQvWNdudy/VU
         N2TmIrhR5gRUqQVOnc1OvlVEltQUZbpgMihL3F1+vAxR1B2+ou2pXhEveTO4hiolgWvW
         ZQrwN8CFLxW/Kky1YnHfBeQF4jn38pVQ+6m8FsrMsD1LcHDrUAk4jRuPvn0tOejmFxPK
         EgYVatNTaBV6zbUPbYI1+BjCbVZOJJOQQB2boQudi/6MwPSTrBbv1rcCmj3bTMv2qcQZ
         Mdxg==
MIME-Version: 1.0
X-Received: by 10.153.8.135 with SMTP id dk7mr35617066lad.18.1398252338989;
 Wed, 23 Apr 2014 04:25:38 -0700 (PDT)
Received: by 10.152.198.166 with HTTP; Wed, 23 Apr 2014 04:25:38 -0700 (PDT)
In-Reply-To: <1398251857-16290-1-git-send-email-james.hogan@imgtec.com>
References: <1398251857-16290-1-git-send-email-james.hogan@imgtec.com>
Date:   Wed, 23 Apr 2014 13:25:38 +0200
X-Google-Sender-Auth: 3e51cSdrojGA1nLzMwMvaAIsGFY
Message-ID: <CAMuHMdU75HO=JUgb_wm7OCXDEEUL_=GGjkTMy0WzA+VyFuKa=g@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Wire up renameat2 syscall
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39909
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

Hi James,

On Wed, Apr 23, 2014 at 1:17 PM, James Hogan <james.hogan@imgtec.com> wrote:
> Wire up for MIPS the new renameat2 system call added in commit
> 520c8b165052 (vfs: add renameat2 syscall) merged in v3.15-rc1.

Miklos already wired this up for all architectures, cfr. the MIPS version
sent to lkml and linux-arch: https://lkml.org/lkml/2014/4/11/196

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
