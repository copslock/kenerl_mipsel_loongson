Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Sep 2013 15:33:21 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:39450 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6818997Ab3I3NdPJmuct (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Sep 2013 15:33:15 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r8UDXE14012431;
        Mon, 30 Sep 2013 15:33:14 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r8UDXBlO012430;
        Mon, 30 Sep 2013 15:33:11 +0200
Date:   Mon, 30 Sep 2013 15:33:11 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [PATCH] MIPS: Alchemy: MTX-1: fix incorrect placement of
 __initdata tag
Message-ID: <20130930133311.GA12077@linux-mips.org>
References: <1426447.xVtcA00boF@amdc1032>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1426447.xVtcA00boF@amdc1032>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38064
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

On Mon, Sep 30, 2013 at 03:09:20PM +0200, Bartlomiej Zolnierkiewicz wrote:

> __initdata tag should be placed between the variable name and equal
> sign for the variable to be placed in the intended .init.data section.

Thanks Bart, applied.

  Ralf
