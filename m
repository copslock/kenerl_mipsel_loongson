Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 May 2003 12:01:08 +0100 (BST)
Received: from nr2-216-196-136-17.fuse.net ([IPv6:::ffff:216.196.136.17]:29962
	"EHLO dellpi.pinski.fam") by linux-mips.org with ESMTP
	id <S8225196AbTEALBB>; Thu, 1 May 2003 12:01:01 +0100
Received: from physics.uc.edu (IDENT:pinskia@localhost.pinski.fam [127.0.0.1])
	by dellpi.pinski.fam (8.12.2/8.12.1) with ESMTP id h41B0oMJ025267;
	Thu, 1 May 2003 07:00:50 -0400 (EDT)
Date: Thu, 1 May 2003 07:00:51 -0400
Subject: Re: GCC -O2 failure for mipsel
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: Andrew Pinski <pinskia@physics.uc.edu>,
	Fuxin Zhang <fxzhang@ict.ac.cn>,
	MAKE FUN PRANK CALLS <linux-mips@linux-mips.org>,
	gcc@gcc.gnu.org
To: Andrew Haley <aph@redhat.com>
From: Andrew Pinski <pinskia@physics.uc.edu>
In-Reply-To: <16048.57054.224964.883062@cuddles.redhat.com>
Message-Id: <2BE9BD5D-7BC4-11D7-A4A1-000393A6D2F2@physics.uc.edu>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Return-Path: <pinskia@physics.uc.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pinskia@physics.uc.edu
Precedence: bulk
X-list: linux-mips

It is the gcc component of SPEC that needs explaining to, this has been 
talked about before:
<http://gcc.gnu.org/ml/gcc/2002-01/msg00711.html>

Thanks,
Andrew Pinski

On Thursday, May 1, 2003, at 04:46 US/Eastern, Andrew Haley wrote:

> Fuxin Zhang writes:
>>  Thanks, -fno-strict-aliasing works.
>> --The actual code can't be changed: because it is part of spec 
>> cpu2000:)
>
> Perhaps SPEC need to have ISO C explained to them...
>
> Andrew.
>
>
