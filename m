Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Dec 2010 10:44:41 +0100 (CET)
Received: from mail-qy0-f170.google.com ([209.85.216.170]:63924 "EHLO
        mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491041Ab0LXJoi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Dec 2010 10:44:38 +0100
Received: by qyk10 with SMTP id 10so8923743qyk.15
        for <multiple recipients>; Fri, 24 Dec 2010 01:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Hxf2F6gbQLfn0Nq8udECe0JE4vwQrVvzvFOOt5+5cGI=;
        b=YZdt+3TdHc75J68JlozhCw7/OWWylohim49SY6GdItaEqVvGmAB/8YkERuprYvMXTP
         4nSEBPTlIWe+G1vPk/VlqQf0JW07ttbwRsjY87i5WqTrtmu2LjAmkuoSxLEVTWC4Cxgl
         J5QTqYRr1jPmBYRlpg3FLyytmhtDDIv44d19k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=dAO7ct11FZ2vPCERKcFsxKGXN6Ccou/PgE88P5ABQv07N3h2xxosUNq/Vsnp7kz0SK
         YkKbKrVHRWBGH8UtYDXQ8V8j5PY6O1XkJFk/DKrxKrGJE4msq7A1HmikwqNTwGGgegqc
         7DMOmOADY5VkYYmiH1s8WbGIZxy7wEhY+fWZ8=
MIME-Version: 1.0
Received: by 10.229.84.135 with SMTP id j7mr8114640qcl.186.1293183871722; Fri,
 24 Dec 2010 01:44:31 -0800 (PST)
Received: by 10.229.107.10 with HTTP; Fri, 24 Dec 2010 01:44:31 -0800 (PST)
In-Reply-To: <1293028561-22125-1-git-send-email-anoop.pa@gmail.com>
References: <1292929580-5829-1-git-send-email-anoop.pa@gmail.com>
        <1293028561-22125-1-git-send-email-anoop.pa@gmail.com>
Date:   Fri, 24 Dec 2010 03:44:31 -0600
Message-ID: <AANLkTimu_gzsd3NY+HDp7jV+EMtrHGZq7qNc3OedyT3C@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] EHCI support for on-chip PMC MSP USB controller.
From:   Shane McDonald <mcdonald.shane@gmail.com>
To:     "Anoop P.A" <anoop.pa@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Anatolij Gustschin <agust@denx.de>,
        Anand Gadiyar <gadiyar@ti.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28709
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Anoop:

On Wed, Dec 22, 2010 at 8:36 AM, Anoop P.A <anoop.pa@gmail.com> wrote:
> From: Anoop P A <anoop.pa@gmail.com>
>
> This patch includes.
>
> 1. USB host driver for MSP71xx family SoC on-chip USB controller.
> 2. Platform support for USB controller.
>
> Signed-off-by: Anoop P A <anoop.pa@gmail.com>

I tried to apply this patch to a pristine linux-mips.org 2.6.37-rc6 kernel,
but the patch failed on arch/mips/pmc-sierra/msp71xx/Makefile.
I think you must have applied an SMP patch to your tree before
generating this patch.  That was easy to fix, and once I did that,
I tried testing this on a PMC-Sierra MSP7120 Garibaldi evaluation
board.  Using your original changes to drivers/usb/core/hub.c in
addition to this patch, I was able to boot a system, plug a USB hard
drive in, and that drive was recognized by the Garibaldi.

You can add my:

Tested-by: Shane McDonald <mcdonald.shane@gmail.com>
