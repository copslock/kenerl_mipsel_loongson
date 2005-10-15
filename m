Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Oct 2005 09:33:31 +0100 (BST)
Received: from wproxy.gmail.com ([64.233.184.201]:61668 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133519AbVJOIdQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 15 Oct 2005 09:33:16 +0100
Received: by wproxy.gmail.com with SMTP id i7so354042wra
        for <linux-mips@linux-mips.org>; Sat, 15 Oct 2005 01:33:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=d6VxmD0MkbmSFQo+G829DRJvwM2T1wPJfAuZtbE3Bh26ngXZPLVbaItfQ1iHd/REGGu9oUxuMfOhELM95MeSJNSk527Ja35m7YRCm91mXqNIKPyHA47gV+8nPuYZmgEYrVIbZh2Ej9Ar5u0g/N8Dcv4WlqSqjrYGzebcR3KPbZU=
Received: by 10.54.80.8 with SMTP id d8mr1290511wrb;
        Sat, 15 Oct 2005 01:33:13 -0700 (PDT)
Received: by 10.54.132.12 with HTTP; Sat, 15 Oct 2005 01:33:13 -0700 (PDT)
Message-ID: <c24555040510150133x7d42afe6x9526b6eecc216b5f@mail.gmail.com>
Date:	Sat, 15 Oct 2005 14:03:13 +0530
From:	Shuveb Hussain <shuveb@gmail.com>
To:	linux-mips@linux-mips.org
Subject: mem_in? and mem_out? functions
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <shuveb@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shuveb@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,
I am compiling the source from git. There are definitions of macros in
include/asm/io.h for the following:

mem_inb
mem_outb
mem_inl
mem_outl
...
...

The issue is that the driver :
drivers/char/ipmi/  - have redeclared these macros as functions
statically, in the file - ipmi_si_intf.c

I do not know if this driver is used on MIPS at all, but it does get
into the way of proper compilation. If compilation of the IPMI driver
in any form is disabled (by default it gets compiled as a module),
then the compilation goes on smoothly.

I changed the names of these functions slightly and made other
modifications as to compile properly and now everything is OK, but I
do not know if this is the best way to do it, though it works for me
now.

What is the best solution for this issue?

--shuveb
