Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Apr 2009 10:59:16 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:11416 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S20046224AbZDWI7w (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Apr 2009 09:59:52 +0100
Date:	Thu, 23 Apr 2009 09:59:52 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Craig Prescott <cpp@ekkaia.net>
cc:	linux-mips@linux-mips.org
Subject: Re: dec_esp?
In-Reply-To: <49EFE510.2090306@ekkaia.net>
Message-ID: <alpine.LFD.1.10.0904230947100.29465@ftp.linux-mips.org>
References: <49EFE510.2090306@ekkaia.net>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22436
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 22 Apr 2009, Craig Prescott wrote:

> I've built a 2.6.28.4 kernel from LinuxMIPS.org and have booted it on one of
> my DECstations.  No SCSI devices are detected, though.
> 
> I noted that the dec_esp driver was removed from the kernel.  Does an
> alternative exist?

 Not at the moment.  I meant to write frontends for the esp_scsi core, but 
got stuck with interrupts for the PMAZC card -- the core has to be 
redesigned (the way the core handles them right now is awful) to get the 
card supported correctly and I didn't have time to get into it yet.  
Simpler wirings such as the PMAZ card or the IOASIC setup might be 
supportable more easily, but said support would have to be rewritten once 
the core has been fixed.

 You're the first one to ask since the old driver was removed -- which is 
sort of indicative of how much interest (beyond myself) in the platform is 
there.  I have planned to get back at it once I am done with what I'm 
doing at the moment (which'll take a while yet), so I have noted your 
request, but feel free to look into the driver if you like.  There's a GIT 
tree at kernel.org dedicated to ESP development and the point of contact 
is DaveM.

  Maciej
