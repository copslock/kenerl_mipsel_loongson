Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Apr 2010 19:39:51 +0200 (CEST)
Received: from mail-bw0-f226.google.com ([209.85.218.226]:38572 "EHLO
        mail-bw0-f226.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492766Ab0DNRjr convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Apr 2010 19:39:47 +0200
Received: by bwz26 with SMTP id 26so433653bwz.27
        for <linux-mips@linux-mips.org>; Wed, 14 Apr 2010 10:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vJTNh/2wldGGuY1mFDyPusTZxcmy6ur5GbU/AaIBBW0=;
        b=MccHOVYj/LYbFt/K24HQ+a4NkXmsv8fOsOLvK03CUULz3PdxFu53bQqwLEGMZ6w8qV
         DM2zL1aRNjhoqiI14wHZoAHfXbl9kl0iPVGVNjdPUf225XLuWM71FajJGZi7vHe+wEVw
         vWkqf6PWnGI9bBb1QBAlvDgqGHTlZT9OydmHA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=an82oqCX2JTzM1pzrv1/DJd/bJsL2psOn6iNf56YRMNzsJmMVExD0uMhZ1bwTN/tlM
         ies9dpw9KLBBClrdOypm/C9jlpuSPRlDdHr34wq4T0jz6GGegrroGlvBLLQq76bMdytQ
         n3LuEuXBAeBslc5iTOOL7rcVyfEx4tuL9pI8Q=
MIME-Version: 1.0
Received: by 10.103.193.7 with HTTP; Wed, 14 Apr 2010 10:39:41 -0700 (PDT)
In-Reply-To: <1269450986-3714-1-git-send-email-manuel.lauss@gmail.com>
References: <1269450986-3714-1-git-send-email-manuel.lauss@gmail.com>
Date:   Wed, 14 Apr 2010 19:39:41 +0200
Received: by 10.102.17.2 with SMTP id 2mr4331976muq.130.1271266782183; Wed, 14 
        Apr 2010 10:39:42 -0700 (PDT)
Message-ID: <t2wf861ec6f1004141039kf25acdddrb1e4639c17ecc8f6@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] serial 8250 platform PM hooks
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Manuel Lauss <manuel.lauss@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26411
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Ping?  Noone interested?

On Wed, Mar 24, 2010 at 7:16 PM, Manuel Lauss
<manuel.lauss@googlemail.com> wrote:
> The following 2 patches implement a PM hook for platform 8250
> UARTs and a sample PM implementation for a MIPS SoC.
>
> Patch #1 hooks a new .pm callback in struct plat_serial8250_port to
> the rest of serial_core's PM infrastructure,
>
> Patch #2 implements uart power gating for Alchemy line of mips socs
> using the new hook.
>
> With these 2 patches serial console on my test system survives
> suspend/resume cycles without having to resort to platform-specific
> hacks in the PM code.
>
> Thanks,
>     Manuel Lauss
>
> Manuel Lauss (2):
>  8250: allow platform uarts to install PM callback.
>  Alchemy: UART PM through serial framework.
>
>  arch/mips/alchemy/common/platform.c |   17 +++++++++++++++++
>  arch/mips/alchemy/common/power.c    |   32 --------------------------------
>  drivers/serial/8250.c               |   31 ++++++++++++++++++++++++++++---
>  include/linux/serial_8250.h         |    6 ++++++
>  4 files changed, 51 insertions(+), 35 deletions(-)
>
>
