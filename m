Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Jan 2006 19:00:53 +0000 (GMT)
Received: from p549F60EF.dip.t-dialin.net ([84.159.96.239]:14988 "EHLO
	p549F60EF.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S8133595AbWAOTAA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 15 Jan 2006 19:00:00 +0000
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.199]:3576 "EHLO
	wproxy.gmail.com") by linux-mips.net with ESMTP id <S876567AbWAOEY2> convert rfc822-to-8bit;
	Sun, 15 Jan 2006 05:24:28 +0100
Received: by wproxy.gmail.com with SMTP id 36so966233wra
        for <linux-mips@linux-mips.org>; Sat, 14 Jan 2006 20:22:23 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bd1lOwud8+TYXsa+osp5z3Vfi44BaaJ3/gRqr5YugrCrILhL2yDFleRxJrYsu3lYLwnX/SEdM1lQVJnjc71WoJKVrHMAjHQ9zdSg0opXVWZ2pI414DlrRRDnIL0c318V8HpY9lL0J58CRkycUEvmj5yTjUKaGJYoQaPIESCFlTs=
Received: by 10.54.136.13 with SMTP id j13mr6987843wrd;
        Sat, 14 Jan 2006 20:22:23 -0800 (PST)
Received: by 10.54.156.1 with HTTP; Sat, 14 Jan 2006 20:22:23 -0800 (PST)
Message-ID: <50c9a2250601142022k6e4a855r6fc0274e4cfb8369@mail.gmail.com>
Date:	Sun, 15 Jan 2006 12:22:23 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: how to emdedded ramdisk.gz in vmlinux for linux-2.6.14?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9877
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

I download the kernel from linux-mips, and select to embedded
ramdisk.gz into vmlinux.
but  i can't find where to place the ramdisk.gz.
I try to put ramdisk.gz  under top dir, or arch/mips/boot/, but it
does not work.
 can someone give any hints?


Best regards

zhuzhenhua
