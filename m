Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Mar 2003 16:07:51 +0100 (BST)
Received: from pasmtp.tele.dk ([IPv6:::ffff:193.162.159.95]:19213 "EHLO
	pasmtp.tele.dk") by linux-mips.org with ESMTP id <S8225192AbTCaPHs>;
	Mon, 31 Mar 2003 16:07:48 +0100
Received: from ekner.info (0x83a4a968.virnxx10.adsl-dhcp.tele.dk [131.164.169.104])
	by pasmtp.tele.dk (Postfix) with ESMTP
	id D88D9B5CD; Mon, 31 Mar 2003 17:07:39 +0200 (CEST)
Message-ID: <3E885B68.6927451E@ekner.info>
Date: Mon, 31 Mar 2003 17:14:48 +0200
From: Hartvig Ekner <hartvig@ekner.info>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-19.7.x i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Eric DeVolder <eric.devolder@amd.com>
Cc: Pete Popov <ppopov@mvista.com>,
	Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: Au1500 hardware cache coherency
References: <3E882FB8.BBFDACE2@ekner.info> <3E8853B3.9080902@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <hartvig@ekner.info>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hartvig@ekner.info
Precedence: bulk
X-list: linux-mips

Hi Eric,

is that errata #12 you are referring to? (only present on silicon stepping AB?) Or are there
others also?

While using HW coherency for copying large files on disk, I do get occasional data errors
which always look like this:

  00061000  4c 69 6e 69 65 3a 20 20 20 20 32 34 38 33 32 0a  Linie:    24832.
  00061010  4c 69 6e 69 65 3a 20 20 20 20 32 34 38 33 33 0a  Linie:    24833.
  00061020  4c 69 6e 69 65 3a 20 20 20 20 32 34 38 33 34 0a  Linie:    24834.
  00061030  4c 69 6e 69 65 3a 20 20 20 20 32 34 38 33 35 0a  Linie:    24835.
  00061040  38 33 35 0a 4c 69 6e 69 65 3a 20 20 20 20 32 34  835.Linie:    24
  00061050  38 33 36 0a 4c 69 6e 69 65 3a 20 20 20 20 32 34  836.Linie:    24
  00061060  38 33 37 0a 38 33 37 0a 4c 69 6e 69 65 3a 20 20  837.837.Linie:
  00061070  4c 69 6e 69 65 3a 20 20 20 20 32 34 38 33 39 0a  Linie:    24839.
  00061080  38 33 39 0a 4c 69 6e 69 65 3a 20 20 20 20 32 34  839.Linie:    24
  00061090  38 34 30 0a 4c 69 6e 69 65 3a 20 20 20 20 32 34  840.Linie:    24
  000610a0  38 34 31 0a 38 34 31 0a 4c 69 6e 69 65 3a 20 20  841.841.Linie:
  000610b0  20 20 32 34 65 3a 20 20 20 20 32 34 38 34 33 0a    24e:    24843.
  000610c0  38 34 33 0a 4c 69 6e 69 65 3a 20 20 20 20 32 34  843.Linie:    24
  000610d0  38 34 34 0a 4c 69 6e 69 65 3a 20 20 20 20 32 34  844.Linie:    24
  000610e0  38 34 35 0a 38 34 35 0a 4c 69 6e 69 65 3a 20 20  845.845.Linie:
  000610f0  20 20 32 34 65 3a 20 20 20 20 32 34 38 34 37 0a    24e:    24847.
  00061100  38 34 37 0a 4c 69 6e 69 65 3a 20 20 20 20 32 34  847.Linie:    24
  00061110  38 34 38 0a 4c 69 6e 69 65 3a 20 20 20 20 32 34  848.Linie:    24
  00061120  38 34 39 0a 38 34 39 0a 4c 69 6e 69 65 3a 20 20  849.849.Linie:
  00061130  20 20 32 34 65 3a 20 20 20 20 32 34 38 35 31 0a    24e:    24851.
  00061140  4c 69 6e 69 65 3a 20 20 20 20 32 34 38 35 32 0a  Linie:    24852.
  00061150  4c 69 6e 69 65 3a 20 20 20 20 32 34 38 35 33 0a  Linie:    24853.
  00061160  4c 69 6e 69 65 3a 20 20 20 20 32 34 38 35 34 0a  Linie:    24854.
  00061170  4c 69 6e 69 65 3a 20 20 20 20 32 34 38 35 35 0a  Linie:    24855.
  00061180  4c 69 6e 69 65 3a 20 20 20 20 32 34 38 35 36 0a  Linie:    24856.
  00061190  4c 69 6e 69 65 3a 20 20 20 20 32 34 38 35 37 0a  Linie:    24857.
  000611a0  4c 69 6e 69 65 3a 20 20 20 20 32 34 38 35 38 0a  Linie:    24858.
  000611b0  4c 69 6e 69 65 3a 20 20 20 20 32 34 38 35 39 0a  Linie:    24859.
  000611c0  4c 69 6e 69 65 3a 20 20 20 20 32 34 38 36 30 0a  Linie:    24860.

The file consists of 16-byte lines with increasing line numbers. Note that most of
the errors are cacheline oriented,  but there are also "skews" of 4 bytes going
into the next cacheline.

However, interestingly enough, switching HW coherency off entirely
(in PCI_CFG) and using uncached PCI buffers, there are still failures:

  001ec060  4c 69 6e 69 65 3a 20 20 20 31 32 35 39 35 38 0a  Linie:   125958.
  001ec070  4c 69 6e 69 65 3a 20 20 20 31 32 35 39 35 39 0a  Linie:   125959.
  001ec080  4c 69 6e 69 65 3a 20 20 20 31 32 35 39 36 30 0a  Linie:   125960.
  001ec090  4c 69 6e 69 65 3a 20 20 20 31 32 35 39 36 31 0a  Linie:   125961.
  001ec0a0  00 00 00 00 00 00 00 00 03 00 09 00 00 00 00 00  ................
  001ec0b0  00 00 00 00 00 00 00 00 03 00 0a 00 00 00 00 00  ................
  001ec0c0  4c 69 6e 69 65 3a 20 20 20 31 32 35 39 36 34 0a  Linie:   125964.
  001ec0d0  4c 69 6e 69 65 3a 20 20 20 31 32 35 39 36 35 0a  Linie:   125965.
  001ec0e0  4c 69 6e 69 65 3a 20 20 20 31 32 35 39 36 36 0a  Linie:   125966.
  001ec0f0  4c 69 6e 69 65 3a 20 20 20 31 32 35 39 36 37 0a  Linie:   125967.
  001ec100  00 00 00 00 00 00 00 00 10 00 00 00 c7 00 00 00  ................
  001ec110  00 00 00 00 00 00 00 00 10 00 00 00 dd 00 00 00  ................
  001ec120  4c 69 6e 69 65 3a 20 20 20 31 32 35 39 37 30 0a  Linie:   125970.
  001ec130  4c 69 6e 69 65 3a 20 20 20 31 32 35 39 37 31 0a  Linie:   125971.
  001ec140  4c 69 6e 69 65 3a 20 20 20 31 32 35 39 37 32 0a  Linie:   125972.
  001ec150  4c 69 6e 69 65 3a 20 20 20 31 32 35 39 37 33 0a  Linie:   125973.
  001ec160  4c 69 6e 69 65 3a 20 20 20 31 32 35 39 37 34 0a  Linie:   125974.

Is there anything else than bit 16 in the PCI_CFG register which needs to be set
to force non-coherent PCI accesses and avoid the PCI errata?

/Hartvig



Eric DeVolder wrote:

> There are data cache snoop bugs with respect to PCI on the Au1500. For the
> Au1500s soldered on DbAu1500 boards to-date, PCI can not use coherent
> transactions. Details in the Specification Update for the Au1500
> available from:
>
> www.amd.com/pcs
>   -> Technical Resources
>         -> AMD Alchemy Solutions Development Board Support
>
> Login with your board and you'll be presented with various docs,
> including the
> spec update.
>
> Regards,
> Eric
>
> Hartvig Ekner wrote:
>
> >Hi Pete,
> >
> >I am attempting to use the HW coherency feature of the AU1500 to avoid SW flushes and increase the performance.
> >In the config-shared.in file, I can see that the CONFIG_NONCOHERENT_IO define is always set for the AMD
> >eval boards, which results in SW cache flushes when dma_cache_xxx functions are called. If HW coherency is
> >working, this define should not be set.
> >
> >However, in your drivers, you only call the dma_cache functions from au1000/common/usbdev.c, but not from e.g. the ethernet
> >driver or the audio driver. Is this intentional? It seems that the ethernet & audio driver already relies on HW
> >coherency to function correctly (and it also sets the MAC enable bits accordingly, to force all ETH DMA
> >accesses to be coherent), so why not USB also?
> >
> >When turning off NONCOHERENT_IO, there are some bugs (not in AU1000 code) which prevents the code from
> >compiling, but I have fixed these. And the kernel boots, but during some large disk-copy tests, I get occasional
> >data errors which I'm looking in to.
> >
> >So before spending more time on debugging this, and creating patches for using HW coherency, I wanted to hear
> >your input - maybe there are known problems in the Au1500 coherency implementation?
> >
> >/Hartvig
> >
