Received:  by oss.sgi.com id <S42329AbQFTPqq>;
	Tue, 20 Jun 2000 08:46:46 -0700
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:51673 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S42229AbQFTPqj>;
	Tue, 20 Jun 2000 08:46:39 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA01540;
	Tue, 20 Jun 2000 17:36:12 +0200 (MET DST)
Date:   Tue, 20 Jun 2000 17:36:11 +0200 (MET DST)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@uni-koblenz.de>,
        Ulf Carlsson <ulfc@engr.sgi.com>, Andreas Jaeger <aj@suse.de>
cc:     linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Gdb 5.0 patches for MIPS/Linux
Message-ID: <Pine.GSO.3.96.1000620165634.25502J-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,

 After a bit of work I have gdb 5.0 working on my mipsel-linux system.  So
far it seems to be stable.  Compiled using gcc 2.95.2 and binutils 2.10,
against glibc 2.1.90.  Since patches are quite large I am not sending them
here -- they are available at 'http://www.ds2.pg.gda.pl/~macro/'.  They
include ported changes to binutils and gdb that are otherwise available at
oss.sgi.com.

 Are we going to submit changes from oss.sgi.com to gdb?  I believe its
the right moment now if we want them in gdb 5.1 -- I've seen an
annoucement the release branch for 5.1 will start early in July.  I've
already submitted all other patches. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
