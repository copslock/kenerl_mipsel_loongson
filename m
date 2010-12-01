Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Dec 2010 09:20:24 +0100 (CET)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:41290 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491988Ab0LAIUV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Dec 2010 09:20:21 +0100
Received: by qwh6 with SMTP id 6so2312282qwh.36
        for <linux-mips@linux-mips.org>; Wed, 01 Dec 2010 00:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=fuqbgted2eneNrvsr/w1ALfbQgIhg3aEIDEUFGf8Dg4=;
        b=EWkoev9kad8cIyVqFbL8dy0yqRsNm6CDhP9zXwF94iJ8lSnFnsEZMotZcz4KMgaQVg
         MXBCWKE2p2R+2u4Y67CTu4EGhq/cYIlkewxRDMClUHrMfKWxuNHYEbs5FYY2TifycK+F
         SGAAAwjUW3WvsxAVRCPIXmsZWk4YYBWRBWKlM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=oSR+oRl3IxQ5O04SWbZpt/MJBjQjdWobCfH4X0lixxv7WrFBjVldt938hhxysaEZLe
         q+TTtQjg4AhRpweoYeMeFgsI0MGSWa9LZmpzJL7Qjwf1a2Fqj7xJ45k7Ys4k0YhUkDTZ
         DFhExCCQ8n5fpEjyZxRrlqXD5Jl6Q8o0pJ25E=
MIME-Version: 1.0
Received: by 10.229.216.201 with SMTP id hj9mr7094921qcb.58.1291191613912;
 Wed, 01 Dec 2010 00:20:13 -0800 (PST)
Received: by 10.229.96.148 with HTTP; Wed, 1 Dec 2010 00:20:13 -0800 (PST)
Date:   Wed, 1 Dec 2010 13:50:13 +0530
Message-ID: <AANLkTi=4gtEC9fZyvc9g6uHecvjPrr0dDc==KsDOvq2Q@mail.gmail.com>
Subject: Change of Default kernel page size i.e 4KB
From:   naveen yadav <yad.naveen@gmail.com>
To:     kernelnewbies@nl.linux.org,
        linux-arm-kernel-request@lists.arm.linux.org.uk,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <yad.naveen@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28577
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yad.naveen@gmail.com
Precedence: bulk
X-list: linux-mips

Hi All,

I have few drivers and very big application running on ARM and MIPS target.
I want to check the performance by changing the page size ie.

8K, 16K, 32K etc.

Is it possile, If yes then what all care i need to take .

Thanks.
