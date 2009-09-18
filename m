Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Sep 2009 18:20:03 +0200 (CEST)
Received: from h155.mvista.com ([63.81.120.155]:36406 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S2097367AbZIRQT4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 18 Sep 2009 18:19:56 +0200
Received: from [192.168.11.189] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id C773A3ECA; Fri, 18 Sep 2009 09:19:50 -0700 (PDT)
Message-ID: <4AB3B3B9.1040804@ru.mvista.com>
Date:	Fri, 18 Sep 2009 20:22:17 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	ralf.roesch@rw-gmbh.de, linux-mips@linux-mips.org,
	Julia Lawall <julia@diku.dk>
Subject: Re: [PATCH] MIPS: TXx9: Fix error handling / Fix for noenexisting
 gpio_remove.
References: <1253080880-11123-1-git-send-email-ralf.roesch@rw-gmbh.de> <20090917.225259.173376281.anemo@mba.ocn.ne.jp>
In-Reply-To: <20090917.225259.173376281.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

>>error was introduced by commit 0385d1f3d394c6814be0b165c153fc3fc254469a

> Thanks, this patch should be holded into the original commit before
> mainlining.  The result should be same as Julia's revised patch.

> I don't mind ether way, I just hope keeping bisectability on mainline.
> Is it too late, (yet another) Ralf ?

    Well, Ralf B. has already committed Julia's broken patch at 9/14.

> ---
> Atsushi Nemoto

WBR, Sergei
