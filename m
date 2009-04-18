Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Apr 2009 10:06:51 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:48292 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20023141AbZDRJGi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 18 Apr 2009 10:06:38 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n3I96afL016928;
	Sat, 18 Apr 2009 11:06:36 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n3I96ZSR016926;
	Sat, 18 Apr 2009 11:06:35 +0200
Date:	Sat, 18 Apr 2009 11:06:35 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Include linux/errno.h from
	arch/mips/include/asm/compat.h
Message-ID: <20090418090634.GC11339@linux-mips.org>
References: <1239388895-27305-1-git-send-email-ddaney@caviumnetworks.com> <20090410191611.GB23582@linux-mips.org> <20090411.233150.25909696.anemo@mba.ocn.ne.jp> <49E75678.7050909@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49E75678.7050909@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 16, 2009 at 09:02:00AM -0700, David Daney wrote:

>> Subject: [PATCH] Do not include seccomp.h from compat.h
>> From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>>
>> The compat.h does not need seccomp.h since TIF_32BIT was moved to
>> thread_info.h
>>
>> This fixes a build error of 64-bit kernel without CONFIG_SECCOMP.
>>
>> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>

Acked-by: you meant?  Eiher way, applied and I'll also send out a patch to
include <linux/errno.h> into <linux/seccmp.h>.

  Ralf
