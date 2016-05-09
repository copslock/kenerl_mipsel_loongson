Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 May 2016 23:31:12 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.133]:60642 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028474AbcEIVbIZ7rN2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 May 2016 23:31:08 +0200
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue003) with ESMTPSA (Nemesis) id 0LrG8W-1blQso0eYG-013AWz; Mon, 09 May
 2016 23:30:50 +0200
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
Date:   Mon, 09 May 2016 23:30:47 +0200
Message-ID: <8966187.QMuYcJlN9t@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <5730FCFB.5050005@synopsys.com>
References: <4231696.iL6nGs74X8@debian64> <18362907.sI27LBpJPE@wuerfel> <5730FCFB.5050005@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:61DYW7nKLJixxWHtYBfXeeCFhmkmhvqdozQ3U5hAE4rgonlKm1s
 1T2gR0QqHiJ4bHCxQrzNIRgwqWulR8o1LNi57pnSb97wjR9EaTg498v0rtYn/IRCsyZF5jj
 4kL6cW0IE9enY0jZ/bYVMvJnYTga+0OZUf2lb7Pi9zEVNcQKXmd1OnLwdOXttCc68Cp41Cd
 +rFSrReNIMajGB7P8zn3w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:O8Y4lNO+uoo=:sa36h3uV1MoVJakx4c7c+Z
 CUdQvkQ9+eQAqhVRwNghkx3F8Toc1BAzYr11a954j+gaeWWdnMhNpM9hS2ekljJEFSehLzb9K
 CUh4wLxn/8cDqOWVFoaUTgTMOlkKXhkh7kYulh7JBeTCFb3cbtTyHjufHu2TtH3ePih7PPY1z
 Accjt/x3h/bK3xibbl3xs1wPYAAHONliI27mB7JlbBgUHzEQCJr6HoHriHrhwIod4hx1MPT6n
 aG+Ly5N1w4Ss8Qx5YdkBMMWZ2ULvr4UUeHEPj4SrUOrgbqGFHWuXZR0Z/v0vbEjIf3UNnDOZ5
 mRC5M7GURM70aYuKI6BMbpcxoW4MB0cx9W3kV8UjQM2yKft8+fMZTghcxCp5MhMk7zhIJH0f9
 bQvIe5pivDv8u5L7kOyS8w8e3aL5nfiGF4bsazpb1z4c9Wk7FT7oEYH/VTDQ6x7W/DIQYPkry
 lhvZKQd5j0UzzdvFD6sCwOwusVDRqHVBG56TCXnF7n7nCzEU18BxioA+FEgFi1u7mWdhaN1iL
 71tKCFMEuVuIju1hZ1OfAC29aCC+pg3rP5mmx+YKeG9PxEn3C82QTe55mXR5slcKm2nL0iBV0
 Dilesmd4tvRZmd7DYlbGzfnFdbenXeQ5MXx5ijJPfvHXq40m+bVBLhkYvmX29SnuNGKn13DNW
 qzAUCgJbT7Dwog5VjGOVNlar551LO6WgqE3Z1JmOCT84dik7g7ZLbwZsPo1FQQSJagM/Lafud
 yefiTHbdC6Z4LZOy
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53329
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

On Monday 09 May 2016 14:11:23 John Youn wrote:
> On 5/9/2016 1:39 PM, Arnd Bergmann wrote:
>
> > The systems are not a particular endianess, only the current state
> > of the CPU is, and that may change independent of the way the
> > hardware block got synthesized. We don't support swapping endianess
> > at runtime in Linux, but the system normally doesn't care what we
> > run.
> > 
> > The normal behavior is for the register contents to be read as
> > little-endian, and then swapped on big-endian kernel builds to
> > match what the kernel expects.
> > 
> > MIPS is a special case here, because the endianess of the CPU
> > core is fixed in hardware (or using a strapping pin) and is often
> > tied to the endianess of all the IP blocks. There are a couple
> > of other architectures like this (e.g. ARM ixp4xx, but none of the
> > modern ARM systems).
> 
> Ok thanks. What you're saying is clear now.
> 
> Is there a standard way to handle this? Must all drivers either check
> some endianness configuration or do a runtime check?

There are four common approaches:

1 hardcode a particular endianess because an IP block is always
  used the same way

2 pick the right endianess at compile-time because we know
  what we are building for (typically by CPU architecture, but
  there are some other ways)

3 do runtime configuration based on a DT property or platform data

4 do automatic runtime configuration based on well-known register
  contents

Approach 1 is the most common, in particular as most IP blocks
are not configurable and are not used on big-endian MIPS machines.

Approach 4 as implemented by Christian Lamparter's patch is the
most reliable way, and probably makes most sense for DesignWare
IP blocks in general, because they are configurable and may
get used in all kinds of systems.

Approaches 2 and 3 are somewhat inferior because you have to
rely on everyone else doing it the way you planned, but 2
is particularly easy and 3 is used when there is no obvious
way to detect endianess of the device.

The patch I suggested would be approach 2, and as Felipe correctly
mentioned, it is not ideal, but it may be more appropriate for
backports to the 4.4-longterm, 4.5-stable and 4.6-stable kernels
than the more elaborate patch we are now discussing.

	Arnd
