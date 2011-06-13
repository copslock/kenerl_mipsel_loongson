Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jun 2011 07:11:03 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:62332 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490973Ab1FMFK5 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Jun 2011 07:10:57 +0200
Received: by pvh11 with SMTP id 11so2837438pvh.36
        for <multiple recipients>; Sun, 12 Jun 2011 22:10:49 -0700 (PDT)
Received: by 10.68.12.132 with SMTP id y4mr2039027pbb.296.1307941849061; Sun,
 12 Jun 2011 22:10:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.68.65.134 with HTTP; Sun, 12 Jun 2011 22:10:28 -0700 (PDT)
In-Reply-To: <201106122020.15609.florian@openwrt.org>
References: <20110606010753.GA16202@linux-mips.org> <20110607230218.GA23552@dvomlehn-lnx2.corp.sa.net>
 <BANLkTikjgj-QH=8u6NeGbWHy5hi1jiiU6Q@mail.gmail.com> <201106122020.15609.florian@openwrt.org>
From:   Grant Likely <grant.likely@secretlab.ca>
Date:   Sun, 12 Jun 2011 23:10:28 -0600
X-Google-Sender-Auth: WJo5I40CI6nu-6TJkGpOPhWCIQ0
Message-ID: <BANLkTikJ665cJhNPFMZgs0j3E52_unbcHA@mail.gmail.com>
Subject: Re: Converting MIPS to Device Tree
To:     Florian Fainelli <florian@openwrt.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        David VomLehn <dvomlehn@cisco.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Imre Kaloz <kaloz@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        "Dezhong Diao (dediao)" <dediao@cisco.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 30363
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10391

On Sun, Jun 12, 2011 at 12:20 PM, Florian Fainelli <florian@openwrt.org> wrote:
> On Wednesday 08 June 2011 09:15:14 Geert Uytterhoeven wrote:
>> On Wed, Jun 8, 2011 at 01:02, David VomLehn <dvomlehn@cisco.com> wrote:
>> > I took a look at the issue of passing device trees to the kernel and
>> > started by surveying the methods currently in use for passing
>> > information from the bootloader to the kernel. I came up with the ten
>> > approaches:
>> >
>> > How MIPS Bootloaders Pass Information to the Kernel
>> > ---------------------------------------------------
>> > Apologies for any errors; this was meant more to be a quick survey
>> > rather than a detailed analysis.
>> >
>> > 6.      a0 - argc
>> >        a1 - argv
>> >        a2 - non-standard envp
>> >        Command line created by concatenating argv strings, starting at
>> >        argv[1]. The envp is a pointer to a list of char ptr to name/char
>> >        ptr pairs.
>> >        Platforms: txx9
>>
>> This depends on the actual boot loader. My rbtx4927 has a VxWorks boot
>> loader, which just doesn't pass anything.
>>
>> Cfr. commit 97b0511ce125b0cb95d73b198c1bdbb3cebc4de2 ("MIPS: TXx9:
>> Make firmware parameter passing more robust").
>
> Thinking about this more, on platforms for which we do not have control about
> the bootloader, we can usually still get it to boot a wrapper. Such a wrapper
> could do the following:
>
> - embedd the kernel
> - embedd the appropriate dtb
> - copy the relevant a0-a3 values and pass to the kernel a pointer to the valid
> dtb in the aX register
>
> such a wrapper already exists, which is the code responsible for decompressing
> the kernel in arch/mips/boot/compressed.
>
> If we want to support multiple flavors of the same SoC, using the same kernel
> image, we only need to relink the boot wrapper with the correct dtb (and
> kernel of course).

I'm definitely in favour of this approach (passing the dtb via a
register) instead of passing it via the command line or something
similar.

What strikes me about this debate (aside from the fact that it is the
same debate we had on other architectures when DT was adopted) is that
it seems to be focused on "here are all the different things all the
MIPS platforms are doing now, so how can each of them be modified to
graft in DT support".  However, switching to DT is absolutely a new
boot interface, regardless of how you cut it (or how the dtb address
gets passed).  Since this is something new, I *strongly* recommend
using the opportunity to standardize on a single boot interface when
passing a DT, and it does *not* have to be the same as any of the
existing interfaces.  By having only a single interface into the
kernel, it eliminates any questions about which data the kernel should
use as authoritative (which data takes precidence, legacy or DT), and
you can get away from per-platform interface quirrks.  Firmware needs
to be modified regardless to take advantage full advantage of DT, so
you may as well make them all change to use the same thing.

For firmware that does not, or can not be modified (like deployed
firmware), the zImage wrapper is the ideal place to translate old
firmware data into a DT representation.

On ARM, the kernel can be passed either an ATAGs list (legacy
interface), or a DTB, and because of the signature on the data
structures it can detect which interface it should be using.
On PowerPC, we straight out dropped all the old boot interfaces from
the kernel proper, and we use the zImage wrapper to inject data from
old firmware interfaces into the DT at boot time (linked into the
wrapper)

g.
