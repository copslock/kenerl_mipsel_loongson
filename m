Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2007 14:47:58 +0100 (BST)
Received: from fk-out-0910.google.com ([209.85.128.188]:57077 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20022119AbXHBNr4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Aug 2007 14:47:56 +0100
Received: by fk-out-0910.google.com with SMTP id f40so449788fka
        for <linux-mips@linux-mips.org>; Thu, 02 Aug 2007 06:47:38 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CO9w6eamRo94O+cYQLGIGu2ZNodtPPeF3Fp1IuLpqzTCC52sILS6ylMseNkKd2HcZY34TbGQyxR4YBotEV54LbduICBpgFVp8OiPnEUIC9LEnweVakjI2kDjmGEd6nQrRWo12K9rbIKcxZTyhsK7NrDL7iodKKJqG1irLbIrGiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mjlFqWz5x+gghlaImWqpISUM1rgvKK8IGOAD3KZluVrew8IOUQCmgE2677T0j/A0KNDXpjIR3cYoV1ZiTaeRkcAdAoVR6C5LioJsDsPdaPvusuKiKbMG8xGDsDZLCJ8fW/wk+MgwRljK2ezdl0GuU4ku4LZDNaELXE9K715crm0=
Received: by 10.82.178.11 with SMTP id a11mr2445434buf.1186062457934;
        Thu, 02 Aug 2007 06:47:37 -0700 (PDT)
Received: by 10.82.156.11 with HTTP; Thu, 2 Aug 2007 06:47:37 -0700 (PDT)
Message-ID: <c58a7a270708020647q7a0c55f4l6904e864609c7304@mail.gmail.com>
Date:	Thu, 2 Aug 2007 14:47:37 +0100
From:	"Alex Gonzalez" <langabe@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: Kernel space access to 2GB of physical memory
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <langabe@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: langabe@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I have a system booting the 2.6.12-rc3 32bits kernel on an RM9000
processor and I am trying to get my head around how to access up to
2GB of physical memory with a mem=256MB command line booting
parameter. I read that on the MIPS kernel this is split 2GB/2GB
between kernel and user space, so the kernel should be able to access
directly 2GB of physical memory.

Kernel drivers will access the memory above 256MB using ioremaps. I
need it this way as the memory above 256MB will be used in special
ways.

What I struggle to understand is whether it would be possible to
access all the memory up to 2GB using the ioremap method.

The only way I can think of achieving this would be to use ksseg and
dynamic TLB entries to access it in 256MB chunks. The fact that I can
access ksseg must mean that the kernel is not clearing the TLB entries
that the bootloader sets up before launching the kernel, so I would
expect to be able to add/remove TLB entries dynamically without
affecting the kernel's own memory management.

1) Is there a simpler mechanism to achieve this?

2) Any ill effect on the kernel from the method described above?

Many thanks,
Alex
