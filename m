Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Oct 2009 22:27:15 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:47528 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492873AbZJKU1I (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 11 Oct 2009 22:27:08 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.60])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id n9BKR1MN001220;
	Sun, 11 Oct 2009 13:27:01 -0700
Received: from [192.168.3.60] ([192.168.3.60]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 11 Oct 2009 13:27:01 -0700
Message-ID: <4AD23F92.8030902@mips.com>
Date:	Sun, 11 Oct 2009 13:26:58 -0700
From:	Chris Dearman <chris@mips.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Avoid potential hazard on Context register
References: <4AD17619.1000201@mips.com> <20091011133912.GA15684@linux-mips.org> <20091011145330.GA23369@linux-mips.org>
In-Reply-To: <20091011145330.GA23369@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Oct 2009 20:27:01.0101 (UTC) FILETIME=[302701D0:01CA4AB1]
Return-Path: <chris@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@mips.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> There is no hazard barrier between writes to c0_context and subsequent
> read accesses.  This is a fairly theoretical hole as c0_context is only
> written on CPU bootup and other, unrelated code will almost certainly
It was actually in the bootup code where I saw the problem, and this 
patch doesn't deal with that case:

>         MTC0            zero, CP0_CONTEXT       # clear context register 
>         PTR_LA          $28, init_thread_union 
>         /* Set the SP after an empty pt_regs.  */ 
>         PTR_LI          sp, _THREAD_SIZE - 32 - PT_SIZE 
>         PTR_ADDU        sp, $28 
>         back_to_back_c0_hazard 
>         set_saved_sp    sp, t0, t1 

The problem I observed is that the Context valuse used by set_saved_sp 
is whatever it inherits from YAMON.

Chris

-- 
Chris Dearman               Desk: +1 408 530 5092  Cell: +1 650 224 8603
MIPS Technologies Inc            955 East Arques Ave, Sunnyvale CA 94085
