Received:  by oss.sgi.com id <S42261AbQGEC0h>;
	Tue, 4 Jul 2000 19:26:37 -0700
Received: from u-179.karlsruhe.ipdial.viaginterkom.de ([62.180.18.179]:49415
        "EHLO u-179.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42258AbQGEC0a>; Tue, 4 Jul 2000 19:26:30 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S1405870AbQGEC0S>;
        Wed, 5 Jul 2000 04:26:18 +0200
Date:   Wed, 5 Jul 2000 04:26:18 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     linux-mips@oss.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: New egcs 1.0.3a crosscompilers
Message-ID: <20000705042617.A11557@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I've uploaded new egcs 1.0.3a crosscompiler source and binary packages
for i386-linux hosts to oss.sgi.com.  This release fix a bug which was
preventing __attribute__((aligned(x))) from working for values of x larger
than 8.  Older releases of egcs 1.0.3a will no longer compile the current
CVS kernel; they'll abort when compiling kernel/sched.c.  The native
compilers are affected by the same bug but I don't have updated packages
yet.

  Ralf
