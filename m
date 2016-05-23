Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 May 2016 23:34:59 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:50694 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27027854AbcEWVe4Li1zf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 23 May 2016 23:34:56 +0200
Received: from [IPv6:2003:8b:2f17:4100:fd1f:e5ee:f36c:ecf] (p2003008B2F174100FD1FE5EEF36C0ECF.dip0.t-ipconnect.de [IPv6:2003:8b:2f17:4100:fd1f:e5ee:f36c:ecf])
        by hauke-m.de (Postfix) with ESMTPSA id 883EF100052;
        Mon, 23 May 2016 23:34:55 +0200 (CEST)
Subject: Re: Adding support for device tree and command line
To:     linux-mips@linux-mips.org, Jonas Gorski <jogo@openwrt.org>
References: <574372CD.1060201@hauke-m.de>
Cc:     Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Mathias Kresin <openwrt@kresin.me>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <5743777F.9060801@hauke-m.de>
Date:   Mon, 23 May 2016 23:34:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.6.0
MIME-Version: 1.0
In-Reply-To: <574372CD.1060201@hauke-m.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53628
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 05/23/2016 11:14 PM, Hauke Mehrtens wrote:
> Section 3 of this document defines some interfaces how a boot loader
> could forward a command line *or* a device tree to the kernel:
> http://wiki.prplfoundation.org/w/images/4/42/UHI_Reference_Manual.pdf
> This allows only a device tree *or* a command line, not both.
> 
> The Linux kernel also supports an appended device tree. In this case the
> early code overwrites the fw_args to look like the boot loader added a
> device tree. This is done when CONFIG_MIPS_RAW_APPENDED_DTB is activated.
> 
> The problem is when we use an appended device tree and the boot loader
> adds some important information in the kernel command line. In this case
> the command line gets overwritten and we do not get this information.
> This is the case for some lantiq devices were the boot loader provides
> the mac address to the kernel via the kernel command line.
> 
> My proposal to solve this problem is to extend the interface and add a
> option to provide the kernel command line *and* a device tree from the
> boot loader to the kernel.
> 
> a) use fw_arg0 ($a0) = -2 and fill the unused registers fw_arg2 ($a2)
> and fw_arg3 ($a3) with argv and envp.
> 
> b) add a new boot protocol $a0 = -3 with $a1 = DT address, $a2 = argv
> and $a3 = envp.

I just looked a little bit more closely and saw that the command line
uses 3 args. One for the count, one argv and one envp.

I would then only support device tree + count and argv, so the new
interface would not support envp.

> 
> I would prefer solution b).
> 
> This way we would not loose the kernel command line when appending a
> device tree and this could also be used by the boot loader if someone
> wants to.
> 
> Should I send a patch for this?
> 
> Hauke
> 
