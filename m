Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5IJ7Or21120
	for linux-mips-outgoing; Mon, 18 Jun 2001 12:07:24 -0700
Received: from ubik.localnet (port48.ds1-vbr.adsl.cybercity.dk [212.242.58.113])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5IJ7NV21113
	for <linux-mips@oss.sgi.com>; Mon, 18 Jun 2001 12:07:23 -0700
Received: from murphy.dk (brian.localnet [10.0.0.2])
        by ubik.localnet (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f5IJ7Gq6013331
        for <linux-mips@oss.sgi.com>; Mon, 18 Jun 2001 21:07:17 +0200
Message-ID: <3B2E5163.D130FA01@murphy.dk>
Date: Mon, 18 Jun 2001 21:07:15 +0200
From: Brian Murphy <brian@murphy.dk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Profiling support in glibc?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


What is the status of profiling in glibc? Our (egcs-1.1.2 based)
compiler fails with a missing symbol
_start (glibc 2.0.6) but even if one fixes this up there are more
fundamental problems.

Is there a later glibc for which profiling works?

/Brian
