Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA44339 for <linux-archive@neteng.engr.sgi.com>; Tue, 22 Jun 1999 16:51:50 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA88579
	for linux-list;
	Tue, 22 Jun 1999 16:50:29 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA68661
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 22 Jun 1999 16:50:26 -0700 (PDT)
	mail_from (ulfc@thepuffingroup.com)
Received: from calypso (dialup88-12-6.swipnet.se [130.244.88.182]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA06751
	for <linux@cthulhu.engr.sgi.com>; Tue, 22 Jun 1999 16:50:25 -0700 (PDT)
	mail_from (ulfc@thepuffingroup.com)
Received: by calypso (Linux Smail3.2.0.101 #1)
	id m10waJg-003LoAC; Wed, 23 Jun 1999 01:51:00 +0200 (CEST)
Date: Tue, 22 Jun 1999 03:39:31 +0200
From: Ulf Carlsson <ulfc@thepuffingroup.com>
To: linux@cthulhu.engr.sgi.com
Subject: Memory corruption
Message-ID: <19990622033931.A7201@thepuffingroup.com>
Mail-Followup-To: linux@cthulhu.engr.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
X-Mailer: Mutt 0.95.4i
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

The compiler may stop working sometimes on certain files, giving bogus error
messages which I don't understand (the compiler is probably not the only
application affected).  Running this program I just wrote forces the corrupted
caches to be flushed or something and ``fixes'' the problems:

int main(void)
{
	unsigned long tot = 0;
	unsigned long i = 1 << 20;
	void *p;
	int failures = 0;

	while (i) {
		p = malloc(i);
		if (!p) {
			if (failures++ < 10)
				continue;
			i = i >> 1;
			failures = 0;
			continue;
		}
		memset(p, 0, i);
		tot += i;
	}
	printf("Total memory set: %u kb\n", tot >> 10);
}

Maybe I should put this in my crontab along with sync :-)

Does anyone else notice these problems?

- Ulf
