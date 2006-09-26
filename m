Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2006 20:55:21 +0100 (BST)
Received: from smtp104.biz.mail.mud.yahoo.com ([68.142.200.252]:24450 "HELO
	smtp104.biz.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20038960AbWIZTzR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 Sep 2006 20:55:17 +0100
Received: (qmail 31349 invoked from network); 26 Sep 2006 19:55:08 -0000
Received: from unknown (HELO ?192.168.1.103?) (ppopov@embeddedalley.com@71.128.175.242 with plain)
  by smtp104.biz.mail.mud.yahoo.com with SMTP; 26 Sep 2006 19:55:08 -0000
Message-ID: <4519859A.1090306@embeddedalley.com>
Date:	Tue, 26 Sep 2006 12:55:06 -0700
From:	Peter Popov <ppopov@embeddedalley.com>
User-Agent: Thunderbird 1.5.0.7 (Macintosh/20060909)
MIME-Version: 1.0
To:	Franck <vagabon.xyz@gmail.com>
CC:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: How to work with Linux-Mips ?
References: <4518D33F.9070208@innova-card.com>
In-Reply-To: <4518D33F.9070208@innova-card.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12687
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


<snip>


> These patchs have been kindly reviewed and acked by Atsushi Nemoto,
> but then no feedback from the MIPS team. I tried to get a status for
> MIPS team a couple of time, to know if something was wrong with them
> but MIPS people seem to not care about them. They even haven't
> bothered to take 10 seconds for replying something like:


>   - your patches are broken because...
> 
>   - your patches do not respect our MIPS protocol, please resend...
> 
>   - Sorry we are very busy, please hold on...
> 
>   - OK your patches suck please try to work on ARM chips because MIPS
>     is a very closed circle reserved to MIPS gurus.

There is no such thing as a 10 sec patch review. Especially when it
comes to patches that touch generic portions of the kernel. Someone has
to very carefully consider what they are doing, any potential risks, how
to test them, etc. Multiply that times the number of people sending
patches plus the new development that someone like Ralf is doing. Try
working full time and being a maintainer yourself for a single board
only over a period of a few years.

> Another question, is that MIPS tree seems to not care about linux
> mainline release process. I actually notice that even Linus do not
> pull MIPS tree anymore during the last release candidate cycle. Is
> MIPS aware that some of its customers are trying to make stable
> releases ? 

MIPS Tech and linux-mips are separate entities. Personally I think MIPS
Tech has done a great service to themselves, their customers, and the
entire Linux MIPS community, by hiring Ralf to do new MIPS development
and properly support new chips coming out.

> Does the linux-mips team exist to ease life of its
> customers to use the linux kernel on MIPS chips or is the purpose of
> this team doing only some development for fun ?

Does it really matter? The developers that are active on the linux-mips
mailing list are not associated with MIPS Tech nor are they paid for
their effort by you or the company you work for. If you want a
"product", you can buy a commercial embedded Linux distro from someone.
If you want to contribute to the linux mips development effort, then
learn to live with any frustrations associated with working in community
trees. And next time, just ask nicely what you can do to get some
feedback on your patches.

Pete
