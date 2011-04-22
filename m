Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Apr 2011 19:03:34 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:45644 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491097Ab1DVRD3 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Apr 2011 19:03:29 +0200
Received: by wyb28 with SMTP id 28so694556wyb.36
        for <multiple recipients>; Fri, 22 Apr 2011 10:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Uvn0J8RURnZGmjUVnLXbpYW35ZB2STd/i7SSpHC8eGo=;
        b=Uoo2S1TJ+/cBoXSevz59K83byKMROnZ3LyILzwgeJymp7jKx1uX8WYAcLNGWuLMrVK
         SQYxVxjETne0p/PDcUiYgDejhAD/b1QvlwAMWe0eGVG9TbDN79CfUxjxopJ0vgbhuuzF
         4rhuFyFQ1tE8DgxgAua4lgWKZHqum0TWwKmCU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JDPhN7dfA2Ck/yAzdDDPpurwOuNlmrwXnLlTLrkvzbra0HShb9N1oq/6csKMbPr/au
         lBbIblBr0neTA8klQGXpBpwaMobKEeXUnjBuzob+FeI7WqJj0tgMGz+IONxeOjKLURgS
         84XnY46dhXKSPNoj64FolHNaElJo6u1naj4T0=
MIME-Version: 1.0
Received: by 10.216.239.65 with SMTP id b43mr1309864wer.29.1303491803907; Fri,
 22 Apr 2011 10:03:23 -0700 (PDT)
Received: by 10.216.46.74 with HTTP; Fri, 22 Apr 2011 10:03:23 -0700 (PDT)
In-Reply-To: <21ae06c6f50f7a770b62d61265e6f509f37d1762.1303487516.git.jayachandranc@netlogicmicro.com>
References: <cover.1303487516.git.jayachandranc@netlogicmicro.com>
        <21ae06c6f50f7a770b62d61265e6f509f37d1762.1303487516.git.jayachandranc@netlogicmicro.com>
Date:   Fri, 22 Apr 2011 19:03:23 +0200
Message-ID: <BANLkTi=cUHpCQAi9LUjPXfDZL=a2XnfqDA@mail.gmail.com>
Subject: Re: [PATCH 7/8] USB support for XLS platforms.
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Jayachandran C <jayachandranc@netlogicmicro.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Fri, Apr 22, 2011 at 7:02 PM, Jayachandran C
<jayachandranc@netlogicmicro.com> wrote:
> update ehci-hcd.c and ohci-hcd.c to add XLS hcds
> add ehci/ohci devices to XLR/XLS platform driver
> Kconfig update
>
> Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
> ---
>  arch/mips/Kconfig                        |    2 +
>  arch/mips/include/asm/netlogic/xlr/xlr.h |   12 ++
>  arch/mips/netlogic/xlr/platform.c        |   91 ++++++++++++++++
>  drivers/usb/host/ehci-hcd.c              |    5 +
>  drivers/usb/host/ehci-xls.c              |  170 ++++++++++++++++++++++++++++++
>  drivers/usb/host/ohci-hcd.c              |    5 +
>  drivers/usb/host/ohci-xls.c              |  160 ++++++++++++++++++++++++++++
>  7 files changed, 445 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/usb/host/ehci-xls.c
>  create mode 100644 drivers/usb/host/ohci-xls.c
> diff --git a/drivers/usb/host/ehci-xls.c b/drivers/usb/host/ehci-xls.c
> new file mode 100644
> index 0000000..54467c6
> --- /dev/null
> +++ b/drivers/usb/host/ehci-xls.c
> @@ -0,0 +1,170 @@
> +/*
> + * OHCI HCD (Host Controller Driver) for USB.
> + *
> + * (C) Copyright 2011 Netlogic Microsystems Inc.
> + * (C) Copyright 1999 Roman Weissgaerber <weissg@vienna.at>
> + * (C) Copyright 2000-2002 David Brownell <dbrownell@users.sourceforge.net>
> + * (C) Copyright 2002 Hewlett-Packard Company
> + *
> + * Bus Glue for AMD Alchemy Au1xxx
> + * Written by Christopher Hoover <ch@hpl.hp.com>
> + * Based on fragments of previous driver by Rusell King et al.
> + *
> + * Modified for LH7A404 from ohci-sa1111.c
> + *  by Durgesh Pattamatta <pattamattad@sharpsec.com>
> + * Modified for AMD Alchemy Au1xxx
> + *  by Matt Porter <mporter@kernel.crashing.org>
> + *
> + * This file is licenced under the GPL.
> + */

Please correct the comments!  I also think that most of the people
which are attributed
here should be removed.  Perhaps simply state which file you used for
inspiration?
("derived from ohci-whatever.c").


Manuel
