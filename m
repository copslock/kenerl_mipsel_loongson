Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Nov 2011 21:50:47 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:51699 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903601Ab1KNUui convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Nov 2011 21:50:38 +0100
Received: by mail-iy0-f177.google.com with SMTP id p10so9570413iap.36
        for <multiple recipients>; Mon, 14 Nov 2011 12:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sR3G++IXN8DRkpJXKHdGucXHD8vTAO91m5bLeoOhSrg=;
        b=KVslTV1JN/rwJ2RJjaS7t0zxyrx9NSxeQ76VKT/utRgnzgYWGzZYZXkW4SISF8+csm
         biRMRZSswYoFWYT+1/Iw+o6FZABOJXsAz3TTW3lJuwOsZulIMLBhG8G75j6lS1RkwKQ4
         PnTqUnE7SeKRfW1TQ0YzpVHMFcZRXXoY+RDFU=
MIME-Version: 1.0
Received: by 10.231.82.213 with SMTP id c21mr5554840ibl.70.1321303837921; Mon,
 14 Nov 2011 12:50:37 -0800 (PST)
Received: by 10.231.17.139 with HTTP; Mon, 14 Nov 2011 12:50:37 -0800 (PST)
In-Reply-To: <abb1d8b542872ef3bfd695e85d3b8a0fd70645b9.1320917558.git.joe@perches.com>
References: <cover.1320917551.git.joe@perches.com>
        <abb1d8b542872ef3bfd695e85d3b8a0fd70645b9.1320917558.git.joe@perches.com>
Date:   Mon, 14 Nov 2011 21:50:37 +0100
X-Google-Sender-Auth: zDYCvielUc_pbw51R8J7cXqCAKI
Message-ID: <CAMuHMdW+KORv6K6jMxTVOM=EeVQ6JTHHe9cOVfKZ39x4NcgvfQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] treewide: Convert uses of ATTRIB_NORETURN to __noreturn
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@google.com>, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>,
        Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, Paul Mundt <lethal@linux-sh.org>,
        Chris Metcalf <cmetcalf@tilera.com>,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 31599
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11885

On Thu, Nov 10, 2011 at 10:41, Joe Perches <joe@perches.com> wrote:
> Use the more commonly used __noreturn instead of ATTRIB_NORETURN.
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
