Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f31HRKY14769
	for linux-mips-outgoing; Sun, 1 Apr 2001 10:27:20 -0700
Received: from hermes.research.kpn.com (hermes.research.kpn.com [139.63.192.8])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f31HRJM14766
	for <linux-mips@oss.sgi.com>; Sun, 1 Apr 2001 10:27:19 -0700
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
 by research.kpn.com (PMDF V5.2-31 #42699)
 with ESMTP id <01K1WAJS7N7Q000Q0N@research.kpn.com> for
 linux-mips@oss.sgi.com; Sun, 1 Apr 2001 19:27:18 +0200
Received: (from karel@localhost)	by sparta.research.kpn.com (8.8.8+Sun/8.8.8)
 id TAA13561	for linux-mips@oss.sgi.com; Sun,
 01 Apr 2001 19:27:17 +0200 (MET DST)
X-URL: http://www-lsdm.research.kpn.com/~karel
Date: Sun, 01 Apr 2001 19:27:17 +0200 (MET DST)
From: Karel van Houten <K.H.C.vanHouten@research.kpn.com>
Subject: strange NFS df counters in new CVS kernel
To: linux-mips@oss.sgi.com
Message-id: <200104011727.TAA13561@sparta.research.kpn.com>
MIME-version: 1.0
X-Mailer: ELM [version 2.5 PL2]
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi all,

I just updated my indy to a recent CVS 2.4.2 kernel.
Now a 'df' on a NFS mounted partition results in
very strange counters:

# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sdb1              3960744   2670088   1089456  72% /
/dev/scd0               426764    426764         0 100% /cdrom
elwing:/local/mips     8997432 -18446744073698455312 1567854685 101% /base
#

The server is a 2.2.18 intel linux box.

Any hints?

-- 
Karel van Houten

----------------------------------------------------------
The box said "Requires Windows 95 or better."
I can't understand why it won't work on my Linux computer. 
----------------------------------------------------------
