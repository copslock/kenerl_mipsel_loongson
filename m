Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Jul 2008 08:15:07 +0100 (BST)
Received: from ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk ([217.169.26.28]:15032
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20023505AbYGSHPF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 19 Jul 2008 08:15:05 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m6J7F2Dl019976;
	Sat, 19 Jul 2008 08:15:02 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m6J7F2if019969;
	Sat, 19 Jul 2008 08:15:02 +0100
Date:	Sat, 19 Jul 2008 08:15:02 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Gebert <martin.gebert@alpha-bit.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: HOWTO submit patches using WebMail - Help appreciated?
Message-ID: <20080719071502.GB7558@linux-mips.org>
References: <64660ef00807171259l55f85380l47cfdc7574f84099@mail.gmail.com> <200807181528.41119.brian.foster@innova-card.com> <20080718143913.GB25491@linux-mips.org> <4880AD07.2070509@alpha-bit.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4880AD07.2070509@alpha-bit.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19900
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 18, 2008 at 04:47:35PM +0200, Martin Gebert wrote:

>> I'd like to remind people of the wiki page on this topic at
>>
>>   http://www.linux-mips.org/wiki/Mailing-patches
>>
>> It's not been updated in a while and doesn't cover all clients or
>> possible solutions so feel free to update it.
>>   
> Which brings me to a question I've been wondering for some days now: Is  
> the [PATCH] prefix in the subject mandatory for a patch proposal being  
> noticed by the maintainers?

That's simply a question of working style and mail volume of the maintainer.

In the past I used to miss patches that were not sent to me directly at
times.  I solved that by filtering for patches using procmail.  But that
scheme also has its shortcomings; it would miss patches being sent in
too creative MIME encodings but people aren't supposed to do that anyway.

  Ralf
