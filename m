Received:  by oss.sgi.com id <S553688AbQKVO1V>;
	Wed, 22 Nov 2000 06:27:21 -0800
Received: from [207.81.221.34] ([207.81.221.34]:19514 "EHLO relay")
	by oss.sgi.com with ESMTP id <S553678AbQKVO1J>;
	Wed, 22 Nov 2000 06:27:09 -0800
Received: from vcubed.com ([207.81.96.153])
	by relay (8.8.7/8.8.7) with ESMTP id JAA32746
	for <linux-mips@oss.sgi.com>; Wed, 22 Nov 2000 09:49:17 -0500
Message-ID: <3A1BD888.7FB3C6A6@vcubed.com>
Date:   Wed, 22 Nov 2000 09:30:32 -0500
From:   Dan Aizenstros <dan@vcubed.com>
Organization: V3 Semiconductor
X-Mailer: Mozilla 4.6 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: Multiple copies of pci-dma.c file.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello All,

Is there any reason for having multiple copies of
the pci-dma.c file in Linux/MIPS.  The are all
doing basically the same thing.  We could have
just one copy in the arch/mips/lib directory
and have the Makefile build it if CONFIG_PCI
is defined.

Also they appear to have an error in that they
convert the pointer that is returned from the
__get_free_pages function call into a KSEG1
address even if the pointer is NULL.

Dan Aizenstros
Software Engineer
V3 Semiconductor Corp.
