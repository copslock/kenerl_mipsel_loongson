Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Dec 2009 09:18:28 +0100 (CET)
Received: from p549F7A62.dip.t-dialin.net ([84.159.122.98]:53999 "EHLO
        h5.dl5rb.org.uk" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S1492123AbZLVISY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Dec 2009 09:18:24 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nBM8IMt2017868;
        Tue, 22 Dec 2009 08:18:22 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nBM8ILVS017866;
        Tue, 22 Dec 2009 08:18:21 GMT
Date:   Tue, 22 Dec 2009 08:18:21 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David VomLehn <dvomlehn@cisco.com>
Cc:     Yoichi Yuasa <yuasa@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 5/5] MIPS: simplify powertv prom_init_cmdline() and merge
 to prom_init()
Message-ID: <20091222081821.GB6018@linux-mips.org>
References: <20091218212917.f42e8180.yuasa@linux-mips.org>
 <20091218213018.79a9fc11.yuasa@linux-mips.org>
 <20091218213346.01f63eac.yuasa@linux-mips.org>
 <20091218213632.7d5b0037.yuasa@linux-mips.org>
 <20091218213837.270d3854.yuasa@linux-mips.org>
 <20091222013701.GE24784@dvomlehn-lnx2.corp.sa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091222013701.GE24784@dvomlehn-lnx2.corp.sa.net>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 21, 2009 at 05:37:01PM -0800, David VomLehn wrote:

> And, for the final time, this looks good, too, and thanks! (And sorry for the
> duplicate replies)
> Reviewed-by: David VomLehn (dvomlehn@cisco.com)

It may seem repetitive if not plain annoying to send a reply for each
patch of a series but it keeps things easy to follow in patchwork.  Until
Patchwork maybe one day learns something about threading.

  Ralf
