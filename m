Received: (from majordomo@localhost)
	by oss.sgi.com (8.9.3/8.9.3) id KAA09266
	for linuxmips-outgoing; Tue, 26 Oct 1999 10:32:05 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linuxmips@oss.sgi.com using -f
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.9.3/8.9.3) with ESMTP id KAA09262
	for <linuxmips@oss.sgi.com>; Tue, 26 Oct 1999 10:31:45 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA4715991
	for <linuxmips@oss.sgi.com>; Tue, 26 Oct 1999 10:35:37 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA22161
	for linux-list;
	Tue, 26 Oct 1999 10:19:54 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA62769
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 26 Oct 1999 10:19:51 -0700 (PDT)
	mail_from (eak@detroit.sgi.com)
Received: from dataserv.detroit.sgi.com (dataserv.detroit.sgi.com [169.238.128.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id KAA31788; Tue, 26 Oct 1999 10:19:45 -0700 (PDT)
Received: from cx1.detroit.sgi.com (cx1.detroit.sgi.com [169.238.130.4]) by dataserv.detroit.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA04847; Tue, 26 Oct 1999 13:19:43 -0400 (EDT)
Received: from detroit.sgi.com (localhost [127.0.0.1]) by cx1.detroit.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id NAA11251; Tue, 26 Oct 1999 13:17:05 -0400 (EDT)
Message-ID: <3815E211.B1549EAB@detroit.sgi.com>
Date: Tue, 26 Oct 1999 13:17:05 -0400
From: Eric Kimminau <eak@detroit.sgi.com>
Reply-To: eak@sgi.com
Organization: sgi
X-Mailer: Mozilla 4.7C-SGI [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Young <pete@alien.bt.co.uk>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: Hardhat 5.1, wu-ftpd problems
References: <m11g9Yj-001kxeC@mail.alien.bt.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk

Pete Young wrote:
> 
> Having proved that I have a stable-ish Indy with Hardhat 5.1, kernel
> version 2.2.1 , i thought I might put it to work as an ftp server
> for part of our internal mirror system.
> 
> Installed the rpms for anonftp and wu-ftpd from our mirror of the
> latest distribution, but found we got some odd behavior from the
> ftp daemon: it was quite happy for people using the Solaris 2.6
> client, but using the BSD client or the netscape client I see no
> files or directories (although it is possible to move about
> the directory structure if you know what the subdirectories are
> called).
> 
> I also built a more-up-to-date version of wu-ftpd (version 2.5.0
> with QUOTAS disabled) but the same thing seems to be happening.
> 
> Is this a known problem, and if so is there a fix?
> 
> Kind regards,
> 
> Pete

This sounds like you are missing something in the lib directory for
your anonymous ftp account. Im not positive how wu-ftpd is configured
for Linux but looking in ~ftp/lib for libc.so, ~ftp/bin for ls and
~ftp/dev for zero would probably be where I would start first.

Here is a good simple set of instructions for configuring an anon ftp
server:
     ~ftp      Make the home directory owned by ``ftp'' and unwritable
by
               anyone (mode 555 - see chmod(1)):

                    chown ftp ~ftp
                    chmod a-w ~ftp



     ~ftp/bin  Make this directory owned by the super-user and
unwritable
               by anyone (mode 555).  The program ls(1) must be
present to
               support the list commands.  This program should have
mode
               111.

     ~ftp/etc  Make this directory owned by the super-user and
unwritable
               by anyone (mode 555). The files passwd(4) and group(4)
must
               be present for the ls command to be able to produce
owner
               names rather than numbers.  This should not be a copy
of the
               real file in /etc, and in particular, it should contain
no
               encrypted passwords from the real /etc/passwd or
/etc/group.
               The password field in passwd is not used.  Only the
minimal
               number of accounts should be listed.  These files
should be
               mode 444.

     ~ftp/lib32
               Make this directory own by the super-user and
unwritable by
               anyone (mode 555).  In order for ls to run, the files
               /lib32/rld and /lib32/libc.so.1 must be copied into
lib32
               (older releases, or some uses of other programs might
also
               require the o32 versions in /lib.  Both rld and
libc.so.1
               should be readable and executable by everyone, e.g.
mode
               555.

     ~ftp/dev  Make this directory owned by the super-user and
unwritable
               by anyone (mode 555).  rld uses /dev/zero, so use
mknod(1)
               to make a copy  of /dev/zero in ~ftp/dev with the same
major
               and minor device numbers.  Make /dev/zero read-only
(mode
               444).

                    mknod ~ftp/dev/zero c 37 0
                    chmod 444 ~ftp/dev/zero

     ~ftp/pub  Make this directory owned by ``ftp''. If local users
and
               remote anonymous users are to be allowed to write in
this
               directory, change the directory's mode to 777.  Users
can
               then place files which are to be accessible via the
               anonymous account in this directory.  If write accesses
are
               to be denied, change the directory's mode to 555.


Hope that helps!
                        Eric.

-- 
.--------1---------2---------3---------4---------5---------6---------7.
  Eric Kimminau           eak@sgi.com       Electronic Support Tools
      Vox:248-848-4455  Fax:248-848-5600  VNET:6-327-4455  
              "I speak my mind and no one else's."
 "I am a bomb technician. If you see me running, try to keep up..."
                    http://support.sgi.com
