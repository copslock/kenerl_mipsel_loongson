Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA95678 for <linux-archive@neteng.engr.sgi.com>; Tue, 26 Jan 1999 11:54:31 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA98561
	for linux-list;
	Tue, 26 Jan 1999 11:52:29 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgidal.dallas.sgi.com (sgidal.dallas.sgi.com [169.238.80.130])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id LAA49634
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 26 Jan 1999 11:52:27 -0800 (PST)
	mail_from (chad@roctane.dallas.sgi.com)
Received: from roctane.dallas.sgi.com by sgidal.dallas.sgi.com via ESMTP (950413.SGI.8.6.12/911001.SGI)
	 id NAA27654; Tue, 26 Jan 1999 13:50:42 -0600
Received: from roctane.dallas.sgi.com (localhost [127.0.0.1]) by roctane.dallas.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id LAA07111; Tue, 26 Jan 1999 11:50:41 -0800 (PST)
Message-ID: <36AE1C8D.9BB6EB1@roctane.dallas.sgi.com>
Date: Tue, 26 Jan 1999 13:50:37 -0600
From: Chad Carlin <chad@roctane.dallas.sgi.com>
Reply-To: chad@sgi.com
Organization: Silicon Graphics Inc.
X-Mailer: Mozilla 4.5C-SGI [en] (X11; I; IRIX64 6.5 IP30)
X-Accept-Language: en
MIME-Version: 1.0
Newsgroups: sgi.engr.linux
To: Alex deVries <adevries@engsoc.carleton.ca>
CC: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Precompiled 2.1.131 binaries.
References: <Pine.LNX.3.96.990125143208.21345N-100000@lager.engsoc.carleton.ca>
Content-Type: multipart/alternative;
 boundary="------------E1525AC140A31ADE04C58465"
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


--------------E1525AC140A31ADE04C58465
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linux on Indy problems.

Cross-posting this one to sgi.engr.linux. Maybe someone here has had succes with
Linux on an
R4400 Indy.

Here are some answers:

> > 2) Does "VFS: Mounted root (ext2 filesystem) readonly" mean that I guessed
> >   the correct disk partition to use?
>
> Probably... could you see what it reports for the SCSI probe?

Yes, I get similar output describing vendor, model and disk sizes. All are correct.
If I get this output
am I OK in this regard. Should I compare this output with mine to look for
discrepencies?

> Could you see what it reports for partitioning?
>
> Mine says:
>
>      Partition check:
>       sda: sda1 sda2 sda3 sda4
>       sdb: sdb1 sdb2 sdb3
>
Yes, I get this feedback.

> > 3) What does init= mean in "Kernel panic: No init found.  Try passing
> >   init= option to kernel"?
>
> It says this because it can't find /sbin/init, because it can't find the
> root filesystem.

That's what I was afraid of. At least my errors seem to be pointed at filesystem
mounting.

> > 4) This seems to suggest that the tty0 and tty1 have been discovered OK:
> >       SGI Zilog8530 serial driver version 1.00
> >       tty00 at 0xbfbd9838 (irq = 21) is a Zilog8530
> >       tty01 at 0xbfbd9830 (irq = 21) is a Zilog8530
> >  Why then would I get this error message?
> >       Warning: unable to open an initial console
> > 5) Could someone point me to where I can browse the source for this indy kernel?
>
> Two reasons: there's no fielsystem that has /dev/console for you, and I
> never built in serial console support.  I will, thuogh.

It seems like I had it in the previous vmlinux kernel. I was using my irix-indy's
console port to
connect to the console port of my linux-indy. I never got feedback on the local
linux-indy's gfx
(prom> setenv console d). With this new kernel, the reverse is true (now behaves like
prom>
setenv console g).

> Could you look into the lack of disk problems first?  This is on an Indy,
> right?

Yes it is.

Aside from the config that I performed on the disk from IRIX (below), what else
should I look at?

What I did (from my recollection):
irix% mk2efs /dev/dsk/dks0d1s0
irix% installer /dev/dsk/dks0d1s0
   cjwsh> MAKEDEV (What should `ls dev` look like at this point?)
   cjwsh> cpio.....
   cjwsh> exit
irix% e2fsck -fy /dev/linux-disk
cp /dist/linux/mipseb/vmlinux /mnt/vmlinux    (/mnt + /dks0d3s1)

prom> boot vmlinux root=/dev/sdb3 (similar)

Notes:
IRIX 6.5 is installed on an XFS partition dks0d3s0. Linux was cpio'ed onto an ext2
partition
at dks0d1s0. I have an IRIX made efs partition at dks0d1s1.

In this case, I am following the instruction included with "Linux-installer". In
these instructions
there is no talk of using bootp/tftp/nfs for anything. Should these instructions
work? Are these
better/same/worse than the instructions available on the webpage which call for using
bootp to
get the kernel?

BTW I did try the webpage instructions as well. I get errors like cannot open system
console.
This happens after the disk discovery completes OK or at least similar to your
example.

Is the reason for needing IRIX on the linux-indy?: a) Needs to boot sash from VH? b)
Be able
to run installion script which executes under IRIX? c) Some other reason?

Thanks,
Chad

--
           -----------------------------------------------------
            Chad Carlin                          Special Systems
            Silicon Graphics Inc.                   972.205.5911
            Pager 888.754.1597          VMail 800.414.7994 X5344
            chad@sgi.com             http://reality.sgi.com/chad
           -----------------------------------------------------
        "flying through hyper space ain't like dusting crops, boy"



--------------E1525AC140A31ADE04C58465
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
Linux on Indy problems.
<p>Cross-posting this one to sgi.engr.linux. Maybe someone here has had
succes with Linux on an
<br>R4400 Indy.
<p>Here are some answers:
<blockquote TYPE=CITE>> 2) Does "VFS: Mounted root (ext2 filesystem) readonly"
mean that I guessed
<br>>&nbsp;&nbsp; the correct disk partition to use?
<p>Probably... could you see what it reports for the SCSI probe?</blockquote>
Yes, I get similar output describing vendor, model and disk sizes. All
are correct. If I get this output
<br>am I OK in this regard. Should I compare this output with mine to look
for discrepencies?
<blockquote TYPE=CITE>Could you see what it reports for partitioning?
<p>Mine says:
<blockquote>Partition check:
<br>&nbsp;sda: sda1 sda2 sda3 sda4
<br>&nbsp;sdb: sdb1 sdb2 sdb3</blockquote>
</blockquote>
Yes, I get this feedback.
<blockquote TYPE=CITE>> 3) What does init= mean in "Kernel panic: No init
found.&nbsp; Try passing
<br>>&nbsp;&nbsp; init= option to kernel"?
<p>It says this because it can't find /sbin/init, because it can't find
the
<br>root filesystem.</blockquote>
That's what I was afraid of. At least my errors seem to be pointed at filesystem
mounting.
<blockquote TYPE=CITE>> 4) This seems to suggest that the tty0 and tty1
have been discovered OK:
<br>>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SGI Zilog8530 serial driver version
1.00
<br>>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tty00 at 0xbfbd9838 (irq = 21)
is a Zilog8530
<br>>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tty01 at 0xbfbd9830 (irq = 21)
is a Zilog8530
<br>>&nbsp; Why then would I get this error message?
<br>>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Warning: unable to open an initial
console
<br>> 5) Could someone point me to where I can browse the source for this
indy kernel?
<p>Two reasons: there's no fielsystem that has /dev/console for you, and
I
<br>never built in serial console support.&nbsp; I will, thuogh.</blockquote>
It seems like I had it in the previous vmlinux kernel. I was using my irix-indy's
console port to
<br>connect to the console port of my linux-indy. I never got feedback
on the local linux-indy's gfx
<br>(prom> setenv console d). With this new kernel, the reverse is true
(now behaves like prom>
<br>setenv console g).
<blockquote TYPE=CITE>Could you look into the lack of disk problems first?&nbsp;
This is on an Indy,
<br>right?</blockquote>
Yes it is.
<p>Aside from the config that I performed on the disk from IRIX (below),
what else should I look at?
<p>What I did (from my recollection):
<br>irix% mk2efs /dev/dsk/dks0d1s0
<br>irix% installer /dev/dsk/dks0d1s0
<br>&nbsp;&nbsp; cjwsh> MAKEDEV (What should `ls dev` look like at this
point?)
<br>&nbsp;&nbsp; cjwsh> cpio.....
<br>&nbsp;&nbsp; cjwsh> exit
<br>irix% e2fsck -fy /dev/linux-disk
<br>cp /dist/linux/mipseb/vmlinux /mnt/vmlinux&nbsp;&nbsp;&nbsp; (/mnt
+ /dks0d3s1)
<p>prom> boot vmlinux root=/dev/sdb3 (similar)
<p>Notes:
<br>IRIX 6.5 is installed on an XFS partition dks0d3s0. Linux was cpio'ed
onto an ext2 partition
<br>at dks0d1s0. I have an IRIX made efs partition at dks0d1s1.
<p>In this case, I am following the instruction included with "Linux-installer".
In these instructions
<br>there is no talk of using bootp/tftp/nfs for anything. Should these
instructions work? Are these
<br>better/same/worse than the instructions available on the webpage which
call for using bootp to
<br>get the kernel?
<p>BTW I did try the webpage instructions as well. I get errors like cannot
open system console.
<br>This happens after the disk discovery completes OK or at least similar
to your example.
<p>Is the reason for needing IRIX on the linux-indy?: a) Needs to boot
sash from VH? b) Be able
<br>to run installion script which executes under IRIX? c) Some other reason?
<p>Thanks,
<br>Chad
<pre>--&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -----------------------------------------------------
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Chad Carlin&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Special Systems
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Silicon Graphics Inc.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 972.205.5911&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Pager 888.754.1597&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VMail 800.414.7994 X5344
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; chad@sgi.com&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <A HREF="http://reality.sgi.com/chad">http://reality.sgi.com/chad</A>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -----------------------------------------------------&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "flying through hyper space ain't like dusting crops, boy"</pre>
&nbsp;</html>

--------------E1525AC140A31ADE04C58465--
