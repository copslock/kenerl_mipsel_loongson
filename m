Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAE0SXk30362
	for linux-mips-outgoing; Tue, 13 Nov 2001 16:28:33 -0800
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAE0SU030359;
	Tue, 13 Nov 2001 16:28:30 -0800
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id fAE0SNjR029471;
	Tue, 13 Nov 2001 16:28:23 -0800
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id fAE0SMmd029467;
	Tue, 13 Nov 2001 16:28:22 -0800
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Tue, 13 Nov 2001 16:28:22 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Krishna Kondaka <krishna@sanera.net>, linux-mips@oss.sgi.com
Subject: Re: BUG : Memory leak in Linux 2.4.2 MIPS SMP kernel
In-Reply-To: <20011114111936.C10410@dea.linux-mips.net>
Message-ID: <Pine.LNX.4.10.10111131627200.29424-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> > Hm. It was pointed out that kfree actually does the checking for us. 
> > Do we really need the check? 
> 
> Seems that check sneaked in without telling me :-)

I didn't know here. I have been bite by kfree when passing a null pointer
to it before. I'm glad their is a nice check.
