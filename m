Received:  by oss.sgi.com id <S553823AbRCADGq>;
	Wed, 28 Feb 2001 19:06:46 -0800
Received: from mailhost.taec.com ([209.243.128.33]:1676 "EHLO
        mailhost.taec.toshiba.com") by oss.sgi.com with ESMTP
	id <S553758AbRCADGV>; Wed, 28 Feb 2001 19:06:21 -0800
Received: from hdqmta.taec.toshiba.com (hdqmta [209.243.180.59])
	by mailhost.taec.toshiba.com (8.8.8+Sun/8.8.8) with ESMTP id TAA21772;
	Wed, 28 Feb 2001 19:06:14 -0800 (PST)
Subject: NFSROOT filesystem
To:     linux-mips@oss.sgi.com, owner-linux-mips@oss.sgi.com
X-Mailer: Lotus Notes Release 5.0.3  March 21, 2000
Message-ID: <OF67407876.E19EEFE1-ON88256A02.000F849E@taec.toshiba.com>
From:   Lisa.Hsu@taec.toshiba.com
Date:   Wed, 28 Feb 2001 19:00:13 -0800
X-MIMETrack: Serialize by Router on HDQMTA/TOSHIBA_TAEC(Release 5.0.5 |September 22, 2000) at
 02/28/2001 07:05:00 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Hi, All

For using NFS boot, I've already edited the /etc/hosts, /etc/exports to add
the entry for my target board.  The command line that I use in our EPROM
based bootloader  is as follows:

root=/dev/nfs rw ip=::::::rarp console=ttyS2
nfsroot=209.243.136.151:/work/nfsroot

I need to setup the NFSROOT filesystem on the server for my target board
(which is running in Big-endian mode),  what are the steps that I have to
do?

There is a FTP site for getting RPM packages for little endian mode:

         tp://ftp.linux.sgi.com/[ig/linux/mips/mipsel-linux/RedHat-6.1/RPMS

I could not find similar one for big-endian.    Can anybody give me a
pointer to where the RPM packages reside on the web?


Thanks,

Lisa
