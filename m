Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Sep 2004 15:58:37 +0100 (BST)
Received: from c2ce9fba.adsl.oleane.fr ([IPv6:::ffff:194.206.159.186]:54966
	"EHLO nikita.france.sdesigns.com") by linux-mips.org with ESMTP
	id <S8224933AbUIKO62>; Sat, 11 Sep 2004 15:58:28 +0100
Received: from nikita.france.sdesigns.com (localhost.localdomain [127.0.0.1])
	by nikita.france.sdesigns.com (8.12.11/8.12.11) with ESMTP id i8BEwIpW004146;
	Sat, 11 Sep 2004 16:58:18 +0200
Received: (from michon@localhost)
	by nikita.france.sdesigns.com (8.12.11/8.12.11/Submit) id i8BEwHdc004145;
	Sat, 11 Sep 2004 16:58:17 +0200
X-Authentication-Warning: nikita.france.sdesigns.com: michon set sender to em@realmagic.fr using -f
Subject: RE: ...cache dimensioning ;-)
From: Emmanuel Michon <em@realmagic.fr>
To: Adrian Hulse <adrian.hulse@lantronix.com>
Cc: linux-mips@linux-mips.org
In-Reply-To: <2F0FC2A92C0B154BB406D5E74CB3E6930B7EAC@3putt.int.lantronix.com>
References: <2F0FC2A92C0B154BB406D5E74CB3E6930B7EAC@3putt.int.lantronix.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: REALmagic France SAS
Message-Id: <1094914697.29872.8811.camel@nikita.france.sdesigns.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 11 Sep 2004 16:58:17 +0200
Return-Path: <em@realmagic.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5823
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: em@realmagic.fr
Precedence: bulk
X-list: linux-mips

On Fri, 2004-09-10 at 20:41, Adrian Hulse wrote:
> >If I consider a platform like Toshiba TX39 which has d-cache four ways
> >with total 32KBytes, it must already have the problems above. I'd like
> >to get some more clues though...
> 
> You probably meant to say Tx49 no ? The Tx39 has 16/8 k Instruction
> Cache, 8/4 k Data cache.

Sorry, yes, TX4938 (so far I could not boot linux from linux-mips cvs
tag 2_4_26 on this (I chose TX49[23]7 platform))

> 
> 
> 
> **********************************************************************
> This e-mail is the property of Lantronix. It is intended only for the person or entity to which it is addressed and may contain information that is privileged, confidential, or otherwise protected from disclosure. Distribution or copying of this e-mail, or the information contained herein, to anyone other than the intended recipient is prohibited. 
> 
