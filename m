Received:  by oss.sgi.com id <S553896AbRAIR0g>;
	Tue, 9 Jan 2001 09:26:36 -0800
Received: from mail.ivm.net ([62.204.1.4]:29192 "EHLO mail.ivm.net")
	by oss.sgi.com with ESMTP id <S553892AbRAIR03>;
	Tue, 9 Jan 2001 09:26:29 -0800
Received: from franz.no.dom (port108.duesseldorf.ivm.de [195.247.65.108])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id SAA23170
	for <linux-mips@oss.sgi.com>; Tue, 9 Jan 2001 18:26:16 +0100
X-To:   <linux-mips@oss.sgi.com>
Message-ID: <XFMail.010109181100.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010109095438.A10683@paradigm.rfc822.org>
Date:   Tue, 09 Jan 2001 18:11:00 +0100 (CET)
Reply-To: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     linux-mips@oss.sgi.com
Subject: Re: MIPS32 patches breaking DecStation
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


On 09-Jan-01 Florian Lohoff wrote:
> On Tue, Jan 09, 2001 at 01:34:47AM +0100, Kevin D. Kissell wrote:
>> Florian,
>> 
>> Could you do me a huge favor and try a build that
>> uses 3 or 4 nops instead of the branch to the instruction
>> after the delay slot?   There was a reason that I eliminated
> 
> No problem - Done - doesnt work

Same here on my /260 (R4400SC V4.0). Neither inserting four "sll $0,$0,1" nor
four "nop" seem to work. The branch, on the other hand, does.

-- 
Regards,
Harald
