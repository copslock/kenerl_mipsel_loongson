Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2009 04:36:19 +0100 (BST)
Received: from ekkaia.net ([70.164.72.43]:54451 "EHLO
	himling.belegaer.ekkaia.net") by ftp.linux-mips.org with ESMTP
	id S20022164AbZDXDgL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Apr 2009 04:36:11 +0100
Received: from imladris.belegaer.ekkaia.net ([192.168.1.2] helo=[192.168.3.101])
	by himling with esmtp (Exim 4.63)
	(envelope-from <cpp@ekkaia.net>)
	id 1LxCCp-0007Es-48; Thu, 23 Apr 2009 23:36:03 -0400
Message-ID: <49F1339E.4090200@ekkaia.net>
Date:	Thu, 23 Apr 2009 23:35:58 -0400
From:	Craig Prescott <cpp@ekkaia.net>
User-Agent: Mozilla-Thunderbird 2.0.0.14 (X11/20080509)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: dec_esp?
References: <49EFE510.2090306@ekkaia.net> <alpine.LFD.1.10.0904230947100.29465@ftp.linux-mips.org>
In-Reply-To: <alpine.LFD.1.10.0904230947100.29465@ftp.linux-mips.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam_score: -4.4
X-Spam_score_int: -43
X-Spam_bar: ----
X-Spam_report: Spam detection software, running on the system "himling", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Maciej W. Rozycki wrote: > On Wed, 22 Apr 2009, Craig
	Prescott wrote: >> I've built a 2.6.28.4 kernel from LinuxMIPS.org and
	have booted it on >> one of >> my DECstations. No SCSI devices are
	detected, though. >> >> I noted that the dec_esp driver was removed from
	the kernel. Does an >> alternative exist? > <snip> > > You're the first
	one to ask since the old driver was removed -- which is > sort of
	indicative of how much interest (beyond myself) in the > platform is >
	there. I have planned to get back at it once I am done with what I'm >
	doing at the moment (which'll take a while yet), so I have noted your >
	request, but feel free to look into the driver if you like. There's a
	GIT > tree at kernel.org dedicated to ESP development and the point of
	contact > is DaveM. Ok, thanks. I will have a look. I'm not sure if I'll
	be able to do anything useful - maybe start by looking at the old
	dec_esp driver and at how other 53c94 drivers made the conversion from
	the NCR to the esp_scsi core will give some guidance. [...] 
	Content analysis details:   (-4.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.8 ALL_TRUSTED            Passed through trusted hosts only via SMTP
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Return-Path: <cpp@ekkaia.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cpp@ekkaia.net
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Wed, 22 Apr 2009, Craig Prescott wrote:
>> I've built a 2.6.28.4 kernel from LinuxMIPS.org and have booted it on 
>> one of
>> my DECstations. No SCSI devices are detected, though.
>>
>> I noted that the dec_esp driver was removed from the kernel. Does an
>> alternative exist?
> <snip>
>
> You're the first one to ask since the old driver was removed -- which is
> sort of indicative of how much interest (beyond myself) in the 
> platform is
> there. I have planned to get back at it once I am done with what I'm
> doing at the moment (which'll take a while yet), so I have noted your
> request, but feel free to look into the driver if you like. There's a GIT
> tree at kernel.org dedicated to ESP development and the point of contact
> is DaveM.
Ok, thanks.  I will have a look.  I'm not sure if I'll be able to do 
anything useful - maybe start by looking at the old dec_esp driver and 
at how other 53c94 drivers made the conversion from the NCR to the 
esp_scsi core will give some guidance.

Cheers,
Craig
