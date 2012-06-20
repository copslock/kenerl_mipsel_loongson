Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2012 14:51:33 +0200 (CEST)
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:35944 "EHLO
        eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903418Ab2FTMv2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jun 2012 14:51:28 +0200
Received: from beta.dmz-eu.st.com ([164.129.1.35]) (using TLSv1) by eu1sys200aob112.postini.com ([207.126.147.11]) with SMTP
        ID DSNKT+HHQTw17xFnFG1f9XKAr/8qK7wsituY@postini.com; Wed, 20 Jun 2012 12:51:28 UTC
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8927F108;
        Wed, 20 Jun 2012 12:50:10 +0000 (GMT)
Received: from mail7.sgp.st.com (mail7.sgp.st.com [164.129.223.81])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E5FEA476A;
        Wed, 20 Jun 2012 12:50:09 +0000 (GMT)
Received: from [10.52.139.57] (ctn000522.ctn.st.com [10.52.139.57])
        by mail7.sgp.st.com (MOS 4.3.3-GA)
        with ESMTP id AMM97094 (AUTH cavagiu);
        Wed, 20 Jun 2012 14:50:09 +0200
Message-ID: <4FE1C6FF.9070302@st.com>
Date:   Wed, 20 Jun 2012 14:50:07 +0200
From:   Giuseppe CAVALLARO <peppe.cavallaro@st.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
MIME-Version: 1.0
To:     Paul Mundt <lethal@linux-sh.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org,
        Linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>
Subject: Re: Build regressions/improvements in v3.5-rc3
References: <1339962373-3224-1-git-send-email-geert@linux-m68k.org> <CAMuHMdVfLjgrtWoPpvbLf12+=ApE6W9dNcweqD-_2Benr-D7NQ@mail.gmail.com> <20120620035951.GC5623@linux-sh.org>
In-Reply-To: <20120620035951.GC5623@linux-sh.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 33741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peppe.cavallaro@st.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello Paul

On 6/20/2012 5:59 AM, Paul Mundt wrote:
> On Sun, Jun 17, 2012 at 09:56:59PM +0200, Geert Uytterhoeven wrote:
>> On Sun, Jun 17, 2012 at 9:46 PM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>>> JFYI, when comparing v3.5-rc3 to v3.5-rc2[3], the summaries are:
>>> ??- build errors: +235/-10
>>
>> Truckloads of powerpc "Unrecognized opcode" breakage, and
>>
> That was my fault, should be fixed up by 2603efa31a.
> 
>>   + drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c: error: implicit
>> declaration of function 'pci_iomap'
>> [-Werror=implicit-function-declaration]:  => 90:3
>>   + drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c: error: implicit
>> declaration of function 'pci_iounmap'
>> [-Werror=implicit-function-declaration]:  => 142:2
>>
> Not sure about this one, it should find everything alright via:
> 
> 	linux/io.h -> asm/io.h -> asm-generic/iomap.h -> asm-generic/pci_iomap.h
> 
> in the case that PCI is enabled. None of allyesconfig/modconfig enable
> PCI for me though, so I'm unsure of how you got in to this configuration
> to begin with?

Trying to reproduce the problem, I've also re-built the mainstream
kernel 3.5-rc3 for se7724_defconfig platform plus the stmmac (pltf and
pci) but all compiles fine.

I've also verified that there is the 33d5e332b9c5 commit that is the
latest one discussed/tested/committed in the network mailing list.

Can you tell me how to reproduce the problem? How can I help?

Pls let me know,
Peppe
