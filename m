Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Oct 2005 05:11:26 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:38686
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S8133500AbVJEELJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Oct 2005 05:11:09 +0100
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 4 Oct 2005 21:11:07 -0700
Message-ID: <4343525A.6080605@avtrex.com>
Date:	Tue, 04 Oct 2005 21:11:06 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Where is op_model_mipsxx.c ?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Oct 2005 04:11:07.0021 (UTC) FILETIME=[CF3433D0:01C5C962]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9141
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

I noticed this in the Makefile for the OProfile directory for mips:

oprofile-$(CONFIG_CPU_MIPS32_R1)                += op_model_mipsxx.o

The file op_model_mipsxx.c does not seem to exist.  Which implies to me 
that someone was working on making it work for MIPS32, but didn't quite 
finish.

I want to start hacking on OProfile for a MIPS32 based system and 
thought it might make a nice starting point.

If the missing file exists would its author mind making it available to me?

Thanks,
David Daney
