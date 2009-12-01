Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 15:06:36 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:58673 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492583AbZLAOGc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Dec 2009 15:06:32 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nB1E6kub020577;
        Tue, 1 Dec 2009 14:06:46 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nB1E6iTi020575;
        Tue, 1 Dec 2009 14:06:44 GMT
Date:   Tue, 1 Dec 2009 14:06:43 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wu Zhangin <wuzhangjin@gmail.com>
Cc:     linux-mips@linux-mips.org, zhangfx@lemote.com,
        Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH v6 3/8] Loongson: YeeLoong: add backlight driver
Message-ID: <20091201140643.GC14064@linux-mips.org>
References: <cover.1259664573.git.wuzhangjin@gmail.com>
 <4328ee6b15dce3cb600dddf4e7151532ddc77f17.1259664573.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4328ee6b15dce3cb600dddf4e7151532ddc77f17.1259664573.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25241
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 01, 2009 at 07:08:42PM +0800, Wu Zhangin wrote:

> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> This patch adds YeeLoong Backlight Driver, which provides standard
> interface for user-space applications to control the brightness of the
> backlight.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

You split old, big driver into several individual drivers - good.

Now we can actually move things to their rightf place and for a backlight
drivers that should be drivers/video/backlight/.  Convert it to a platform
driver.

  Ralf
