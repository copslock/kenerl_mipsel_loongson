Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0HDQ6B12068
	for linux-mips-outgoing; Thu, 17 Jan 2002 05:26:06 -0800
Received: from gate.hhi.de (gate.HHI.DE [193.174.67.20])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0HDQ2P12064
	for <linux-mips@oss.sgi.com>; Thu, 17 Jan 2002 05:26:02 -0800
Received: from mails.hhi.de by gate.hhi.de
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 17 Jan 2002 12:26:00 UT
Received: from hhi.de (bs-hpp.HHI.DE)
 by mails.HHI.DE (Sun Internet Mail Server sims.3.5.2000.01.05.12.18.p9)
 with ESMTP id <0GQ300MFT1791B@mails.HHI.DE> for linux-mips@oss.sgi.com; Thu,
 17 Jan 2002 13:25:58 +0100 (MET)
Date: Thu, 17 Jan 2002 13:25:57 +0100
From: Torsten Weber <t.weber@hhi.de>
Subject: -O2 in gcc 2.96 buggy?
To: Linux MIPS <linux-mips@oss.sgi.com>
Message-id: <3C46C2D5.F191DC26@hhi.de>
Organization: HHI
MIME-version: 1.0
X-Mailer: Mozilla 4.7 [en] (X11; I; HP-UX B.10.20 9000/782)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On a RedHat 7.1 installation I compiled gawk (3.1.0),  but gawk crashed
(gawk couldn't run glibc-2.2.4/scripts/firstversions.awk, it resulted
in:
       > (FILENAME=- FNR=1) fatal error: internal error
       > Aborted (core dumped)
)
The gawk problem disappeares if I compile without optimizing with -O2
(i.e. optimizing with -O works).

gcc version is 2.96 20000731 (Red Hat Linux 7.1 2.96-99.1)

Is this problem already known, or where is my mistake?

Thanks.

---------------------------------------------------------------
Torsten Weber                    Heinrich-Hertz-Institut fuer
E-Mail: t.weber@hhi.de           Nachrichtentechnik Berlin GmbH
---------------------------------------------------------------
