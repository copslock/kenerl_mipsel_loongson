Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f72CkK915243
	for linux-mips-outgoing; Thu, 2 Aug 2001 05:46:20 -0700
Received: from dea.waldorf-gmbh.de (u-206-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.206])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f72CkHV15215
	for <linux-mips@oss.sgi.com>; Thu, 2 Aug 2001 05:46:17 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f72C5cN24785;
	Thu, 2 Aug 2001 14:05:38 +0200
Date: Thu, 2 Aug 2001 14:05:38 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Steven J. Hill" <sjhill@cotw.com>
Cc: debian-mips@lists.debian.org, linux-mips@oss.sgi.com
Subject: Re: Horrible X and kernel crashes under mipsel RH7.1...
Message-ID: <20010802140538.G24305@bacchus.dhis.org>
References: <3B66B5F3.79D6AAB8@cotw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B66B5F3.79D6AAB8@cotw.com>; from sjhill@cotw.com on Tue, Jul 31, 2001 at 08:43:15AM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 31, 2001 at 08:43:15AM -0500, Steven J. Hill wrote:

> root@localhost:/home/sjhill$ /usr/X11R6/bin/Xfbdev 
> __alloc_pages: 5-order allocation failed.
> __alloc_pages: 5-order allocation failed.

Order 5 allocations are pretty unreliable and put high stress on the
memory managment.  They may fail though you may still have plenty of
memory available in smaller chunks.  So if possible at all try to
avoid the allocation of high order pages or at least have a fallback
strategy available.

  Ralf
