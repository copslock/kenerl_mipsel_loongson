Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Mar 2007 08:45:04 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.169]:25290 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20021452AbXCOIpA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Mar 2007 08:45:00 +0000
Received: by ug-out-1314.google.com with SMTP id 40so258093uga
        for <linux-mips@linux-mips.org>; Thu, 15 Mar 2007 01:43:59 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LyCZ6VTeP+HgameJWRBMww6DIBrafEZTXKa4PnX3GzAHdRUTFhPKFWLx0uirf65K1R2M1Ec71CgwuEwZtir59BbBNc1lfj1YCAtGg416WL7TRW9zuBGsdX3fTgj/q8aPJXZTrAZvP3kofoGzfCpVYBKuOBfF/9XttYsZ2R7AlCk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DG8fs7+swNcZc82EE6nxkpTMLKDEfxuHAesyR4xOaXcvwgGJjWsGTJfIUjrJnULbxR4G7HRi59jy8PC8wp43UfD+Wa2cwSZtUVJPwf+sB9fKTdvglX6YEfJF5ygqfnYdpoRmvReU7/ccl11XWyIjJuNssnPODXFlAoGkobFuDVM=
Received: by 10.82.188.15 with SMTP id l15mr195140buf.1173948239089;
        Thu, 15 Mar 2007 01:43:59 -0700 (PDT)
Received: by 10.82.178.13 with HTTP; Thu, 15 Mar 2007 01:43:59 -0700 (PDT)
Message-ID: <b115cb5f0703150143y46a1f877m9dbb43345721c355@mail.gmail.com>
Date:	Thu, 15 Mar 2007 14:13:59 +0530
From:	"Rajat Jain" <rajat.noida.india@gmail.com>
To:	linux-mips@linux-mips.org
Subject: How does boot loader pass initrd address / size to kernel?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <rajat.noida.india@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rajat.noida.india@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I'm running an ancient Linux kernel 2.4.20 (please don't ask me why
:-( ) on a MIPS 4KEC. I am experimenting with initrd and my initrd
fails to mount. My bootloader (U-BOOT) coorectly loads the initrd into
RAM as I can see.

I am wondering how does the kernel get to know the address at which
the initrd is loaded by boot loader? How does the boot loader
communicate this to the kernel?

I can see that when emebedding root filesystem into kernel image, the
symbols __rd_start and __rd_end are defined by the linker script and
hence the kernel gets to know. However, how does this happen when
bootloader loads the ramdisk and needs to tell the kernel?

Any code references will be appreciated.

Thanks,

Rajat
