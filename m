Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jan 2012 23:44:01 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:12558 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903686Ab2A2Wnw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 29 Jan 2012 23:43:52 +0100
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q0TMh6QU030435
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sun, 29 Jan 2012 17:43:07 -0500
Received: from redhat.com (vpn-203-124.tlv.redhat.com [10.35.203.124])
        by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id q0TMgcAV018377;
        Sun, 29 Jan 2012 17:42:39 -0500
Date:   Mon, 30 Jan 2012 00:45:07 +0200
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Richard Henderson <rth@twiddle.net>,
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
Subject: Re: [PATCH-RFC 06/10] mips: switch to GENERIC_PCI_IOMAP
Message-ID: <20120129223339.GA22666@redhat.com>
References: <cover.1322163031.git.mst@redhat.com>
 <66457f7750d7d14229fcf8d0b011aba63185a75d.1322163031.git.mst@redhat.com>
 <CAJiQ=7BPzhWWzU3_nDv3j=ZB4f=iOzeyLyd2L0_3UFaMiLujpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJiQ=7BPzhWWzU3_nDv3j=ZB4f=iOzeyLyd2L0_3UFaMiLujpw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
X-archive-position: 32321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mst@redhat.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sat, Jan 28, 2012 at 02:38:10PM -0800, Kevin Cernekee wrote:
> On Thu, Nov 24, 2011 at 12:18 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > mips copied pci_iomap from generic code, probably to avoid
> > pulling the rest of iomap.c in.  Since that's in
> > a separate file now, we can reuse the common implementation.
> 
> [snip]
> 
> > -       if (flags & IORESOURCE_IO)
> > -               return ioport_map_pci(dev, start, len);
> 
> While investigating a new warning on the 3.3-rc1 MIPS build (unused
> static function ioport_map_pci()), I noticed that this patch has shown
> up in Linus' tree as commit eab90291d35438bcebf7c3dc85be66d0f24e3002.
> 
> I am not completely clear on the implications it has on mapping PCI I/O regions:

Yes, my bad, I missed the difference between ioport_map_pci
and ioport_map for both MIPS and SH.
I'll post a patch to fix this, which is probably preferable
to reintroducing the code duplication where it might
trip us up again.

-- 
MST
