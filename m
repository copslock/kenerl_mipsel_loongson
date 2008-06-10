Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jun 2008 22:30:38 +0100 (BST)
Received: from fk-out-0910.google.com ([209.85.128.187]:43256 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S28596368AbYFJVag (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Jun 2008 22:30:36 +0100
Received: by fk-out-0910.google.com with SMTP id b27so1615417fka.0
        for <linux-mips@linux-mips.org>; Tue, 10 Jun 2008 14:30:35 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=8PdoJ2MYVvVvw2kpR2m8vAmcTFqP0ZWz0a2GyawZNgM=;
        b=W1xs0hqycO2/s4UwRPYwlSGytc7WFvvT0Kqjj8wyqW/kuoPW88VNOgdjuPvt1eWYLU
         6EVZpqjA7IGvNnEh02djJ98YkIuYYQk9sqxoeEvyF2RPflC5adVaTaRBWVq00kquSd6E
         rhXy6XmIAy/DNMJx13EMQauqa2Z79/fscOLME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=EnF7kOwXDow81nSZSjHCxhtDIbbSd3WNZhiqol8KA5OuELOWsXtKrw6nwXpbkNr8k3
         W+D59SiAmH+RJwveyc3XvueIxdpO6l66nBvfiKZLrdAEnR/pRkOD6z18Mb8UichxzWjS
         zY6sukwo9Jj8dqfw+Ci176afJ0sVPPB5G408Q=
Received: by 10.82.178.11 with SMTP id a11mr373976buf.47.1213133435067;
        Tue, 10 Jun 2008 14:30:35 -0700 (PDT)
Received: by 10.82.146.3 with HTTP; Tue, 10 Jun 2008 14:30:35 -0700 (PDT)
Message-ID: <ecb4efd10806101430o426a2b51r3895871e31ceec89@mail.gmail.com>
Date:	Tue, 10 Jun 2008 17:30:35 -0400
From:	"Clem Taylor" <clem.taylor@gmail.com>
To:	linux-mips@linux-mips.org
Subject: early hang in 2.6.24 on au1550 (MIPSLE)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <clem.taylor@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19468
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clem.taylor@gmail.com
Precedence: bulk
X-list: linux-mips

A few months ago I switched from 2.6.16.16 to 2.6.24 on an AU1550
(MIPSLE) system. I started rolling this out to more systems, getting
ready for a new software release and discovered that on fresh powerup,
the 2.6.24 kernel sometimes (1 in 10-25 power cycles) fails to start.
The bootloader (uboot) decompresses the kernel from a jffs2 filesystem
and then jumps to it, but I don't get any serial messages from the
kernel.

If I switch back to the 2.6.16.16 kernel, everything is happy. The
annoying thing is that I have been unable to catch the problem with
the JTAG debugger connected, so I'm not sure where it is hanging.

I've been looking at diffs in the arch/mips tree and nothing has
jumped out at me.   I don't think this is a hardware problem, this
hardware platform has been fairly stable and it works just fine with
the older kernel. I was wondering if anyone has any suggestions where
I might look? Also, is anyone using 2.6.24 with a Au1550?

                       Thanks,
                       Clem
