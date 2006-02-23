Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2006 13:25:10 +0000 (GMT)
Received: from wproxy.gmail.com ([64.233.184.201]:15523 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133438AbWBWNZB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Feb 2006 13:25:01 +0000
Received: by wproxy.gmail.com with SMTP id i14so362968wra
        for <linux-mips@linux-mips.org>; Thu, 23 Feb 2006 05:32:08 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HPnhcVdavEeTt2Qs5yS3e03HSbpk0tR/DxY4WVjHGHxb4wyo9t6iVj81/jLnItJbLWoNcB2jvDYPwKGv3xHvT6x24IlUGnP6PSlQezG9Ucd2gU74Afo3LRN36HXo7GUb+0zV/eOZBcq5EG5dg2xoqQSsJI9t8FQo9bkblvtiiew=
Received: by 10.54.105.12 with SMTP id d12mr223383wrc;
        Thu, 23 Feb 2006 05:32:08 -0800 (PST)
Received: by 10.54.133.18 with HTTP; Thu, 23 Feb 2006 05:32:08 -0800 (PST)
Message-ID: <f69849430602230532uc1ac687t773f261a34abab9b@mail.gmail.com>
Date:	Thu, 23 Feb 2006 05:32:08 -0800
From:	"kernel coder" <lhrkernelcoder@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Programmed ide transfer size
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <lhrkernelcoder@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lhrkernelcoder@gmail.com
Precedence: bulk
X-list: linux-mips

hi,

I'm working on an ide driver.Whenever a DMA read operation is
started,i never recieve the DMA interrupt.The staus register at offset
00h shows value ' 0 ',which means that the descriptor table specified
a smaller buffer size than the programmed IDE transfer size.
But occassionaly i recieved the DMA interrupt.

Actually this driver works well on another board.On that board
whenever i reduced the buffer size in physical region descriptor table
to less than the current size in the PRDT table,i again got the same
error.

I think this confirms that whenever we give smaller size in PRDT than
the programmed IDE transfer size,status register shows ' 0 ' value.

Please tell me where in kernel that programmed IDE transfer size is
being set.The transfer size in PRDT on the other board(on which driver
shows no problem) varied from 4k to 1k ,which means it is changed
frequently.

shahzad
