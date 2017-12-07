Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Dec 2017 07:58:22 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:34502 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990435AbdLGG6AlQP32 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Dec 2017 07:58:00 +0100
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2A7F9C3A;
        Thu,  7 Dec 2017 06:57:53 +0000 (UTC)
Date:   Thu, 7 Dec 2017 07:57:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        Rui Wang <wangr@lemote.com>, Binbin Zhou <zhoubb@lemote.com>,
        Ce Sun <sunc@lemote.com>, Yao Wang <wangyao@lemote.com>,
        Liangliang Huang <huangll@lemote.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, r@hev.cc,
        zhoubb.aaron@gmail.com, huanglllzu@163.com, 513434146@qq.com,
        1393699660@qq.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] About MIPS/Loongson maintainance
Message-ID: <20171207065759.GC19722@kroah.com>
References: <1512628268-18357-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1512628268-18357-1-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

On Thu, Dec 07, 2017 at 02:31:07PM +0800, Huacai Chen wrote:
> Hi, Linus, Stephen, Greg, Ralf and James,
> 
> We are kernel developers from Lemote Inc. and Loongson community. We
> have already made some contributions in Linux kernel, but we hope we
> can do more works.
> 
> Of course Loongson is a sub-arch in MIPS, but linux-mips community is
> so inactive (Maybe maintainers are too busy?) that too many patches (
> Not only for Loongson, but also for other sub-archs) were delayed for
> a long time. So we are seeking a more efficient way to make Loongson
> patches be merged in upstream.
> 
> Now we have a github organization for collaboration:
> https://github.com/linux-loongson/linux-loongson.git

Ick, why not get a kernel.org account for your git tree?

> We don't want to replace linux-mips, we just want to find a way to co-
> operate with linux-mips. So we will still use the maillist and patchwork
> of linux-mips, but we hope we can send pull requests from our github to
> linux-next and linux-mainline by ourselves (if there is no objections
> to our patches from linux-mips community).

What does the mips maintainers think about this?

Odds are a linux-next tree is fine, but they probably want to merge the
trees into their larger mips one for the pulls to Linus, much like the
arm-core tree works, right?

thanks,

greg k-h
