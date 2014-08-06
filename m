Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Aug 2014 19:10:17 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:34937 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6863073AbaHFRKLP71Ze (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 6 Aug 2014 19:10:11 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.4) with ESMTP id s76GRLFK012069;
        Wed, 6 Aug 2014 18:30:01 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s76GRHk0012060;
        Wed, 6 Aug 2014 18:27:17 +0200
Date:   Wed, 6 Aug 2014 18:27:17 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        David Daney <ddaney@caviumnetworks.com>,
        James Hogan <james@albanarts.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: tlbex: fix a missing statement for HUGETLB
Message-ID: <20140806162716.GA5855@linux-mips.org>
References: <53D9674E.4000507@caviumnetworks.com>
 <CAAhV-H51phVJvSTv_GMw15RpKp32vmNgj2QSzYzf+UOMK0koyw@mail.gmail.com>
 <53D99854.8090109@caviumnetworks.com>
 <53DA2E66.20200@imgtec.com>
 <53DA7E03.9090306@caviumnetworks.com>
 <20140802213538.GC19066@hall.aurel32.net>
 <53DF5BB2.70502@imgtec.com>
 <20140804130506.GA27352@hall.aurel32.net>
 <53DF864B.6000702@imgtec.com>
 <CAAhV-H56MhaMvjX1T4uj=DhC9vgibVvAOa+-u5n_s1cwP4EHzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H56MhaMvjX1T4uj=DhC9vgibVvAOa+-u5n_s1cwP4EHzw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41890
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

On Tue, Aug 05, 2014 at 03:09:04PM +0800, Huacai Chen wrote:

> Now what should we do? My original patch is not perfect, but it has
> already merged into Ralf's tree (but hasn't merged in Linus's tree).
> Let me send Ralf a new version of this patch? Or let David send
> another patch on top of my original one?

I'll create an incremental patch so you don't need to do anything.

  Ralf
