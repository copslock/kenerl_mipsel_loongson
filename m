Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2014 18:01:42 +0200 (CEST)
Received: from hall.aurel32.net ([195.154.112.97]:48027 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860022AbaG3QBkLgkVk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Jul 2014 18:01:40 +0200
Received: from [37.161.205.241] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1XCWJo-0003Hf-J5; Wed, 30 Jul 2014 18:01:32 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1XCWJa-0001FN-RI; Wed, 30 Jul 2014 18:01:18 +0200
Date:   Wed, 30 Jul 2014 18:01:18 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Binbin Zhou <zhoubb@lemote.com>,
        Kent Overstreet <koverstreet@google.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Andreas Barth <aba@ayous.org>
Subject: Re: SMP IPI issues on Loongson 3A based machines
Message-ID: <20140730160118.GA4386@ohm.rr44.fr>
References: <tencent_0448A221440A321914235E33@qq.com>
 <20140726145116.GA14047@hall.aurel32.net>
 <CAAhV-H6UbeXG__c14qn+ToM_eR1SkOj+BN+7gqG1NxH=RGUBFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAAhV-H6UbeXG__c14qn+ToM_eR1SkOj+BN+7gqG1NxH=RGUBFA@mail.gmail.com>
X-Mailer: Mutt 1.5.21 (2010-09-15)
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
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

Hi Hucai,

On Wed, Jul 30, 2014 at 04:35:26PM +0800, Huacai Chen wrote:
> Hi, Aurelien,
> 
> After some days debugging, we found the root cause: If we revert the
> commit 21b40200cfe961 (aio: use flush_dcache_page()), everything is
> OK. This commit add two flush_dcache_page() in irq disabled context,
> but in MIPS, flush_dcache_page() is implemented via call_function IPI.
> Unfortunately, call_function IPI shouldn't be called in irq disabled
> context, otherwise there will be deadlock.

Thanks a lot for digging into the problem. I will try to revert this
patch to confirm it fixes the problem for us, and I'll keep you updated.

> I don't know how to solve this problem, since commit 21b40200
> shouldn't be reverted (Loongson can revert it because of
> hardware-maintained cache, but other MIPS need this). May be the
> original author (Kent Overstreet) have good ideas?

Maybe we should look if it's possible to reduce the window where
interrupts are disabled in this function, but I guess we'll have to wait
for Kent about that. Do we know if other MIPS systems or other
architectures also implement the flush_dcache_page() function via IPI?

Thanks,
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
