Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f44Cqsn08761
	for linux-mips-outgoing; Fri, 4 May 2001 05:52:54 -0700
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f44CqqF08756
	for <linux-mips@oss.sgi.com>; Fri, 4 May 2001 05:52:53 -0700
Received: from bilbo.physik.uni-konstanz.de [134.34.144.81] (8)
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 14vf4i-0000Ls-00; Fri, 04 May 2001 14:52:48 +0200
Received: from agx by bilbo.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 14vf4d-0005WE-00; Fri, 04 May 2001 14:52:43 +0200
Date: Fri, 4 May 2001 14:52:43 +0200
From: Guido Guenther <guido.guenther@uni-konstanz.de>
To: "John D. Davis" <johnd@stanford.edu>
Cc: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: NFS -13 error
Message-ID: <20010504145243.B21147@bilbo.physik.uni-konstanz.de>
Mail-Followup-To: "John D. Davis" <johnd@stanford.edu>,
	linux-mips <linux-mips@oss.sgi.com>
References: <20010502155424.A9256@bilbo.physik.uni-konstanz.de> <Pine.GSO.4.31.0105031707340.14342-100000@myth1.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.31.0105031707340.14342-100000@myth1.Stanford.EDU>; from johnd@stanford.edu on Thu, May 03, 2001 at 05:15:59PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, May 03, 2001 at 05:15:59PM -0700, John D. Davis wrote:
[..snip..] 
> >Kernel panic: I have no root and I want to scream.
You can try to give the rootfs on the prom command line e.g.:
bootp(): nfsroot=ip.of.your.nfsserver:/path/to/rootfs
See Documentation/nfsroot.txt in the kernel source for details.
[..snip..]
Regards, 
 -- Guido
