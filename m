Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2G3PDS25435
	for linux-mips-outgoing; Thu, 15 Mar 2001 19:25:13 -0800
Received: from spawn.hockeyfiend.com (mail@dsl027-138-146.nyc1.dsl.speakeasy.net [216.27.138.146])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2G3PCM25432
	for <linux-mips@oss.sgi.com>; Thu, 15 Mar 2001 19:25:12 -0800
Received: from localhost ([127.0.0.1] ident=chris)
	by spawn.hockeyfiend.com with esmtp (Exim 3.22 #1 (Debian))
	id 14dkrW-0001TJ-00; Thu, 15 Mar 2001 22:25:10 -0500
Date: Thu, 15 Mar 2001 22:25:10 -0500 (EST)
From: "Christopher C. Chimelis" <chris@debian.org>
X-Sender: chris@spawn.hockeyfiend.com
To: Daniel Jacobowitz <dan@debian.org>
cc: linux-mips@oss.sgi.com
Subject: Re: -mmad patches for binutils/gcc
In-Reply-To: <20010315213456.A7042@nevyn.them.org>
Message-ID: <Pine.LNX.4.21.0103152222200.19339-100000@spawn.hockeyfiend.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


On Thu, 15 Mar 2001, Daniel Jacobowitz wrote:

> Before I try to submit these to the FSF, I thought I'd post them here for
> comments.
> 
> These patches change one small thing in gcc (%{mmad:-m4650} becomes %{mmad}
> in the invocation of GAS; we no longer lie about what the processor is) and
> add a -mmad flag to binutils.
> 
> I was able to build an IVR kernel with these changes; ext2_statfs,
> get_pci_port, and vc_resize got one piddling mad instruction each, and
> nfs_xdr_statfsres got half a dozen.  Nothing to write home about, but it's
> the principal of the thing.

Do you want me to include the binutils part in the next Debian binutils
upload that I'll be doing tomorrow?  I've already built the debs, but had
a feeling that there might be some mips changes coming, so I don't mind
building again.

I've got my Indy up and somewhat running (the lack of available packages
like netstd is shocking and tough to work around).  I wouldn't mind doing
at least some binutils testing on it for now...at least until the
dedicated mips folks are more comfortable with the toolchain state.

FYI, there's a gcc upload planned for this weekend, so you may want to
talk to Matthias about getting the gcc patch into that as well...

Let me know :-)

C
