Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAE0I3g29891
	for linux-mips-outgoing; Tue, 13 Nov 2001 16:18:03 -0800
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAE0I2029888
	for <linux-mips@oss.sgi.com>; Tue, 13 Nov 2001 16:18:02 -0800
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id fAE0HtjR028982;
	Tue, 13 Nov 2001 16:17:55 -0800
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id fAE0HsaG028978;
	Tue, 13 Nov 2001 16:17:54 -0800
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Tue, 13 Nov 2001 16:17:54 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Guo-Rong Koh <grk@start.com.au>
cc: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: 2.4.13-pre5 problem
In-Reply-To: <B1514136053@i01sv4132.ids1.intelonline.com>
Message-ID: <Pine.LNX.4.10.10111131617310.28670-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> I decided to give up on framebuffer support for now. 
> Anyway, what's the current suggested kernel for a DECStation 5000/25?
> My cross-compiled 2.4.13-pre5 kernel stops after calibrating the delay
> loop. Is this kernel revision buggy or is there something else I need
> to know? (It seems to die somewhere in mem_init).

Use the current snapshot from the OSS tree. 
