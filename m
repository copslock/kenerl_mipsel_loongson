Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Jun 2004 06:04:46 +0100 (BST)
Received: from smtp808.mail.sc5.yahoo.com ([IPv6:::ffff:66.163.168.187]:49062
	"HELO smtp808.mail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8224915AbUFMFEl>; Sun, 13 Jun 2004 06:04:41 +0100
Received: from unknown (HELO ?10.2.2.68?) (ppopov@pacbell.net@63.194.214.47 with plain)
  by smtp808.mail.sc5.yahoo.com with SMTP; 13 Jun 2004 05:04:34 -0000
Subject: Re: Au1000 AC97 ALSA Driver
From: Pete Popov <pete_popov@yahoo.com>
To: charles.eidsness@ieee.org
Cc: linux-mips@linux-mips.org
In-Reply-To: <40CB2FAF.3050807@ieee.org>
References: <40CB2FAF.3050807@ieee.org>
Content-Type: text/plain
Organization: 
Message-Id: <1087103071.1432.3.camel@thinkpad>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 12 Jun 2004 22:04:31 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <pete_popov@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pete_popov@yahoo.com
Precedence: bulk
X-list: linux-mips

On Sat, 2004-06-12 at 09:30, Charles Eidsness wrote:
> I've been working on an ALSA driver for the Au1000 processor AC'97 port. 
> Specifically for the DBAu1000 Merlot eval card. It seems to be working 
> in OSS emulation mode, I'm having a few problems setting up my system to 
> work in ALSA native mode, and it contains only a minimum of features. 
> i.e. it's still a work in progress, but I thought there may be someone 
> else out there interested in it.
> 
> I've posted a patch that should add a mips sub-directory in the sound 
> directory of the 2.6.6 kernel and add an au1000 sound option to the 
> kernel configuration menu here: 
> http://members.rogers.com/charles.eidsness/au1000_alsa.patch
> 
> Alternately you can find just the source code here:
> http://members.rogers.com/charles.eidsness/au1000.c

Great -- let me know when the driver is ready to be checked in :)

Pete
