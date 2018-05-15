Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 May 2018 22:48:22 +0200 (CEST)
Received: from shards.monkeyblade.net ([184.105.139.130]:57140 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992828AbeEOUsQLdqPC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 May 2018 22:48:16 +0200
Received: from localhost (67.110.78.66.ptr.us.xo.net [67.110.78.66])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 68C2613FA4842;
        Tue, 15 May 2018 13:48:11 -0700 (PDT)
Date:   Tue, 15 May 2018 16:45:02 -0400 (EDT)
Message-Id: <20180515.164502.1934826189006257590.davem@davemloft.net>
To:     alexandre.belloni@bootlin.com
Cc:     Allan.Nielsen@microsemi.com, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, thomas.petazzoni@bootlin.com, andrew@lunn.ch,
        f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        jhogan@kernel.org
Subject: Re: [PATCH net-next v3 0/7] Microsemi Ocelot Ethernet switch
 support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180514200500.2953-1-alexandre.belloni@bootlin.com>
References: <20180514200500.2953-1-alexandre.belloni@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 15 May 2018 13:48:12 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
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

From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Mon, 14 May 2018 22:04:53 +0200

> The ocelot dts changes are here for reference and should probably go
> through the MIPS tree once the bindings are accepted.

Ok, series applied to net-next minus patches #5 and #6.

Thank you.
