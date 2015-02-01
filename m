Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Feb 2015 23:46:35 +0100 (CET)
Received: from mail-la0-f42.google.com ([209.85.215.42]:65473 "EHLO
        mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010831AbbBAWqds9vaM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 1 Feb 2015 23:46:33 +0100
Received: by mail-la0-f42.google.com with SMTP id ms9so35534709lab.1
        for <linux-mips@linux-mips.org>; Sun, 01 Feb 2015 14:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:organization:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=gUDTWELGKiF/FX3bwIvXw5iQ42QflplFVN7O5kLl3Bs=;
        b=MsTpNMk3Z50CP4COZoxVJuYOIaSlfsxS9llNBa0XBWt5cO3INdwWIQpmgv9QqQoD/o
         W37qZyJZkCBhwGp5xFpGECEr2MemfO0rSu7icUq9CSp/n4wSZ0f0MgU8b/4+lxzYUEg3
         53r9XA2m56ecEFtWcO9edhPgCq0c/OfyX3TD9PxlvYYW3EbZya0IXDg5SOdmCqEvyMvH
         GtMet56s+47PqzSdwPSEon240aZVvxNMWyKVdHAK9hWxbMwkf7/pW7FXY/FZxAENhi/7
         FBMjKyHl92M+/XLFMWv5Ec6xO11J6EWQWetX+Q2ml1fkJYfwFq+MACZPMlFSt6v9WLZn
         DGcg==
X-Received: by 10.152.9.170 with SMTP id a10mr16771982lab.1.1422830788386;
        Sun, 01 Feb 2015 14:46:28 -0800 (PST)
Received: from [192.168.0.100] ([213.138.85.113])
        by mx.google.com with ESMTPSA id xv4sm4031577lab.12.2015.02.01.14.46.26
        for <linux-mips@linux-mips.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Feb 2015 14:46:27 -0800 (PST)
Message-ID: <54CEACC1.1040701@gmail.com>
Date:   Mon, 02 Feb 2015 01:46:25 +0300
From:   Oleg Kolosov <bazurbat@gmail.com>
Organization: Art System
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Few questions about porting Linux to SMP86xx boards
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <bazurbat@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45598
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bazurbat@gmail.com
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

Hello MIPS gurus!

I'm adding support for Sigma Designs SMP8652/SMP8654 (Tango3 family,
MIPS 24kf CPU) to newer kernel. I've selectively adapted patches from
2.6.32.15 (the latest officially available for us) to the latest mips
3.18 stable branch and things seem to work (it boots, runs simple test
programs), but there are few questions which I was not able to resolve
yet with my limited experience:

1. They (Sigma Designs) have overridden __fast_iob which is identical to
the default one except for one line:

    : "m" (*(int *)CKSEG1)

is replaced with:

    : "m" (*(int *)(CKSEG1+CPU_REMAP_SPACE))

where CPU_REMAP_SPACE=0x4000000 is a compile time constant for Tango3
and also called KERNEL_START_ADDRESS in Makefiles. The same value is
also written to ebase:

ebase = KSEG0ADDR(CPU_REMAP_SPACE);
write_c0_ebase(ebase);

in traps.c:per_cpu_trap_init()

while writing ebase is really necessary for the kernel to boot, I've not
found any negative effects of not applying __fast_iob patch. What is it
supposed to do?

2. In io.h they have added explicit __sync() to the end of
pfx##write##bwlq and pfx##out##bwlq##p. Is this really necessary? I've
not yet found any adverse effects of not doing so. Maybe this was a
workaround for some old kernel issue which was fixed since then?

3. In c-r4k.c:r4k_cache_init() they assign:

flush_icache_page = r4k_flush_icache_page;

where:

static void r4k_flush_icache_page(struct vm_area_struct *vma,
                                  struct page *page)
{
    r4k_flush_icache_range((unsigned long)page_address(page),
        (unsigned long)page_address(page) + PAGE_SIZE);
}

thus overriding default empty flush_icache_page.

By digging the archives I've found some talks about removing
flush_icache_page. Various sources says it should not be necessary.
Maybe this is board-specific workaround?

--------------

I would really appreciate some explanations on what these changes
supposed to solve or pointers to some background info to better
understand what I'm actually doing. The main concern is that not
properly applying the changes might break something subtly, and, on the
contrary, applying everything might conflict with some fixes in newer
kernel and break something subtly - the sadness.

Thanks a lot!

-- 
Regards, Oleg
Art System
