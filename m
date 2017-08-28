Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Aug 2017 14:51:47 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:58116 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992181AbdH1Mv3vBVKs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Aug 2017 14:51:29 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6020388A;
        Mon, 28 Aug 2017 12:51:23 +0000 (UTC)
Date:   Mon, 28 Aug 2017 14:51:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Kevin Cernekee <cernekee@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH 3/8] tty/bcm63xx_uart: use refclk for the expected clock
 name
Message-ID: <20170828125129.GA2652@kroah.com>
References: <20170802093429.12572-1-jonas.gorski@gmail.com>
 <20170802093429.12572-4-jonas.gorski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170802093429.12572-4-jonas.gorski@gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59834
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

On Wed, Aug 02, 2017 at 11:34:24AM +0200, Jonas Gorski wrote:
> We now have the clock available under refclk, so use that.
> 
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
