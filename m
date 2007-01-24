Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2007 02:06:19 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.172]:62400 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S28575400AbXAXCGP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 Jan 2007 02:06:15 +0000
Received: by ug-out-1314.google.com with SMTP id 40so38281uga
        for <linux-mips@linux-mips.org>; Tue, 23 Jan 2007 18:05:10 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Rkf50BpYdnMsjsJjxRq4/QB+vdRBdc29o3YAKEFr+tH8jWCTB+L6hu0pDF8by8DFRP8XlWeXSgUXIs/se8UBBvIH2z5CzbIy2Upyip4X9SjV+h50gyzRQ2w72M7InbsePkDJ3gsWMz7cQBVIjhldCMyM3Go2ediDLvWFDzNQr1c=
Received: by 10.82.120.14 with SMTP id s14mr44583buc.1169604310319;
        Tue, 23 Jan 2007 18:05:10 -0800 (PST)
Received: by 10.82.179.13 with HTTP; Tue, 23 Jan 2007 18:05:10 -0800 (PST)
Message-ID: <50c9a2250701231805y62ec67f0v83d2fcf3ae2c55da@mail.gmail.com>
Date:	Wed, 24 Jan 2007 10:05:10 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: how to choose journal filesystem for embedded linux?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13775
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

hello all:
          i now work on a mips board, and want to store my system code
on NAND Flash.
 our Flash driver can handle the Flash features(bad block,  phy  to
logic addr, spare,etc.),
 so i just want to select a journal filesystem to handle sudden poweroff.
Our system code(writeable) is about 10M~50M. i am not sure what
journal filesystem will be suitable, ext3,xfs,jfs,or reiserFS?
 i have try ext3, it runs well, but seems to waste too much space
while mkfs.ext3.
