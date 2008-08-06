Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Aug 2008 19:36:37 +0100 (BST)
Received: from zrtps0kp.nortel.com ([47.140.192.56]:28856 "EHLO
	zrtps0kp.nortel.com") by ftp.linux-mips.org with ESMTP
	id S28575446AbYHFSg3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Aug 2008 19:36:29 +0100
Received: from zcarhxs1.corp.nortel.com (zcarhxs1.corp.nortel.com [47.129.230.89])
	by zrtps0kp.nortel.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id m76IaJI02096;
	Wed, 6 Aug 2008 18:36:20 GMT
Received: from [47.130.64.42] ([47.130.64.42] RDNS failed) by zcarhxs1.corp.nortel.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 6 Aug 2008 14:36:16 -0400
Message-ID: <4899EF0E.705@nortel.com>
Date:	Wed, 06 Aug 2008 12:35:58 -0600
From:	"Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: looking for help interpreting softlockup/stack trace
References: <48989AFE.5000500@nortel.com> <20080805191618.GB8629@linux-mips.org>
In-Reply-To: <20080805191618.GB8629@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Aug 2008 18:36:17.0773 (UTC) FILETIME=[506159D0:01C8F7F3]
Return-Path: <CFRIESEN@nortel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cfriesen@nortel.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

> $LBB378 is an internal symbol.  The value of RA may not be very informative
> if it was overwritten by a random subroutine call.

What determines which function names get compiled into the object file, 
and which ones get these numerical symbols?

> You may also try lockdep; it gives much more detailed information though
> it's more heavyweight.

I would love to be able to use lockdep...however I'm stuck on an old kernel.

Chris
