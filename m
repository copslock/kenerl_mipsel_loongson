Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2014 17:35:28 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:32833 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013415AbaKKQf0hhR6V (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Nov 2014 17:35:26 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sABGZPxK007179;
        Tue, 11 Nov 2014 17:35:25 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sABGZPmO007178;
        Tue, 11 Nov 2014 17:35:25 +0100
Date:   Tue, 11 Nov 2014 17:35:25 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Aaro Koskinen <aaro.koskinen@nsn.com>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] MIPS: cavium-octeon: fix early boot hang on EBH5600 board
Message-ID: <20141111163525.GD29662@linux-mips.org>
References: <1383142087-25995-1-git-send-email-aaro.koskinen@nsn.com>
 <52729302.6090505@gmail.com>
 <20141111161910.GC29662@linux-mips.org>
 <20141111162412.GD6632@ak-desktop.emea.nsn-net.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141111162412.GD6632@ak-desktop.emea.nsn-net.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44008
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

On Tue, Nov 11, 2014 at 06:24:12PM +0200, Aaro Koskinen wrote:

> > Drop?  Apply?  Apply carbon dating first?
> 
> This one is already applied to mainline
> (b2e4f1560f7388f8157dd2c828211abbfad0e806).

Ah, great thanks.  I dropped it then.

We have a bunch more patches that are pending for very long time; I'm
going to post them in the next days.  Not 377 days though :)

  Ralf
