Received:  by oss.sgi.com id <S553825AbRAKMEa>;
	Thu, 11 Jan 2001 04:04:30 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:54798 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553687AbRAKMEJ>;
	Thu, 11 Jan 2001 04:04:09 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id DBDEB7F3; Thu, 11 Jan 2001 13:04:06 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 5E7F0F597; Thu, 11 Jan 2001 13:04:50 +0100 (CET)
Date:   Thu, 11 Jan 2001 13:04:50 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Erik Andersen <andersen@lineo.com>
Cc:     Michael Shmulevich <michaels@jungo.com>,
        busybox@opensource.lineo.com,
        "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: [BusyBox] 0.48 - Can't mount /proc
Message-ID: <20010111130450.B5811@paradigm.rfc822.org>
References: <3A5CAC53.60700@jungo.com> <20010110122159.A24714@lineo.com> <3A5D609C.2080201@jungo.com> <20010111044808.A1592@lineo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010111044808.A1592@lineo.com>; from andersen@lineo.com on Thu, Jan 11, 2001 at 04:48:08AM -0700
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Jan 11, 2001 at 04:48:08AM -0700, Erik Andersen wrote:
> On Thu Jan 11, 2001 at 09:28:28AM +0200, Michael Shmulevich wrote:
> > Erik,
> > 
> > No, doesn't help.
> > 
> > bash# mount proc /proc -t proc                                          
> >        
> > mount: Mounting proc on /proc failed: Unknown error 716878944           
> >        
> > 
> > Maybe people in mips-linux know something about this?
> 
> Yes, this does sound like a kernel specific problem then,
> since this works on (at least) arm, ppc, sh, and x86.
> I havn't tried it on anything else.

Henning Heinold has done a lot with busybox on mips (debian installer)
Might this be due to kernel 2.4 and /proc/mounts includeing a / in front
of proc 

(flo@ping)~# cat /proc/mounts 
/dev/root / ext2 rw 0 0
proc /proc proc rw 0 0
devpts /dev/pts devpts rw 0 0
/dev/sda7 /usr ext2 rw 0 0
/dev/sda8 /var ext2 rw 0 0
/dev/sda9 /tmp ext2 rw 0 0
/dev/sda10 /home ext2 rw 0 0
/dev/hda5 /var/tmp ext3 rw 0 0
usbdevfs /proc/bus/usb usbdevfs rw 0 0
automount(pid19472) /mnt autofs rw 0 0
(flo@ping)~# uname -a
Linux ping.mediaways.net 2.2.18ext3 #1 Thu Dec 14 18:24:45 CET 2000 i686 unknown

Or 

flo@resume:~$ cat /proc/mounts 
/dev/root / ext2 rw 0 0
/proc /proc proc rw 0 0
/dev/sdb1 /home2 ext2 rw 0 0
/dev/sdc1 /home3 ext2 rw 0 0
/dev/sdd1 /ftp.rfc822.org ext2 rw 0 0
/dev/sde1 /home4 ext2 rw 0 0
shmfs /var/shm shm rw 0 0
devpts /home4/dev/pts devpts rw 0 0
proc /home4/proc proc rw 0 0
flo@resume:~$ uname -a
Linux resume.rfc822.org 2.4.0-test6 #2 Sun Aug 27 12:37:51 GMT 2000 mips unknown


Henning has fought with this IIRC.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
