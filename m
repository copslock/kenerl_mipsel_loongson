Received:  by oss.sgi.com id <S305176AbQDCXz2>;
	Mon, 3 Apr 2000 16:55:28 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:28420 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305168AbQDCXzR>;
	Mon, 3 Apr 2000 16:55:17 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA03844; Mon, 3 Apr 2000 16:50:35 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA37123
	for linux-list;
	Mon, 3 Apr 2000 16:44:42 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA42648
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 3 Apr 2000 16:44:41 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA09631
	for <linux@cthulhu.engr.sgi.com>; Mon, 3 Apr 2000 16:44:36 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 838B27FA; Tue,  4 Apr 2000 01:44:36 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 59DF98FC3; Tue,  4 Apr 2000 01:27:55 +0200 (CEST)
Date:   Tue, 4 Apr 2000 01:27:55 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux@cthulhu.engr.sgi.com
Subject: indigo2 problems - resume
Message-ID: <20000404012755.C275@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Hi,
after trying at least 20 different kernels (Selfmade and binary images)
i must say "Fu!&%!§!" - Basically its broken - The complete console thing
is a bug with SGI_IP22 - If i get the kernel to boot until it mounts the
nfs-root the console disappears (2.3.21 with serial console and 2.3.21
with prom console - cvs checkout -D 20000114) - Current CVS doesnt even
boot until then. If i repair the prom console (Serial console doesnt
work either) the kernel stops after "On node 0 totalpages: 65413" -
Might the mm things be broken ? This looks really like NUMA issues Ralf
is working on - Might this have broken the mips things ?

Does anyone have an idea WHY the console disappears when going single user ?
I see that the machine continues booting (strace on nfsd) - I tried
nearly everything as "/dev/console"
Major 5 minor 1 (serial-console howto), major 4 minor 64, link to ttyS0 - 
Nothing ...

So currently i would say the SGI_IP22 mips things are unusable.

Very frustrated

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
