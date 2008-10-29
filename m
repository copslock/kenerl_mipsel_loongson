Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2008 16:18:32 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:54391 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22667889AbYJ2QS1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Oct 2008 16:18:27 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49088cc10000>; Wed, 29 Oct 2008 12:18:09 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 29 Oct 2008 09:18:07 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 29 Oct 2008 09:18:07 -0700
Message-ID: <49088CBF.8060109@caviumnetworks.com>
Date:	Wed, 29 Oct 2008 09:18:07 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: Re: [PATCH 15/36] Probe for Cavium OCTEON CPUs.
References: <1225152181-3221-6-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-7-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-8-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-9-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-10-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-11-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-12-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-13-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-14-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-15-git-send-email-ddaney@caviumnetworks.com> <20081029121737.GA26256@linux-mips.org>
In-Reply-To: <20081029121737.GA26256@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Oct 2008 16:18:07.0512 (UTC) FILETIME=[EDB2E980:01C939E1]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
[...]
> 
> We probably should move the mips_probe_watch_registers() into
> mips_probe_watch_registers().  I notice the function is only getting
> called from cpu_probe_mips().  Iow the watch register support won't work
> for CPUs made by any other vendor.  So I suggest below patch.  Plus
> all of the above patch sans the mips_probe_watch_registers call on top.
> 
>   Ralf
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index 0cf1545..008230f 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c

Acked-by: David Daney <ddaney@caviumnetworks.com>

This seems sane to me assuming that alchemy, sibyte, sandcraft, nxp, and 
broadcom all have standard mips{32,64} watch registers (i.e., if the 
watch bit in config1 is set the registers have mips semantics).

David Daney
