Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g24MvC101476
	for linux-mips-outgoing; Mon, 4 Mar 2002 14:57:12 -0800
Received: (from ralf@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g24Mv9V01472;
	Mon, 4 Mar 2002 14:57:09 -0800
Date: Mon, 4 Mar 2002 14:57:09 -0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: William Jhun <wjhun@ayrnetworks.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Compressed images?
Message-ID: <20020304145709.A1332@oss.sgi.com>
References: <20020304120803.A1247@ayrnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020304120803.A1247@ayrnetworks.com>; from wjhun@ayrnetworks.com on Mon, Mar 04, 2002 at 12:08:03PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Mar 04, 2002 at 12:08:03PM -0800, William Jhun wrote:

> I've been looking through the recent linux-mips archives and it seems
> there isn't a concensus about where to build compressed ((b)zImage)
> images. We have been placing our code under arch/mips/boot/compressed,
> though it seems that the latest oss tree doesn't have such a directory,
> and the only reference I can find to building a compressed image is in
> galileo-boards/ev64120/compressed/.
> 
> Should we be placing our boot image compression stuff in our
> platform-specific directory? Are most MIPS-based Linux platforms not
> using compressed images?

General rant, not directed to you personally.  Right now we've got more
than half a dozen variations of code to support compressed images throughout
the kernel.  So I'm not going to accept any new patches for compressed
images before this mess has been cleaned.  Volunteers :-)

  Ralf
