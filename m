Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9TILTe31651
	for linux-mips-outgoing; Mon, 29 Oct 2001 10:21:29 -0800
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9TILR031648
	for <linux-mips@oss.sgi.com>; Mon, 29 Oct 2001 10:21:27 -0800
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f9TILNE0031477;
	Mon, 29 Oct 2001 10:21:23 -0800
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f9TILMfw031473;
	Mon, 29 Oct 2001 10:21:23 -0800
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Mon, 29 Oct 2001 10:21:22 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
cc: Wayne Gowcher <wgowcher@yahoo.com>, linux-mips@oss.sgi.com
Subject: Re: Backspace on Virtual Console causes oops
In-Reply-To: <3BDD12C8.A8D62ACB@niisi.msk.ru>
Message-ID: <Pine.LNX.4.10.10110291020420.27579-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> This is a famous problem, just look at vt.c, you'll see a lot of ifdefs
> around sound routines. Just every porting engineer who encounter this
> problem solved it himself (and added own ifdef to vt.c). In my case, I
> just got fault epc, found the address in objdump -D output and look at
> the sources. For me it seems easier, than posting a message to a list.
> <nothing personal, really>

I plan to have this problem removed in 2.5.X when the console system is
migrated to the input api :-)
