Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Mar 2015 19:09:35 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:53040 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009498AbbCYSJd3cHOw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Mar 2015 19:09:33 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t2PI9U3a015177;
        Wed, 25 Mar 2015 19:09:30 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t2PI9RmG015174;
        Wed, 25 Mar 2015 19:09:27 +0100
Date:   Wed, 25 Mar 2015 19:09:27 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Alexandre Courbot <gnurou@gmail.com>
Cc:     Huacai Chen <chenhc@lemote.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH V8 3/8] MIPS: Cleanup Loongson-2F's gpio driver
Message-ID: <20150325180927.GI1385@linux-mips.org>
References: <1426213595-28454-1-git-send-email-chenhc@lemote.com>
 <CAAVeFuLytDZwo-=Q3DSxS7jLWbr4Jgf8BsBr9VGptBBu4SzZZg@mail.gmail.com>
 <CAAhV-H5i+ysaJi1=6ftyY_82yGBZnCqpUmCV2ayMVMDFw0uWVQ@mail.gmail.com>
 <CAAVeFuLF7tHgqXbX1MAikM67DwSu729eG0JcBiipSAG=AeBfOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAVeFuLF7tHgqXbX1MAikM67DwSu729eG0JcBiipSAG=AeBfOQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46527
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

On Wed, Mar 25, 2015 at 11:19:01AM +0900, Alexandre Courbot wrote:

> On Wed, Mar 25, 2015 at 10:15 AM, Huacai Chen <chenhc@lemote.com> wrote:
> > I think these three patches can go to GPIO tree, because it has no
> > relationship with others in this series.
> 
> In that case we would need a ack from the MIPS maintainers to move the
> code into drivers/gpio/.

Yes, please.  For all three patches:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
