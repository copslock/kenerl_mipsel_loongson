Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0HD2Ut11580
	for linux-mips-outgoing; Thu, 17 Jan 2002 05:02:30 -0800
Received: from gate.hhi.de (gate.HHI.DE [193.174.67.20])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0HD2QP11577
	for <linux-mips@oss.sgi.com>; Thu, 17 Jan 2002 05:02:26 -0800
Received: from mails.hhi.de by gate.hhi.de
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 17 Jan 2002 12:02:24 UT
Received: from hhi.de (bs-hpp.HHI.DE)
 by mails.HHI.DE (Sun Internet Mail Server sims.3.5.2000.01.05.12.18.p9)
 with ESMTP id <0GQ300M9N03Y1B@mails.HHI.DE> for linux-mips@oss.sgi.com; Thu,
 17 Jan 2002 13:02:22 +0100 (MET)
Date: Thu, 17 Jan 2002 13:02:22 +0100
From: Torsten Weber <t.weber@hhi.de>
Subject: profiling in glibc for Linux/MIPS
To: Linux MIPS <linux-mips@oss.sgi.com>
Message-id: <3C46BD4D.DCF1F188@hhi.de>
Organization: HHI
MIME-version: 1.0
X-Mailer: Mozilla 4.7 [en] (X11; I; HP-UX B.10.20 9000/782)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

We use RedHat 7.1 (available at ftp.mips.com) for the MALTA board,

but programs compiled usign gcc -pg (and using a lib call inside)

generate a segmentation fault and core dump. I applied the "patch"

described in the mailing list

(http://oss.sgi.com/mips/archive/linux-mips.0107,

Subject: [patch] fix profiling in glibc for Linux/MIPS), but

the core dumps are still generated. Does anybody know a solution?

Thanks

---------------------------------------------------------------
Torsten Weber                    Heinrich-Hertz-Institut fuer
E-Mail: t.weber@hhi.de           Nachrichtentechnik Berlin GmbH
---------------------------------------------------------------
