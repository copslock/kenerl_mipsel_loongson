Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Mar 2003 07:15:28 +0000 (GMT)
Received: from [IPv6:::ffff:212.12.33.223] ([IPv6:::ffff:212.12.33.223]:8320
	"EHLO jusst.de") by linux-mips.org with ESMTP id <S8224847AbTCXHP1> convert rfc822-to-8bit;
	Mon, 24 Mar 2003 07:15:27 +0000
Received: from pd9e31316.dip.t-dialin.net ([217.227.19.22] helo=juli.scheel-home.de)
	by jusst.de with asmtp (Exim 4.05)
	id 18xM5u-0007V8-00
	for linux-mips@linux-mips.org; Mon, 24 Mar 2003 08:10:06 +0100
From: Julian Scheel <jscheel@activevb.de>
To: linux-mips@linux-mips.org
Subject: Set Registers for VR4181A
Date: Mon, 24 Mar 2003 08:16:03 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200303240816.03482.jscheel@activevb.de>
Return-Path: <jscheel@activevb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1796
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jscheel@activevb.de
Precedence: bulk
X-list: linux-mips

Hi all,

as I wrote a few weeks ago I have a NEC VR4181A-Board, on which I want to get 
linux running. Currently I have a kernel which should work, but it can't 
boot, since linux seems to expect that the registers have been already set by 
the bootloader. Since the used bootloader is a very small one which only 
proceeds the given files (written by a friend of me) it didn't do this job, 
so linux tries to access registers, which are not set yet.

So I need a bootloader which can do the job and works with my CPU/Board. Can 
someone give me a hint which one to use?

-- 
Grüße,
Julian
