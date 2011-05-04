Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 May 2011 14:18:02 +0200 (CEST)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:61436 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491051Ab1EDMR5 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 May 2011 14:17:57 +0200
Received: by bwz1 with SMTP id 1so1179861bwz.36
        for <linux-mips@linux-mips.org>; Wed, 04 May 2011 05:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3ERi4Yv6QUYVc9R1ygD5GOUKWvs/8X1wolS/oEDmci8=;
        b=rWTmL+qKC4a25Wby1kavCPeOcCVKBrRxXfruVvrbhM0WbjKQEJr8suEL3oJd9CI4UN
         C1VBQchDRocSM98CXvhG8cXSI0pNApuOzFUcd2zth2iSdh906QIiqzjVlCFkQbT22ah9
         olopGzojadjlBa+DpwOwDi+Da8mISa3qcH1zc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=f51yaEtpSAU1uXzB0uFikDTsnRzdJs5qeoBFJ5G46lBryxBVESllgxJ3ZNW0Tan/30
         1dmZ9s/ahKafyMpm9XKTENrhqMALkR6UFzVX28gXJnkjoy7fqlHCrm2AjpBDIgygAIss
         gHankU5bqAHPFjeMQJXbuN2/GnUfHN4qWjxyk=
MIME-Version: 1.0
Received: by 10.204.0.82 with SMTP id 18mr1025272bka.100.1304511471362; Wed,
 04 May 2011 05:17:51 -0700 (PDT)
Received: by 10.204.126.154 with HTTP; Wed, 4 May 2011 05:17:51 -0700 (PDT)
In-Reply-To: <1304458235-28473-1-git-send-email-sven@narfation.org>
References: <1304458235-28473-1-git-send-email-sven@narfation.org>
Date:   Wed, 4 May 2011 14:17:51 +0200
X-Google-Sender-Auth: 52Q_K_1bwIVJ1s18yumwIOjW098
Message-ID: <BANLkTi=kRLxKS417xhaWDpF4h8+VTcUQQA@mail.gmail.com>
Subject: Re: [PATCH] atomic: add *_dec_not_zero
From:   Geert Uytterhoeven <geert@linux-m68k.org>
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
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, May 3, 2011 at 23:30, Sven Eckelmann <sven@narfation.org> wrote:
> Introduce an *_dec_not_zero operation.  Make this a special case of
> *_add_unless because batman-adv uses atomic_dec_not_zero in different
> places like re-broadcast queue or aggregation queue management. There
> are other non-final patches which may also want to use this macro.

>  arch/m68k/include/asm/atomic.h     |    1 +

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
