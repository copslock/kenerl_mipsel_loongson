Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Oct 2017 16:28:38 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59822 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992400AbdJIO2aQovL- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Oct 2017 16:28:30 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v99ESOUY018302;
        Mon, 9 Oct 2017 16:28:25 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v99ESOei018301;
        Mon, 9 Oct 2017 16:28:24 +0200
Date:   Mon, 9 Oct 2017 16:28:24 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        adi-buildroot-devel@lists.sourceforge.net,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Steven Miao <realmz6@gmail.com>
Subject: Re: [PATCH 4/7] i2c: gpio: Augment all boardfiles to use open drain
Message-ID: <20171009142824.GB17971@linux-mips.org>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
 <20170917093906.16325-5-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170917093906.16325-5-linus.walleij@linaro.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60347
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

On Sun, Sep 17, 2017 at 11:39:03AM +0200, Linus Walleij wrote:

> Steven (Blackfin): requesting ACK for Wolfram to take this patch.
> Ralf (MIPS): requesting ACK for Wolfram to take this patch.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
