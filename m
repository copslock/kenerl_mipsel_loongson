Received: (from majordomo@localhost)
	by oss.sgi.com (8.9.3/8.9.3) id NAA10714
	for linuxmips-outgoing; Tue, 26 Oct 1999 13:42:39 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linuxmips@oss.sgi.com using -f
Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by oss.sgi.com (8.9.3/8.9.3) with ESMTP id NAA10711
	for <linuxmips@oss.sgi.com>; Tue, 26 Oct 1999 13:42:39 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id NAA13683
	for <linuxmips@oss.sgi.com>; Tue, 26 Oct 1999 13:42:32 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA20948
	for linux-list;
	Tue, 26 Oct 1999 13:22:28 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA91286
	for <linux@engr.sgi.com>;
	Tue, 26 Oct 1999 13:22:25 -0700 (PDT)
	mail_from (e1097757@ceng.metu.edu.tr)
Received: from mendelson.ceng.metu.edu.tr (mendelson71.ceng.metu.edu.tr [144.122.71.3]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA4806576
	for <linux@engr.sgi.com>; Tue, 26 Oct 1999 13:22:20 -0700 (PDT)
	mail_from (e1097757@ceng.metu.edu.tr)
Received: (from e1097757@localhost)
	by mendelson.ceng.metu.edu.tr (8.9.0/8.9.0) id XAA02674
	for linux@engr.sgi.com; Tue, 26 Oct 1999 23:22:25 +0300 (EET DST)
From: SERTKAYA BARIS <e1097757@ceng.metu.edu.tr>
Message-Id: <199910262022.XAA02674@mendelson.ceng.metu.edu.tr>
Subject: HardHat 5.1 booting problem
To: linux@cthulhu.engr.sgi.com
Date: Tue, 26 Oct 1999 23:22:24 +0300 (EET DST)
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk



	Hi, 

	I installed HardHat 5.1 on an Indy.When booting a 2.2.1 kernel,
	it gives the warning:
	Warning: unable to open an initial console.
	after mounting root (ext2 filesystem).When I ping the machine,
	I can see that it is alive.But when I telnet to it, connection is
	refused (most probably because inetd is not running yet).
	I looked up the online FAQ at linux.sgi.com.It says that it might
	occur if the distribution is not on a linux.(because of non-standard
	file represantation).
	The tar file is on an NFS mounted machine running AIX 4.x.I untarred it 
	to the local disk of my linux box.And  I did the installation from
	my machine running linux.But I still have the same problem.

	Could somebody offer a solution please?I have been trying to install
	HardHat for a long time and I still could not manage it.But I hope
	I will see my Indy giving me a login prompt someday :)

-------------------------
#!/usr/bin/perl          |
use Tranquilizan;        |
goto bed;                |
bed: while (!&asleep) {  |
                ++$sheep;|
        }                |
sub asleep {             |
        return 0;        |
}                        |
--------------------------
