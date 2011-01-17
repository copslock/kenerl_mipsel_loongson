Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jan 2011 12:58:02 +0100 (CET)
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:56898 "EHLO
        bu3sch.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493399Ab1AQL57 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Jan 2011 12:57:59 +0100
Received: by bu3sch.de with esmtpsa (Exim 4.69)
        (envelope-from <mb@bu3sch.de>)
        id 1Penic-0008I0-IW; Mon, 17 Jan 2011 12:57:54 +0100
Subject: Re: Merging SSB and HND/AI support
From:   Michael =?ISO-8859-1?Q?B=FCsch?= <mb@bu3sch.de>
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
In-Reply-To: <AANLkTikJcug7LUTgX_YDD4Z8ZBrdkAdLq8_Epa6TkA5f@mail.gmail.com> (sfid-20110117_122135_343461_FFFFFFFFFA00D75F)
References: <AANLkTi=GDcy50zsC6=Dgv1-Ty3cYK2qpx9o=q3JdXuCh@mail.gmail.com>
         <1295261783.24530.3.camel@maggie>
         <AANLkTikJcug7LUTgX_YDD4Z8ZBrdkAdLq8_Epa6TkA5f@mail.gmail.com>
         (sfid-20110117_122135_343461_FFFFFFFFFA00D75F)
Content-Type: text/plain; charset="UTF-8"
Date:   Mon, 17 Jan 2011 12:57:48 +0100
Message-ID: <1295265468.24530.23.camel@maggie>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Content-Transfer-Encoding: 8bit
Return-Path: <mb@bu3sch.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28932
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mb@bu3sch.de
Precedence: bulk
X-list: linux-mips

On Mon, 2011-01-17 at 12:21 +0100, Jonas Gorski wrote: 
> On 17 January 2011 11:56, Michael Büsch <mb@bu3sch.de> wrote:
> > On Mon, 2011-01-17 at 11:46 +0100, Jonas Gorski wrote:
> >> a) Merge the HND/AI code into the current SSB code, or
> >>
> >> b) add the missing code for SoCs to brcm80211 and replace the SSB code with it.
> >
> > Why can't we keep those two platforms separated?
> > Is there really a lot of shared code between SSB and HND/AI?
> 
> Yes, as far as I understand the AI bus behaves mostly like a SSB bus
> except for places like enabling/disabling cores. E.g. the AI bus also
> has a common core, which has a bit for telling whether its a SSB or AI
> bus, and has the mostly the same registers as the SSB common cores (so
> most driver_chipcommon_* stuff also applies for the AI bus).

Well... I don't really like the idea of running one driver and
subsystem implementation on completely distinct types of silicon.
We will end up with the same mess that broadcom ended up with in
their "SB" code (broadcom's SSB backplane implementation).
For example, in their code the driver calls pci_enable_device() and
related PCI functions, even if there is no PCI device at all. The calls
are magically re-routed to the actual SB backplane.
You'd have to do the same mess with SSB. Calling ssb_device_enable()
will mean "enable the SSB device", if the backplane is SSB, and will
mean "enable the HND/AI" device, if the backplane is HND/AI.

So I'm still in favor of doing a separate HND/AI bus implementation,
even if
that means duplicating a few lines of code. I think that compared to the
workarounds and conditionals needed for getting SSB to run on HND/AI
hardware, it will be a net win.

> > So why do we need to replace or merge SSB in the first place? Can't
> > it co-exist with HND/AI?
> 
> It probably can, but then the SSB code must be at least made AI aware
> so it doesn't try to attach itself if it finds one.

SSB doesn't search for SSB busses in the system, because there's no
way to do so. The architecture (or the PCI/PCMCIA/SDIO device) registers
the bus,
if it detected an SSB device. So for the embedded case, it's hardcoded
in the arch code. For the PCI case it simply depends on the PCI IDs.
I don't see a problem here. Your arch code will already have to know
what machine it is running on. So it will have to decide whether to
register a SSB or HND/AI bus.

It's like a platform_device. However, it doesn't use the platform_device
mechanism. There's no technical reason. It would be trivial to port the
SSB bus registration to use platform_device, however.

> Also I don't know
> if it is a good idea to let arch-specific code depend on code in
> staging.

Sure. The code needs to be cleaned up and moved to the mainline kernel
_anyway_. You don't get around this.

-- 
Greetings Michael.
