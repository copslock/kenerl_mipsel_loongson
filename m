Received: (from majordomo@localhost)
	by oss.sgi.com (8.9.3/8.9.3) id JAA20871
	for linuxmips-outgoing; Fri, 22 Oct 1999 09:53:55 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linuxmips@oss.sgi.com using -f
Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by oss.sgi.com (8.9.3/8.9.3) with ESMTP id JAA20868
	for <linuxmips@oss.sgi.com>; Fri, 22 Oct 1999 09:53:54 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id JAA27775
	for <linuxmips@oss.sgi.com>; Fri, 22 Oct 1999 09:53:29 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA14838
	for linux-list;
	Fri, 22 Oct 1999 09:32:21 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA35345
	for <linux@engr.sgi.com>;
	Fri, 22 Oct 1999 09:32:18 -0700 (PDT)
	mail_from (e1097757@ceng.metu.edu.tr)
Received: from mendelson.ceng.metu.edu.tr (mendelson71.ceng.metu.edu.tr [144.122.71.3]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA2960034
	for <linux@engr.sgi.com>; Fri, 22 Oct 1999 09:31:55 -0700 (PDT)
	mail_from (e1097757@ceng.metu.edu.tr)
Received: (from e1097757@localhost)
	by mendelson.ceng.metu.edu.tr (8.9.0/8.9.0) id TAA17036
	for linux@engr.sgi.com; Fri, 22 Oct 1999 19:32:07 +0300 (EET DST)
From: SERTKAYA BARIS <e1097757@ceng.metu.edu.tr>
Message-Id: <199910221632.TAA17036@mendelson.ceng.metu.edu.tr>
Subject: HardHat5-1 installation problem
To: linux@cthulhu.engr.sgi.com
Date: Fri, 22 Oct 1999 19:32:07 +0300 (EET DST)
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk



	Hi,

	I am trying to install HardHat linux on an Indy.The kernel and the
	distribution are on different machines so on the command monitor
	I type
	>>boot bootp():/vmlinux nfsroot=144.122.*.*:/tmpfs/mipseb

	The kernel starts to load, it detects the memory, disks and so on,
	and later the installation script begins.I select the target disk
	and the partition (/dev/sdb1) and the packets to be installed.Then
	it starts to make ext2 file system on /dev/sdb1 and after a while,
	it gives up with the message:

	install exited abnormally -- recieved signal 11
	sending termination signals...done
	mounting filesystems.../proc /mnt /tmp
	you may safely reboot your system

	I would be very gradefull if someone could tell me the result and
	the solution.

	thanks in advance,

	baris sertkaya.
