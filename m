Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Sep 2007 18:48:06 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:40429 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20023880AbXISRr4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 19 Sep 2007 18:47:56 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 29FE6309FB2;
	Wed, 19 Sep 2007 17:48:03 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Wed, 19 Sep 2007 17:48:03 +0000 (UTC)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 19 Sep 2007 10:47:42 -0700
Message-ID: <46F160BE.9030500@avtrex.com>
Date:	Wed, 19 Sep 2007 10:47:42 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.12 (X11/20070719)
MIME-Version: 1.0
To:	David Daney <ddaney@avtrex.com>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Richard Sandiford <rsandifo@nildram.co.uk>,
	GCC Mailing List <gcc@gcc.gnu.org>, linux-mips@linux-mips.org
Subject: Re: MIPS atomic memory operations (A.K.A PR 33479).
References: <46F06980.4080500@avtrex.com> <20070919165809.GA14767@linux-mips.org> <Pine.LNX.4.64N.0709191759361.24627@blysk.ds.pg.gda.pl> <46F15BB3.50107@avtrex.com>
In-Reply-To: <46F15BB3.50107@avtrex.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Sep 2007 17:47:42.0807 (UTC) FILETIME=[2DE95670:01C7FAE5]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> Maciej W. Rozycki wrote:
>> On Wed, 19 Sep 2007, Ralf Baechle wrote:
>>
>>> Please make this loop closure branch a branch-likely.  This is necessary
>>> as a errata workaround for some processors.
>>
>>  Do we emulate them for MIPS I?  We do emulate "ll" and "sc" and 
>> adding "sync" is easy
> 
> Currently, I (and thus GCC 4.3) am assuming that Linux emulates 'll', 
> 'sc' and 'sync', If sync is not emulated, we would need to adjust the 
> code generation so that it is not emitted on ISAs that don't support it.
> 

I just checked myself.  'sync' is not emulated.  We will have to make a 
change so that it is not emitted on ISAs that do not support it.

David Daney
