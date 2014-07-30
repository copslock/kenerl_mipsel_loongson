Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2014 10:35:36 +0200 (CEST)
Received: from mail-ie0-f170.google.com ([209.85.223.170]:44856 "EHLO
        mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6836188AbaG3IfdQh1AN convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Jul 2014 10:35:33 +0200
Received: by mail-ie0-f170.google.com with SMTP id rl12so1082406iec.15
        for <linux-mips@linux-mips.org>; Wed, 30 Jul 2014 01:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=mEQtT/kB0v4QpDEz1NC9ruEZUdmU43zxp8TCwxGiE04=;
        b=G0QjbIIPpR/pDQRSFyEIkGjGOW3K/Dtpk0AO2YRXnfFY5PHpndbXfPyMhQ44p5RShk
         gHQcyOl1xdhpOQPiOghnK1s+dTO2Yv2K5ccgZqSVhczLElqNR9gF+QpEnqqsmvfIcW3a
         MfvvJvZwP4rikSuGLTJ3hWVH7Yjsc6g3ZGXcgDIKiByJyG1cKVCnbKKaRRKulINdD3YQ
         LgCu9A560qGMYzZY8CoIogwe6H97ZhUMndw48O/krrPOc/q1phHt2UdVPa4Ty+pheDW0
         nAIGpd6OaVDwa3irL065UlC+c0qUKZ0a2eR5BTQ4Bx/JvVq+RjmLFrlCMDKGNclLQ7i4
         fkZg==
MIME-Version: 1.0
X-Received: by 10.50.8.6 with SMTP id n6mr33800343iga.43.1406709327032; Wed,
 30 Jul 2014 01:35:27 -0700 (PDT)
Received: by 10.64.241.5 with HTTP; Wed, 30 Jul 2014 01:35:26 -0700 (PDT)
In-Reply-To: <20140726145116.GA14047@hall.aurel32.net>
References: <tencent_0448A221440A321914235E33@qq.com>
        <20140726145116.GA14047@hall.aurel32.net>
Date:   Wed, 30 Jul 2014 16:35:26 +0800
X-Google-Sender-Auth: iCSy9zpmekNsgt7z3yQyX1fPCdE
Message-ID: <CAAhV-H6UbeXG__c14qn+ToM_eR1SkOj+BN+7gqG1NxH=RGUBFA@mail.gmail.com>
Subject: Re: SMP IPI issues on Loongson 3A based machines
From:   Huacai Chen <chenhc@lemote.com>
To:     Aurelien Jarno <aurelien@aurel32.net>,
        Binbin Zhou <zhoubb@lemote.com>,
        Kent Overstreet <koverstreet@google.com>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Andreas Barth <aba@ayous.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41804
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Hi, Aurelien,

After some days debugging, we found the root cause: If we revert the
commit 21b40200cfe961 (aio: use flush_dcache_page()), everything is
OK. This commit add two flush_dcache_page() in irq disabled context,
but in MIPS, flush_dcache_page() is implemented via call_function IPI.
Unfortunately, call_function IPI shouldn't be called in irq disabled
context, otherwise there will be deadlock.

I don't know how to solve this problem, since commit 21b40200
shouldn't be reverted (Loongson can revert it because of
hardware-maintained cache, but other MIPS need this). May be the
original author (Kent Overstreet) have good ideas?

Huacai

On Sat, Jul 26, 2014 at 10:51 PM, Aurelien Jarno <aurelien@aurel32.net> wrote:
> On Sat, Jul 26, 2014 at 02:05:28PM +0800, 陈华才 wrote:
>> Hi,
>>
>> I'm debugging, please wait for some time.
>
> Great, thanks! Does it means you have been able to reproduce the issue?
> If not I can provide you a copy of the chroot I used to reproduce the
> issue.
>
> I also tried with the kernel from
> http://dev.lemote.com/cgit/linux-official.git/ but unfortunately
> I haven't been able to get it working correctly with
> PREEMPT_VOLUNTARY=yes. I have tried with the kernel from the master
> branch and after merging the v3.15.6 tag. In one of the case I got the
> following backtrace on the serial console:
>
> | [   75.128906] irq 17, desc: ffffffff80c911e0, depth: 1, count: 0, unhandled: 0
> | [   75.136718] ->handle_irq():  ffffffff80289a18, handle_bad_irq+0x0/0x2d0
> | [   75.144531] ->irq_data.chip(): ffffffff80cbe210, 0xffffffff80cbe210
> | [   75.144531] ->action():           (null)
> | [   75.144531]    IRQ_NOPROBE set
> | [   75.144531] unexpected IRQ # 17
>
> Aurelien
>
> --
> Aurelien Jarno                          GPG: 4096R/1DDD8C9B
> aurelien@aurel32.net                 http://www.aurel32.net
>
