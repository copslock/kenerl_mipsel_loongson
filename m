Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2005 21:38:38 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.194]:41355 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8225549AbVFWUiX> convert rfc822-to-8bit;
	Thu, 23 Jun 2005 21:38:23 +0100
Received: by wproxy.gmail.com with SMTP id 57so1044841wri
        for <linux-mips@linux-mips.org>; Thu, 23 Jun 2005 13:37:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fW3vslrUUPcj6admfy4uVXgd0yb6AnpryL/D0RN6fdGdr/0A4idWfns2twlXs/uiKvuPrxX2/4gCqdrd8IuOmTnSo8x60joBiG1W6uDkgDHRSK0/qrRStoPlwzoS4NyEnL7F8TWNgxV/ZTHPYhaT9hii3SkFlJSZnr4Q9zYTRVA=
Received: by 10.54.15.71 with SMTP id 71mr1401588wro;
        Thu, 23 Jun 2005 13:37:21 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Thu, 23 Jun 2005 13:37:21 -0700 (PDT)
Message-ID: <2db32b72050623133731f7b098@mail.gmail.com>
Date:	Thu, 23 Jun 2005 13:37:21 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	linux-mips@linux-mips.org
Subject: which 2.6 kernel can be run on db1550?
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

I just compiled 2.4.31 and run that on db1550. It works through a NFS
root file system. I am thinking of running of 2.6 on db1550. Which one
can be compiled by SDE and run this box?

I tried 2.6.12 and tried 2.6.12-rc6, but got no luck. They just don't compile.

thanks
