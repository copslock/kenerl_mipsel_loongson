Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 07:56:11 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:46629 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492369AbZKKG4F (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Nov 2009 07:56:05 +0100
Received: by pwi15 with SMTP id 15so536157pwi.24
        for <multiple recipients>; Tue, 10 Nov 2009 22:55:58 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=b5OLdN0spcdaVCeT43OL2pnVwpXlTE2Sb4W4YyJ7y2M=;
        b=Qr3jh9J27xH+rbOHi3XzGn5AccRI8Vbs892Sq9jFE0F1NDTiGxVfL4r5sgk2wSm4Ig
         Oqeuf8Dq9IIjqCdK3wL/Q1ddDf6Wb19GTUUZSqlDbR5qZysfhYLhQjG1s4q9Chf3zyvK
         Ht8FoPCiFK/9KxmVTxO+jEGXvgKVfNvJtoVnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=CT7nOR5nI0r324KTXWuRb40X/3NUqWhkdXCEukeZqXMiTv+ubo40/B76c+bRub3LVU
         yk26mSQhPaolJ3n/D5mtCFgcypx1bot7T0HTLENHHS7ne7KSBYTODNu570bnf59aNXWg
         IdOxqQ2kN1xMejPDenOPjGbWP0zckJbQ7GLyk=
Received: by 10.115.38.39 with SMTP id q39mr2467715waj.27.1257922558516;
        Tue, 10 Nov 2009 22:55:58 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm821672pzk.10.2009.11.10.22.55.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 22:55:57 -0800 (PST)
Subject: [PATCH -queue 0/2] add suspend support for loongson2f
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, yanh@lemote.com, huhb@lemote.com,
	Wu Zhangjin <wuzhangjin@gmail.com>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	linux-pm@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Wed, 11 Nov 2009 14:55:51 +0800
Message-ID: <1257922551.2922.96.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24840
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

(Add CC to Rafael J. Wysocki, Len Brown and Pavel Machek)

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
