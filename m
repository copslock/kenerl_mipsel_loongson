Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2012 12:54:22 +0200 (CEST)
Received: from shark3.inbox.lv ([89.111.3.83]:32990 "EHLO shark3.inbox.lv"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1902755Ab2GMKyS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 Jul 2012 12:54:18 +0200
Received: from mail.inbox.lv (pop [10.0.1.110])
        by shark3-plain.inbox.lv (Postfix) with ESMTP id 13B87EEFD
        for <linux-mips@linux-mips.org>; Fri, 13 Jul 2012 13:54:13 +0300 (EEST)
Received: from inbox.lv (unknown [77.125.145.41])
        (Authenticated sender: codeblue@inbox.lv)
        by mail.inbox.lv (Postfix) with ESMTPSA id 4045D18546
        for <linux-mips@linux-mips.org>; Fri, 13 Jul 2012 13:54:10 +0300 (EEST)
Date:   Fri, 13 Jul 2012 10:54:06 +0000
From:   John Long <codeblue@inbox.lv>
To:     linux-mips@linux-mips.org
Subject: Re: Please recommend distro for Lemote Fuloong
Message-ID: <20120713105406.GA30449@inbox.lv>
References: <20120705160222.GJ25225@inbox.lv>
 <CAEdQ38EOyU0WFKosbYmZ5Sa88KByRYeX_PyzzOPbvH+h33Ypdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEdQ38EOyU0WFKosbYmZ5Sa88KByRYeX_PyzzOPbvH+h33Ypdw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: OK
X-archive-position: 33907
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: codeblue@inbox.lv
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, Jul 12, 2012 at 04:52:41PM -0700, Matt Turner wrote:
> On Thu, Jul 5, 2012 at 9:02 AM, Code Blue <codeblue@inbox.lv> wrote:
> > Hi,
> >
> > I just received a Lemote Fuloong Mini and I installed OpenBSD on it. I would
> > like to dual boot Linux but I am having a hard time finding the right distro.
> >
> > I know Lemote and MIPS people are doing a lot of work and submitting patches
> > to the Linux kernel and binutils and I am sure many other areas. Can anyone
> > please recommend a Linux distro that will come with (or can install) a
> > recent kernel so I can take advantage of all this hard work people are
> > doing? Of course I will need a tarball or USB installer since the Fuloong
> > doesn't have an optical drive. Thank you.
> 
> Gentoo.
> 
> Join the #gentoo-mips IRC channel and ping 'blueness' since he's built
> some very nice install stages and netboot images.
> 
> Also, we provide multilib installations with o32, n32, and n64 base
> libraries (n32 is default).

Thanks a lot for the info. For now I have repartitioned the drive and used
all of it for OpenBSD. I hope to get another identical box in the next few
months and then I will look into Gentoo.
