Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8583R215957
	for linux-mips-outgoing; Wed, 5 Sep 2001 01:03:27 -0700
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8583Od15954
	for <linux-mips@oss.sgi.com>; Wed, 5 Sep 2001 01:03:25 -0700
Received: from agx by gandalf.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 15eXed-0003Fi-00; Wed, 05 Sep 2001 10:03:23 +0200
Date: Wed, 5 Sep 2001 10:03:23 +0200
From: Guido Guenther <guido.guenther@gmx.net>
To: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: recent kernel probs
Message-ID: <20010905100323.A22446@gandalf.physik.uni-konstanz.de>
Mail-Followup-To: linux-mips <linux-mips@oss.sgi.com>
References: <3B95C9C5.8070500@csh.rit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B95C9C5.8070500@csh.rit.edu>; from werkt@csh.rit.edu on Wed, Sep 05, 2001 at 02:44:21AM -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Sep 05, 2001 at 02:44:21AM -0400, George Gensure wrote:
> I've been keeping busy trying to keep a working kernel for a set of lab 
> machines (indy r5ks) running linux, and as of a couple of days ago, I 
> haven't been able to build a kernel that does not simply blank the 
> screen and draw a non-blinking cursor where the mouse had been in the 
> prom.  I can boot from the stock vmlinux-2.4.3.ecoff kernel, and i can 
> write that kernel to the volume header to boot locally.  However, when I 
> try to rebuild and boot a later kernel, with the X-ish support that I 
> need, it errors as above.  It feels as if I've done something to the 
> system to deserve this kind of punishment.  Can anyone help?
The blank screen with non-blinking cursor looks exactly like what I saw
when I compiled the kernel with 2.11.90.0.27 debian binutils. There
were patches missing and so the kernel got miscompiled. Try to compile
with 2.11.90.0.31 or try the 2.4.5 kernel images in the debian archives.
 -- Guido
