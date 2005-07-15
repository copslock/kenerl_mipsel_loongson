Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jul 2005 00:46:51 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.198]:49767 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8226755AbVGOXqf> convert rfc822-to-8bit;
	Sat, 16 Jul 2005 00:46:35 +0100
Received: by wproxy.gmail.com with SMTP id i27so733437wra
        for <linux-mips@linux-mips.org>; Fri, 15 Jul 2005 16:47:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Zyj02ah4xylmb/X52gooUVzmlzQJTISi6S+IrJvXHAiz9l0eC6dM+95+cCkJ+r10FyL40D+HE3dpi/Va76YKCouwi2O2Sj2Zopt52dxaImbHI5ightH78ME11HAMjKS9xzOjL+dwf0QZvmN+/ax1zvMA2qdQml3GcnvQxeK20hY=
Received: by 10.54.31.62 with SMTP id e62mr1303352wre;
        Fri, 15 Jul 2005 16:47:50 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Fri, 15 Jul 2005 16:47:50 -0700 (PDT)
Message-ID: <2db32b720507151647480ed75d@mail.gmail.com>
Date:	Fri, 15 Jul 2005 16:47:50 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	linux-mips@linux-mips.org
Subject: How to "make zImage" for db1550?
Cc:	rolf liu <rolfliu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

Time to get rid of the NFS root fs. I want to put linux and root file
system into the flash. But I couldn't find the zImage target for linux
2.6.12 mipscvs.  What I should do?

Another question, the vmlinux created is more than 3MB, the default
"raw kernel" mtdblock is 2.75 MB. So could I change the size of "raw
kernel" in drivers/mtd/maps/alchemy-flash.c to 4MB or more? I hope the
yamon will not be overwritten then.

I searched the list and website, got no luck on this part. 

Thanks
