Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Jul 2014 18:05:56 +0200 (CEST)
Received: from hall.aurel32.net ([195.154.112.97]:47214 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6861525AbaGZOvZgJH6X (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 26 Jul 2014 16:51:25 +0200
Received: from aurel32 by hall.aurel32.net with local (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1XB3Jc-0003Bo-G5; Sat, 26 Jul 2014 16:51:16 +0200
Date:   Sat, 26 Jul 2014 16:51:16 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Andreas Barth <aba@ayous.org>
Subject: Re: SMP IPI issues on Loongson 3A based machines
Message-ID: <20140726145116.GA14047@hall.aurel32.net>
References: <tencent_0448A221440A321914235E33@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_0448A221440A321914235E33@qq.com>
X-Mailer: Mutt 1.5.21 (2010-09-15)
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41632
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

On Sat, Jul 26, 2014 at 02:05:28PM +0800, 陈华才 wrote:
> Hi,
> 
> I'm debugging, please wait for some time.

Great, thanks! Does it means you have been able to reproduce the issue?
If not I can provide you a copy of the chroot I used to reproduce the
issue.

I also tried with the kernel from
http://dev.lemote.com/cgit/linux-official.git/ but unfortunately 
I haven't been able to get it working correctly with
PREEMPT_VOLUNTARY=yes. I have tried with the kernel from the master
branch and after merging the v3.15.6 tag. In one of the case I got the
following backtrace on the serial console:

| [   75.128906] irq 17, desc: ffffffff80c911e0, depth: 1, count: 0, unhandled: 0
| [   75.136718] ->handle_irq():  ffffffff80289a18, handle_bad_irq+0x0/0x2d0
| [   75.144531] ->irq_data.chip(): ffffffff80cbe210, 0xffffffff80cbe210
| [   75.144531] ->action():           (null)
| [   75.144531]    IRQ_NOPROBE set
| [   75.144531] unexpected IRQ # 17

Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
