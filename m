Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g28JgIb08537
	for linux-mips-outgoing; Fri, 8 Mar 2002 11:42:18 -0800
Received: from mxzilla3.xs4all.nl (mxzilla3.xs4all.nl [194.109.6.49])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g28JgE908533
	for <linux-mips@oss.sgi.com>; Fri, 8 Mar 2002 11:42:14 -0800
Received: from xs3.xs4all.nl (knuffie@xs3.xs4all.nl [194.109.6.44])
	by mxzilla3.xs4all.nl (8.12.0/8.12.0) with ESMTP id g28Ig93o005239;
	Fri, 8 Mar 2002 19:42:10 +0100 (CET)
Received: from localhost (knuffie@localhost)
	by xs3.xs4all.nl (8.9.0/8.9.0) with ESMTP id TAA21256;
	Fri, 8 Mar 2002 19:42:09 +0100 (CET)
Date: Fri, 8 Mar 2002 19:42:09 +0100 (CET)
From: Seth Mos <knuffie@xs4all.nl>
To: Pete Popov <ppopov@mvista.com>
cc: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: xfs
In-Reply-To: <1015611727.12994.441.camel@zeus>
Message-ID: <Pine.BSI.4.10.10203081932450.10949-100000@xs3.xs4all.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On 8 Mar 2002, Pete Popov wrote:

> I see on SGI's web site that XFS is supported only on x86 and IA64. Has
> anyone tried it on mips?
> 
> Pete
> 
Not that I know off.

People have allready tested XFS on Sparc sparc64 alpha PPC and S390.

So far there is positive feedback about the sparc alpha PP and sparc64
ports.

You will have to try it. AFAIK the SGI people don't test XFS on the mips
boxes. The kernel source is mostly compatible with the newer compilers out
there like 2.95.3 and u.

I think you will need to merge the mips and XFS CVS tree and edit some
arch specific files like the syscalls. If you also want to use ACLs make
sure you have the latest xfsprogs tools.

Cheers
Seth
