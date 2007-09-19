Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Sep 2007 19:22:01 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:59268 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20023828AbXISSVw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 19 Sep 2007 19:21:52 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id DA91CB9B17;
	Wed, 19 Sep 2007 20:12:50 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1IY42L-0004WN-Gp; Wed, 19 Sep 2007 19:12:33 +0100
Date:	Wed, 19 Sep 2007 19:12:33 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	David Daney <ddaney@avtrex.com>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Richard Sandiford <rsandifo@nildram.co.uk>,
	GCC Mailing List <gcc@gcc.gnu.org>, linux-mips@linux-mips.org
Subject: Re: MIPS atomic memory operations (A.K.A PR 33479).
Message-ID: <20070919181233.GR9972@networkno.de>
References: <46F06980.4080500@avtrex.com> <20070919165809.GA14767@linux-mips.org> <Pine.LNX.4.64N.0709191759361.24627@blysk.ds.pg.gda.pl> <46F15BB3.50107@avtrex.com> <Pine.LNX.4.64N.0709191836140.24627@blysk.ds.pg.gda.pl> <46F16142.1090600@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46F16142.1090600@avtrex.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> Maciej W. Rozycki wrote:
>> On Wed, 19 Sep 2007, David Daney wrote:
>>> Currently, I (and thus GCC 4.3) am assuming that Linux emulates 'll', 
>>> 'sc' and
>>> 'sync', If sync is not emulated, we would need to adjust the code 
>>> generation
>>> so that it is not emitted on ISAs that don't support it.
>>  While adding "sync" is trivial enough I may have a patch ready by 
>> tomorrow, that will not change the existing userbase and I am not entirely 
>> sure forcing such a hasty upgrade on people would be reasonable; likely 
>> not.
>>>> A workaround for a CPU erratum fits within the "-mfix-*" option family 
>>>> quite
>>>> well though.
>>> Do we know which CPUs require branch-likely?
>>  The R10000; there is a note about it in <asm-mips/war.h> at 
>> R10000_LLSC_WAR.
>>> I would be inclined to agree with adding a "-mfix-??" option.
>>>
>>> The only place where GCC's __sync_* primitives are generated without
>>> explicitly writing them into your program is in GCJ compiled java code 
>>> that
>>> uses volatile fields.
>>>
>>> If we expect the use of the __sync_* primitives on CPUs that require
>>> branch-likely to be rare, we shouldn't penalize those trying to rid 
>>> themselves
>>> of the beasts.
>>  Another option is to depend on the setting of -mbranch-likely.  By 
>> default it is on only for the processors which implement it and do not 
>> discourage it, i.e. these of the MIPS II, MIPS III and MIPS IV ISAs.
>
> This seems to be the most sensible option.
>
> I will try to work up the GCC patch tonight.

This means generic MIPS code (MIPS I) wil have broken atomic
intrinsics when run on modern MIPS machines.


Thiemo
