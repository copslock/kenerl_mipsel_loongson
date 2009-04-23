Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Apr 2009 16:42:46 +0100 (BST)
Received: from yx-out-1718.google.com ([74.125.44.157]:1009 "EHLO
	yx-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20022986AbZDWPmg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Apr 2009 16:42:36 +0100
Received: by yx-out-1718.google.com with SMTP id 4so364458yxp.24
        for <multiple recipients>; Thu, 23 Apr 2009 08:42:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=gYVQRW3mvzgPEGrDuKq+BAJcIp8igzOTF3oEg0zdZZY=;
        b=TPwzsn5Hl1LNUMgbtKfMu7pkXroUvRw+QbMX8J+fGZi5aXeVv2Mr8Vg0YUmj6pBw1N
         64L3mhrJ39HHdLpuTHwstMtGj1ZPYKloQVgcDx1zERHn8aRVUZLNzNGweEysJv5nGEgo
         y3Nw9wHGL0WvhZO08oboNlnhAV63DRmlGoQb4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=lX7lLlWZS2Pluk9511HNoleeAUm7dtjUKnk6JDSPlaqpHvrF740m7Jaaa8QKDT9IGj
         aJrg4p9xeS/MrtSI7pMPNneSYKq8K9B9xZGQPWgFunHpzylTMiTEOh/vLllKj5rpoaqc
         OHgGtKX2OC/DoSCtrBRwMGrHOFwUWaCQ10VRk=
Received: by 10.142.239.11 with SMTP id m11mr379142wfh.120.1240501354081;
        Thu, 23 Apr 2009 08:42:34 -0700 (PDT)
Received: from ?172.16.18.144? ([222.92.8.142])
        by mx.google.com with ESMTPS id 27sm241551wff.31.2009.04.23.08.42.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Apr 2009 08:42:33 -0700 (PDT)
Subject: a pre-release of merging loongson patchs to linux-2.6.29.1
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	loongson-dev@googlegroups.com
Cc:	yanh@lemote.com, zhangfx@lemote.com, penglj@lemote.com,
	huhb@lemote.com, taohl@lemote.com, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Thu, 23 Apr 2009 23:42:12 +0800
Message-Id: <1240501332.28136.24.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

hi, all

these days, I am working on merging loongson patchs to linux-2.6.29.1, 
the fuloong(2f) & yeeloong source code have been completely merged to an
2f directory, most of the 2e & 2f source code have been merged except
the irq.c & reset.c, fixup-loongson2e.c & fixup-loongson2f.c.

the current directory architecture is as following:

$ tree arch/mips/loongson/
arch/mips/loongson/
|-- 2e
|   |-- Makefile
|   |-- irq.c
|   `-- reset.c
|-- 2f
|   |-- 8250.c
|   |-- Makefile
|   |-- clock.c
|   |-- cs5536.h
|   |-- cs5536_pci.h
|   |-- cs5536_vsm.c
|   |-- irq.c
|   |-- mfgpt.c
|   |-- mipsdha.c
|   |-- pcireg.h
|   `-- reset.c
|-- Kconfig
`-- common
    |-- Makefile
    |-- bonito-irq.c
    |-- dbg_io.c
    |-- mem.c
    |-- pci.c
    |-- prom.c
    `-- setup.c

$ tree arch/mips/include/asm/mach-loongson/
arch/mips/include/asm/mach-loongson/
|-- cpu-feature-overrides.h
|-- dma-coherence.h
|-- mc146818rtc.h
|-- mem.h
|-- pci.h
|-- prom.h
`-- war.h

$ ls arch/mips/pci/*loongson*
arch/mips/pci/fixup-loongson2e.c  arch/mips/pci/fixup-loongson2f.c

a current version is released to git://dev.lemote.com/rt4ls.git, 
(for avoid creating another git repository for it, i just use my
RT_PREEMPT git tree instead, so, it may be very big :-( )

$ git clone git://dev.lemote.com/rt4ls.git
$ git checkout linux-2.6.29-stable-loongson --track
origin/linux-2.6.29-stable-loongson

TODO:

   * clean up some of the commits carefully, especially the following
files:
   arch/mips/pci/fixup-loongson2*
   arch/mips/loongson/2f/cs5536* 
   irq.c, reset.c

   * try to merge the left files if possible.
   * update it to the latest mainline kernel and push it in.

best regards,
Wu Zhangjin

-- 
Wu Zhangjin
DSLab, Lanzhou University, China
www.lemote.com, Jiangsu Province, China
