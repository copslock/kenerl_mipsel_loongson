Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Jan 2006 18:21:35 +0000 (GMT)
Received: from p549F60EF.dip.t-dialin.net ([84.159.96.239]:56458 "EHLO
	p549F60EF.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S8126537AbWAOSVO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 15 Jan 2006 18:21:14 +0000
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.198]:47286 "EHLO
	wproxy.gmail.com") by linux-mips.net with ESMTP id <S872756AbWAMHGY> convert rfc822-to-8bit;
	Fri, 13 Jan 2006 08:06:24 +0100
Received: by wproxy.gmail.com with SMTP id 36so632604wra
        for <linux-mips@linux-mips.org>; Thu, 12 Jan 2006 23:04:22 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mDhYhbr16xM1hSi9THZplb5bghvhDefj3tHs483uh0TXxGyY5ngxmMcFJS8Xtnz+n88o2F83b5YhcCJFDMOMg0P6LpkYklnCZ+ACzeJb+q114q9VatICwNNGIAE7HajDgICUUZ6AYrDtMzUGwyKx+TrlNwhEQZGQxIg8sM2xoVQ=
Received: by 10.54.132.17 with SMTP id f17mr4593145wrd;
        Thu, 12 Jan 2006 23:04:22 -0800 (PST)
Received: by 10.54.156.1 with HTTP; Thu, 12 Jan 2006 23:04:21 -0800 (PST)
Message-ID: <50c9a2250601122304idfa535dt7066274b6dce2d43@mail.gmail.com>
Date:	Fri, 13 Jan 2006 15:04:21 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: does not the kernel support embedded ramdisk too larget?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

i compile the ramdisk.gz into the vmlinux, and if the ramdisk.gz is
not too large, it works fine. it the ramdisk.gz is too large about 4M.
it get error when uncomrpessed ramdisk
"invalid compressed format(err=1)"

My sdram is 64M, and i download uImage to 0x82000000,and then bootm 0x82000000
does anyone meet this?
thanks for any hints

Best regards
Zhuzhenhua
