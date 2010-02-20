Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Feb 2010 16:04:39 +0100 (CET)
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:9428 "EHLO
        g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492420Ab0BTPEf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Feb 2010 16:04:35 +0100
Received: from g5t0030.atlanta.hp.com (g5t0030.atlanta.hp.com [16.228.8.142])
        by g5t0007.atlanta.hp.com (Postfix) with ESMTP id 973C614427;
        Sat, 20 Feb 2010 15:04:28 +0000 (UTC)
Received: from ldl (ldl.fc.hp.com [15.11.146.30])
        by g5t0030.atlanta.hp.com (Postfix) with ESMTP id F3719140B4;
        Sat, 20 Feb 2010 15:04:27 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
        by ldl (Postfix) with ESMTP id C5A25CF00C7;
        Sat, 20 Feb 2010 08:04:27 -0700 (MST)
Received: from ldl ([127.0.0.1])
        by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0n7LAvLRFmar; Sat, 20 Feb 2010 08:04:27 -0700 (MST)
Received: from [192.168.1.2] (squirrel.fc.hp.com [15.11.146.57])
        by ldl (Postfix) with ESMTP id 56D07CF0013;
        Sat, 20 Feb 2010 08:04:27 -0700 (MST)
Subject: Re: Reverting old hack
From:   Bjorn Helgaas <bjorn.helgaas@hp.com>
To:     Yoichi Yuasa <yuasa@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <20100220211805.6a33e9e2.yuasa@linux-mips.org>
References: <20100220113134.GA27194@linux-mips.org>
         <20100220211805.6a33e9e2.yuasa@linux-mips.org>
Content-Type: text/plain
Date:   Sat, 20 Feb 2010 07:57:49 -0700
Message-Id: <1266677869.1320.8.camel@dc7800.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 
Content-Transfer-Encoding: 7bit
Return-Path: <bjorn.helgaas@hp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bjorn.helgaas@hp.com
Precedence: bulk
X-list: linux-mips

On Sat, 2010-02-20 at 21:18 +0900, Yoichi Yuasa wrote:
> Hi Ralf,
> 
> On Sat, 20 Feb 2010 12:31:34 +0100
> Ralf Baechle <ralf@linux-mips.org> wrote:
> 
> > Below 9f7670e4ddd940d95e48997c2da51614e5fde2cf, an old hack which I
> > committed in December '07 I think mostly for Cobalt machines.  This is
> > now getting in the way - in fact the whole loop in
> > pcibios_fixup_device_resources() may have to go.  So I wonder if this
> > old hack is still necessary.  Only testing can answer so I'm going to
> > put a patch to revert this into the -queue tree for 2.6.34.
> 
> It is still necessary for Cobalt.
> I got the following IDE resource errors.
> 
> pata_via 0000:00:09.1: BAR 0: can't reserve [io  0xf00001f0-0xf00001f7]         
> pata_via 0000:00:09.1: failed to request/iomap BARs for port 0 (errno=-16)      
> pata_via 0000:00:09.1: BAR 2: can't reserve [io  0xf0000170-0xf0000177]         
> pata_via 0000:00:09.1: failed to request/iomap BARs for port 1 (errno=-16)      
> pata_via 0000:00:09.1: no available native port 

Thanks for trying that out.

I'd like to understand the PCI architecture of Cobalt better.  Would you
mind turning on CONFIG_PCI_DEBUG and posting the dmesg log?

The purpose of IORESOURCE_PCI_FIXED is to say that we shouldn't reassign
the device resources.  But the pcibios_fixup_device_resources() loop
isn't *moving* devices, it's merely converting PCI bus addresses to CPU
addresses.  So I suspect that the IORESOURCE_PCI_FIXED test there is
merely covering up another bug.

For example, maybe 00:09.1 is an internal device that's behind a
different host bridge that does no address conversion, or maybe the host
bridge just handles that device specially.  If something like that is
happening, pcibios_bus_to_resource() should be broken for that device,
and fixing that should allow us to remove the IORESOURCE_PCI_FIXED test.

Bjorn
