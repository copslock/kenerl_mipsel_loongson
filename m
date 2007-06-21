Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jun 2007 15:35:10 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:34760 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021578AbXFUOfI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 Jun 2007 15:35:08 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l5LERL73024760;
	Thu, 21 Jun 2007 15:27:22 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l5LERLdm024759;
	Thu, 21 Jun 2007 15:27:21 +0100
Date:	Thu, 21 Jun 2007 15:27:21 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Daniel Laird <daniel.j.laird@nxp.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Philips(NXP)/STB810 changes
Message-ID: <20070621142721.GC21938@linux-mips.org>
References: <11229250.post@talk.nabble.com> <467A67B6.6090909@ru.mvista.com> <11232209.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11232209.post@talk.nabble.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15501
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 21, 2007 at 05:37:25AM -0700, Daniel Laird wrote:

> Please find the new patch below - I hope it is following the correct rules
> now.

This is a good opportunity to advertise the checkpatch.pl script which is
part of the latest kernel once more.  For example running it against your
patch results gives:

[ralf@denk linux-queue]$ scripts/checkpatch.pl /tmp/xxx 
line over 80 characters
#107: FILE: arch/mips/philips/pnx8550/common/setup.c:117:
+                                  (PR4450_CMEM_SIZE_128MB << PR4450_CMEMB_SIZE) |

line over 80 characters
#112: FILE: arch/mips/philips/pnx8550/common/setup.c:122:
+                                  (PR4450_CMEM_SIZE_128MB << PR4450_CMEMB_SIZE) |

trailing whitespace
#141: 
>> +++ kernel-new/arch/mips/philips/pnx8550/common/setup.c $

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
[ralf@denk linux-queue]$ 
