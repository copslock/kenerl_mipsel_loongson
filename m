Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Sep 2007 18:27:11 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:19148 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20023838AbXISR1B (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 19 Sep 2007 18:27:01 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id EDD2330C769;
	Wed, 19 Sep 2007 17:26:34 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Wed, 19 Sep 2007 17:26:33 +0000 (UTC)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 19 Sep 2007 10:26:11 -0700
Message-ID: <46F15BB3.50107@avtrex.com>
Date:	Wed, 19 Sep 2007 10:26:11 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.12 (X11/20070719)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Richard Sandiford <rsandifo@nildram.co.uk>,
	GCC Mailing List <gcc@gcc.gnu.org>, linux-mips@linux-mips.org
Subject: Re: MIPS atomic memory operations (A.K.A PR 33479).
References: <46F06980.4080500@avtrex.com> <20070919165809.GA14767@linux-mips.org> <Pine.LNX.4.64N.0709191759361.24627@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0709191759361.24627@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Sep 2007 17:26:12.0004 (UTC) FILETIME=[2C886E40:01C7FAE2]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Wed, 19 Sep 2007, Ralf Baechle wrote:
> 
>> Please make this loop closure branch a branch-likely.  This is necessary
>> as a errata workaround for some processors.
> 
>  Do we emulate them for MIPS I?  We do emulate "ll" and "sc" and adding 
> "sync" is easy

Currently, I (and thus GCC 4.3) am assuming that Linux emulates 'll', 
'sc' and 'sync', If sync is not emulated, we would need to adjust the 
code generation so that it is not emitted on ISAs that don't support it.

> (as a no-op as support for R3000 SMP is unlikely to ever 
> happen).  Adding branches-likely, hmm...  Even though we do have logic to 
> do that as a part of the FP emulator.
> 
>  A workaround for a CPU erratum fits within the "-mfix-*" option family 
> quite well though.

Do we know which CPUs require branch-likely?

I would be inclined to agree with adding a "-mfix-??" option.

The only place where GCC's __sync_* primitives are generated without 
explicitly writing them into your program is in GCJ compiled java code 
that uses volatile fields.

If we expect the use of the __sync_* primitives on CPUs that require 
branch-likely to be rare, we shouldn't penalize those trying to rid 
themselves of the beasts.

> 
>   Maciej
