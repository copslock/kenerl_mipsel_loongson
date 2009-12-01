Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 15:17:33 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:57285 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492486AbZLAORb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Dec 2009 15:17:31 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nB1EHkG0021012;
        Tue, 1 Dec 2009 14:17:46 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nB1EHi94021010;
        Tue, 1 Dec 2009 14:17:44 GMT
Date:   Tue, 1 Dec 2009 14:17:44 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     linux-mips@linux-mips.org, zhangfx@lemote.com
Subject: Re: [PATCH v6 2/8] Loongson: YeeLoong: add platform specific option
Message-ID: <20091201141744.GD14195@linux-mips.org>
References: <cover.1259664573.git.wuzhangjin@gmail.com>
 <e420b43bb54c33343e15cf53baf39806ba6583ae.1259664573.git.wuzhangjin@gmail.com>
 <20091201133427.GB14064@linux-mips.org>
 <1259674751.11106.5.camel@falcon.domain.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1259674751.11106.5.camel@falcon.domain.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25242
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 01, 2009 at 09:39:11PM +0800, Wu Zhangjin wrote:

> On Tue, 2009-12-01 at 13:34 +0000, Ralf Baechle wrote:
> > On Tue, Dec 01, 2009 at 07:07:45PM +0800, Wu Zhangin wrote:
> > 
> > > This patch add a new LEMOTE_YEELOONG2F option, a yeeloong_laptop/
> > > directory for the coming yeeloong specific support, and for the
> > > ec_kb3310b belongs to yeeloong, so, move it to yeeloong_laptop/ too.
> > > 
> > > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> > 
> > I suggest you fold this patch into patch 2/8.
> 
> Sorry, do you mean merging the following two? for this patch itself is
> 2/8?
> 
> [PATCH v6 1/8] Loongson: Lemote-2F: add platform specific submenu
> [PATCH v6 2/8] Loongson: YeeLoong: add platform specific option

Yes.

  Ralf
