Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Oct 2006 09:55:34 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.172]:1058 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20038986AbWJEIzb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 5 Oct 2006 09:55:31 +0100
Received: by ug-out-1314.google.com with SMTP id 40so185156uga
        for <linux-mips@linux-mips.org>; Thu, 05 Oct 2006 01:55:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tap3BwvqW+3Bm2LPzMHCzpjfJk5E7vD1jd6z3JZDE2IPEY40+BVrheeIJS1QiE1jcSbGt8mK6SqNaQIcwCi8yg/dRbhn5jprpf6jZ88vAHDu5apBh38a7ifdjcLsvJ5fbcKyerMEd85/h8s2bbNXNMgGpE3ZLfNOwLLfefCsjCE=
Received: by 10.67.101.10 with SMTP id d10mr1623899ugm;
        Thu, 05 Oct 2006 01:55:30 -0700 (PDT)
Received: by 10.66.241.3 with HTTP; Thu, 5 Oct 2006 01:55:30 -0700 (PDT)
Message-ID: <50c9a2250610050155r9928a24rf41cf58a73e7a89c@mail.gmail.com>
Date:	Thu, 5 Oct 2006 16:55:30 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: how to do a fast checksum for ext2fs?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

on my board, i use the ext2fs as rootfs on a DOC device, and i want do
a fast checksum for the rootfs, is there only one way to use fsck?

thanks for any hints
Best Regards


zhuzhenhua
