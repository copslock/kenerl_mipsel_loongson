Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Sep 2002 02:25:14 +0200 (CEST)
Received: from h24-83-212-10.vc.shawcable.net ([24.83.212.10]:34555 "EHLO
	bard.illuminatus.org") by linux-mips.org with ESMTP
	id <S1123906AbSI0AZN>; Fri, 27 Sep 2002 02:25:13 +0200
Received: from templar ([10.0.0.2])
	by bard.illuminatus.org with esmtp (Exim 3.35 #1 (Debian))
	id 17ui9o-00055c-00
	for <linux-mips@linux-mips.org>; Thu, 26 Sep 2002 16:34:56 -0700
Subject: Re: Format of bootable Indy CDs?
From: Mike Nugent <mips@illuminatus.org>
To: linux-mips@linux-mips.org
In-Reply-To: <20020926171033.GA13337@paradigm.rfc822.org>
References: <3D92B80A.3080802@linuxcare.com> 
	<20020926171033.GA13337@paradigm.rfc822.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 26 Sep 2002 17:23:32 -0700
Message-Id: <1033086212.13264.26.camel@templar>
Mime-Version: 1.0
Return-Path: <mips@illuminatus.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mips@illuminatus.org
Precedence: bulk
X-list: linux-mips


Could we not just make an image file with an arcboot header and burn
that to cd?

On Thu, 2002-09-26 at 10:10, Florian Lohoff wrote:
> On Thu, Sep 26, 2002 at 03:32:26AM -0400, Alex deVries wrote:
> > I'm curious about the possibility of making a Linux installer for the 
> > Indy that boots from CD; is there any description of the format of 
> > bootable IRIX CDs out there?  What does the firmware expect?
> 
> The firmware loads an ecoff file from a volume header - The volume
> header is a special partition with a "minimalistic" filesystem
> in it - This can be modified by "dvhtool". 
> 
> I succeeded in booting an indy by creating a fake "volume header"
> on the ISO filesystem CD. (ISO Specifies the first 8k of an image
> to be for the bootloader and partitioning etc). Then i created
> directory entrys for the kernels on the iso in the pseudo
> volume header. As the ISO filesystems needs all files to be
> contigues (same for the volume header) the machine was able
> to boot from the cd although booting the ecoff kernel image
> including the ramdisk directly. Having a bootloader would
> be much nicer.
> 
> > I know that sash is involved somehow...
> 
> "sash" is proprietary IRIX. The IRIX CDs are EFS BTW.
> 
> If you plan to work on this - Feel free to come around in
> Oldenburg this weekend - We will have a Kernel Hacker meeting
> in the University Oldenburg. I'll bring a Burner and CD-RW's 
> with me to test this.
> 

I'd be interested in working on this, but I'm not 100% sure that I know
enough about my indigo2 yet.  I'll start by seeing what I can do with
arcboot.

-- 
Mike Nugent
Programmer/Author
mike@illuminatus.org
"I believe the use of noise to make music will increase until we reach a music produced through the aid of electrical instruments which will make available for musical purposes any and all sounds that can be heard."
 -- composer John Cage, 1937
