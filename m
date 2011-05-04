Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 May 2011 10:33:58 +0200 (CEST)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:48127 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490984Ab1EDIdu convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 May 2011 10:33:50 +0200
Received: by gwb1 with SMTP id 1so360704gwb.36
        for <linux-mips@linux-mips.org>; Wed, 04 May 2011 01:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=ZjYSQ3FUv2Mh+C2C8y6rq/DkVU0IKBkQeY8EgZl9N+E=;
        b=JmKIltEPoJoMs5Ywot7vURXXM+ZorhWQ8uB+yucxRNvkd/WAnP7MOjR+NOo76BHiy9
         +ipOg425jJhQfQr5pCXWyB4r9XRaRuk24Vyah/jrRdDmqnHbomG/2C+yYEBt7R9G0TaI
         FAQuLqzfOJ2G24RMUlqrZy8UIkGDpfXvfEHQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=uanrApxMmwvwo06Bya8A+hoAytG/7rvDHGRTiJ6gM4NcPb8GrRCxxCEZVqV+NefZIh
         tMZ3nZfZ9IOygsVFM54NwGXSo2KoH5M6K3Cvb+Yamq0UsiAVit+ph/jS2/zWs5iSvWVY
         tPDc/6Npmb8IBen8P0+4SZf8JgHA179qhyxqY=
Received: by 10.90.188.16 with SMTP id l16mr789544agf.88.1304498024192; Wed,
 04 May 2011 01:33:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.91.19.32 with HTTP; Wed, 4 May 2011 01:33:24 -0700 (PDT)
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AD0D@saturn3.aculab.com>
References: <1304458235-28473-1-git-send-email-sven@narfation.org> <AE90C24D6B3A694183C094C60CF0A2F6D8AD0D@saturn3.aculab.com>
From:   Mike Frysinger <vapier.adi@gmail.com>
Date:   Wed, 4 May 2011 04:33:24 -0400
Message-ID: <BANLkTimctgbto3dsnJ3d3r7NggS0KF9_Sw@mail.gmail.com>
Subject: Re: [PATCH] atomic: add *_dec_not_zero
To:     David Laight <David.Laight@aculab.com>
Cc:     Sven Eckelmann <sven@narfation.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        linux-m32r@ml.linux-m32r.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        x86@kernel.org, Chris Metcalf <cmetcalf@tilera.com>,
        David Howells <dhowells@redhat.com>,
        linux-m68k@lists.linux-m68k.org, linux-am33-list@redhat.com,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <vapier.adi@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29810
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vapier.adi@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, May 4, 2011 at 04:05, David Laight wrote:
>> Introduce an *_dec_not_zero operation.  Make this a special case of
>> *_add_unless because batman-adv uses atomic_dec_not_zero in different
>> places like re-broadcast queue or aggregation queue management. There
>> are other non-final patches which may also want to use this macro.
>
> Isn't there a place where a default definition of this can be
> defined? Instead of adding it separately to every architecture.

that's what asm-generic is for.  if the arch isnt using it, it's
either because the arch needs to convert to it, or they're using SMP
and asm-generic doesnt yet support that for atomic.h.

for example, the Blackfin port only needed updating for the SMP case.
in the non-SMP case, we're getting the def from asm-generic/atomic.h.
-mike
