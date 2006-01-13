Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Jan 2006 18:18:09 +0000 (GMT)
Received: from p549F60EF.dip.t-dialin.net ([84.159.96.239]:47498 "EHLO
	p549F60EF.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S8133352AbWAOSRl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 15 Jan 2006 18:17:41 +0000
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.204]:58313 "EHLO
	wproxy.gmail.com") by linux-mips.net with ESMTP id <S872498AbWAMClp> convert rfc822-to-8bit;
	Fri, 13 Jan 2006 03:41:45 +0100
Received: by wproxy.gmail.com with SMTP id 36so584812wra
        for <linux-mips@linux-mips.org>; Thu, 12 Jan 2006 18:39:40 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XT5o5SMjyZOtBeNWWxP1LOUty6gXqDaqz81iZauvCj4OYFDid540L/QRk9PBv5EIvp21PXwIewcrJXdEdkoFbAPStB1/MYVa4482HJVykLbdPZol1Ypu6SldB0ovDHGM7LeagiOl6nMrkk0VcWdSBB6MdrCWYL860Mb59CcDCK8=
Received: by 10.54.94.16 with SMTP id r16mr4357288wrb;
        Thu, 12 Jan 2006 18:39:40 -0800 (PST)
Received: by 10.54.156.1 with HTTP; Thu, 12 Jan 2006 18:39:40 -0800 (PST)
Message-ID: <50c9a2250601121839n3d96327ald74e129aea19b56a@mail.gmail.com>
Date:	Fri, 13 Jan 2006 10:39:40 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: does the linux kernel use k0, k1 regs?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

i have to handle a NMI interrupt in bootloader(0xBFC00000),
 and i want to return to linux after the NMI interrupt,  i think other
regs maybe be useing by linux-kernel, i think the NMI handle only can
use K0, K1.

and i do not find the use of K0, K1 in linux-kernel interrupt or
exception handle
so i think if the NMI interrupt a linux interrupt handle, there is
still no conflict.

i am not sure my thinking is right, anyone can give some hints?

Best regards

zhuzhenhua
