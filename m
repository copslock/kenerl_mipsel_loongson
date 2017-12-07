Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Dec 2017 14:10:48 +0100 (CET)
Received: from forward106o.mail.yandex.net ([IPv6:2a02:6b8:0:1a2d::609]:36071
        "EHLO forward106o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991534AbdLGNKhBbC53 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Dec 2017 14:10:37 +0100
Received: from mxback8o.mail.yandex.net (mxback8o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::22])
        by forward106o.mail.yandex.net (Yandex) with ESMTP id C686D783AEA;
        Thu,  7 Dec 2017 16:10:29 +0300 (MSK)
Received: from smtp4o.mail.yandex.net (smtp4o.mail.yandex.net [2a02:6b8:0:1a2d::28])
        by mxback8o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 1p35lOVNgY-AQNKnpqT;
        Thu, 07 Dec 2017 16:10:29 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1512652229;
        bh=MvMXlSXiXFy82X+GI16vb+Hc+kxYsglP1z0u9ZOTR5U=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=KZSG+yRP8MoZgTeykHVHCsAbWRvS2YJDclKpC1nTjaiXjYeB/c27MxDLpkJIt44+v
         B485Yp+i0DZ3XOPBuGwfV2/1gxsTv+3G1HDtOTwu+0FZ6k5ZjKtA46Lt47LMA2mm3b
         B2UPF2/hm6umsdVzT5YB9uYjYxktwyzXpLA3ef1A=
Received: by smtp4o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id Wlsznvz1Pk-ADaKZdtA;
        Thu, 07 Dec 2017 16:10:21 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1512652223;
        bh=MvMXlSXiXFy82X+GI16vb+Hc+kxYsglP1z0u9ZOTR5U=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=aX8tMx0adD/KGGAcJus/Sfdfr3imGABgFZ5fcc8x2Asb/sonb4w+jKKU1Mz7/S4YT
         Arik3+PPYa5rtz5n7Z4vR6PPEIY3e4y+rjsJEGXVRFnf/Kw7/5gmIJfvctnHIj8uer
         IXQu5OSgA0/mOOLxmjMN22IiadaKpOF3z5Gm16MI=
Authentication-Results: smtp4o.mail.yandex.net; dkim=pass header.i=@flygoat.com
Message-ID: <1512652210.13996.10.camel@flygoat.com>
Subject: Re: [PATCH 0/1] About MIPS/Loongson maintainance
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     James Hogan <james.hogan@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Huacai Chen <chenhc@lemote.com>,
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
Date:   Thu, 07 Dec 2017 21:10:10 +0800
In-Reply-To: <20171207110549.GM27409@jhogan-linux.mipstec.com>
References: <1512628268-18357-1-git-send-email-chenhc@lemote.com>
         <20171207065759.GC19722@kroah.com>
         <20171207110549.GM27409@jhogan-linux.mipstec.com>
X-Priority: 1
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61339
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

On 2017-12-07 Thu 11:05 +0000，James Hogan Wrote：
> On Thu, Dec 07, 2017 at 07:57:59AM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Dec 07, 2017 at 02:31:07PM +0800, Huacai Chen wrote:
> > > Hi, Linus, Stephen, Greg, Ralf and James,
> > > 
> > > We are kernel developers from Lemote Inc. and Loongson community.
> > > We
> > > have already made some contributions in Linux kernel, but we hope
> > > we
> > > can do more works.
> > > 
> > > Of course Loongson is a sub-arch in MIPS, but linux-mips
> > > community is
> > > so inactive (Maybe maintainers are too busy?) that too many
> > > patches (
> > > Not only for Loongson, but also for other sub-archs) were delayed
> > > for
> > > a long time. So we are seeking a more efficient way to make
> > > Loongson
> > > patches be merged in upstream.
> > > 
> > > Now we have a github organization for collaboration:
> > > https://github.com/linux-loongson/linux-loongson.git
> > 
> > Ick, why not get a kernel.org account for your git tree?
> > 
> > > We don't want to replace linux-mips, we just want to find a way
> > > to co-
> > > operate with linux-mips. So we will still use the maillist and
> > > patchwork
> > > of linux-mips, but we hope we can send pull requests from our
> > > github to
> > > linux-next and linux-mainline by ourselves (if there is no
> > > objections
> > > to our patches from linux-mips community).
> > 
> > What does the mips maintainers think about this?
> > 
> > Odds are a linux-next tree is fine, but they probably want to merge
> > the
> > trees into their larger mips one for the pulls to Linus, much like
> > the
> > arm-core tree works, right?
> 
> I'm not officially a MIPS maintainer but I have donned the hat
> unofficially a few times lately, so FWIW I think the Loongson stuff
> should go through the MIPS tree, since it so often touches core
> architecture code.
Yes we are always touching architecture code. For that part, we'll
still submit our patches to linux-mips tree. But we're also maintaining
many platform code under /arch/mips/loongson64 and also platform
drivers such as hwmon, cpufreq and YeeLoong Laptop driver I'm trying to
submit recently. For that part, make a pull request might be more
efficient than apply patches to linux-mips for many times. Just as what
arm architecture did.

We would like to reduce Ralf's work load. Not bypassing him.

> Clearly there have been some issues getting MIPS stuff applied
> recently,
> but I think the right approach long-term is to try and improve things
> there rather than bypass the MIPS tree altogether.
> 
> I believe assigning a co-maintainer would help spread Ralf's load,
> even
> if that primarily means helping review patches (something we can all
> help with tbh), and being able to ack patches which touch MIPS but
> need
> to go through other subsystem trees (e.g. I know David Daney was
> waiting
> on acks for the MIPS portions of the Octeon III ethernet driver
> series).
I agree with that. Ralf really need help.
> I'm willing to take on that role if Ralf is okay with it. I'm already
> trying to keep track of fixes and spend more time reviewing patches
> on
> the list, but the more who can help out the better.
> 
> The question of who applies patches can't be avoided though. It would
> clearly suck to have all the review in the world but still end up
> with
> the co-maintainer having to take the reigns at the last minute to get
> those important fixes in, and then have no time to apply anything
> substantial for the merge window.
> 
> Cheers
> James
-- 
Jiaxun Yang
