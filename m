Received:  by oss.sgi.com id <S305167AbQDESpy>;
	Wed, 5 Apr 2000 11:45:54 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:45180 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305166AbQDESpV>; Wed, 5 Apr 2000 11:45:21 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id LAA05086; Wed, 5 Apr 2000 11:49:06 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA34793
	for linux-list;
	Wed, 5 Apr 2000 11:30:35 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA17002
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 5 Apr 2000 11:30:28 -0700 (PDT)
	mail_from (mikehill@hgeng.com)
Received: from calvin.tor.onramp.ca (calvin.tor.onramp.ca [204.225.88.15]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id LAA01701
	for <linux@cthulhu.engr.sgi.com>; Wed, 5 Apr 2000 11:30:22 -0700 (PDT)
	mail_from (mikehill@hgeng.com)
Received: (qmail 15654 invoked from network); 5 Apr 2000 18:30:19 -0000
Received: from imail.hgeng.com (HELO bart.hgeng.com) (199.246.72.233)
  by mail.onramp.ca with SMTP; 5 Apr 2000 18:30:19 -0000
Received: by BART with Internet Mail Service (5.5.2232.9)
	id <HZ2QG5XV>; Wed, 5 Apr 2000 14:23:02 -0400
Message-ID: <E138DB347D10D3119C630008C79F5DEC2B9D7C@BART>
From:   Mike Hill <mikehill@hgeng.com>
To:     "'Florian Lohoff'" <flo@rfc822.org>, linux@cthulhu.engr.sgi.com
Subject: RE: kernel for indigo2
Date:   Wed, 5 Apr 2000 14:23:01 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2232.9)
Content-Type: text/plain
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hi Florian,

I re-ran the Hardhat installer with setup-1.9.2.noarch.rpm in place of
1.9.1.  (The installer seemed to have a problem with the root password I
entered.)  I can now boot the Indigo2 with the 2.3.21 kernel (boot vmlinux
root=/dev/sdb1 console=ttyS0) and see the kernel boot-up messages in the
serial console.  The last messages visible are:


Freeing unused kernel memory: 48k freed
Unable to find swap-space signature [this message appears four times]


At this point, the hard drive is silent, and telnet from another machine
elicits this response:


Hard Hat Linux Hard Hat release 5.1 (Manhattan)
Kernel 2.3.21 on a mips

login:


My attempted root login is then declared invalid.  For my next trick I'll
try pre-loading installfs/etc/passwd with a valid account, then re-running
the installer.  Is there any reason this shouldn't work?

Thanks,

Mike
