Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Apr 2011 14:39:24 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:38057 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491791Ab1DEMjV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Apr 2011 14:39:21 +0200
Received: by wwb17 with SMTP id 17so370941wwb.24
        for <multiple recipients>; Tue, 05 Apr 2011 05:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:reply-to:to:cc:in-reply-to
         :references:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=2xYNuAScJ9PM9Whs4G+CHX2yGB1Vd8TqRecRSqMDsWw=;
        b=n9otRSjh2yl0fHkWIRNUFSuLUb1Ams+eOmkc1BuxeN34ispwp0wfxO8c1PDvu4zXKp
         OxpVDyi+5Nb4b2fXfLIyHUT5gujK7E9pClIsbQF8h3evBZ3bsD/QFiIJUHYjrDlHkAx1
         pzxPPzXix1xPqXPUVLf1mNVmvQlaQnq+kDWlo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=F2IyGSubHLmdW1oubxnHBiIC7UNMwKMJjH1PnYQlcuC6d8w/Ar5+BZl1I4omIBzSW4
         q/PRCJXljYKmrX/w0ZjACw3JddleCfHwmS3Bklb75BOiLDvUiXuZ9rilBNdmbs4EkNp6
         FOgcuFcBrFcUlZpUqV8VLadpSC1Tj0i8Qe9H0=
Received: by 10.227.169.77 with SMTP id x13mr8499915wby.151.1302007154856;
        Tue, 05 Apr 2011 05:39:14 -0700 (PDT)
Received: from ?IPv6:::1? (shutemov.name [188.40.19.243])
        by mx.google.com with ESMTPS id y29sm3535093wbd.38.2011.04.05.05.39.13
        (version=SSLv3 cipher=OTHER);
        Tue, 05 Apr 2011 05:39:14 -0700 (PDT)
Subject: Re: [PATCH V7] MIPS: lantiq: add NOR flash support
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mtd@lists.infradead.org,
        Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>,
        David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1302006830-10345-1-git-send-email-blogic@openwrt.org>
References: <1302006830-10345-1-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Tue, 05 Apr 2011 15:36:35 +0300
Message-ID: <1302006995.2760.120.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 (2.32.2-1.fc14) 
Content-Transfer-Encoding: 8bit
Return-Path: <dedekind1@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29690
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, 2011-04-05 at 14:33 +0200, John Crispin wrote:
> +#include <lantiq_soc.h>
> +#include <lantiq_platform.h>
> +
> +/* 
> + * The NOR flash is connected to the same external bus unit (EBU) as PCI.
> + * To make PCI work we need to enable the endianess swapping for the address
> + * written to the EBU. This endianess swapping works for PCI correctly but
> + * fails for attached NOR devices. To workaround this we need to use a complex
> + * map. The workaround involves swapping all addresses whilste probing the chip.
> + * Once probing is complete we stop swapping the addresses but swizzle the
> + * unlock addresses to ensure that access to the NOR device works correctly.
> + */
> +
> +static int ltq_mtd_probing;
Disclamer: I do not really understand the PCI/swapping issue, even
though you wrote a comment about this, but still....

... I'm worried about this global variable. If you have multiple
instances of such NOR flash, then you theoretically may have a situation
when one of them is being probed, while another is being used for real.
And this single global switch will break the one which is used for real.

IOW, the right solution would be to have per-chip flag, not a global
flag.

-- 
Best Regards,
Artem Bityutskiy (Артём Битюцкий)
