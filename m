Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2011 10:50:24 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:57092 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491040Ab1FOIuR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jun 2011 10:50:17 +0200
Received: by wyb28 with SMTP id 28so154625wyb.36
        for <multiple recipients>; Wed, 15 Jun 2011 01:50:12 -0700 (PDT)
Received: by 10.216.6.27 with SMTP id 27mr265919wem.69.1308127811976;
        Wed, 15 Jun 2011 01:50:11 -0700 (PDT)
Received: from localhost (gw-ba1.picochip.com [94.175.234.108])
        by mx.google.com with ESMTPS id g4sm120655weg.12.2011.06.15.01.50.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 15 Jun 2011 01:50:10 -0700 (PDT)
Date:   Wed, 15 Jun 2011 09:49:59 +0100
From:   Jamie Iles <jamie@jamieiles.com>
To:     Shane McDonald <mcdonald.shane@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Jamie Iles <jamie@jamieiles.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@suse.de>, linux-mips@linux-mips.org,
        Marc St-Jean <bluezzer@gmail.com>,
        Anoop P A <anoop.pa@gmail.com>
Subject: Re: [PATCH] tty: 8250: handle USR for DesignWare 8250 with correct
 accessors
Message-ID: <20110615084959.GG3075@pulham.picochip.com>
References: <1307616525-22028-1-git-send-email-jamie@jamieiles.com>
 <20110610035817.GA6740@linux-mips.org>
 <BANLkTi=0Pk-2YT=jLeBTNLYELfo+e-saZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BANLkTi=0Pk-2YT=jLeBTNLYELfo+e-saZA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30403
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jamie@jamieiles.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12199

On Tue, Jun 14, 2011 at 09:33:45AM -0600, Shane McDonald wrote:
> On Thu, Jun 9, 2011 at 9:58 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> > If you look at arch/mips/include/asm/pmc-sierra/msp71xx/msp_regs.h there's
> >
> > #define MSP_UART0_BASE          (MSP_SLP_BASE + 0x100)
> >                                        /* UART0 controller base        */
> > #define MSP_BCPY_CTRL_BASE      (MSP_SLP_BASE + 0x120)
> >                                        /* Block Copy controller base   */
> >
> > So there are just 0x20 of address space reserved for that UART.  Me thinks
> > that PMC-Sierra clamped the 256 byte address space of the DesignWare APB
> > UART to what is standard for 16550 class UARTs, 8 registers which at a
> > shift of 4 is 0x20 bytes and the status register being accesses is really
> > something else.  I'd guess PMC-Sierra just remapped the register to
> > another address.
> 
> I have confirmed with a contact at PMC-Sierra that this is the case.

Thanks for confirming that Shane.  I'm currently working on a series to 
move the DesignWare handling code into the pmc-sierra platform and kill 
off UPIO_DWAPB{,32} and will post it in a couple of days.

Jamie
