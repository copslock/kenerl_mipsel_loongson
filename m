Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 May 2006 22:42:05 +0200 (CEST)
Received: from nf-out-0910.google.com ([64.233.182.190]:52402 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S8133760AbWEOUl5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 15 May 2006 22:41:57 +0200
Received: by nf-out-0910.google.com with SMTP id k27so168012nfc
        for <linux-mips@linux-mips.org>; Mon, 15 May 2006 13:41:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MmhtGKmD3SryM0t8rHCOcO4T5Yswqy5et8Ho/P0yTGM95ViVVNQczLBu6yhZCBo07c3WiSplWfTx27LwJp8Q+ZFOfK7U7CXEH4r9uhRWrkb6CaTI9jRHLR/5eBWMx0ruiWgHUyHXPX0GQxD4tIp6t89ftm4pbS4n2R1ggXdWWVk=
Received: by 10.48.199.9 with SMTP id w9mr3815459nff;
        Mon, 15 May 2006 13:41:57 -0700 (PDT)
Received: by 10.49.39.16 with HTTP; Mon, 15 May 2006 13:41:57 -0700 (PDT)
Message-ID: <ecb4efd10605151341l33f491f1ueca8a0ce609c989d@mail.gmail.com>
Date:	Mon, 15 May 2006 16:41:57 -0400
From:	"Clem Taylor" <clem.taylor@gmail.com>
To:	linux-mips@linux-mips.org
Subject: CONFIG_PRINTK_TIME and initial value for jiffies?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <clem.taylor@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clem.taylor@gmail.com
Precedence: bulk
X-list: linux-mips

I just switched to 2.6.16.16 from 2.6.14 on a Au1550. I enabled
CONFIG_PRINTK_TIME, and for some reason jiffies doesn't start out near
zero like it does on x86. The first printk() always seems to have a
time of 4284667.296000.

jiffies_64 and wall_jiffies gets initialized to INITIAL_JIFFIES, but
I'm not sure where jiffies is initialized. INITIAL_JIFFIES is -300*HZ
(with some weird casting)

The first line on the 2.6.16.16 Au1550 box is:
[4294667.296000] Linux version 2.6.16.16 (ctaylor@gort) (gcc version
4.1.0) #4 Mon May 15 13:06:37 EDT 2006

The first line on a 2.6.16 x86_64 box is:
[    0.000000] Bootdata ok (command line is ro root=/dev/md0)
[    0.000000] Linux version 2.6.16 (ctaylor@klaatu) (gcc version
4.1.0 20060420 (Red Hat 4.1.0-9)) #3 SMP PREEMPT Sat Apr 29 03:36:06
EDT 2006

Shouldn't the first printk() have a time at or very near zero?

                                    --Clem
