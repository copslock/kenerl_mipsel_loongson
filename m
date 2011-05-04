Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 May 2011 06:45:20 +0200 (CEST)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:41101 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490954Ab1EDEpN convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 May 2011 06:45:13 +0200
Received: by gxk2 with SMTP id 2so326882gxk.36
        for <linux-mips@linux-mips.org>; Tue, 03 May 2011 21:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=SiHOHYPZplxYzEe1LV2HgbIkftjZmwJhiWkX9LoI13U=;
        b=SNmqV5qgB2uXNQyKPzcXfz+LFZEGWu4nQ0EyWbUhb7jpmMlcQFmt0aJcpDVzBh1q1e
         oKji0WXKLGALASK9TVCwnvoZapnFfducKJenfPgED4DIs9JT7Tvw0qXzvirkzDjv/S0G
         IhE7KtTHEFIPOYtsekS9WC3lCgt7DDliN1h5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=P3q/LtiLXRDW5M9apfXqtpa0o1NGigAbH1bVHFdu+pPiKJ2tRE+akDw5nhKqNVQehj
         zft90B72mafT9ujrLEIfKmtWkWc6dWOiPnf3AFNPO1vEq5mJfSeBAWo76EfKYtror2gd
         mx3OZe9TRn8uRvt37KE3JCv8K0um3Iwr6Ghg0=
Received: by 10.91.24.4 with SMTP id b4mr699396agj.34.1304484307079; Tue, 03
 May 2011 21:45:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.91.19.32 with HTTP; Tue, 3 May 2011 21:44:46 -0700 (PDT)
In-Reply-To: <1304458235-28473-1-git-send-email-sven@narfation.org>
References: <1304458235-28473-1-git-send-email-sven@narfation.org>
From:   Mike Frysinger <vapier.adi@gmail.com>
Date:   Wed, 4 May 2011 00:44:46 -0400
Message-ID: <BANLkTiminpyJ_opxhqG0E0gBOrF490b+tQ@mail.gmail.com>
Subject: Re: [PATCH] atomic: add *_dec_not_zero
To:     Sven Eckelmann <sven@narfation.org>
Cc:     linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Chris Metcalf <cmetcalf@tilera.com>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        uclinux-dist-devel@blackfin.uclinux.org,
        linux-cris-kernel@axis.com, linux-ia64@vger.kernel.org,
        linux-m32r@ml.linux-m32r.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <vapier.adi@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vapier.adi@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, May 3, 2011 at 17:30, Sven Eckelmann wrote:
> Introduce an *_dec_not_zero operation.  Make this a special case of
> *_add_unless because batman-adv uses atomic_dec_not_zero in different
> places like re-broadcast queue or aggregation queue management. There
> are other non-final patches which may also want to use this macro.
>
> Cc: uclinux-dist-devel@blackfin.uclinux.org
>
> --- a/arch/blackfin/include/asm/atomic.h
> +++ b/arch/blackfin/include/asm/atomic.h
> @@ -103,6 +103,7 @@ static inline int atomic_test_mask(int mask, atomic_t *v)
>        c != (u);                                               \
>  })
>  #define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)
> +#define atomic_dec_not_zero(v) atomic_add_unless((v), -1, 0)
>
>  /*
>  * atomic_inc_and_test - increment and test

no opinion on the actual idea, but for the Blackfin pieces:
Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike
