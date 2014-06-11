Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2014 19:10:06 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:43000 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6815784AbaFKRKD4wwBw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Jun 2014 19:10:03 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s5BHA2iL023660;
        Wed, 11 Jun 2014 19:10:02 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s5BHA0fF023640;
        Wed, 11 Jun 2014 19:10:00 +0200
Date:   Wed, 11 Jun 2014 19:10:00 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Eunbong Song <eunb.song@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: mips: math-emu: Fix compilation error ieee754.c
Message-ID: <20140611171000.GD26335@linux-mips.org>
References: <2463243.264261402478691777.JavaMail.weblogic@epml26>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2463243.264261402478691777.JavaMail.weblogic@epml26>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40488
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

On Wed, Jun 11, 2014 at 09:24:51AM +0000, Eunbong Song wrote:

> ieee754dp has bitfield member in struct without name. And this
> cause compilation error. This patch removes struct in ieee754dp
> declaration. So compilation error is fixed.
> Signed-off-by: Eunbong Song <eunb.song@samsung.com>

What gcc version are you using?

  Ralf
