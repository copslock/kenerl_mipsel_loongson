Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAE0JgG30087
	for linux-mips-outgoing; Tue, 13 Nov 2001 16:19:42 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fAE0Je030084
	for <linux-mips@oss.sgi.com>; Tue, 13 Nov 2001 16:19:41 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fAE0Ja310847;
	Wed, 14 Nov 2001 11:19:36 +1100
Date: Wed, 14 Nov 2001 11:19:36 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Krishna Kondaka <krishna@sanera.net>, linux-mips@oss.sgi.com
Subject: Re: BUG : Memory leak in Linux 2.4.2 MIPS SMP kernel
Message-ID: <20011114111936.C10410@dea.linux-mips.net>
References: <20011114104753.A10410@dea.linux-mips.net> <Pine.LNX.4.10.10111131615340.28670-100000@transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10111131615340.28670-100000@transvirtual.com>; from jsimmons@transvirtual.com on Tue, Nov 13, 2001 at 04:16:57PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Nov 13, 2001 at 04:16:57PM -0800, James Simmons wrote:

> Hm. It was pointed out that kfree actually does the checking for us. 
> Do we really need the check? 

Seems that check sneaked in without telling me :-)

  Ralf
