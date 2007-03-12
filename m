Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2007 15:35:48 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:12524 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20021375AbXCLPfo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 12 Mar 2007 15:35:44 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 655BD3EC9; Mon, 12 Mar 2007 08:35:10 -0700 (PDT)
Message-ID: <45F57328.8000606@ru.mvista.com>
Date:	Mon, 12 Mar 2007 18:35:04 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Marco Braga <marco.braga@gmail.com>
Cc:	Domen Puncer <domen.puncer@telargo.com>, linux-mips@linux-mips.org
Subject: Re: Trouble with sound/mips/au1x00.c AC97 driver
References: <20070307104930.GD25248@dusktilldawn.nl>	 <d459bb380703082322r18879381ma4c57149a8b7adfe@mail.gmail.com>	 <45F350E9.3020208@cooper-street.com>	 <d459bb380703120157wb3dde00p4c232e300e82fd3d@mail.gmail.com>	 <d459bb380703120259r53889966xd8af623ff01ef297@mail.gmail.com>	 <20070312103927.GC14658@moe.telargo.com> <d459bb380703120609i7d3a9e1dwf7f4fa431a9631e5@mail.gmail.com>
In-Reply-To: <d459bb380703120609i7d3a9e1dwf7f4fa431a9631e5@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Marco Braga wrote:
> 2007/3/12, Domen Puncer <domen.puncer@telargo.com>:

>> It might be ignorance on my part, but aren't au_sync()'s needed here?

> My ignorance too.. What's au_sync()? Something to writeback/invalidate the
> cache?

    It's "memory barrier" (SYNC instruction).

WBR, Sergei
