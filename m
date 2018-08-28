Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Aug 2018 18:03:03 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:55743 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992494AbeH1QDAt1gpG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Aug 2018 18:03:00 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DD71320797; Tue, 28 Aug 2018 18:02:55 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id B25D320618;
        Tue, 28 Aug 2018 18:02:55 +0200 (CEST)
Date:   Tue, 28 Aug 2018 18:02:54 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: VDSO and dcache aliasing
Message-ID: <20180828160254.GC16561@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

Hello James,

A year ago, you wrote that patch:

https://www.linux-mips.org/archives/linux-mips/2017-06/msg00658.html

You called it a hack but it has been used since then. As you will
certainly realize by now, Ocelot is one of the affected SoC so we would
pretty much like to see this going upstream.

What would be the way forward?

Regards,

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
