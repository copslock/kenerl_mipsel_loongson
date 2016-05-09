Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 May 2016 22:39:19 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.10]:63038 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028467AbcEIUjRxBHEF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 May 2016 22:39:17 +0200
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue103) with ESMTPSA (Nemesis) id 0ME41n-1aqkTT0uch-00HNOP; Mon, 09 May
 2016 22:39:00 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     John Youn <John.Youn@synopsys.com>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "benh@au1.ibm.com" <benh@au1.ibm.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Christian Lamparter <chunkeey@googlemail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "a.seppala@gmail.com" <a.seppala@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since 4.3.0-rc4
Date:   Mon, 09 May 2016 22:38:57 +0200
Message-ID: <18362907.sI27LBpJPE@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <5730F198.2080105@synopsys.com>
References: <4231696.iL6nGs74X8@debian64> <4162108.qmr2GZCaDN@wuerfel> <5730F198.2080105@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:diB5w9ZgfL2+/buw/1HEYeIQMCZeS+eEWnUa3/TrKAwYFLCX6YU
 bdWifT996auZ42RvrpW99pbB0D2I82ZZ/PQPFNp7l2E2PQkjiuwJk5oVcAb/ll4LFNAJK0i
 RWyKDas9kCWRO/3vVB5ghr4N2ibptTDaFMFQ3W5en62KDiK9c18Is7awSYvXkAkwehFo71g
 KV0eIY2qJsNf0dvQllP3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GDI77rkNJ4s=:09hv62p25N54BhiNwcJeLe
 8XNSFD5VNovG8UOoehOIpl/L36K2b4Vzsb2FhaGNRUfv1I4BpCsqSS2fK8+ZTMdTuvwTY/3rB
 X627gZY+FVeFiG95PQR5h8i91cF+HW/w/qfnEmpujWP/kY9oyXwxASncm98YrORdYs7WpOned
 kT4vkggsJi/gbFlgI90/QhLJsFyV4wWhyWTUWCWqdbId37/lha+H0zM7ASbpdwc+vYaGg7OWR
 j2FyUzckyr5hGS/ajQ/sknIe1aIMrQCHo6TVhwk9R2qm2JIAmQDPeEXRkxhZ/T0+9uX3iGZid
 1xeszwjFEvUXvsjP1qD/6zKaNCAjBM7YQt5W4JFcUQ+lSpTdLbcbLW3gm7YwZUp7H4pq2Af7W
 WeVooQQO6+Ioa4gvgpJ1WvPbQ88rRrS3GCrfUapRMBhKjinrxiFZsxicPb34MA+lkMm/cCQbX
 y/7Hjs2bk+y2+9GDi7BemulI+Ug41X2sO7pqkN+JUksSrmLLFa489Rqk6vzQQso9CL0hqveuN
 mgJxtz2I/nC9DuCL1Qn0+ZiMAkmZtIkpxW8BlFaZrCzuN2uqQJkUus0NMJ3AifeAdtBGIEJRJ
 ApqNI6xDxTBxXgszh4gKSLvf6pAbzbfSt9VT3sKrZpd9CM+owIHpeN5IDUve2O/JTIG1g0ZY/
 57gXM4u/Dk8uW+8da7LCJMsTXw4OPEdtz2AB86CY+evLUVqKDJubfyIawDnkR0zArh8ap5h+1
 y5zosJtBCsNWpXdW
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53327
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Monday 09 May 2016 13:22:48 John Youn wrote:
> On 5/9/2016 3:36 AM, Arnd Bergmann wrote:
> > On Monday 09 May 2016 10:23:22 Benjamin Herrenschmidt wrote:
> >> On Sun, 2016-05-08 at 13:44 +0200, Christian Lamparter wrote:
> >>> On Sunday, May 08, 2016 08:40:55 PM Benjamin Herrenschmidt wrote:
> >>>>
> >>>> On Sun, 2016-05-08 at 00:54 +0200, Christian Lamparter via Linuxppc-dev 
> >>>> wrote:
> >>>>>
> >>>>> I've been looking in getting the MyBook Live Duo's USB OTG port
> >>>>> to function. The SoC is a APM82181. Which has a PowerPC 464 core
> >>>>> and related to the supported canyonlands architecture in
> >>>>> arch/powerpc/.
> >>>>>
> >>>>> Currently in -next the dwc2 module doesn't load: 
> >>>> Smells like the APM implementation is little endian. You might need to
> >>>> use a flag to indicate what endian to use instead and set it
> >>>> appropriately based on some DT properties.
> >>> I tried. As per common-properties[0], I added little-endian; but it has no
> >>> effect. I looked in dwc2_driver_probe and found no way of specifying the
> >>> endian of the device. It all comes down to the dwc2_readl & dwc2_writel
> >>> accessors. These - sadly - have been hardwired to use __raw_readl and
> >>> __raw_writel. So, it's always "native-endian". While common-properties
> >>> says little-endian should be preferred.
> >>
> >> Right, I meant, you should produce a patch adding a runtime test inside
> >> those functions based on a device-tree property, a bit like we do for
> >> some of the HCDs like OHCI, EHCI etc...
> >>
> >>
> > 
> > The patch that caused the problem had multiple issues:
> > 
> > - it broke big-endian ARM kernels: any machine that was working
> >   correctly with a little-endian kernel is no longer using byteswaps
> >   on big-endian kernels, which clearly breaks them.
> 
> 
> I'm a bit confused about how this is supposed to work. My
> understanding was that the readl() and writel() are defined as little
> endian. So byte-swapping was performed if the architecture is big
> endian. And the raw versions never swapped, always using the "native"
> endianness.
> 
> dwc2 is always treating the result of readl/writel as if it was read
> in native endian. So it needs to read the registers in big-endian on
> big-endian systems.

The hardware has no idea of what endianess the CPU uses at any
given time, it's fixed by the SoC design, so there is no such
thing as "native" endianess for a random IP block.

The readl/writel accessors accomodate for that by swapping the
data on big-endian kernels, because most SoC designers tend to
pick little-endian device registers by default.

> This was the premise on which this patch was made.
> 
> So for big endian systems, isn't what we want is to read in big-endian
> without any byteswapping to little-endian? But your saying this breaks
> big-endian ARM systems as well. Am I missing something?

The systems are not a particular endianess, only the current state
of the CPU is, and that may change independent of the way the
hardware block got synthesized. We don't support swapping endianess
at runtime in Linux, but the system normally doesn't care what we
run.

The normal behavior is for the register contents to be read as
little-endian, and then swapped on big-endian kernel builds to
match what the kernel expects.

MIPS is a special case here, because the endianess of the CPU
core is fixed in hardware (or using a strapping pin) and is often
tied to the endianess of all the IP blocks. There are a couple
of other architectures like this (e.g. ARM ixp4xx, but none of the
modern ARM systems).

	Arnd
