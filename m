Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBB9w6F11139
	for linux-mips-outgoing; Tue, 11 Dec 2001 01:58:06 -0800
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBB9w2o11127
	for <linux-mips@oss.sgi.com>; Tue, 11 Dec 2001 01:58:02 -0800
Received: from agx by gandalf.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 16Dijg-0001VG-00; Tue, 11 Dec 2001 09:58:00 +0100
Date: Tue, 11 Dec 2001 09:58:00 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@oss.sgi.com
Cc: flo@rfc822.org, klaus@mgnet.de
Subject: Re: [PATCH] sgiwd93.c fix for multiple disks
Message-ID: <20011211095759.A5689@gandalf.physik.uni-konstanz.de>
Mail-Followup-To: linux-mips@oss.sgi.com, flo@rfc822.org, klaus@mgnet.de
References: <20011210200757.GA25722@paradigm.rfc822.org> <20011211015341.GA27203@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011211015341.GA27203@paradigm.rfc822.org>; from flo@rfc822.org on Tue, Dec 11, 2001 at 02:53:41AM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Dec 11, 2001 at 02:53:41AM +0100, Florian Lohoff wrote:
> On Mon, Dec 10, 2001 at 09:07:57PM +0100, Florian Lohoff wrote:
> > Hi,
> > the attached patch fixes part of the DMA problems we see with multiple
> > disks and the sgiwd93.c with DISCONNECTs. Klaus patch formerly just
> > disabled all DMA replacing it with PIO which is a major performance hit.
> > 
> > This patch simply deletes all the HPC Scatter/Gather stuff thus we will
> > see a couple more interrupts due to all segments beeing transferred
> > individually. The transfer itself still happens with the HPC DMA thus
> > the performance impact will not be that large. I am running a test right
> > now but it seems the error is gone.
> 
> Ok - I am running the attached script right now which copies a kernel
> source tree from one disk to another disk in a loop. I ran this on the a
> 133Mhz R4600 Indy with 2 SCSI Disks on the same SCSI bus.  Without the
> patch not a single cycle in this script made it through as on page in
> the binarys would be corrupted. Also a whole bunch of files of the source
> tree would be broken, mangled truncated - Whatever might happen. Nothing
> of this now happened while running the test for the last 5 hours. The
> machine is still up and running and kind of responsive.
> 
> I am unsure if we should put this into CVS as it brings us correctness
> for the price of some performance penalty.
Can you very roughly estimate the performance hit - let's say the slow
down when copying the whole kernel-tree once?
 -- Guido
