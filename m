Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jan 2012 23:38:25 +0100 (CET)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:50028 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903662Ab2A1WiS convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 28 Jan 2012 23:38:18 +0100
Received: by pbdx9 with SMTP id x9so3313486pbd.36
        for <multiple recipients>; Sat, 28 Jan 2012 14:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=0i+RjziX8xr1fw1XyWqYc3ttsNXRW/8Z5EzgKlkyr40=;
        b=RRJfoJqnNF3aaXzqz6P4SPT+/fOKX7TKmuGc4tTb16k5q9ZHS6qRasvkrVsGrVvy85
         GE1jbJ9UAIE1XF3cwBfw5jyTAJzMvx5RG76lei4vvcTAGl5OVTjHBMfPk+y+iH3ob7XL
         2LvRJZW1zIzucIThSKdOqPh7Szlw+dufKDVTM=
MIME-Version: 1.0
Received: by 10.68.73.4 with SMTP id h4mr27207845pbv.27.1327790290371; Sat, 28
 Jan 2012 14:38:10 -0800 (PST)
Received: by 10.68.234.166 with HTTP; Sat, 28 Jan 2012 14:38:10 -0800 (PST)
In-Reply-To: <66457f7750d7d14229fcf8d0b011aba63185a75d.1322163031.git.mst@redhat.com>
References: <cover.1322163031.git.mst@redhat.com>
        <66457f7750d7d14229fcf8d0b011aba63185a75d.1322163031.git.mst@redhat.com>
Date:   Sat, 28 Jan 2012 14:38:10 -0800
Message-ID: <CAJiQ=7BPzhWWzU3_nDv3j=ZB4f=iOzeyLyd2L0_3UFaMiLujpw@mail.gmail.com>
Subject: Re: [PATCH-RFC 06/10] mips: switch to GENERIC_PCI_IOMAP
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Jonas Bonn <jonas@southpole.se>,
        Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Chen Liqin <liqin.chen@sunplusct.com>,
        Lennox Wu <lennox.wu@gmail.com>,
        Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Paul Bolle <pebolle@tiscali.nl>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <rob.herring@calxeda.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Kumar Gala <galak@kernel.crashing.org>,
        Michael Ellerman <michael@ellerman.id.au>,
        Fabio Baltieri <fabio.baltieri@gmail.com>,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        "John W. Linville" <linville@tuxdriver.com>,
        Lasse Collin <lasse.collin@tukaani.org>,
        Arend van Spriel <arend@broadcom.com>,
        Franky Lin <frankyl@broadcom.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@vger.kernel.org,
        microblaze-uclinux@itee.uq.edu.au, linux-mips@linux-mips.org,
        linux@openrisc.net, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 32319
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, Nov 24, 2011 at 12:18 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> mips copied pci_iomap from generic code, probably to avoid
> pulling the rest of iomap.c in.  Since that's in
> a separate file now, we can reuse the common implementation.

[snip]

> -       if (flags & IORESOURCE_IO)
> -               return ioport_map_pci(dev, start, len);

While investigating a new warning on the 3.3-rc1 MIPS build (unused
static function ioport_map_pci()), I noticed that this patch has shown
up in Linus' tree as commit eab90291d35438bcebf7c3dc85be66d0f24e3002.

I am not completely clear on the implications it has on mapping PCI I/O regions:

Prior to this change, the MIPS version of pci_iomap() called a
MIPS-specific function, ioport_map_pci(), which tried to use the PCI
controller's io_map_base field to determine the base address of the
PCI I/O space.  It also had a fallback mechanism to deal with the case
where io_map_base is unset.

Now, in 3.3-rc1, the generic version of pci_iomap() is used instead.
This code just calls arch/mips/lib/iomap.c:ioport_map() on these
regions.  ioport_map() falls through to ioport_map_legacy(), which
always uses mips_io_port_base (not the PCI controller's io_map_base)
as the base address.  But on MIPS, it is still permissible to use
different I/O port bases for PCI devices and for legacy (ISA?)
devices.

Is this new behavior desirable, or are there any supported platforms
on which adverse effects might be seen?

As for my part, I don't use PCI I/O regions at all - just memory
regions.  I'm more worried about making sure my tree builds with 0
warnings.

If we do want to move ahead with the switch to GENERIC_PCI_IOMAP now,
I have patches to scrap iomap-pci.c entirely and squash the unused
function warning.

If we still want to support the case where io_map_base !=
mips_io_port_base, maybe it would be better to revert commit eab90291
for 3.3.

Might also want to take a look at SH since it also appears to have an
orphaned ioport_map_pci() function.

What are your thoughts?
