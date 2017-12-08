Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2017 10:35:12 +0100 (CET)
Received: from forward101j.mail.yandex.net ([5.45.198.241]:44628 "EHLO
        forward101j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990439AbdLHJfFjnsHh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Dec 2017 10:35:05 +0100
Received: from mxback10o.mail.yandex.net (mxback10o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::24])
        by forward101j.mail.yandex.net (Yandex) with ESMTP id 07BA51241C53;
        Fri,  8 Dec 2017 12:34:55 +0300 (MSK)
Received: from smtp1j.mail.yandex.net (smtp1j.mail.yandex.net [2a02:6b8:0:801::ab])
        by mxback10o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id ledl4vV0MZ-Yop8gF1M;
        Fri, 08 Dec 2017 12:34:54 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1512725695;
        bh=wHOiWIRus2ZQcVYuAdtmbuYpWcyDyFGk/OJF40IaNCY=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=aCXlrSEChHwq/1HZ8oneM8jH+f2k0U0OvuC9q3prwCVW7ez+c4mnkRoeuLVkOkdWM
         Gs6xywlDZYyeoHKj61JgcRL2PgZ01odlfce5SMO2GfXIJb3ndrGHd3TRJphiXYX9ZC
         pWmX5DXyIOnCs9yPCEVE0PRDEIOQeRd99jgWdWGM=
Received: by smtp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id gzzwNFKryx-YZPelo12;
        Fri, 08 Dec 2017 12:34:47 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1512725688;
        bh=wHOiWIRus2ZQcVYuAdtmbuYpWcyDyFGk/OJF40IaNCY=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=vSDn7CYjAD3F+VYYhBzKScOlFpySrYQyitf2EpFEw1ogtMtR4npm5ef5Bjs3j8UcU
         loiF3US4faRNeEKQqQK0hI84Qw/ptaR8PzC6DpgW0d0fBq0OBYdUdYzC5cq9AIeQQ2
         zCzTKut6LK1fkh9NbvDK5bzbluYQ3F2+dwiIvtx0=
Authentication-Results: smtp1j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Message-ID: <1512725670.1852.15.camel@flygoat.com>
Subject: Re: [PATCH 0/1] About MIPS/Loongson maintainance
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     James Hogan <james.hogan@mips.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Huacai Chen <chenhc@lemote.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rui Wang <wangr@lemote.com>, Binbin Zhou <zhoubb@lemote.com>,
        Ce Sun <sunc@lemote.com>, Yao Wang <wangyao@lemote.com>,
        Liangliang Huang <huangll@lemote.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, r@hev.cc,
        zhoubb.aaron@gmail.com, huanglllzu@163.com, 513434146@qq.com,
        1393699660@qq.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 08 Dec 2017 17:34:30 +0800
In-Reply-To: <20171208075134.GP5027@jhogan-linux.mipstec.com>
References: <1512628268-18357-1-git-send-email-chenhc@lemote.com>
         <20171207065759.GC19722@kroah.com>
         <20171207110549.GM27409@jhogan-linux.mipstec.com>
         <1512652210.13996.10.camel@flygoat.com>
         <20171207141829.GN27409@jhogan-linux.mipstec.com>
         <1512705706.1756.12.camel@flygoat.com>
         <20171208075134.GP5027@jhogan-linux.mipstec.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiaxun.yang@flygoat.com
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

On 2017-12-08 Fri 07:51 +0000，James Hogan Wrote：
> On Fri, Dec 08, 2017 at 12:01:46PM +0800, Jiaxun Yang wrote:
> > Also we're going to separate code between
> > Loongson2 and Loongson3 since they are becoming more and more
> > identical.
> 
> Do you mean you want to combine them?

Sorry, my fault. They're become more and more different and  I'm going
to separate loongson64 into loongson2 and loongson3.

> 
> > But It will cause a lot of changes under march of loongson64
> >  that currently maintaining by linux-mips community. Send plenty of
> > patches to mailing list would not be a wise way to do that. So we
> > can
> > PR these changes to linux-next directly and PR to linux-mips before
> > merge window.

So we can commit by ourselves after subsystem's review to reduce linux-
mips's workload. 
Since Huacai Chen said that we won't send PR, maybe it's unnecessary.
Thanks.

> For the avoidance of doubt, a pull request would not excempt you from
> needing your patches properly reviewed on the mailing lists first.
> 
> And quoting Stephen's boilerplate response to linux-next additions:
> > Thanks for adding your subsystem tree as a participant of linux-
> > next.  As
> > you may know, this is not a judgement of your code.  The purpose of
> > linux-next is for integration testing and to lower the impact of
> > conflicts between subsystems in the next merge window.
> > 
> > You will need to ensure that the patches/commits in your
> > tree/series have
> > been:
> >      * submitted under GPL v2 (or later) and include the
> > Contributor's
> >         Signed-off-by,
> >      * posted to the relevant mailing list,
> >      * reviewed by you (or another maintainer of your subsystem
> > tree),
> >      * successfully unit tested, and
> >      * destined for the current or next Linux merge window.
> > 
> > Basically, this should be just what you would send to Linus (or ask
> > him
> > to fetch).  It is allowed to be rebased if you deem it necessary.
> 
> Cheers
> James
-- 
Jiaxun Yang
