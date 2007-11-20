Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2007 18:30:34 +0000 (GMT)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:24514 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20021511AbXKTSa0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Nov 2007 18:30:26 +0000
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 1D6FE3100AC;
	Tue, 20 Nov 2007 18:30:02 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Tue, 20 Nov 2007 18:30:01 +0000 (UTC)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 20 Nov 2007 10:29:48 -0800
Message-ID: <4743279B.7070402@avtrex.com>
Date:	Tue, 20 Nov 2007 10:29:47 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.12 (X11/20071019)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Kaz Kylheku <kaz@zeugmasystems.com>, linux-mips@linux-mips.org
Subject: Re: futex_wake_op deadlock?
References: <20071119184837.GA12287@linux-mips.org> <DDFD17CC94A9BD49A82147DDF7D545C54DCDE2@exchange.ZeugmaSystems.local> <20071120112051.GB30675@linux-mips.org>
In-Reply-To: <20071120112051.GB30675@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Nov 2007 18:29:48.0122 (UTC) FILETIME=[54BA53A0:01C82BA3]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

> 
> Notice the branch at the end of the fixup code, it goes back to the
> SC instruction.  The SC instruction took an exception so it will not have
> changed $1 so the loop will continue endless unless by coincidence the
> value to be stored from $1 happened to be zero.
> 
> Obviously this one was MIPS specific and may hit all supported ABIs.  So
> my initial suspicion this might be the issue David Miller recently
> discovered in the binary compat code isn't true.  And it's a local DoS
> probably for all of 2.6.16 and up.
> 

I mostly similar code is in 2.6.15, so I think it is effected as well. 
2.6.12 on the other hand doesn't seem to have futex.h

David Daney
