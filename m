Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Feb 2004 20:11:53 +0000 (GMT)
Received: from web41510.mail.yahoo.com ([IPv6:::ffff:66.218.93.93]:47964 "HELO
	web41510.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225603AbUBWULt>; Mon, 23 Feb 2004 20:11:49 +0000
Message-ID: <20040223201134.72649.qmail@web41510.mail.yahoo.com>
Received: from [209.172.118.142] by web41510.mail.yahoo.com via HTTP; Mon, 23 Feb 2004 12:11:34 PST
Date:	Mon, 23 Feb 2004 12:11:34 -0800 (PST)
From:	Krishna Kondaka <kkondaka@yahoo.com>
Subject: Re: MIPS SMP Linux
To:	dwalton+mips@ddtsm.com
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <kkondaka@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kkondaka@yahoo.com
Precedence: bulk
X-list: linux-mips

Thanks for the reply daniel,


>> I would like to know if any one is using MIPS SMP
>> Linux in the realworld(i.e., more than just for
mips
>> SMP linux development work)? I am specifically
>> interested in broadcom BCM12500s running SMP Linux.

>We have been using it on commercially deployed telco
>grade products
>for 18 months or more. If you have been talking with
>Broadcom they can
>probably provide references for you. I believe a
>large proportion of
>their designs are Linux based now.


>> If yes, I would like to know their experience in
terms
>> of stability and performance.

>It's stability is fine with SMP. You application code
>will (should?)
>crash much more than the kernel will :-)

Applications are crashing due to kernel bugs? or due
to application bugs? Are the applications crashing
more often when run on SMP than on UP kernel?
I would appreciate if you could provide more details
on what you mean by applications crashing.

Thanks
Krishna

>Performance is relative to a lot of factors (board
>space/power/thermal
>budget available). It's hard to beat the
>size/performance offered by
>the 1250. 

Daniel



__________________________________
Do you Yahoo!?
Yahoo! Mail SpamGuard - Read only the mail you want.
http://antispam.yahoo.com/tools
