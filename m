Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Aug 2004 09:29:03 +0100 (BST)
Received: from c154091.adsl.hansenet.de ([IPv6:::ffff:213.39.154.91]:37384
	"EHLO gruft.cubic.org") by linux-mips.org with ESMTP
	id <S8224851AbUHAI27>; Sun, 1 Aug 2004 09:28:59 +0100
Received: from cubic.org (starbase [192.168.10.1])
	by gruft.cubic.org (8.12.2/8.12.2) with ESMTP id i718SwW9003875
	for <linux-mips@linux-mips.org>; Sun, 1 Aug 2004 10:28:58 +0200
Message-ID: <410CAAD8.7070204@cubic.org>
Date: Sun, 01 Aug 2004 10:33:28 +0200
From: Michael Stickel <michael@cubic.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: ATI Rage XL
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <michael@cubic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5577
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael@cubic.org
Precedence: bulk
X-list: linux-mips

Hi.

I am new to the list.
I have a MIPS32 based platform with miniPCI slots and an ATI Rage XL.
There where rumors that there is code in the 2.6 Kernel that initializes 
the card for non-x86 platforms. I have found a file called xlinit.c
with a function atyfb_xl_init in it, but I did not find a place where it 
is called. I read that it is a patch from SGI to get the Rage XL running
on non X86 platforms.

Is all that only a rumor or does anyone have a pointer where to find
more information about the ATI Rage XL in non x86 platforms.

Michael
michael@cubic.org
