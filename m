Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f768ofR31654
	for linux-mips-outgoing; Mon, 6 Aug 2001 01:50:41 -0700
Received: from kenton.algor.co.uk (smtp.algor.co.uk [62.254.210.199])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f768oYV31651
	for <linux-mips@oss.sgi.com>; Mon, 6 Aug 2001 01:50:37 -0700
Received: from gladsmuir.algor.co.uk (IDENT:root@gladsmuir.algor.co.uk [192.168.5.75])
	by kenton.algor.co.uk (8.9.3/8.8.8) with ESMTP id JAA16147;
	Mon, 6 Aug 2001 09:50:15 +0100 (GMT/BST)
Received: (from dom@localhost)
	by gladsmuir.algor.co.uk (8.11.0/8.8.7) id f768oEX01106;
	Mon, 6 Aug 2001 09:50:14 +0100
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15214.23110.345236.934305@gladsmuir.algor.co.uk>
Date: Mon, 6 Aug 2001 09:50:14 +0100 (BST)
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: SysV IPC shared memory and virtual alising
In-Reply-To: <20010806164452D.nemoto@toshiba-tops.co.jp>
References: <20010806164452D.nemoto@toshiba-tops.co.jp>
X-Mailer: VM 6.72 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Atsushi Nemoto (nemoto@toshiba-tops.co.jp) writes:

> Here is an patch to fix virtual aliasing problem with SysV IPC
> shared memory.  I tested this patch on a r4k cpu with 32Kb D-cache.
> 
> If D-cache is smaller than PAGE_SIZE this patch is not needed at
> all...

More precisely, if the size of a D-cache "set" is smaller than
PAGE_SIZE.  So a CPU with a 16Kbyte 4-way set-associative cache and
4Kbyte PAGE_SIZE is safe.

Dominic Sweetman
Algorithmics Ltd
