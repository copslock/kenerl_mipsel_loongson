Received:  by oss.sgi.com id <S553820AbQJ1Wte>;
	Sat, 28 Oct 2000 15:49:34 -0700
Received: from u-75.karlsruhe.ipdial.viaginterkom.de ([62.180.18.75]:65032
        "EHLO u-75.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553694AbQJ1WtB>; Sat, 28 Oct 2000 15:49:01 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870710AbQJ1NSJ>;
        Sat, 28 Oct 2000 15:18:09 +0200
Date:   Sat, 28 Oct 2000 15:18:09 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Pete Popov <ppopov@mvista.com>
Cc:     "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: FATAL: cannot determine library version
Message-ID: <20001028151809.A7138@bacchus.dhis.org>
References: <39F9B924.97AF7A4@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39F9B924.97AF7A4@mvista.com>; from ppopov@mvista.com on Fri, Oct 27, 2000 at 10:19:32AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Oct 27, 2000 at 10:19:32AM -0700, Pete Popov wrote:

> I've got a big endian kernel running for a new embedded board, and it
> mounts the root fs over nfs.  I'm using the simple-0.2b packages as the
> root fs.  At some point after /bin/sh is loaded, I get the following
> error:
> 
> FATAL: cannot determine library version
> 
> The same root file system is fine on my Indigo2.

Seems your kernel is foobared.  On startup libc is trying to determine
the kernel version but both using uname and /proc/sys/kernel/osrelease
fail for some reason.

  Ralf
