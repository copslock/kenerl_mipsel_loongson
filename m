Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Aug 2012 20:13:16 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:44639 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903262Ab2H3SNM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Aug 2012 20:13:12 +0200
Message-ID: <503FACD4.20700@phrozen.org>
Date:   Thu, 30 Aug 2012 20:11:32 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH 0/7] Prerequisites for BCM63XX UDC driver
References: <0f67eabbb0d5c59add27e42a08b94944@localhost>
In-Reply-To: <0f67eabbb0d5c59add27e42a08b94944@localhost>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

On 23/06/12 07:14, Kevin Cernekee wrote:
> These patches are intended to lay the groundwork for a new USB Device
> Controller (gadget UDC) driver.  arch/mips/bcm63xx updates include:
> 
> Clock enable bits
> DMA descriptor updates
> New register and IRQ definitions
> Create platform_device and platform_data
> 
> Baseline is:
> 
> git://git.linux-mips.org/pub/scm/ralf/upstream-sfr.git #mips-for-linux-next
> 
> Note that this is not an OTG-capable controller.  Therefore, boards are
> permanently wired up for either host mode or device mode.  Device vs.
> host can be determined in board_bcm963xx.c based on the detected board ID.
> Some boards have connectors/pads for both modes, but need to be
> reworked to run in device mode; usually this involves moving 0-ohm
> resistors on the D+ and D- lines.


Thanks, queued the whole series for 3.7

	John
