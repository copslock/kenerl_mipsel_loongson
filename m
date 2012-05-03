Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 May 2012 21:41:06 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:43608 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903765Ab2ECTlA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 May 2012 21:41:00 +0200
Message-ID: <4FA2DEF4.9050506@openwrt.org>
Date:   Thu, 03 May 2012 21:39:32 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 02/14] MIPS: pci: parse memory ranges from devicetree
References: <1336066949-24546-1-git-send-email-blogic@openwrt.org> <CAMuHMdWkd4YYKp1dBOFXyLFUT=Jc0iE3nb5OqbT6isQ977z1_w@mail.gmail.com>
In-Reply-To: <CAMuHMdWkd4YYKp1dBOFXyLFUT=Jc0iE3nb5OqbT6isQ977z1_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-archive-position: 33133
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Geert,


> There's no pci_load_of_ranges() in arch/powerpc/?
>

Sorry, its based on pci_process_bridge_OF_ranges.

I will fold your comments into the patch,

Thanks,
John
