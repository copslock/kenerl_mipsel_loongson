Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Dec 2009 15:55:03 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:36834 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493114AbZLCOy7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Dec 2009 15:54:59 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nB3Estbv016360;
        Thu, 3 Dec 2009 14:54:56 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nB3EsrFk016358;
        Thu, 3 Dec 2009 14:54:53 GMT
Date:   Thu, 3 Dec 2009 14:54:53 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     linux-mips@linux-mips.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Jones <davej@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        cpufreq@vger.kernel.org
Subject: Re: [PATCH v0] Loongson2: CPUFreq: add support to load module
 automatically
Message-ID: <20091203145452.GA28957@linux-mips.org>
References: <8421507f5dfc1a70d1dba92ad7604a8bfaa5a447.1259805106.git.wuzhangjin@gmail.com>
 <1259815795.4474.34.camel@falcon.domain.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1259815795.4474.34.camel@falcon.domain.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25288
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 03, 2009 at 12:49:55PM +0800, Wu Zhangjin wrote:

> > +++ b/arch/mips/loongson/common/platform.c
> > @@ -0,0 +1,32 @@
> > +/*
> > + * Copyright (C) 2009 Lemote Inc.
> > + * Author: Wu Zhangjin, wuzj@lemote.com
> > + *
> > + * This program is free software; you can redistribute  it and/or modify it
> > + * under  the terms of  the GNU General  Public License as published by the
> > + * Free Software Foundation;  either version 2 of the  License, or (at your
> > + * option) any later version.
> > + */
> > +
> > +#include <linux/err.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include <asm/bootinfo.h>
> 
> The above header file is not needed.

I folded your patch into "MIPS: Loongson 2F: Add CPU frequency scaling
support" and removed that line.  Thanks!

  Ralf
