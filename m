Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Oct 2009 22:33:59 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:32863 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493876AbZJBUdz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Oct 2009 22:33:55 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n92KYudu010272;
	Fri, 2 Oct 2009 22:34:57 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n92KYsET010270;
	Fri, 2 Oct 2009 22:34:54 +0200
Date:	Fri, 2 Oct 2009 22:34:54 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Don't write ones to reserved entryhi bits.
Message-ID: <20091002203454.GA9138@linux-mips.org>
References: <1241812330-21041-1-git-send-email-ddaney@caviumnetworks.com> <20090527162937.GA9831@linux-mips.org> <4AB129DF.8060200@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AB129DF.8060200@caviumnetworks.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 16, 2009 at 11:09:35AM -0700, David Daney wrote:

>>> According to the MIPS64 Privileged Resource Architecture manual, only
>>> values of zero may be written to bits 8..10 of CP0 entryhi.  We need
>>> to add masking by ASID_MASK.
>>
>> Yes, I've silently been relying on the hardware chopping off the excess
>> bits for no better reason that it saving an instruction.  One of the
>> functions you've touched is switch_mm() which is being used in context
>> switches and any changes to it will show up in context switching
>> benchmarks.
>>
>> The patch you did (and along with that some older SMTC changes by Kevin)
>> can be done slightly more elegant because we already have:
>>
>> #define cpu_asid(cpu, mm)       (cpu_context((cpu), (mm)) & ASID_MASK)
>>
>> in <asm/mmu_context.h>.
>>
>> We used to optimize the ASID managment code by code patching even, see
>> mmu_context.h in 78c388aed2b7184182c08428db1de6c872d815f5.
>>
>>   Ralf
>>
>> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>>
>
> This is nice, but you never committed it.

Waiting for people to test it - thanks!  Committing it now.

  Ralf
