Received:  by oss.sgi.com id <S553714AbRADUnF>;
	Thu, 4 Jan 2001 12:43:05 -0800
Received: from mailgate1.zdv.Uni-Mainz.DE ([134.93.8.56]:7841 "EHLO
        mailgate1.zdv.Uni-Mainz.DE") by oss.sgi.com with ESMTP
	id <S553696AbRADUmt>; Thu, 4 Jan 2001 12:42:49 -0800
Received: from arthur.zdv.Uni-Mainz.DE (arthur.zdv.Uni-Mainz.DE [134.93.8.145])
	by mailgate1.zdv.Uni-Mainz.DE (8.11.0/8.10.2) with ESMTP id f04KgkM22121;
	Thu, 4 Jan 2001 21:42:46 +0100 (MET)
Received: (from martin@localhost)
	by arthur.zdv.Uni-Mainz.DE (8.10.2/8.10.2) id f04Kgk522700;
	Thu, 4 Jan 2001 21:42:46 +0100 (MET)
From:   Christoph Martin <martin@uni-mainz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14932.57412.617757.439688@arthur.zdv.Uni-Mainz.DE>
Date:   Thu, 4 Jan 2001 21:42:44 +0100 (MET)
To:     ralf@oss.sgi.com
Cc:     Christoph.Martin@uni-mainz.de, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr, debian-mips@lists.debian.org,
        Andreas Jaeger <aj@suse.de>
Subject: glibc 2.2 on MIPS
X-Mailer: VM 6.75 under Emacs 19.34.1
Organization: Johannes Gutenberg-Universitaet Mainz
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi Ralf,

On Thu, 12 Oct 2000 04:04:44 +0200, Ralf Baechle wrote:

> On Thu, Oct 12, 2000 at 12:24:21AM +0200, Florian Lohoff wrote:

> > We are trying :) I am currently basing all my Debian-mips(el) things
> > on glibc 2.0.6. It is the only stable solution right now. I am experimenting
> > with the glibc 2.1.94-3 debian source package which i managed to get
> > compiled with unmodified cvs binutils and gcc + the gcse patch.
> > 
> > Ralf reported bugs in the ld where he send me a patch. With that patch
> > i get a "Bus Error" from the ld.so within the glibc build.

> There patch is ok; you get those bus errors because there are bugs in
> both ld and binutils that in most cases compensate each other.  If you
> fix only one of them you get all sorts of funnies ...

I just tried to build glibc-2.2 (CVS-2000-12-28) for debian-mips and
it still has the "Bus Error" problem. We are currently using binutils
2.10.1.0.2 and gcc 2.95.2 + CVS from 2.95 branch. 

Can you please post both patches, so that we can verify which one is
missing in our build.

> Even with the fixes ld is not yet perfect - for example emacs and X still
> fail.

The gcc/binutils combination seams to work correctly as far as I can
see. I managed to compile xfree 4.0.2 linked agains 2.1.95-1.1. What
problems did you have with X?

Christoph
