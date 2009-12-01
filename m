Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 16:17:55 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:52714 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492724AbZLAPRu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Dec 2009 16:17:50 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nB1FI6dx023155;
        Tue, 1 Dec 2009 15:18:07 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nB1FI5s2023153;
        Tue, 1 Dec 2009 15:18:05 GMT
Date:   Tue, 1 Dec 2009 15:18:05 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Rafael J. Wysocki" <rjw@sisk.pl>
Cc:     Wu Zhangin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        zhangfx@lemote.com, Pavel Machek <pavel@ucw.cz>,
        linux-pm@lists.linux-foundation.org
Subject: Re: [PATCH v6 7/8] Loongson: YeeLoong: add suspend driver
Message-ID: <20091201151805.GA23019@linux-mips.org>
References: <cover.1259660040.git.wuzhangjin@gmail.com>
 <2574dde59f2e54ef9fa80423a7f02ed32eab7ab4.1259664573.git.wuzhangjin@gmail.com>
 <200912011324.29486.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200912011324.29486.rjw@sisk.pl>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25250
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 01, 2009 at 01:24:29PM +0100, Rafael J. Wysocki wrote:

> On Tuesday 01 December 2009, Wu Zhangin wrote:
> > From: Wu Zhangjin <wuzhangjin@gmail.com>
> > 
> > This patch adds Suspend Driver, which will suspend the YeeLoong Platform
> > specific devices.
> > 
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> I'm still not sure how useful it is to build it as a module, but otherwise

I think I agree with that.  Maybe even one step further and just build
this code depending on CONFIG_PM or similar?

  Ralf
