Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Jun 2009 00:12:00 +0200 (CEST)
Received: from main.gmane.org ([80.91.229.2]:45538 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493217AbZFXWLx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Jun 2009 00:11:53 +0200
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MJadf-0002Ir-7p
	for linux-mips@linux-mips.org; Wed, 24 Jun 2009 22:08:19 +0000
Received: from woodchuck.wormnet.eu ([77.75.105.223])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Wed, 24 Jun 2009 22:08:19 +0000
Received: from alex by woodchuck.wormnet.eu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Wed, 24 Jun 2009 22:08:19 +0000
X-Injected-Via-Gmane: http://gmane.org/
To:	linux-mips@linux-mips.org
From:	Alexander Clouter <alex@digriz.org.uk>
Subject:  Re: [PATCH 5/8] add Texas Instruments AR7 support
Date:	Wed, 24 Jun 2009 22:16:23 +0100
Message-ID:  <7mhah6-pmn.ln1@woodchuck.wormnet.eu>
References:  <200906041619.25359.florian@openwrt.org> <200906241112.58301.florian@openwrt.org> <o8f9h6-v4l.ln1@woodchuck.wormnet.eu> <200906241932.09909.florian@openwrt.org>
Mime-Version:  1.0
Content-Type:  text/plain; charset=ISO-8859-15
Content-Transfer-Encoding:  8bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: woodchuck.wormnet.eu
User-Agent: tin/1.9.3-20080506 ("Dalintober") (UNIX) (Linux/2.6.26-1-sparc64 (sparc64))
Return-Path: <sgi-linux-mips@m.gmane.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23492
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips

Hi,

Florian Fainelli <florian@openwrt.org> wrote:
> 
> Le Wednesday 24 June 2009 13:28:56 Alexander Clouter, vous avez écrit :
>>
>> Florian Fainelli <florian@openwrt.org> wrote:
>>
>> > +/*
>> > + * Initializes basic routines and structures pointers, memory size (as
>> > + * given by the bios and saves the command line.
>> > + */
>> > +
>> > +void __init plat_mem_setup(void)
>> > +{
>> > +       unsigned long io_base;
>> > +
>> > +       _machine_restart = ar7_machine_restart;
>> > +       _machine_halt = ar7_machine_halt;
>> > +       pm_power_off = ar7_machine_power_off;
>> > +       panic_timeout = 3;
>> > +
>> > +       io_base = (unsigned long)ioremap(AR7_REGS_BASE, 0x10000);
>> > +       if (!io_base)
>> > +               panic("Can't remap IO base!\n");
>> > +       set_io_port_base(io_base);
>> > +
>>
>> Casting a pointer to a unsigned long...hmmmm.
>>
arch/mips/sgi-ip32/crime.c:crime_init() has the much nicer feeling:

set_io_port_base((unsigned long) ioremap(AR7_REGS_BASE, 0x100000));

At least this approach hides the pointer to int cast'ing.

>> I have been slightly tracking the ar7 code for a while and I have to say
>> it is really looking much nicer now-a-days.  Well done!  If you ever are
>> in London, I'll buy you a beer.
> 
> I am in Paris at the moment, but you can also come here ;)
> 
Noted :)

Cheers

-- 
Alexander Clouter
.sigmonster says: I'm not proud.
