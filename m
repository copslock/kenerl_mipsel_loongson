Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jun 2008 20:15:49 +0100 (BST)
Received: from an-out-0708.google.com ([209.85.132.241]:49353 "EHLO
	an-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20041870AbYFPTPn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Jun 2008 20:15:43 +0100
Received: by an-out-0708.google.com with SMTP id d11so1199653and.64
        for <linux-mips@linux-mips.org>; Mon, 16 Jun 2008 12:15:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=7QWnZj3xf/+rXajrxxKwiskWmIMkeUNaH0NdvoATygc=;
        b=K/f1eU0U9GJlAj/CvUp+xZmBKn5Q0MAvn5EEmTQQqgXcjtiDQ7Uy7HnFOciVuYnJFF
         9HvxTcqE/WiApEhnJTA4PpVetbjz8fyXvhZNLPOvZLF1eidkKpxxLuXbeO4x8jSKXW+T
         MKtwcFVcvcIJmILZv03szCvHoUB1+5t8jo+KE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=ly3jSxdq9E91ht/EWmsCEZYuimraVCJ0UttAc51vXvPBUyKmu2pSC604l+L24YsFqP
         6SPfZuKydxZCh6tQ2TTPHNEDcP2a9701zX03xMD2axQrvNTzt0dg/QnBd5puoR0Zh4ch
         drtvcI1uQZSPyZ8y+CsCRwVRTKf4qZFHt87vU=
Received: by 10.100.215.14 with SMTP id n14mr9101275ang.148.1213643736388;
        Mon, 16 Jun 2008 12:15:36 -0700 (PDT)
Received: from ?10.1.8.176? ( [209.29.220.87])
        by mx.google.com with ESMTPS id 28sm927878qbw.0.2008.06.16.12.15.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Jun 2008 12:15:35 -0700 (PDT)
Message-ID: <4856BBDB.6000306@gmail.com>
Date:	Mon, 16 Jun 2008 15:15:39 -0400
From:	David Pelton <david.r.pelton@gmail.com>
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: [PATCH] [MIPS] change EARLY_PRINTK default to n
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.r.pelton@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19575
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.r.pelton@gmail.com
Precedence: bulk
X-list: linux-mips


This patch changes the default for CONFIG_EARLY_PRINTK to n.  Prior to
this change, the presence of SYS_HAS_EARLY_PRINTK would always set
EARLY_PRINTK to y if either EMBEDDED or DEBUG_KERNEL were not set.  As
this is a debugging option, it should default to n.

Signed-off-by: David Pelton <david.r.pelton@gmail.com>
---

Hi,

while fiddling with kernel configuration options for the Broadcom eval
board I am working with, I noticed that turning off DEBUG_KERNEL would
make many bad things happen.  I did not get to the root cause, but I
think that some of the early printk drivers have some dependency on
functionality enabled by DEBUG_KERNEL.  The 2.6.25.6 kernel has a
default value of "y" for EARLY_PRINTK, and this default will be applied
anytime the platform claims to support early printk.  In particular, if
DEBUG_KERNEL is not selected, there is no way to disable EARLY_PRINTK.
This patch changes the default to "n" to avoid these problems.

- David Pelton


 arch/mips/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff -Nraup linux-2.6.25.6-clean/arch/mips/Kconfig linux-2.6.25.6/arch/mips/Kconfig
--- linux-2.6.25.6-clean/arch/mips/Kconfig      2008-06-09 14:27:19.000000000 -0400
+++ linux-2.6.25.6/arch/mips/Kconfig    2008-06-16 14:34:33.229160000 -0400
@@ -807,7 +807,7 @@ config DMA_NEED_PCI_MAP_STATE
 config EARLY_PRINTK
        bool "Early printk" if EMBEDDED && DEBUG_KERNEL
        depends on SYS_HAS_EARLY_PRINTK
-       default y
+       default n
        help
          This option enables special console drivers which allow the kernel
          to print messages very early in the bootup process.
