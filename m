Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7Q0lcs18635
	for linux-mips-outgoing; Sat, 25 Aug 2001 17:47:38 -0700
Received: from dea.linux-mips.net (u-22-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.22])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7Q0lZd18632
	for <linux-mips@oss.sgi.com>; Sat, 25 Aug 2001 17:47:35 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f7Q0ix608943;
	Sun, 26 Aug 2001 02:44:59 +0200
Date: Sun, 26 Aug 2001 02:44:59 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: Patch against ac11
Message-ID: <20010826024459.A8915@dea.linux-mips.net>
References: <20010826010933.A8466@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010826010933.A8466@dea.linux-mips.net>; from ralf@oss.sgi.com on Sun, Aug 26, 2001 at 01:09:33AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Aug 26, 2001 at 01:09:33AM +0200, Ralf Baechle wrote:

> For those who want to stay on the bleeding edge or maybe just want one of
> the features not yet merged into Linus' codebase I've uploaded a patch
> against 2.4.8-ac11 to oss.sgi.com:/pub/linux/mips/kernel/ac/.

The patch was generated on a corrupt XFS filesystem which did a few minutes
after.  I'll re-create the patch once I finally fixed the fs problem
and that looks tricky, IRIX keeps kernel core dumping ...

  Ralf
