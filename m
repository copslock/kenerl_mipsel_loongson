Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Nov 2011 21:50:20 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:51699 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903598Ab1KNUuR convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Nov 2011 21:50:17 +0100
Received: by iapp10 with SMTP id p10so9570413iap.36
        for <multiple recipients>; Mon, 14 Nov 2011 12:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uJje3MhxxNLStr9jLh5D9UN1FsAQZiTgwpWn8SYkKKI=;
        b=QK8iIvQes5QCdu/tog5dwZGApn5XHedNEnoegw2y7sy63nsPQTp2LAdsDH/P0Z/s6d
         3XLnXpBOnEDYe20i7axPlS2fWzv2EaTDbJqcUr42VjjrVgTUOrvqVYzZ63QxC27qKB+s
         cqS56kyBZ2jc9aX3Edpr0tG0oa3VZNmUi6DE8=
MIME-Version: 1.0
Received: by 10.231.60.76 with SMTP id o12mr5647534ibh.83.1321303810405; Mon,
 14 Nov 2011 12:50:10 -0800 (PST)
Received: by 10.231.17.139 with HTTP; Mon, 14 Nov 2011 12:50:10 -0800 (PST)
In-Reply-To: <e69163f6245513b05d5d21c2f57b916931ad5bff.1320917557.git.joe@perches.com>
References: <cover.1320917551.git.joe@perches.com>
        <e69163f6245513b05d5d21c2f57b916931ad5bff.1320917557.git.joe@perches.com>
Date:   Mon, 14 Nov 2011 21:50:10 +0100
X-Google-Sender-Auth: SwdDdjc_3e8ROtsAi_lwDlBWB80
Message-ID: <CAMuHMdXwjFphNNHc-OZXHaC4OP981x48hRuCdi3FjtPKh6YvHA@mail.gmail.com>
Subject: Re: [PATCH 3/5] treewide: Remove useless NORET_TYPE macro and uses
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@google.com>, Ingo Molnar <mingo@elte.hu>,
        Peter Zijlstra <peterz@infradead.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, Chris Metcalf <cmetcalf@tilera.com>,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 31598
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11882

On Thu, Nov 10, 2011 at 10:41, Joe Perches <joe@perches.com> wrote:
> It's a very old and now unused prototype marking
> so just delete it.
>
> Neaten panic pointer argument style to keep checkpatch quiet.
>
> Signed-off-by: Joe Perches <joe@perches.com>

For the m68k parts:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
