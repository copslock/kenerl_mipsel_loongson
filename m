Received:  by oss.sgi.com id <S305156AbPK3Qm4>;
	Tue, 30 Nov 1999 08:42:56 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:64891 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305155AbPK3Qmn>;
	Tue, 30 Nov 1999 08:42:43 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id IAA03679; Tue, 30 Nov 1999 08:45:20 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA23353
	for linux-list;
	Tue, 30 Nov 1999 08:37:30 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA60448
	for <linux@engr.sgi.com>;
	Tue, 30 Nov 1999 08:37:26 -0800 (PST)
	mail_from (e1097757@ceng.metu.edu.tr)
Received: from mendelson.ceng.metu.edu.tr (mendelson.ceng.metu.edu.tr [144.122.171.110]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA03615
	for <linux@engr.sgi.com>; Tue, 30 Nov 1999 08:37:22 -0800 (PST)
	mail_from (e1097757@ceng.metu.edu.tr)
Received: (from e1097757@localhost)
	by mendelson.ceng.metu.edu.tr (8.9.0/8.9.0) id SAA17580
	for linux@engr.sgi.com; Tue, 30 Nov 1999 18:37:41 +0200 (EET)
From:   SERTKAYA BARIS <e1097757@ceng.metu.edu.tr>
Message-Id: <199911301637.SAA17580@mendelson.ceng.metu.edu.tr>
Subject: EXT2 fs error
To:     linux@cthulhu.engr.sgi.com
Date:   Tue, 30 Nov 1999 18:37:41 +0200 (EET)
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing



	Hi,

	While running updatedb from crontab, my Indy crashed with the 
	following errors.It became OK when I booted it.What can be the
	reason?

	...
	EXT2-fs error (device 08:11) ext2_free blocks: Freeing blocks not in
	datazone - block = ...., count=1
	EXT2-fs error (device 08:11): ext2_readdir: bad entry in directory
	#... :directory entry across blocks - ...
	scsi0 channel 0 : resetting for second half of entries.
	SCSI bus is being reset for 0 channel 0.
	scsi0 reset. sending SDTR

	thanx in advance,
	           baris.

-- 
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
