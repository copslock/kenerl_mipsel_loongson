Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g29AHHF25471
	for linux-mips-outgoing; Sat, 9 Mar 2002 02:17:17 -0800
Received: from mail.ocs.com.au (mail.ocs.com.au [203.34.97.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g29AHC925465
	for <linux-mips@oss.sgi.com>; Sat, 9 Mar 2002 02:17:13 -0800
Received: (qmail 17999 invoked from network); 9 Mar 2002 09:17:09 -0000
Received: from ocs3.intra.ocs.com.au (192.168.255.3)
  by mail.ocs.com.au with SMTP; 9 Mar 2002 09:17:08 -0000
Received: by ocs3.intra.ocs.com.au (Postfix, from userid 16331)
	id 0349F3000B8; Sat,  9 Mar 2002 19:17:05 +1000 (EST)
Received: from ocs3.intra.ocs.com.au (localhost [127.0.0.1])
	by ocs3.intra.ocs.com.au (Postfix) with ESMTP
	id CBEFFBA; Sat,  9 Mar 2002 20:17:05 +1100 (EST)
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Pete Popov <ppopov@mvista.com>
Cc: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: xfs 
In-reply-to: Your message of "08 Mar 2002 10:22:07 -0800."
             <1015611727.12994.441.camel@zeus> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 09 Mar 2002 20:17:00 +1100
Message-ID: <7338.1015665420@ocs3.intra.ocs.com.au>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On 08 Mar 2002 10:22:07 -0800, 
Pete Popov <ppopov@mvista.com> wrote:
>I see on SGI's web site that XFS is supported only on x86 and IA64. Has
>anyone tried it on mips?

Anybody wanting to port XFS to new architectures should start with
  ftp://oss.sgi.com/projects/xfs/download/patches/2.4.18
I split the XFS patches up so people can pick and choose which
components they use, it makes it easier to exclude code like kdb,
kbuild 2.5 or ia64 from the port.  Note the ia64 patch, you will need a
MIPS equivalent.

When you get it working, send us the changes from the split patches.
