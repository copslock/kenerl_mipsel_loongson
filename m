Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6KIG8117273
	for linux-mips-outgoing; Fri, 20 Jul 2001 11:16:08 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6KIFdV17265
	for <linux-mips@oss.sgi.com>; Fri, 20 Jul 2001 11:15:39 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f6KHF0W07704;
	Fri, 20 Jul 2001 10:15:03 -0700
Message-ID: <3B58744B.659668CF@mvista.com>
Date: Fri, 20 Jul 2001 11:11:23 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: ppopov@pacbell.net
CC: linux-mips-kernel@lists.sourceforge.net, linux-mips@oss.sgi.com
Subject: Re: generic ramdisk support
References: <3B5792FF.1030808@pacbell.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Pete Popov wrote:
> 
> Any reason why we don't have a single directory for a ramdisk linker
> script and Makefile? I've attached that does that. You just put a
> ramdisk.gz image in arch/mips/ramdisk and turn on initrd support. At
> somepoint I'll upload some useful ramdisks to the sourceforge linux-mips
> anonymous ftp site.
> 

This is a good idea.  People don't have to maintain a separate script to
generate the ram root fs.

BTW, I created 1.4 MB busybox ram fs for mips-le.  You can find it at

	http://65.5.25.179/linux.

Jun
