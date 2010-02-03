Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2010 23:21:28 +0100 (CET)
Received: from imr2.ericy.com ([198.24.6.3]:54448 "EHLO imr2.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492841Ab0BCWVV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Feb 2010 23:21:21 +0100
Received: from eusaamw0707.eamcs.ericsson.se ([147.117.20.32])
        by imr2.ericy.com (8.13.1/8.13.1) with ESMTP id o13MMH3Z032037
        for <linux-mips@linux-mips.org>; Wed, 3 Feb 2010 16:22:24 -0600
Received: from localhost (147.117.20.212) by eusaamw0707.eamcs.ericsson.se
 (147.117.20.92) with Microsoft SMTP Server id 8.1.375.2; Wed, 3 Feb 2010
 17:21:07 -0500
Date:   Wed, 3 Feb 2010 14:22:50 -0800
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     linux-mips@linux-mips.org
Subject: VMALLOC_END, TASK_SIZE and FIXADDR_START for 64 bit MIPS kernels
Message-ID: <20100203222250.GA21139@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <groeck@ericsson.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips

Hi,

since it came up during the review of the patch for virtual memory detection
on 64 bit mips kernels, I looked further into making vmalloc_end
a variable and TASK_SIZE dependent on the virtual memory size.
 
That turned out to be relatively straightforward, and I have a working patch.

The one question I still have is about FIXADDR_START.  It is currently
set to one of 0xff000000, 0xfffe0000, or (0xff000000 - 0x20000),
depending on the target CPU.

Quoting from one of the comments during the review,
	" ... ensure the value of vmalloc_end is <= FIXADDR_START".

Obviously that is currently not the case. Is that a concern, or is it good as it is ?

Thanks,
Guenter
