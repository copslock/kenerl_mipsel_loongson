Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Mar 2003 13:44:47 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:27513 "EHLO
	trasno.mitica") by linux-mips.org with ESMTP id <S8224847AbTCXNoq>;
	Mon, 24 Mar 2003 13:44:46 +0000
Received: by trasno.mitica (Postfix, from userid 1001)
	id 24D986EE; Mon, 24 Mar 2003 14:44:31 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Julian Scheel <jscheel@activevb.de>, linux-mips@linux-mips.org
Subject: Re: Set Registers for VR4181A
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20030324140529.C4959@linux-mips.org> (Ralf Baechle's message
 of "Mon, 24 Mar 2003 14:05:30 +0100")
References: <200303240816.03482.jscheel@activevb.de>
	<20030324140529.C4959@linux-mips.org>
Date: Mon, 24 Mar 2003 14:44:31 +0100
Message-ID: <86r88wc20w.fsf@trasno.mitica>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2.93
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1798
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips

>>>>> "ralf" == Ralf Baechle <ralf@linux-mips.org> writes:

ralf> On Mon, Mar 24, 2003 at 08:16:03AM +0100, Julian Scheel wrote:
>> as I wrote a few weeks ago I have a NEC VR4181A-Board, on which I want to get 
>> linux running. Currently I have a kernel which should work, but it can't 
>> boot, since linux seems to expect that the registers have been already set by 
>> the bootloader. Since the used bootloader is a very small one which only 
>> proceeds the given files (written by a friend of me) it didn't do this job, 
>> so linux tries to access registers, which are not set yet.

ralf> Fixinging the few assumptions that Linus is making about the initializaton
                                         ^^^^^
ralf> state of the machine should be fairly easy.

I assume you mean Linux :)

Later, Juan "who didn't knew that Linus hacked in Linux/MIPS lately"



-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
