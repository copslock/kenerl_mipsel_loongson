Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Sep 2009 10:12:41 +0200 (CEST)
Received: from rs1.rw-gmbh.net ([213.239.201.58]:37092 "EHLO rs1.rw-gmbh.net"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492185AbZIRIMe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 18 Sep 2009 10:12:34 +0200
Received: from pd951aadc.dip0.t-ipconnect.de ([217.81.170.220] helo=[192.168.178.24])
	by rs1.rw-gmbh.net with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <ralf.roesch@rw-gmbh.de>)
	id 1MoYa1-0006Fn-7Q; Fri, 18 Sep 2009 10:12:33 +0200
Message-ID: <4AB340F0.5050101@rw-gmbh.de>
Date:	Fri, 18 Sep 2009 10:12:32 +0200
From:	Ralf Roesch <ralf.roesch@rw-gmbh.de>
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20090701)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, Julia Lawall <julia@diku.dk>
Subject: Re: [PATCH] MIPS: TXx9: Fix error handling / Fix for noenexisting
 gpio_remove.
References: <1253080880-11123-1-git-send-email-ralf.roesch@rw-gmbh.de> <20090917.225259.173376281.anemo@mba.ocn.ne.jp>
In-Reply-To: <20090917.225259.173376281.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ralf.roesch@rw-gmbh.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24045
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf.roesch@rw-gmbh.de
Precedence: bulk
X-list: linux-mips

On Thu Sep 17 2009 15:52:59 GMT+0200 (CEST), Atsushi Nemoto  wrote:
> Thanks, this patch should be holded into the original commit before
> mainlining.  The result should be same as Julia's revised patch.
>
> I don't mind ether way, I just hope keeping bisectability on mainline.
> Is it too late, (yet another) Ralf ?
>
>   
Not for me Atshushi, thanks.
--
the other Ralf ;-)
