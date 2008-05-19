Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 May 2008 10:35:42 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:43684 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20022655AbYESJfj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 May 2008 10:35:39 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 28FFC3EC9; Mon, 19 May 2008 02:35:34 -0700 (PDT)
Message-ID: <483149E0.6010009@ru.mvista.com>
Date:	Mon, 19 May 2008 13:35:28 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 1.5.0.14 (Windows/20071210)
MIME-Version: 1.0
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	drzeus@drzeus.cx
Subject: Re: [PATCH 1/9] Alchemy: export get_au1x00_speed for modules
References: <20080519080339.GA21985@roarinelk.homelinux.net> <20080519080416.GB21985@roarinelk.homelinux.net>
In-Reply-To: <20080519080416.GB21985@roarinelk.homelinux.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Manuel Lauss wrote:
> From 8492076e98c7fd47c9dee53984dbd9568ace357d Mon Sep 17 00:00:00 2001
> From: Manuel Lauss <mlau@msc-ge.com>
> Date: Wed, 7 May 2008 13:42:55 +0200
> Subject: [PATCH] Alchemy: export get_au1x00_speed for modules
>
> au1xmmc.c driver depends on it, so export it for modules.
>
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
>   

   I thought that has been merged.

WBR, Sergei
