Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 May 2014 15:31:37 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:56083 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6819004AbaEVNb1umbGN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 May 2014 15:31:27 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s4MDVQ8R012005;
        Thu, 22 May 2014 15:31:26 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s4MDVMj0012004;
        Thu, 22 May 2014 15:31:22 +0200
Date:   Thu, 22 May 2014 15:31:22 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Bolle <pebolle@tiscali.nl>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: MSP71xx: remove checks for two macros
Message-ID: <20140522133121.GD10287@linux-mips.org>
References: <1400751291.16832.27.camel@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1400751291.16832.27.camel@x220>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40241
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Thu, May 22, 2014 at 11:34:51AM +0200, Paul Bolle wrote:

> Since v2.6.39 there are checks for CONFIG_MSP_HAS_DUAL_USB and checks
> for CONFIG_MSP_HAS_TSMAC in the code. The related Kconfig symbols have
> never been added. These checks have evaluated to false for three years
> now. Remove them and the code they have been hiding.

Queued for 3.16.

  Ralf
