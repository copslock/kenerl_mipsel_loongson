Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jun 2004 19:12:27 +0100 (BST)
Received: from avtrex.com ([IPv6:::ffff:216.102.217.178]:56143 "EHLO
	avtrex.com") by linux-mips.org with ESMTP id <S8225934AbUFKSMV>;
	Fri, 11 Jun 2004 19:12:21 +0100
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 11 Jun 2004 11:10:09 -0700
Message-ID: <40C9F5A4.2050606@avtrex.com>
Date: Fri, 11 Jun 2004 11:10:44 -0700
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: [Patch]  / 0 should send SIGFPE not SIGTRAP...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Jun 2004 18:10:09.0958 (UTC) FILETIME=[553D0460:01C44FDF]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5287
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

I am getting a SIGTRAP whenever an integer divide by 0 happens.  It 
should be sending SIGFPE.

It looks like kernel/traps.c is a little messed up.

The attached patch fixes it for me.

The decoding of the break instruction was selecting the wrong bits.  It 
looks like the trap instruction decoding was messed up also.  The patch 
fixes trap also, but I could not figure out how to get gcc to generate 
the trap form of division, so that part is untested.

David Daney.
