Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jul 2009 03:19:45 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:62995 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493470AbZGABTi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Jul 2009 03:19:38 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a4ab85d0000>; Tue, 30 Jun 2009 21:14:05 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 30 Jun 2009 18:13:41 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 30 Jun 2009 18:13:41 -0700
Message-ID: <4A4AB845.1030906@caviumnetworks.com>
Date:	Tue, 30 Jun 2009 18:13:41 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Define  __arch_swab64 for all mips r2 cpus (v2).
References: <1246294455-26866-1-git-send-email-ddaney@caviumnetworks.com> <20090629193454.GA23430@linux-mips.org> <alpine.LFD.2.00.0907010132500.23134@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.00.0907010132500.23134@eddie.linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Jul 2009 01:13:41.0640 (UTC) FILETIME=[2BECB880:01C9F9E9]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23555
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Mon, 29 Jun 2009, Ralf Baechle wrote:
> 
>>> Some CPUs implement mipsr2, but because they are a super-set of
>>> mips64r2 do not define CONFIG_CPU_MIPS64_R2.  Cavium OCTEON falls into
>>> this category.  We would still like to use the optimized
>>> implementation, so since we have already checked for
>>> CONFIG_CPU_MIPSR2, checking for CONFIG_64BIT instead of
>>> CONFIG_CPU_MIPS64_R2 is sufficient.
>>>
>>> Change from v1: Add comments about why the change is safe.
>> Thanks, applied.  Though this sort of patch make me thing that maybe we
>> rather should have treated the cnMIPS cores differently.
> 
>  This is a pure code generation option and it asks for "select 
> CPU_MIPS64_R2" under CPU_OCTEON (or whatever option is used for that 
> chip).  Or something like "select ISA_MIPS64_R2" actually, as we want to 
> keep CPU_foo as the -march=, etc. designator.  IOW it looks like we lack 
> ISA supersetting along the lines of how tools handle it.
> 

The problem with CPU_MIPS64_R2 in the kernel is that it means two 
unrelated things:

1) The cpu can execute all mips64r2 ISA instructions.

2) The cpu requires that all worse case cache and execution hazards are 
handled.

In the case of the Octeon processors, #1 is true, but we can get better 
performance by omitting many of the hazard barriers because they are 
unneeded.

David Daney
