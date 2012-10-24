Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Oct 2012 18:24:16 +0200 (CEST)
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:1690 "EHLO
        smtp-vbr13.xs4all.nl" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823040Ab2JXQYPudetD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Oct 2012 18:24:15 +0200
Received: from starbug-2.trinair2002 (dhcp-089-098-069-120.chello.nl [89.98.69.120])
        (authenticated bits=0)
        by smtp-vbr13.xs4all.nl (8.13.8/8.13.8) with ESMTP id q9OGNPMm027120;
        Wed, 24 Oct 2012 18:23:25 +0200 (CEST)
        (envelope-from maarten@treewalker.org)
Received: from hyperion.localnet (hyperion.trinair2002 [192.168.0.43])
        by starbug-2.trinair2002 (Postfix) with ESMTP id B1F2F30AA;
        Wed, 24 Oct 2012 18:23:24 +0200 (CEST)
From:   Maarten ter Huurne <maarten@treewalker.org>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC 11/13] MIPS: JZ4750D: Add Kbuild files
Date:   Wed, 24 Oct 2012 18:16:35 +0200
Message-ID: <4796718.WhuB0k6pfC@hyperion>
User-Agent: KMail/4.9.2 (Linux/3.4.11-2.16-desktop; KDE/4.9.2; x86_64; ; )
In-Reply-To: <1351014241-3207-12-git-send-email-antonynpavlov@gmail.com>
References: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com> <1351014241-3207-12-git-send-email-antonynpavlov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Virus-Scanned: by XS4ALL Virus Scanner
X-archive-position: 34768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maarten@treewalker.org
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

On Tuesday 23 October 2012 21:43:59 Antony Pavlov wrote:
> Add the Kbuild files for the JZ4750D architecture and adds JZ4750D support
> to the MIPS Kbuild files.
[snip]
> diff --git a/arch/mips/jz4750d/Platform b/arch/mips/jz4750d/Platform
> new file mode 100644
> index 0000000..2e4e050
> --- /dev/null
> +++ b/arch/mips/jz4750d/Platform
> @@ -0,0 +1,3 @@
> +platform-$(CONFIG_MACH_JZ4750D)	+= jz4750d/
> +cflags-$(CONFIG_MACH_JZ4750D)	+=
> -I$(srctree)/arch/mips/include/asm/mach-jz4750d
> +load-$(CONFIG_MACH_JZ4750D)	+= 0xffffffff80010000

What is the purpose of padding the load address to 64 bits?

The reason I'm asking is that we encountered a bug with that when creating a 
u-boot image on a 32-bit host machine: the mkimage tool will only parse the 
first 8 hex digits and then inserts the wrong load address into the uImage.

Bye,
		Maarten
