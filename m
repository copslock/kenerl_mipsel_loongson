Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jan 2015 00:47:52 +0100 (CET)
Received: from mail-wi0-f173.google.com ([209.85.212.173]:52480 "EHLO
        mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009484AbbAVXrvDV1ud (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Jan 2015 00:47:51 +0100
Received: by mail-wi0-f173.google.com with SMTP id r20so45561573wiv.0;
        Thu, 22 Jan 2015 15:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=OSUnI7jXG8VQpKQXPnQkVrrU+rAuVvni1zDh3vIjtj4=;
        b=zDUL8uRRXQUTYkIC+8XjQrY8YuuI3UbsJSH+mv7nqEGmWd5GM0ljtN7bfV9g6JzBfe
         jE2gC8uwS6Zjvr3CjIeKRYmWPLCWhBXxzsVpkxkSj6iXTFSweqj/1Zvx014wBJ5kIEo2
         t+0ZnbEwe4KJrt7fPyS7776e0zuBRoKj6NEwkG7n7x7ejBnsrxaJuT7s1PVJ1UJnl7V2
         O9qXDiLP6i53r3Jg0fiX5YLRaci85pTVOdGektBQcfePlIClv6s6lw7nhJEJ54tD8ZUO
         1YyTOkRwVnHGK89QfIYOE+jMxekX/CZ22asTWRLvhksc4G//FT0ymRaApkg7fXgS6PB5
         ESNA==
X-Received: by 10.180.211.169 with SMTP id nd9mr70993495wic.4.1421970465756;
 Thu, 22 Jan 2015 15:47:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.194.59.199 with HTTP; Thu, 22 Jan 2015 15:47:25 -0800 (PST)
In-Reply-To: <20150122210344.GE13072@google.com>
References: <1420857290-8373-1-git-send-email-robh@kernel.org> <20150122210344.GE13072@google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 22 Jan 2015 17:47:25 -0600
X-Google-Sender-Auth: jxZxkq1ovtRf1Oubiyb5n6VzBE0
Message-ID: <CAL_Jsq+aw0y-1rrF=RMpYKMP4zGfmqzzG5BXYYoFABtKEUpX8Q@mail.gmail.com>
Subject: Re: [PATCH 00/16] PCI generic configuration space accessors
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Howells <dhowells@redhat.com>,
        Greg Ungerer <gerg@uclinux.org>,
        Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <michal.simek@xilinx.com>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@arm.linux.org.uk>,
        Simon Horman <horms@verge.net.au>,
        =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        cbe-oss-dev@lists.ozlabs.org, linux-am33-list@redhat.com,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        SH-Linux <linux-sh@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Thu, Jan 22, 2015 at 3:03 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Fri, Jan 09, 2015 at 08:34:34PM -0600, Rob Herring wrote:
>> This series adds common accessor functions for PCI configuration space
>> accesses. This supports most PCI hosts with memory mapped configuration
>> space like ECAM or hosts with memory mapped address/data registers. ECAM
>> is not generically supported by this series, but could be added on top
>> of this. While some hosts have standard address decoding which could be
>> common as well, the various checks on bus numbers and device numbers are
>> quite varied. It is unclear how much of that is really necessary or
>> could be common.
>>
>> The first 4 patches are preparatory cleanup. Patch 5 introduces the
>> common accessors. The remaining patches convert several PCI host
>> controllers. This is in no way a complete list of host controllers. The
>> conversion of more hosts should be possible. The Designware controller
>> in particular should be able to be converted, but its config space
>> accessors are a mess of override-able functions that I've not gotten my
>> head around.

[...]

> Really nice cleanups.  I added these with the acks so far to a pci/config
> branch for v3.20.  I'll update it with more acks if they trickle in.

Thanks.

> You've structured it nicely so I can also just drop individual arch pieces
> if necessary.  The pieces that haven't been acked yet (hint, hint):
>
>     arch/arm/mach-cns3xxx/pcie.c
>     arch/arm/mach-sa1100/pci-nanoengine.c

Some ARM sub-arch maintainers tend to not respond on things. These are
platforms which aren't very active and aren't going to move to
drivers/pci/host/ anytime soon. Maybe Arnd wants to ack them.

>     arch/mn10300/unit-asb2305/pci.c
>     arch/powerpc
>
> In addition, nobody has acked the frv and mips parts, but they're trivial
> (they only add struct member names) that I can apply them without worrying.

You must pick-up the 4 clean-up ones or the build will break for those
platforms. Or perhaps that will encourage some acks.

I've also got some actual conversions for some MIPS platforms in my
tree I haven't sent out yet. MIPS is fun with all the variety of
endianness and h/w swapping capability or not.

Rob
