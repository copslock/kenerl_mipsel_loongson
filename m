Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Nov 2015 13:40:28 +0100 (CET)
Received: from plane.gmane.org ([80.91.229.3]:48434 "EHLO plane.gmane.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007109AbbKUMk0lK-Hq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 21 Nov 2015 13:40:26 +0100
Received: from list by plane.gmane.org with local (Exim 4.69)
        (envelope-from <sgi-linux-mips@m.gmane.org>)
        id 1a07SX-0004nl-AO
        for linux-mips@linux-mips.org; Sat, 21 Nov 2015 13:40:05 +0100
Received: from f054026208.adsl.alicedsl.de ([78.54.26.208])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Sat, 21 Nov 2015 13:40:05 +0100
Received: from albeu by f054026208.adsl.alicedsl.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Sat, 21 Nov 2015 13:40:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-mips@linux-mips.org
From:   Alban <albeu@free.fr>
Subject: Re: [PATCH 06/14] MIPS: Add support for PIC32MZDA platform
Date:   Sat, 21 Nov 2015 12:37:53 +0100
Message-ID: <20151121123753.58eb6e80@tock>
References: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
        <1448065205-15762-7-git-send-email-joshua.henderson@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: f054026208.adsl.alicedsl.de
In-Reply-To: <1448065205-15762-7-git-send-email-joshua.henderson@microchip.com>
X-Newsreader: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Cc:     linux-kernel@vger.kernel.org
Return-Path: <sgi-linux-mips@m.gmane.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50023
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

On Fri, 20 Nov 2015 17:17:18 -0700
Joshua Henderson <joshua.henderson@microchip.com> wrote:

> This adds support for the Microchip PIC32 MIPS microcontroller with
> the specific variant PIC32MZDA. PIC32MZDA is based on the MIPS m14KEc
> core and boots using device tree.
> 
> This includes an early pin setup and early clock setup needed prior to
> device tree being initialized. In additon, an interface is provided to
> synchronize access to registers shared across several peripherals.
> 
> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
>
>[...]
>
> diff --git a/arch/mips/include/asm/mach-pic32/gpio.h
> b/arch/mips/include/asm/mach-pic32/gpio.h new file mode 100644

Custom GPIO header are not used anymore, this file can be dropped.

Alban
