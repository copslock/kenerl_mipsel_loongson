Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Aug 2007 16:29:33 +0100 (BST)
Received: from qb-out-0506.google.com ([72.14.204.238]:44952 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20021757AbXHQP3Z (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 17 Aug 2007 16:29:25 +0100
Received: by qb-out-0506.google.com with SMTP id z1so637610qbc
        for <linux-mips@linux-mips.org>; Fri, 17 Aug 2007 08:29:07 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WE5NHnnY4aO8Uc30P8Fx0y/dTXB71jplkfMYzG82j7kDzvPpe8mu52GrbHqh0xLFRpY6zplb1k1yANGxV3iPQic7ywYmjc7yav8xNwllNs051Gfikrn6sw5pZVUpFulmcgxDE0kSdeo0Nfbs2BTQnOhWgRVOpJ3mwT43w/aXrRo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Kb72I8LmzfWWmLgdf24U1c0jxQ4MdwQkYsbIp6ochPOiP8S8YehuHrvcuV2uQfK8oZMM9eZmjPnXNOG+dV0UjW8mUxtd+dlYEKHlJphngi/RUHfM1wbAx05Pg1e8ExHlXCVIOcweMf9AQQ86DhlDHkEVGjPlFWTSKCZ6ntWDh94=
Received: by 10.64.220.8 with SMTP id s8mr5534544qbg.1187364547132;
        Fri, 17 Aug 2007 08:29:07 -0700 (PDT)
Received: by 10.65.98.18 with HTTP; Fri, 17 Aug 2007 08:29:05 -0700 (PDT)
Message-ID: <99ac6e0e0708170829q4148349br993d1f07bbe9ef4b@mail.gmail.com>
Date:	Fri, 17 Aug 2007 10:29:07 -0500
From:	"bo y" <byu1000@gmail.com>
To:	linux-mips@linux-mips.org
Subject: RE: Alchemy DMA and GFP_DMA
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <byu1000@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: byu1000@gmail.com
Precedence: bulk
X-list: linux-mips

>arch/mips/au1000/common/dbdma.c uses GFP_DMA in two places and I think
>both instances are uncessary.  Could some alchmist confirm that both are
>unnecessary?
>
>Thanks,
>
>  Ralf

I tested it without GFP_DMA on Au1550 board. It worked.

The more serious problem in dbdma.c is how DMA descriptor cmd1
register is used. In multiple places, it just do

-       dp->dscr_cmd1 = nbytes;

Au1550/1200 supports 0x3fffff bytes of buffer. So the following is
better I think.

+       if(nbytes > DSCR_CMD1_BC_MASK) {
+               return 0;
+       }
+       dp->dscr_cmd1 = (dp->dscr_cmd1 & ~DSCR_CMD1_BC_MASK) + nbytes;

Also, there is no way to do memory-to-PCI dma. I added a few lines in
au1xxx_dbdma_ring_alloc().

+         if(DSCR_CUSTOM2DEV_ID(destid) == DSCR_CMD0_PCI_WRITE) {
+                cmd1 |= 0x04000000;
+         }
+         if(DSCR_CUSTOM2DEV_ID(srcid) == DSCR_CMD0_PCI_WRITE) {
+                cmd1 |= 0x40000000;
+         }

Last, a few places like:

-       nbytes = dscr->dscr_cmd1;

+       nbytes = (DSCR_CMD1_BC_MASK & dscr->dscr_cmd1);


Thanks.

Bo
