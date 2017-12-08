Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2017 05:02:22 +0100 (CET)
Received: from forward104j.mail.yandex.net ([IPv6:2a02:6b8:0:801:2::107]:58372
        "EHLO forward104j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990431AbdLHECLgHZIr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Dec 2017 05:02:11 +0100
Received: from mxback18j.mail.yandex.net (mxback18j.mail.yandex.net [IPv6:2a02:6b8:0:1619::94])
        by forward104j.mail.yandex.net (Yandex) with ESMTP id 47F5742620;
        Fri,  8 Dec 2017 07:02:03 +0300 (MSK)
Received: from smtp2p.mail.yandex.net (smtp2p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:7])
        by mxback18j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id s5ilH2B4LV-205GqQQW;
        Fri, 08 Dec 2017 07:02:03 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1512705723;
        bh=W3kbJqESkZc4HEJlKshcpsHzLUVT2DqBfx/sskmDkrg=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=EVdpx0yEVXkW1Pamjdte1njTHyMufKEX/RvZVYltHgffoO7r0MhtgAYHgVzd+1O8c
         he1MPJfn1LN/pUHiMeU511HIAo59cq04RzvZdDzORu3UvI9OGF+FIKoNqN7y1hSYq+
         JXQku/iCVFWCjMlBrvLlrAGgiGEeU6RmRFg4NeUk=
Received: by smtp2p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id xjhMULCYoA-1qYCh4wU;
        Fri, 08 Dec 2017 07:01:58 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1512705719;
        bh=W3kbJqESkZc4HEJlKshcpsHzLUVT2DqBfx/sskmDkrg=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=V6iPk+o5exBqS30b8SLg2UGeqoKQPdFaTnI8O6zLSKosOrxvCPhCKahTQnRm1HzfR
         kfbs+tyyF96FNORTh5nMplyZCYOoTdmezC265p041r/f4V/2+rz1FNUUdAwCv+Uv1s
         6C3qAEKHHmSfTycVpLRWtm35W2i4zUYNTB4Xh4ZM=
Authentication-Results: smtp2p.mail.yandex.net; dkim=pass header.i=@flygoat.com
Message-ID: <1512705706.1756.12.camel@flygoat.com>
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
Date:   Fri, 08 Dec 2017 12:01:46 +0800
In-Reply-To: <20171207141829.GN27409@jhogan-linux.mipstec.com>
References: <1512628268-18357-1-git-send-email-chenhc@lemote.com>
         <20171207065759.GC19722@kroah.com>
         <20171207110549.GM27409@jhogan-linux.mipstec.com>
         <1512652210.13996.10.camel@flygoat.com>
         <20171207141829.GN27409@jhogan-linux.mipstec.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61350
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

On 2017-12-07 Thu 14:18 +0000，James Hogan Wrote：
> On Thu, Dec 07, 2017 at 09:10:10PM +0800, Jiaxun Yang wrote:
> > On 2017-12-07 Thu 11:05 +0000，James Hogan Wrote：
> > > On Thu, Dec 07, 2017 at 07:57:59AM +0100, Greg Kroah-Hartman
> > > wrote:
> > > > On Thu, Dec 07, 2017 at 02:31:07PM +0800, Huacai Chen wrote:
> > > > > Hi, Linus, Stephen, Greg, Ralf and James,
> > > > > 
> > > > > We are kernel developers from Lemote Inc. and Loongson
> > > > > community.
> > > > > We
> > > > > have already made some contributions in Linux kernel, but we
> > > > > hope
> > > > > we
> > > > > can do more works.
> > > > > 
> > > > > Of course Loongson is a sub-arch in MIPS, but linux-mips
> > > > > community is
> > > > > so inactive (Maybe maintainers are too busy?) that too many
> > > > > patches (
> > > > > Not only for Loongson, but also for other sub-archs) were
> > > > > delayed
> > > > > for
> > > > > a long time. So we are seeking a more efficient way to make
> > > > > Loongson
> > > > > patches be merged in upstream.
> > > > > 
> > > > > Now we have a github organization for collaboration:
> > > > > https://github.com/linux-loongson/linux-loongson.git
> > > > 
> > > > Ick, why not get a kernel.org account for your git tree?
> > > > 
> > > > > We don't want to replace linux-mips, we just want to find a
> > > > > way
> > > > > to co-
> > > > > operate with linux-mips. So we will still use the maillist
> > > > > and
> > > > > patchwork
> > > > > of linux-mips, but we hope we can send pull requests from our
> > > > > github to
> > > > > linux-next and linux-mainline by ourselves (if there is no
> > > > > objections
> > > > > to our patches from linux-mips community).
> > > > 
> > > > What does the mips maintainers think about this?
> > > > 
> > > > Odds are a linux-next tree is fine, but they probably want to
> > > > merge
> > > > the
> > > > trees into their larger mips one for the pulls to Linus, much
> > > > like
> > > > the
> > > > arm-core tree works, right?
> > > 
> > > I'm not officially a MIPS maintainer but I have donned the hat
> > > unofficially a few times lately, so FWIW I think the Loongson
> > > stuff
> > > should go through the MIPS tree, since it so often touches core
> > > architecture code.
> > 
> > Yes we are always touching architecture code. For that part, we'll
> > still submit our patches to linux-mips tree. But we're also
> > maintaining
> > many platform code under /arch/mips/loongson64 and also platform
> > drivers such as hwmon, cpufreq and YeeLoong Laptop driver I'm
> > trying to
> > submit recently.
> 
> The drivers at least can always go in via the relevant driver
> subsystem
> anyway, though of course if they're tightly bound to arch headers
> that
> could still be painful, as I found out here when trying to fix some
> build errors there:
> https://lkml.kernel.org/r/20171115211755.25102-1-james.hogan@mips.com
> 
Yes I noticed that previous maintainer have made some problems. I'm
going to fix that later. Also we're going to separate code between
Loongson2 and Loongson3 since they are becoming more and more
identical. But It will cause a lot of changes under march of loongson64
 that currently maintaining by linux-mips community. Send plenty of
patches to mailing list would not be a wise way to do that. So we can
PR these changes to linux-next directly and PR to linux-mips before
merge window.
> Cheers
> James
> 
> > For that part, make a pull request might be more
> > efficient than apply patches to linux-mips for many times. Just as
> > what
> > arm architecture did.
-- 
Jiaxun Yang
