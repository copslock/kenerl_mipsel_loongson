Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9JFMa530546
	for linux-mips-outgoing; Fri, 19 Oct 2001 08:22:36 -0700
Received: from ux3.sp.cs.cmu.edu (UX3.SP.CS.CMU.EDU [128.2.198.103])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9JFMYD30543
	for <linux-mips@oss.sgi.com>; Fri, 19 Oct 2001 08:22:34 -0700
Received: from GS256.SP.CS.CMU.EDU by ux3.sp.cs.cmu.edu id aa04924;
          19 Oct 2001 11:21 EDT
Subject: Re: Moving kernel_entry to LOADADDR
From: Justin Carlson <justincarlson@cmu.edu>
To: linux-mips@oss.sgi.com
In-Reply-To: <200110191511.IAA27477@saturn.mikemac.com>
References: <200110191511.IAA27477@saturn.mikemac.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 19 Oct 2001 11:21:41 -0400
Message-Id: <1003504901.29529.54.camel@gs256.sp.cs.cmu.edu>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 2001-10-19 at 11:11, Mike McDonald wrote:

>   Because a bare bones bootloader may not know anything about ELF. The
> simplest solution is to just stick a "jmp start_kernel" at LOADADDR
> right before the fill. Then the load address and the entry point are
> the same. Once the exception vectors get loaded, they'll overwrite the
> jmp, so no space is wasted and none of the LOADADDRs have to be
> changed.


This may be true, but grokking ELF far enough to find e_entry just a
matter of looking at a fixed offset into the kernel image.  Problems
that require bootloaders to be simpler than that are pretty rare...

-Justin
