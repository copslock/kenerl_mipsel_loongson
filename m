Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Apr 2003 11:05:25 +0100 (BST)
Received: from pasmtp.tele.dk ([IPv6:::ffff:193.162.159.95]:44050 "EHLO
	pasmtp.tele.dk") by linux-mips.org with ESMTP id <S8225211AbTDKKFY>;
	Fri, 11 Apr 2003 11:05:24 +0100
Received: from ekner.info (0x83a4a968.virnxx10.adsl-dhcp.tele.dk [131.164.169.104])
	by pasmtp.tele.dk (Postfix) with ESMTP
	id 07145B600; Fri, 11 Apr 2003 12:05:10 +0200 (CEST)
Message-ID: <3E969362.B50934A@ekner.info>
Date: Fri, 11 Apr 2003 12:05:22 +0200
From: Hartvig Ekner <hartvig@ekner.info>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-19.7.x i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: ext3 under MIPS?
References: <3E954651.C7AECB90@ekner.info> <20030410154050.GI5242@lug-owl.de> <3E95D16D.1671BA5A@ekner.info> <20030411064754.GM5242@lug-owl.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <hartvig@ekner.info>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1990
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hartvig@ekner.info
Precedence: bulk
X-list: linux-mips

I think you are right, something else is wrong, very wrong, probably not related to ext3 recovery at all.
It might be as simple as the way I converted the root ext2 to ext3 was done wrongly. Take a look
here:

When the system starts up (after the fake crash) with root in RO mode, I get (as previously
explained):

Checking root filesystem
/dev/hdc2: Inodes that were part of a corrupted orphan linked list found.  [/sbin/fsck.ext3 (1) -- /] fsck.ext3 -a -f /dev/hdc2
/dev/hdc2: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.
        (i.e., without -a or -p options)
xxx The return code from fsck was 4
[FAILED]

*** An error occurred during the file system check.
*** Dropping you to a shell; the system will reboot
*** when you leave the shell.
Give root password for maintenance
(or type Control-D for normal startup):

I then login and run the fsck manually:

(Repair filesystem) 1 # fsck.ext3 -y /dev/hdc2
e2fsck 1.27 (8-Mar-2002)
/dev/hdc2 contains a file system with errors, check forced.
Pass 1: Checking inodes, blocks, and sizes
Inodes that were part of a corrupted orphan linked list found.  Fix? yes
Inode 653 was part of the orphaned inode list.  FIXED.
Inode 33040 was part of the orphaned inode list.  FIXED.
... stuff deleted
Inode 434395 was part of the orphaned inode list.  FIXED.
Inode 465769 was part of the orphaned inode list.  FIXED.
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information

/dev/hdc2: ***** FILE SYSTEM WAS MODIFIED *****
/dev/hdc2: 43937/513024 files (0.1% non-contiguous), 188654/1024002 blocks

Now one would believe the disk is fine, as in eg:

(Repair filesystem) 2 # fsck.ext3 -y /dev/hdc2
e2fsck 1.27 (8-Mar-2002)
/dev/hdc2: clean, 43937/513024 files, 188654/1024002 blocks

So, I thought everything was fine. WRONG. If I force another filesystem check, I get:

(Repair filesystem) 11 # fsck.ext3 -y -f /dev/hdc2
e2fsck 1.27 (8-Mar-2002)
Pass 1: Checking inodes, blocks, and sizes
Inodes that were part of a corrupted orphan linked list found.  Fix? yes

Inode 653 was part of the orphaned inode list.  FIXED.
Inode 33040 was part of the orphaned inode list.  FIXED.
Inode 33225 was part of the orphaned inode list.  FIXED.
Inode 70198 was part of the orphaned inode list.  FIXED.
Inode 129443 was part of the orphaned inode list.  FIXED.
...
Inode 434395 was part of the orphaned inode list.  FIXED.
Inode 465769 was part of the orphaned inode list.  FIXED.
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information

/dev/hdc2: ***** FILE SYSTEM WAS MODIFIED *****
/dev/hdc2: 43937/513024 files (0.1% non-contiguous), 188654/1024002 blocks

In short, exactly the same errors again. And if I force the check again, I get 100% identical
errors again. So something is fundamentally broken. Looking to what the system believes it has mounted:

(Repair filesystem) 14 # mount -l
/dev/hdc2 on / type ext3 (rw) []            <========= Is this really right?
none on /proc type proc (rw)

(Repair filesystem) 20 # more /proc/mounts
rootfs / rootfs rw 0 0                <=========== Is this really right?
/dev/root / ext3 ro 0 0
/proc /proc proc rw 0 0

Now I'm beginning to suspect that my conversion from ext2 to ext3 (tune2fs -j on a running system, and
just modifying ext2 to ext3 in fstab) is somehow not correct, or something else which I overlooked?
How did you guys (the ones without any ext3 problems) initially get the ext3 root partition in place
(was it born as ext3 or converted from ext2?) and anything special one needs to do in fstab?

/Hartvig


Jan-Benedict Glaw wrote:

> On Thu, 2003-04-10 22:17:49 +0200, Hartvig Ekner <hartvig@ekner.info>
> wrote in message <3E95D16D.1671BA5A@ekner.info>:
> > Jan-Benedict Glaw wrote:
>
> [ext3 fs corruption after journal recovery]
>
> > I can reproduce this anytime by just pushing the reset button and checking the filesystem
> > at reboot after ext3 recovery has run. However, if I just do regular fsck's (without unclean
> > shutdowns) nothing seems to be wrong. So I am pretty sure it is something which
>
> How do you invoce fsck?
>
> > goes wrong in conjunction with the unclean shutdowns.
>
> That's bad then:-(
>
> > Is ext3 journal recovery really supposed to recover everything to a state where fsck returns no
> > errors, or is it potentially leaving non-fatal errors in the filesystem (e.g. lost inodes which just
>
> No. The concept is different.
>
> Such a journal will log things like:
>
> - File creation/deletion
> - Owner/timestamp/access changes
>
> These informations are restored during journal recovery. Most
> filesystems do /not/ store the actual data you're writing to a file into
> the journal. So, after you've issued a write() and presses the reset
> button, the journal contains the new filesize, but by possibility
> __not__ the data you've written to the file. So file size is okay, but
> file content isn't. It's basically the job of the journal to keep your
> filesystem intact, but not your data.
>
> If you do this:
>
>         - Boot with / mounted r/o
>         - e2fsck -f /dev/your-root-device
>         - Reset
>         - Boot with / mounted r/w
>         - Write something
>         - Reset
>
> You shouldn't see fsck failing (except it may replay the journal for
> filesystems which hadn't been mounted on /).
>
> If you see corruption here (ie. fsck finds problems after replaying the
> journal), something is serverely broken.
>
> > reduces capacity, but does not cause further corruption if the filesystem is used) which will then
> > be picked up by a later fsck when one has time to run it?
>
> It should present you a f/s with no *known* problems. If corruption
> (broken DMA transfers, ...) took place, this hasn't eventually logget
> into the journal so this isn't recovered:-)
>
> > What does the error "Inodes that were part of a corrupted orphan linked list found." actually
> > mean? Is this a fatal error, or a non-critical error along the lines I described above (an error
> > which does not get any worse if the filesystem is used)?
>
> I think this basically means that fsck found files of a (destroyed)
> directory. But for exact statements here, read e2fsck's sources...
>
> > Is there anybody with ext3 up and running who would volunteer to do a couple of unclean
> > shutdowns and see if the recovery works without any fsck errors present afterwards?
>
> :-)
>
> MfG, JBG
