Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 May 2003 14:14:03 +0100 (BST)
Received: from 66-152-54-2.ded.btitelecom.net ([IPv6:::ffff:66.152.54.2]:36378
	"EHLO mmc.atmel.com") by linux-mips.org with ESMTP
	id <S8225204AbTEMNOB>; Tue, 13 May 2003 14:14:01 +0100
Received: from mmc.atmel.com (pc-11.mmc.atmel.com [10.127.240.141])
	by mmc.atmel.com (8.9.3/8.9.3) with ESMTP id JAA17050
	for <linux-mips@linux-mips.org>; Tue, 13 May 2003 09:13:53 -0400 (EDT)
Message-ID: <3EC0EF90.7090705@mmc.atmel.com>
Date: Tue, 13 May 2003 09:13:52 -0400
From: David Kesselring <dkesselr@mmc.atmel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: accessing 64bit device
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dkesselr@mmc.atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dkesselr@mmc.atmel.com
Precedence: bulk
X-list: linux-mips

Hello,
We are trying to test a 64bit device implemented in an fpga connected to 
a 5kc on a MIPS Sead board.
My understanding is that linux built in 32bit mode can access this 64bit 
memory controller using a compile or linker option XPHYS.
I cannot find any documentation or examples on how to do this. If you 
have any suggestions or resources that could be useful, please let me know.
Sincerely,
David Kesselring

-- 
--------------------------------
W. David Kesselring
Sr. Software Engineer
Tel  : (919) 462_6587
Fax  : (919) 462_0300
Email: dkesselr@mmc.atmel.com
--------------------------------
Atmel
3800 Gateway Centre, Suite 311
Morrisville, NC 27560
-------------------------------- 
