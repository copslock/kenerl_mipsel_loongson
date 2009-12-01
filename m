Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 16:23:24 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:45719 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492724AbZLAPXV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Dec 2009 16:23:21 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nB1FNdv8023343;
        Tue, 1 Dec 2009 15:23:39 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nB1FNd5b023341;
        Tue, 1 Dec 2009 15:23:39 GMT
Date:   Tue, 1 Dec 2009 15:23:39 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     linux-mips@linux-mips.org, zhangfx@lemote.com,
        Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH v6 3/8] Loongson: YeeLoong: add backlight driver
Message-ID: <20091201152339.GB23019@linux-mips.org>
References: <cover.1259664573.git.wuzhangjin@gmail.com>
 <4328ee6b15dce3cb600dddf4e7151532ddc77f17.1259664573.git.wuzhangjin@gmail.com>
 <20091201140643.GC14064@linux-mips.org>
 <1259679137.12571.4.camel@falcon>
 <20091201145745.GH14064@linux-mips.org>
 <1259679693.12571.8.camel@falcon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1259679693.12571.8.camel@falcon>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25251
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 01, 2009 at 11:01:33PM +0800, Wu Zhangjin wrote:

> This time, I like the folks did under drivers/platform/x86/ ;) which
> will be better to maintain. for all of these drivers are really only
> YeeLoong platform specific ;)

Experience has shown that drivers for a particular subsystem are best
combined in a single menu, in a single directory.  Otherwise any changes
to subsystem's internal APIs will become a major pain.  Which in the
end means arch/ is usually the place for drivers that don't fit into
any established cathegory.

  Ralf
