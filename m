Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Oct 2005 00:59:31 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:54021
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S8133590AbVJGX7N (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 8 Oct 2005 00:59:13 +0100
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 7 Oct 2005 16:59:11 -0700
Message-ID: <43470BCF.1070709@avtrex.com>
Date:	Fri, 07 Oct 2005 16:59:11 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: OProfile cannot be loaded as module...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Oct 2005 23:59:11.0563 (UTC) FILETIME=[1CED99B0:01C5CB9B]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9198
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

arch/mips/oprofile/common.c defines several symbols (op_model_mipsxx and 
op_model_rm9000) with __attribute__((weak)).  It then assumes that ELF 
linking conventions will prevail and there will be no problems if they 
are undefined.

The problem is if you try to load oprofile as a module.  The kernel 
module linker evidentially does not understand weak symbols and refuses 
to load the module because they are undefined.

Perhaps a single

extern struct op_mips_model plat_op_model;

That must be defined by each different implementation.  Deciding one 
which implementation would then be done at compile time instead of runtime.

I don't have a patch for this yet, but that is what I am thinking of doing.

David Daney.
