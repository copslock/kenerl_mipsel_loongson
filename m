Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2014 12:21:49 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:60372 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6855253AbaHSKVjQ8EJ3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Aug 2014 12:21:39 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s7JALaol023342;
        Tue, 19 Aug 2014 12:21:36 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s7JALaG7023341;
        Tue, 19 Aug 2014 12:21:36 +0200
Date:   Tue, 19 Aug 2014 12:21:36 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@gmail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Alchemy: fix db1200 PSC clock enablement
Message-ID: <20140819102135.GD11547@linux-mips.org>
References: <1408374632-130791-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1408374632-130791-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42144
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

On Mon, Aug 18, 2014 at 05:10:32PM +0200, Manuel Lauss wrote:

> Enable PSC0 (I2C/SPI) clock and leave PSC1 (Audio) alone.  This patch
> restores functionality to both Audio and I2C/SPI.

Applied.  Thanks,

  Ralf
