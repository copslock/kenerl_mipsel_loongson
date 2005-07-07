Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jul 2005 21:55:44 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.192]:49888 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8226325AbVGGUz3> convert rfc822-to-8bit;
	Thu, 7 Jul 2005 21:55:29 +0100
Received: by wproxy.gmail.com with SMTP id 57so290615wri
        for <linux-mips@linux-mips.org>; Thu, 07 Jul 2005 13:55:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kykFUpgPqwwWCDQrVNB2h64cODqwqJuYHycF/FIksFA2zcFztxq58l4qaDXSLN63CSXSjeLLF50Ap3CFmN9LFpb1/iuraX5YqSmrU4GOQbXz+Pm+i47uQ39aVfputkEQK2cGkXG7PMQiHcvls6xSPbaJJfYuI+Y3cfpxzt4nqzY=
Received: by 10.54.101.2 with SMTP id y2mr1066630wrb;
        Thu, 07 Jul 2005 13:55:59 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Thu, 7 Jul 2005 13:55:59 -0700 (PDT)
Message-ID: <2db32b7205070713553df6096a@mail.gmail.com>
Date:	Thu, 7 Jul 2005 13:55:59 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	linux-mips@linux-mips.org
Subject: insmod error for pcmcia support on db1550
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8397
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

I compiled linux 2.6.12 with the pcmcia support. And I got 3 module
files: au1x00_ss.ko, pcmcia.ko, and pcmcia_core.ko.

I used" insmod au1x00_ss.ko", but system tells me:
>>insmod: QM_MODULES: Function not implemented

The same thing happens to pcmcia_core.ko and pcmcia.ko too.

What is the problem here? Do I need to recompile the module untilities
for the 2.6 kernels?

Also, when I typed "lspci -v", no information for the pcmcia showed up.

Thanks for comments
