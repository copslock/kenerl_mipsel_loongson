Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Sep 2008 16:48:40 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:62641 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S32712841AbYITPsd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 20 Sep 2008 16:48:33 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id B01E83EC9; Sat, 20 Sep 2008 08:48:28 -0700 (PDT)
Message-ID: <48D51B48.2090400@ru.mvista.com>
Date:	Sat, 20 Sep 2008 19:48:24 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	ralf@linux-mips.org
Subject: Re: [PATCH 2/2] TXx9: Add TX4939 ATA support (v2)
References: <20080918.001358.08318211.anemo@mba.ocn.ne.jp>
In-Reply-To: <20080918.001358.08318211.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20577
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

> Add a helper routine to register tx4939ide driver and use it on
> RBTX4939 board.
>   

  BTW, how about supporting IDE aboard RBTX4938, not worth the trouble?

> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
