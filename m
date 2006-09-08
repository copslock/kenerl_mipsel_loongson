Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Sep 2006 18:39:44 +0100 (BST)
Received: from dmz.mips-uk.com ([194.74.144.194]:29712 "EHLO dmz.mips-uk.com")
	by ftp.linux-mips.org with ESMTP id S20037816AbWIHRjm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 8 Sep 2006 18:39:42 +0100
Received: from dmzgw.mips-uk.com ([194.74.144.193] helo=ukservices1.mips.com)
	by dmz.mips-uk.com with esmtp (Exim 3.35 #1 (Debian))
	id 1GLkKF-0001L6-00; Fri, 08 Sep 2006 18:39:35 +0100
Received: from highbury.mips.com ([192.168.192.236])
	by ukservices1.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GLkJp-0007KS-00; Fri, 08 Sep 2006 18:39:09 +0100
Message-ID: <4501AABC.1050009@mips.com>
Date:	Fri, 08 Sep 2006 18:39:08 +0100
From:	Nigel Stephens <nigel@mips.com>
Organization: MIPS Technologies
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org
CC:	dan@debian.org, macro@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] fast path for rdhwr emulation for TLS
References: <Pine.LNX.4.64N.0607071715360.25285@blysk.ds.pg.gda.pl>	<20060710.235553.48797818.anemo@mba.ocn.ne.jp>	<20060711025342.GA6898@nevyn.them.org> <20060711.122014.52129937.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20060711.122014.52129937.nemoto@toshiba-tops.co.jp>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MIPS-Technologies-UK-MailScanner: Found to be clean
X-MIPS-Technologies-UK-MailScanner-From: nigel@mips.com
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips

moto wrote:
>   
>> BTW, if the fast emulation can't handle rdhwr in a delay slot, please
>> report a bug on GCC asking it not to put rdhwr in delay slots by
>> default.  It's probably worthwhile.
>>     
>
> If rdhwr was on a delay slot, the slow emulation will be more slower.
> So I think rdhwr should not be put on delay slot anyway regardless
> fast emulation.
>
> I asked on GCC bugzilla a few days ago but can not got feedback yet.
> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=28126
>   

In spite of the GCC issue, is this patch now at the point where it could
be applied, or at least queued?

Nigel
