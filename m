Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Nov 2013 17:46:23 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:51008 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6838416Ab3KSQioHKEwL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Nov 2013 17:38:44 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id rAJGcL87015946;
        Tue, 19 Nov 2013 17:38:21 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id rAJGcCZ9015945;
        Tue, 19 Nov 2013 17:38:12 +0100
Date:   Tue, 19 Nov 2013 17:38:12 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Shinya Kuribayashi <skuribay@pobox.com>
Cc:     jbaron@akamai.com, mingo@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        florian@openwrt.org, jchandra@broadcom.com, ganesanr@broadcom.com
Subject: Re: [PATCH v2] panic: Make panic_timeout configurable
Message-ID: <20131119163811.GD13331@linux-mips.org>
References: <20131118210436.233B5202A@prod-mail-relay06.akamai.com>
 <20131119090211.GN10382@linux-mips.org>
 <528B7AEF.7020805@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <528B7AEF.7020805@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38547
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

On Tue, Nov 19, 2013 at 11:51:27PM +0900, Shinya Kuribayashi wrote:

> IIRC we had set it to 180 seconds for some historical reasons, but
> I'm afraid nobody can recall the reason why it's set so in 2013...
> Anyway I was thinking it too long and reduced to a few seconds locally
> when debugging, so there shouldn't be a problem with this change.

I think one motivation was to have boards reboot automatically avoiding
the need to walk over to the board just powercycle or reset it - let
alone reseting by emailing/phoning an admin!

But that's a development-specific motivation and it shouldn't result
in a hardcoded reboot timeout for everybody.

  Ralf
