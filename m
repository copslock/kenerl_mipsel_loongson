Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3BFuOj07906
	for linux-mips-outgoing; Wed, 11 Apr 2001 08:56:24 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3BFuKM07903
	for <linux-mips@oss.sgi.com>; Wed, 11 Apr 2001 08:56:20 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 0C3977D9; Wed, 11 Apr 2001 17:56:19 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id AA9ECF385; Wed, 11 Apr 2001 17:56:02 +0200 (CEST)
Date: Wed, 11 Apr 2001 17:56:02 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Deepak Shenoy <deepak@ishoni.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: floating point libarary for mips
Message-ID: <20010411175602.G28618@paradigm.rfc822.org>
References: <7019982E6729D511914E00C04F0CCD250B44A4@leonoid.in.ishoni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <7019982E6729D511914E00C04F0CCD250B44A4@leonoid.in.ishoni.com>; from deepak@ishoni.com on Wed, Apr 11, 2001 at 09:07:53PM +0530
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Apr 11, 2001 at 09:07:53PM +0530, Deepak Shenoy wrote:
> Hi,
> 
> Our MIPS processor does not have a floating point unit. But when I build the
> kernel with "soft-float" option I would get many undefined references. So I
> guess I would need to include the soft floating point library. Where can i
> get this? Any pointers would help me.

The kernel itself does not use floating point ops so you need/must not
compile the kernel with soft-float - Another option is to just
enable the kernel floating point emulator as that will enable you
to run unmodified binarys in userspace.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
