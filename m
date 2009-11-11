Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 07:53:04 +0100 (CET)
Received: from mail-pz0-f194.google.com ([209.85.222.194]:36356 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491885AbZKKGw5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Nov 2009 07:52:57 +0100
Received: by pzk32 with SMTP id 32so590323pzk.21
        for <multiple recipients>; Tue, 10 Nov 2009 22:52:50 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=+hu0BGhiIZPt/HlZcdrD/abtW6FPIlhOSuKIzeFCR3c=;
        b=L6zLUYWTcOsghweUziSPpvwinmSEzyVV7YhjQZFRm7blrtnb9DP+AhF7dXC3RH0hmg
         qDWieJbEnm/DOyQlKJvAyfFz3rs6pWkippGezdQkWxWqncFRnugIvadKkw/9iyg261uf
         Aj3GyA5BAd58pSa1WVAJALjmKI8pbKwOr3ArU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=tvh8/G/gqabT3stPDy1tewiju1BCzODdclbuDC/cIJzl4p/gHL2j0/nBwcjvRTiFhd
         Zv7TCfLW43mDYu4uXXFZ2o1EAIyTJ4vpRQIaZbsdVOlYEU9v0hi+fa95IkMQ1MdLcmVP
         2Cw6XCCgLbySTaF6JIypU+uqXdbQotUwJuDbw=
Received: by 10.115.113.6 with SMTP id q6mr2450776wam.55.1257922370791;
        Tue, 10 Nov 2009 22:52:50 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm819777pzk.2.2009.11.10.22.52.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 22:52:50 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, yanh@lemote.com, huhb@lemote.com,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue 0/2] add suspend support for loongson2f
Date:	Wed, 11 Nov 2009 14:52:35 +0800
Message-Id: <cover.1257920162.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Loongson2f's cpu frequency is software configurable, when we set its frequency
to ZERO, it will go into the suspend mode and can be waked up by the external
interrupts.

With this feature and based on the kernel's suspend framework, this patch add
the suspend support for loongson2f family machines.

To utilize this support, the machines should provide a necessary external
interrupt to wakeup loongson2f from the suspend mode and make sure the
interrupt be able to send to the processor directly or indirectly(the interrupt
path is not blocked). otherwise, it will suspend there all the time.

And If there is an external timer used, please mask it with IRQF_TIMER,
otherwise, the system will fail on resuming from suspend.

The old lemote Fuloong2F mini PC did not provide any method to wakeup the
machine from the suspend mode, so, please not try to suspend the machine.  But
the latest lemote Fuloong2F add an interrupt line from the Power Button to the
Processor, If we press the button and release it immediatly, it will work as a
wakeup button.

For YeeLoong2F netbook, Since it's easy to setup the keyboard interrupt as the
wakeup interrupt, we just setup it and avoid changing the hardware. So the old
YeeLoong2F machines can also utilize this support. and in the coming patchset,
we will also setup the LID interrupt as the wakeup interrupt.

Thanks & Regards,
	Wu Zhangjin

Wu Zhangjin (2):
  [loongson] 2f: add suspend support framework
  [loongson] yeeloong2f: add board specific suspend support

 arch/mips/loongson/Kconfig            |    5 +
 arch/mips/loongson/common/Makefile    |    6 ++
 arch/mips/loongson/common/pm.c        |  157 +++++++++++++++++++++++++++++++++
 arch/mips/loongson/lemote-2f/Makefile |    6 ++
 arch/mips/loongson/lemote-2f/pm.c     |   70 +++++++++++++++
 5 files changed, 244 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/loongson/common/pm.c
 create mode 100644 arch/mips/loongson/lemote-2f/pm.c
