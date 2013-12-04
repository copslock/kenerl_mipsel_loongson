Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Dec 2013 00:56:34 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:58117 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819765Ab3LDX4aej1Py (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Dec 2013 00:56:30 +0100
Received: from localhost (c-76-28-172-123.hsd1.wa.comcast.net [76.28.172.123])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D2F0B269;
        Wed,  4 Dec 2013 23:56:21 +0000 (UTC)
Date:   Wed, 4 Dec 2013 15:29:53 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 0/2] MIPS/staging: Probe octeon-usb driver via device-tree
Message-ID: <20131204232953.GA7698@kroah.com>
References: <1386100012-6077-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1386100012-6077-1-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38644
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

On Tue, Dec 03, 2013 at 11:46:50AM -0800, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Tested against both EdgeRouter LITE (no bootloader supplied device
> tree), and ebb5610 (device tree supplied by bootloader).
> 
> The patch set is spread across both the MIPS and staging trees, so it
> would be great if Ralf could merge at least the MIPS parts, if not
> both parts.

That's fine with me:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
