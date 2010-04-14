Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Apr 2010 10:03:23 +0200 (CEST)
Received: from mail-pz0-f186.google.com ([209.85.222.186]:50103 "EHLO
        mail-pz0-f186.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491052Ab0DNIDT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Apr 2010 10:03:19 +0200
Received: by pzk16 with SMTP id 16so4634941pzk.22
        for <multiple recipients>; Wed, 14 Apr 2010 01:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=ZYqdjjD1QwNS65uWijunZJ5X8JnHzKGeeGCzCyFNGDY=;
        b=QJcbnuBRtFxGb6Obcf6/g5MKOUAx6YgEs1fOEwvYb43tRMZSPjh3a+DDJOFo2L+1oG
         52cmgLgzBmROECT2pERyGHszsnW0XFG0X7YeK8SYlA8QyF1VP9CODchuhZtgYYPLaiDf
         WJ9IsLzsuPvwYUqUHUIsN+Z8bDZVFWXXgoFyw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=EyUypCb23RNIgUyoqNUEmvTVVHljkm5E/kas/9mLsXs2QXqAAm464gHypelxcQMsaP
         FZ9lHHwlWu8nX7a57HQgI3DN6YL/zcL/Z9x7tMNjrX1a54HptJ5Ccq6VE3sQwepKrjIL
         94X4NG7hmsBW6PrrHsGWrZzD2bxhlkC4r+VDw=
Received: by 10.115.102.36 with SMTP id e36mr6623024wam.126.1271232192080;
        Wed, 14 Apr 2010 01:03:12 -0700 (PDT)
Received: from [192.168.2.243] ([202.201.14.140])
        by mx.google.com with ESMTPS id 22sm68533pzk.5.2010.04.14.01.03.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Apr 2010 01:03:11 -0700 (PDT)
Subject: Re: [PATCH] MIPS: Calculate proper ebase value for 64-bit kernels
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org
In-Reply-To: <20100413171610.GA16578@linux-mips.org>
References: <1270585790-12730-1-git-send-email-ddaney@caviumnetworks.com>
         <1271135034.25797.41.camel@falcon> <20100413073435.GA6371@alpha.franken.de>
         <20100413171610.GA16578@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Wed, 14 Apr 2010 16:03:05 +0800
Message-ID: <1271232185.25872.142.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26407
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, 2010-04-13 at 18:16 +0100, Ralf Baechle wrote:
> On Tue, Apr 13, 2010 at 09:34:38AM +0200, Thomas Bogendoerfer wrote:
> 
> > On Tue, Apr 13, 2010 at 01:03:54PM +0800, Wu Zhangjin wrote:
> > > This patch have broken the support to the MIPS variants whose
> > > cpu_has_mips_r2 is 0 for the CAC_BASE and CKSEG0 is completely different
> > > in these MIPSs.
> > 
> > I've checked R4k and R10k manulas and the exception base is at CKSEG0, so
> > about CPU we are talking ? And wouldn't it make for senso to have
> > an extra define for the exception base then ?
> 
> C0_ebase's design was a short-sigthed only considering 32-bit processors.
> So the exception base is in CKSEG0 on every 64-bit processor, be it R2 or
> older.  So yes, there is a bug as I've verified by testing but the patch
> is unfortunately incorrect.

Just debugged it via PMON:

loaded the kernel and used "g console=tty root=/dev/hda5 init=/bin/bash"
to start the kernel, there was a bad address exception.

the kernel stopped at:

Exception Cause=address error on store, SR=0x24000002, PC=0x8020526c
...
BADVADDR=0x97ffffff80000100, ENTHI=0xfffffe000
...
...
__copy_user+0x48  ... sd  t0,0(a0)  # addr = 0x80000100 rt=0x401a8000

Seems the a0 argument of __copy_user is _bad_.

And tried to set a break pointer to trap_init() and per_cpu_trap_init(),
and then cpu_cache_init() ... r4k_cache_init() and at last found that
set_uncached_handler(0x100, &except_vec2_generic, 0x80);

/*
 * Install uncached CPU exception handler.
 * This is suitable only for the cache error exception which is the only
 * exception handler that is being run uncached.
 */
void __cpuinit set_uncached_handler(unsigned long offset, void *addr,
        unsigned long size)
{
#ifdef CONFIG_32BIT
        unsigned long uncached_ebase = KSEG1ADDR(ebase);
#endif       
#ifdef CONFIG_64BIT
        unsigned long uncached_ebase = TO_UNCAC(ebase);
#endif       

        if (!addr)
                panic(panic_null_cerr);

        memcpy((void *)(uncached_ebase + offset), addr, size);
}

memcpy() called __copy_user... and the a0 is uncached_ebase + offset,
and uncached_ebase is defined by TO_UNCAC:

#define TO_UNCAC(x)             (UNCAC_BASE | ((x) & TO_PHYS_MASK))
#define TO_PHYS_MASK _CONST64_(0x07ffffffffffffff)
#define UNCAC_BASE _AC(0x9000000000000000, UL)

If using CKSEG0 as the ebase, CKSEG0 is defined as 0xffffffff80000000,
then we get the address: 0x97ffffff80000100, is this address ok?

And before, we have used the CAC_BASE as the ebase, the CAC_BASE is
defined as following:

#ifndef CAC_BASE
#ifdef CONFIG_DMA_NONCOHERENT
#define CAC_BASE                _AC(0x9800000000000000, UL)
#else
#define CAC_BASE                _AC(0xa800000000000000, UL)
#endif
#endif

So, before, the uncached_base is 0x9000000000000000.

Regards,
	Wu Zhangjin
