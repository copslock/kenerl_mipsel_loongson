Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jun 2004 17:31:06 +0100 (BST)
Received: from fep01-mail.bloor.is.net.cable.rogers.com ([IPv6:::ffff:66.185.86.71]:2899
	"EHLO fep01-mail.bloor.is.net.cable.rogers.com") by linux-mips.org
	with ESMTP id <S8225984AbUFLQbC>; Sat, 12 Jun 2004 17:31:02 +0100
Received: from ieee.org ([24.157.59.167]) by web01-imail.rogers.com
          (InterMail vM.5.01.05.12 201-253-122-126-112-20020820) with ESMTP
          id <20040612162906.BAES278675.web01-imail.rogers.com@ieee.org>
          for <linux-mips@linux-mips.org>; Sat, 12 Jun 2004 12:29:06 -0400
Message-ID: <40CB2FAF.3050807@ieee.org>
Date: Sat, 12 Jun 2004 12:30:39 -0400
From: Charles Eidsness <charles.eidsness@ieee.org>
Reply-To: charles.eidsness@ieee.org
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Au1000 AC97 ALSA Driver
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at web01-imail.rogers.com from [24.157.59.167] using ID <charles.eidsness@rogers.com> at Sat, 12 Jun 2004 12:29:04 -0400
Return-Path: <charles.eidsness@ieee.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: charles.eidsness@ieee.org
Precedence: bulk
X-list: linux-mips

I've been working on an ALSA driver for the Au1000 processor AC'97 port. 
Specifically for the DBAu1000 Merlot eval card. It seems to be working 
in OSS emulation mode, I'm having a few problems setting up my system to 
work in ALSA native mode, and it contains only a minimum of features. 
i.e. it's still a work in progress, but I thought there may be someone 
else out there interested in it.

I've posted a patch that should add a mips sub-directory in the sound 
directory of the 2.6.6 kernel and add an au1000 sound option to the 
kernel configuration menu here: 
http://members.rogers.com/charles.eidsness/au1000_alsa.patch

Alternately you can find just the source code here:
http://members.rogers.com/charles.eidsness/au1000.c

Cheers,
Charles
