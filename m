Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jun 2012 13:11:42 +0200 (CEST)
Received: from h9.dl5rb.org.uk ([81.2.74.9]:39174 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903705Ab2FVLLi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Jun 2012 13:11:38 +0200
Received: from h5.dl5rb.org.uk (h5.dl5rb.org.uk [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.5/8.14.3) with ESMTP id q5MBBWPP019845;
        Fri, 22 Jun 2012 12:11:32 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.5/8.14.5/Submit) id q5MBBWqA019844;
        Fri, 22 Jun 2012 12:11:32 +0100
Date:   Fri, 22 Jun 2012 12:11:32 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Arnaud Patard <arnaud.patard@rtp-net.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH V3 11/16] drm/radeon: Make radeon card usable for
 Loongson.
Message-ID: <20120622111131.GB18249@linux-mips.org>
References: <1340334073-17804-1-git-send-email-chenhc@lemote.com>
 <1340334073-17804-12-git-send-email-chenhc@lemote.com>
 <87txy3sn20.fsf@lebrac.rtp-net.org>
 <CAAhV-H5q5G87UMn0ixPUVZNcEV1b_qBHJKVKmCJsmzKdEB--4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H5q5G87UMn0ixPUVZNcEV1b_qBHJKVKmCJsmzKdEB--4A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33781
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, Jun 22, 2012 at 06:55:40PM +0800, Huacai Chen wrote:

> > btw, would it be a good idea to use uncached accelerated instead ?
> I have tried uncached accelerated, there will be random points in the
> monitor, it seems a hw issue...

Have you flushed the pages from memory before switching their cache mode
to uncached accelerated?  The MIPS architecture defines the result of
mixing cache modes as UNPREDICTABLE so be careful to flush caches before
switching cache mode of a page.

  Ralf
