Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Mar 2006 01:39:57 +0000 (GMT)
Received: from nproxy.gmail.com ([64.233.182.207]:31414 "EHLO nproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133906AbWCIBjt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 9 Mar 2006 01:39:49 +0000
Received: by nproxy.gmail.com with SMTP id p77so252585nfc
        for <linux-mips@linux-mips.org>; Wed, 08 Mar 2006 17:48:22 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=IeKwPMxhGzaHH7mLvVF9CTO/8Y3yrqqMrYqGtgpz5DVz+qnLH39xqXOoAr9hNQn/S/9qLthU67ABf4fu2AZlo65YKbvg+g+4Q5ozqPh8qN2O6krongCCE6bF+6NmLxFqmwJzsmNQE++Ue62ZShVye/bVrWCXqXwRiRw9lnKwlBI=
Received: by 10.49.95.20 with SMTP id x20mr677867nfl;
        Wed, 08 Mar 2006 17:48:21 -0800 (PST)
Received: by 10.48.144.19 with HTTP; Wed, 8 Mar 2006 17:48:21 -0800 (PST)
Message-ID: <50c9a2250603081748u639d35c0n272d53e24acc9f02@mail.gmail.com>
Date:	Thu, 9 Mar 2006 09:48:21 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: how to select the filesystem for nand flash?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10764
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

In the linux, I find there are two solutions for nand flash: one is
YAFFS2/JFFS2 + MTD, other is EXT2/EXT3+FTL. Because we have to
implement vfat based FTL for our u-disk,so i wonder if  the ext2/ext3
+ FTL is stable enough to be root filesystem?
thanks for any hints.

Best Regards
Zhuzhenhua
