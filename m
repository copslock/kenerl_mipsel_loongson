Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 May 2014 19:07:10 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:53703 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6854792AbaESRHGt12c9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 May 2014 19:07:06 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s4JH71qK012079;
        Mon, 19 May 2014 19:07:01 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s4JH6wej012069;
        Mon, 19 May 2014 19:06:58 +0200
Date:   Mon, 19 May 2014 19:06:58 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Chen Jie <chenj@lemote.com>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Huacai Chen <chenhc@lemote.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        =?utf-8?B?546L6ZSQ?= <wangr@lemote.com>
Subject: Re: [PATCH 2/2] MIPS: lib: csum_partial: use wsbh/movn on ls3
Message-ID: <20140519170658.GB17197@linux-mips.org>
References: <1400401410-32600-1-git-send-email-chenj@lemote.com>
 <CAAhV-H6zvhUvjoQiG9-e5HHGBkbLJvN_LkbEZWEzfjJEmrmLgg@mail.gmail.com>
 <20140519100244.GL63315@pburton-linux.le.imgtec.org>
 <CAGXxSxWD2ryrv0JHnOUpDkjXGGKLk=5=RYH_aEXsq9kCu40LfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXxSxWD2ryrv0JHnOUpDkjXGGKLk=5=RYH_aEXsq9kCu40LfQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Mon, May 19, 2014 at 11:15:15PM +0800, Chen Jie wrote:

> 2014-05-19 18:02 GMT+08:00 Paul Burton <paul.burton@imgtec.com>:
> > On Sun, May 18, 2014 at 10:39:20PM +0800, Huacai Chen wrote:
> >> Due to Wang Rui's tests, Loongson-3's EI/DI instructions don't have
> >> correct behaviors, its Status.FR is also different with MIPS64R2. So,
> >> I don't want to select CPU_MIPS64_R2.
> >
> > Out of curiosity, how do ei & di misbehave?
> In our test, it may cause machine stall if use ei&di in kernel,
> especially in smp case.

In that case we could make the use of DI/EI depend on a new errata flag
in war.h or similar.

  Ralf
