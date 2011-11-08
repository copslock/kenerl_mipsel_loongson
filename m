Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2011 16:24:01 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:32946 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903661Ab1KHPX4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Nov 2011 16:23:56 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pA8FNsnn005876;
        Tue, 8 Nov 2011 15:23:54 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pA8FNsiY005875;
        Tue, 8 Nov 2011 15:23:54 GMT
Date:   Tue, 8 Nov 2011 15:23:54 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 8/9] MIPS: Add board_* hooks for ebase and NMI
Message-ID: <20111108152354.GB1491@linux-mips.org>
References: <c2c8833593cb8eeef5c102468e105497@localhost>
 <338065dfaf54d0ca25497eabf63a54f0@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <338065dfaf54d0ca25497eabf63a54f0@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6811

On Sat, Nov 05, 2011 at 02:21:17PM -0700, Kevin Cernekee wrote:

> Certain BMIPS platforms need to move the exception vectors and/or
> intercept NMI events.  Add hooks to make this possible.

There are other potencial users of NMI hooks and exporting random
function pointers has never been terribly stylish.  I instead suggest
to use notifiers, see <linux/notifiers.h>.

Due to the locking constraints in an NMI board_nmi_handler should then
become a raw notifier and the board_ebase_setup() function could
just go away.

  Ralf
