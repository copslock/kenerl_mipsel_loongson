Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f48FJdr18043
	for linux-mips-outgoing; Tue, 8 May 2001 08:19:39 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f48FJbF18039
	for <linux-mips@oss.sgi.com>; Tue, 8 May 2001 08:19:38 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 8BBF17D9; Tue,  8 May 2001 17:19:35 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 6A5D4EFFF; Tue,  8 May 2001 17:19:08 +0200 (CEST)
Date: Tue, 8 May 2001 17:19:08 +0200
From: Florian Lohoff <flo@rfc822.org>
To: George Gensure <werkt@csh.rit.edu>
Cc: linux-mips@oss.sgi.com
Subject: Re: 2.4.3 kernel
Message-ID: <20010508171908.B8522@paradigm.rfc822.org>
References: <Pine.SOL.4.31.0105061221330.1956-100000@fury.csh.rit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.SOL.4.31.0105061221330.1956-100000@fury.csh.rit.edu>; from werkt@csh.rit.edu on Sun, May 06, 2001 at 12:25:12PM -0400
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, May 06, 2001 at 12:25:12PM -0400, George Gensure wrote:
> Can anyone explain to me how the 2.4.3 kernel available on ftp.rfc822.org was
> built? I've been working for about a month and a half on getting that to
> compile with no success.  The only reason I need it is to get input core
> support, since linux doesn't like to recognize any device nodes that I create
> using mknod.  If anyone could shed some light on either of these problems...
> the kernel or getting linux to recognize my mouse on (10,1) please contact me.

Whats your exact problem ? I made the kernel and i dont think i had
greater problems. Everything needed should be in the tar (config etc)
except some patches which should be in the cvs by now.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
