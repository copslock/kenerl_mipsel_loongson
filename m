Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Dec 2013 09:22:47 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:41506 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821408Ab3LIIWoOmF2j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Dec 2013 09:22:44 +0100
Received: from localhost (unknown [166.170.57.22])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6B966273;
        Mon,  9 Dec 2013 08:22:33 +0000 (UTC)
Date:   Sun, 8 Dec 2013 17:13:56 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org, blogic@openwrt.org,
        jogo@openwrt.org, mbizon@freebox.fr, cernekee@gmail.com,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 0/5] tty: serial: bcm63xx_uart: do not depend on MIPS
Message-ID: <20131209011356.GB7671@kroah.com>
References: <1386296768-20204-1-git-send-email-florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1386296768-20204-1-git-send-email-florian@openwrt.org>
User-Agent: Mutt/1.5.22 (2013-10-16)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

On Thu, Dec 05, 2013 at 06:26:03PM -0800, Florian Fainelli wrote:
> Hi all,
> 
> This patchset reduces the dependency of the bcm63xx_uart on the MIPS BCM63XX
> SoC support code in preparation for being used on different architectures
> such as ARM.
> 
> Due to the MIPS patch which breaks down the register defines, this series
> should ideally go via the MIPS tree.

That's fine with me:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
