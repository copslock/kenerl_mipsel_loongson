Received:  by oss.sgi.com id <S553896AbQJ3WSW>;
	Mon, 30 Oct 2000 14:18:22 -0800
Received: from gateway-490.mvista.com ([63.192.220.206]:27891 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553891AbQJ3WSH>;
	Mon, 30 Oct 2000 14:18:07 -0800
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e9UMGM317669;
	Mon, 30 Oct 2000 14:16:22 -0800
Message-ID: <39FDF26A.196F5D1B@mvista.com>
Date:   Mon, 30 Oct 2000 14:12:58 -0800
From:   Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: FATAL: cannot determine library version
References: <39F9B924.97AF7A4@mvista.com> <20001028151809.A7138@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle wrote:
> 
> On Fri, Oct 27, 2000 at 10:19:32AM -0700, Pete Popov wrote:
> 
> > I've got a big endian kernel running for a new embedded board, and it
> > mounts the root fs over nfs.  I'm using the simple-0.2b packages as the
> > root fs.  At some point after /bin/sh is loaded, I get the following
> > error:
> >
> > FATAL: cannot determine library version
> >
> > The same root file system is fine on my Indigo2.
> 
> Seems your kernel is foobared.  On startup libc is trying to determine
> the kernel version but both using uname and /proc/sys/kernel/osrelease
> fail for some reason.

Thanks, that helped.

uname wasn't called at all -- only /proc/sys/kernel/osrelease was being
opened. However, I did not have CONFIG_SYSCTL enabled in my .config
file. 

Pete
