Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Aug 2008 21:46:48 +0100 (BST)
Received: from zrtps0kn.nortel.com ([47.140.192.55]:20443 "EHLO
	zrtps0kn.nortel.com") by ftp.linux-mips.org with ESMTP
	id S20022316AbYHEUqm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 5 Aug 2008 21:46:42 +0100
Received: from zcarhxs1.corp.nortel.com (zcarhxs1.corp.nortel.com [47.129.230.89])
	by zrtps0kn.nortel.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id m75KkVh02902;
	Tue, 5 Aug 2008 20:46:31 GMT
Received: from [47.130.64.132] ([47.130.64.132] RDNS failed) by zcarhxs1.corp.nortel.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 5 Aug 2008 16:46:30 -0400
Message-ID: <4898BC23.6050704@nortel.com>
Date:	Tue, 05 Aug 2008 14:46:27 -0600
From:	"Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Chad Reese <kreese@caviumnetworks.com>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: looking for help interpreting softlockup/stack trace
References: <48989AFE.5000500@nortel.com> <4898B7DD.6090402@caviumnetworks.com>
In-Reply-To: <4898B7DD.6090402@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Aug 2008 20:46:30.0636 (UTC) FILETIME=[56CBE2C0:01C8F73C]
Return-Path: <CFRIESEN@nortel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20120
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cfriesen@nortel.com
Precedence: bulk
X-list: linux-mips

Chad Reese wrote:
> I assume this is happening under high network load. Some early Octeon
> ethernet drivers had a problem where they could starve the rest of the
> system processing incoming packets. The message you are getting is the
> kernel warning you that userspace hasn't been given any processing time.
> What is probably happening is the cavium_ethernet driver is spending all
> its time in a receive tasklet getting packets and then dropping them.
> This has been fixed in a later cavium SDK, but it looks like you are
> running an ancient kernel. A newer kernel is available on the cavium
> support site.

It seems unlikely it's due to cpu load.  It's only receiving around 
30000 packets/sec total, and before the problem shows up "top" shows 
some cores at around 25% and others totally idle.  The only symptom of 
the problem is that the system simply stops responding.

You wouldn't happen to know which versions fixed the problem you 
described above, would you?  Upgrading the kernel isn't an option, but 
it wouldn't be the first time we've had to backport things.

> The cavium ethernet driver doesn't use the standard NAPI interface since
> it doesn't support multicore receive for a single port.

Ah...I was wondering about that.

Chris
