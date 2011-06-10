Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2011 20:58:31 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:44465 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491108Ab1FJS62 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Jun 2011 20:58:28 +0200
Received: by iwn36 with SMTP id 36so3118191iwn.36
        for <multiple recipients>; Fri, 10 Jun 2011 11:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=I01LqixJctSzwD3TaBgkRvrn6lkxN3TuAPE1uZklsMQ=;
        b=mmyCc1HDLGGAqbDVy00DoTM/9uxgB/2zWIcdgRFNjg4x7AFijZDr3FZBDcpsrFZA05
         6ZqyVR7nak28CQdQz+Cok44dhAQsb9DLZVnL+Nf7Pw4wLUk1OBuu9vAFXsPw1i2qZMU1
         1HS8lvMcOI452ezBWYWScuHp1mJQBxF3F1soI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ufRMSFBtPF2jVrmOUSpOPbNDPUOoosycfTi+xUIIO0YSOz0Co3a2+fSM7tjnfVqkCD
         JqT/aAQNPOx+lpfOEuAKmwQXgH+hh8tAAJS3Bv19c4+uoQN7/CGfTqBbvPQMOSD0rJzu
         HUbyfRRdIamwovj/fr9VTcnQuxndG2prX4Gzc=
MIME-Version: 1.0
Received: by 10.42.99.4 with SMTP id u4mr2888108icn.461.1307732300366; Fri, 10
 Jun 2011 11:58:20 -0700 (PDT)
Received: by 10.42.164.201 with HTTP; Fri, 10 Jun 2011 11:58:20 -0700 (PDT)
In-Reply-To: <20110610035817.GA6740@linux-mips.org>
References: <1307616525-22028-1-git-send-email-jamie@jamieiles.com>
        <20110610035817.GA6740@linux-mips.org>
Date:   Fri, 10 Jun 2011 12:58:20 -0600
Message-ID: <BANLkTikatUdC=9tPts9_UjzHcz1UfTktAg@mail.gmail.com>
Subject: Re: [PATCH] tty: 8250: handle USR for DesignWare 8250 with correct accessors
From:   Shane McDonald <mcdonald.shane@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Jamie Iles <jamie@jamieiles.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@suse.de>, linux-mips@linux-mips.org,
        Marc St-Jean <bluezzer@gmail.com>,
        Anoop P A <anoop.pa@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 30323
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9497

On Thu, Jun 9, 2011 at 9:58 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Thu, Jun 09, 2011 at 11:48:45AM +0100, Jamie Iles wrote:
>
> The original read access was for a read access at offset 0xc0 from the
> base address.  Your patch changes this to offset 0x1f * 4 = 0x7c.
>
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
...
> On a 2nd thought I wonder if the restricted address space of the PMC-Sierra
> variant and the strange remapping would justify treating it as a subvariant
> of the DW APB UART, rename it to UPIO_PMC_MSP_DWAPB, hardcode the access to
> the remapped status register.  And get rid of the unused UPIO_DWAPB32 ...
>
> I've cced a few people who should know more about this.

Marc and I were originally responsible for this code, but we're no longer
at PMC-Sierra, and I don't remember the details.  If Anoop isn't able
confirm Ralf's suspicions regarding the smaller address space
and remapped register, I'll see if I can track down some former co-workers
that could shed some light on this.

Ralf's 2nd thought makes perfect sense to me, though.

Shane
