Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2011 17:33:56 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:33678 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491014Ab1FNPdw convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Jun 2011 17:33:52 +0200
Received: by yxe42 with SMTP id 42so1758324yxe.36
        for <multiple recipients>; Tue, 14 Jun 2011 08:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ouFjE4oCkQanBZ79I9Xz/ge7VxEzxhCqLMLAb2sMObw=;
        b=xGFxywx4nlCSTBPJo29gu9hx9sqyX7FY9nv49oa1GVPmzoTSvjRGYSvErQxIw1aTyu
         zXyrwSW21TelwlapDD5J7Hf6f/pHe+uNsAh64DDGxLzO1hrQn5sUDEHO23XnGzYgRx4b
         SDIesl3dfo2ha0N/y+n8IfZSgUaj1fCgPmbtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PGnBm68GpMIz/FuCO+EtEC+WYduAf5ZPKE8HrLpzk/XrR+hbWRtHgQ6czuVy+uIE3o
         xD3sDY88Jzv1vTiZzsnwsKeBZAJVakw2dfs+x5zr8Rle58VZ3UFsICILmCeuEqRGn9BL
         XHSrSxvGfyK62AeB2QMupliFUn1o0uUVIc9qs=
MIME-Version: 1.0
Received: by 10.42.75.202 with SMTP id b10mr5015598ick.242.1308065625473; Tue,
 14 Jun 2011 08:33:45 -0700 (PDT)
Received: by 10.42.169.193 with HTTP; Tue, 14 Jun 2011 08:33:45 -0700 (PDT)
In-Reply-To: <20110610035817.GA6740@linux-mips.org>
References: <1307616525-22028-1-git-send-email-jamie@jamieiles.com>
        <20110610035817.GA6740@linux-mips.org>
Date:   Tue, 14 Jun 2011 09:33:45 -0600
Message-ID: <BANLkTi=0Pk-2YT=jLeBTNLYELfo+e-saZA@mail.gmail.com>
Subject: Re: [PATCH] tty: 8250: handle USR for DesignWare 8250 with correct accessors
From:   Shane McDonald <mcdonald.shane@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Jamie Iles <jamie@jamieiles.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@suse.de>, linux-mips@linux-mips.org,
        Marc St-Jean <bluezzer@gmail.com>,
        Anoop P A <anoop.pa@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 30376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11650

On Thu, Jun 9, 2011 at 9:58 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> If you look at arch/mips/include/asm/pmc-sierra/msp71xx/msp_regs.h there's
>
> #define MSP_UART0_BASE          (MSP_SLP_BASE + 0x100)
>                                        /* UART0 controller base        */
> #define MSP_BCPY_CTRL_BASE      (MSP_SLP_BASE + 0x120)
>                                        /* Block Copy controller base   */
>
> So there are just 0x20 of address space reserved for that UART.  Me thinks
> that PMC-Sierra clamped the 256 byte address space of the DesignWare APB
> UART to what is standard for 16550 class UARTs, 8 registers which at a
> shift of 4 is 0x20 bytes and the status register being accesses is really
> something else.  I'd guess PMC-Sierra just remapped the register to
> another address.

I have confirmed with a contact at PMC-Sierra that this is the case.

Shane
