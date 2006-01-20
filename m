Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jan 2006 18:59:01 +0000 (GMT)
Received: from mail.ivivity.com ([64.238.111.98]:65243 "EHLO thoth.ivivity.com")
	by ftp.linux-mips.org with ESMTP id S8133395AbWATS6l convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Jan 2006 18:58:41 +0000
Received: from 192.168.1.162 ([192.168.1.162]) by thoth.ivivity.com ([192.168.1.9]) with Microsoft Exchange Server HTTP-DAV ;
 Fri, 20 Jan 2006 19:02:31 +0000
Received: from MCK_Linux_NB by mail.ivivity.com; 20 Jan 2006 14:02:31 -0500
Subject: Re: how to emdedded ramdisk.gz in vmlinux for linux-2.6.14?
From:	Marc Karasek <marckarasek@ivivity.com>
To:	Linux-Mips <linux-mips@linux-mips.org>
In-Reply-To: <43D06305.8070908@gentoo.org>
References: <0F31272A2BCBBE4FA01344C6E69DBF501EAB1B@thoth.ivivity.com>
	 <43CC39A0.8080704@gentoo.org>
	 <1137515220.11738.2.camel@localhost.localdomain>
	 <43CD9568.1000707@gentoo.org>
	 <1137704865.22994.7.camel@localhost.localdomain>
	 <43D06305.8070908@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date:	Fri, 20 Jan 2006 14:02:31 -0500
Message-Id: <1137783751.22994.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Return-Path: <marck@ivivity.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10026
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marckarasek@ivivity.com
Precedence: bulk
X-list: linux-mips

I am not entirely sold on this initramfs.  

I have a question:

>From what I have read so far, it seems that this is meant as a stepping
stone to booting/mounting the real system.  Has anyone used this where
the initramfs is the filesystem and the endpoint in the boot process?  


On Thu, 2006-01-19 at 23:11 -0500, Kumba wrote:
> Marc Karasek wrote:
> > Is the process still the same.  In that you create a ramdisk image that
> > can be mounted, just using initramfs instead?   
> 
> It's actually simpler than that, insofar as creating the archive.  There are two 
> ways that I've tried, probably another exists as well.  None involve the mess of 
> creating a mountable image.
> 
> 1) In the scripts/ dir in the kernel tree, there's a script, 
> gen_initramfs_list.sh.  chmod +x it, and pass to it (as its only argument) an 
> absolute path pointing to a ready-to-go root file system that will be loaded by 
> the machine that boots the subsequently produced kernel.  The output of 
> gen_initramfs_list should be directed to a text file -- it's a text listing of 
> every file in the directory passed, including mode params, symlink destination, 
> whether it's a device or not (and if is, how to re-create it), etc..  This text 
> file can then be passed to the initramfs option in menuconfig, and the kernel 
> pulls in the files and rolls them into its initramfs cpio archive it builds.
> 
> 2) cpio up a ready-to-go root file system and pass that to the same initramfs 
> option in menuconfig.
> 
> 
> Provided the root filesystem is setup properly, just don't pass root= on the 
> command line, and the kernel takes over loading and running the main startup 
> script (it's either /init or /linuxrc that it looks for, one of the two).
> 
> 
> > We will be moving to 2.6.x for our next chip and currently have scripts
> > to create a ramdisk with busybox embedded.  If these cannot be used
> > anymore, I may want to take over the patches for ramdisk from you and
> > maintain them.  Otherwise our sdk would have to change and the tools,
> > etc. and that is not a desireable option......
> 
> This isn't that big of a change actually.  As described above, it's decidedly 
> simpler, as you don't have to rely on any file system (it's basically the same 
> as the old MS-DOS ramdisks some utilities diskettes would load up and dump tools 
> into)
> 
> 
> > IMO: Fixing something that was not broken is not a very good idea. :-)
> 
> I thought the same initially, but in truth, initramfs is far simpler, once you 
> figure it out.  I even fixed the embedded ramdisk to handle linking in objects 
> files with conflicting ABIs (encountered when we built netboot images for SGI O2 
> because at the time, we built O2's kernels with -mabi=o64 which uses some mean 
> tricks to stuff 64bit code into a 32bit file; ld hated that).  Of course, I did 
> this fix about an hour after Ralf removed the ramdisk code from 2.6.10 CVS. 
> Talk about a sense of timing.
> 
> Especially once we found out initramfs loaded flawlessly on Origin, it was 
> essentially deemed to become the replacement.
> 
> 
> 
> --Kumba
> 
-- 
Any content within this email is provided “AS IS” for informational purposes only.  No contract will be formed between the parties by virtue of this email. 
/***********************
Marc Karasek
System Lead Technical Engineer
iVivity Inc.
T 678-990-1550 x238
F 678-990-1551
***********************/
