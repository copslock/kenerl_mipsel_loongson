Received:  by oss.sgi.com id <S305165AbQBDD7P>;
	Thu, 3 Feb 2000 19:59:15 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:46955 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305160AbQBDD6u>;
	Thu, 3 Feb 2000 19:58:50 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA07353; Wed, 2 Feb 2000 11:53:39 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA65899
	for linux-list;
	Wed, 2 Feb 2000 11:30:58 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA33307
	for <linux@relay.engr.sgi.com>;
	Wed, 2 Feb 2000 11:30:55 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id LAA15243
	for linux@engr.sgi.com; Wed, 2 Feb 2000 11:30:47 -0800
Date:   Wed, 2 Feb 2000 11:30:47 -0800
Message-Id: <200002021930.LAA15243@liveoak.engr.sgi.com>
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
From:   Eliseu Filho <efilho@ece.uci.edu>
To:     linux@cthulhu.engr.sgi.com
cc:     eliseu@cos.ufrj.br
Subject: sources of 2.2.1-990526 (fwd)
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing



         -----------------------------------------------------------
          I apologize if multiple copies of this mail are received
         -----------------------------------------------------------    

Hello

I tried to run the pre-compiled vmlinux-indy-2.2.1-990226 kernel
on a SGI Indy (R4600 Rev. 00002020 processor with PROMLIB SGI ARCS 
Ver. 1 Rev. 10) but it has not worked (the INIT process does not 
start). I compiled its source locally, but it did not work either 
(same problem). However, the pre-compiled vmlinux-indy-sound-2.2.1-990526  
runs perfectly.

1. What is the difference between vmlinux-indy-2.2.1-990226 and
vmlinux-indy-sound-2.2.1-990526?

2. Where can I find the sources of vmlinux-indy-sound-2.2.1-990526?
Or, is there any patch to upgrade from 2.2.1-990226 to it? I looked 
at ftp.linux.sgi.com/pub/linux/mips/src/kernel/v2.2, but it is empty.
Also, ftp.linux.sgi.com/pub/linux/mips/test contains only the
sources of 2.2.1-990226.

I need the sources of a working kernel in order to introduce some
instrumentation, necessary for my research. So, I really would 
appreciate any help regarding this. Thanks in advance.

Regards
Eliseu M. C. Filho

-------------------------------------------------------
Eliseu M. Chaves Filho, Ph.D.
Associate Professor
Department of Systems and Computer Engineering
Federal University of Rio de Janeiro
P.O. Box 68511
21945-970  Rio de Janeiro, RJ  Brazil

Phone:  +55 21 590-2552 ext. 245 (voice)
        +55 21 290-6626 (fax)
e-mail: eliseu@cos.ufrj.br,
        efilho@ece.uci.edu
Web:    http://www.cos.ufrj.br,
        http://www.eng.uci.edu/morphosys
