Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2008 23:52:32 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:63657 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S22532626AbYJ0XwX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 27 Oct 2008 23:52:23 +0000
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 3AA8B3ECA; Mon, 27 Oct 2008 16:52:16 -0700 (PDT)
Message-ID: <4906542A.9090905@ru.mvista.com>
Date:	Tue, 28 Oct 2008 02:52:10 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	ralf@linux-mips.org
Subject: Re: [PATCH 2/2] tx4938ide: Do not call devm_ioremap for whole 128KB
References: <20081027.223939.59650930.anemo@mba.ocn.ne.jp>
In-Reply-To: <20081027.223939.59650930.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21009
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:
> Call devm_ioremap() for CS0 and CS1 separetely.
> And some style cleanups.
>
> Suggested-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>   

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


MBR, Sergei
