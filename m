Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Feb 2003 18:05:38 +0000 (GMT)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:7556
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225205AbTB0SFh>; Thu, 27 Feb 2003 18:05:37 +0000
Received: from bogon.sigxcpu.org (kons-d9bb556d.pool.mediaWays.net [217.187.85.109])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id EA7A82BC2D
	for <linux-mips@linux-mips.org>; Thu, 27 Feb 2003 19:05:20 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 199EC176DB; Thu, 27 Feb 2003 19:03:33 +0100 (CET)
Date: Thu, 27 Feb 2003 19:03:33 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@linux-mips.org
Subject: [PATCH] IP22: don't let kernel oops when eaddr is unset
Message-ID: <20030227180332.GA22166@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	linux-mips@linux-mips.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1584
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
ArcGetenvironment returns NULL if "eaddr" is unset which lets the
following str2eaddr die.
 -- Guido

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Description: sgiseeq-no-eaddr.diff
Content-Disposition: attachment; filename="sgiseeq-no-mac.diff"

Index: drivers/net/sgiseeq.c
===================================================================
RCS file: /home/cvs/linux/drivers/net/sgiseeq.c,v
retrieving revision 1.31
diff -u -u -r1.31 sgiseeq.c
--- drivers/net/sgiseeq.c	6 Nov 2001 07:56:00 -0000	1.31
+++ drivers/net/sgiseeq.c	27 Feb 2003 18:04:25 -0000
@@ -718,6 +718,10 @@
 	 * On MIPS64 it crashes for some other, yet unknown reason ...
 	 */
 	ep = ArcGetEnvironmentVariable("eaddr");
+	if (ep == NULL) {
+		printk(KERN_INFO "Seeq8003: Can't get MAC address!\n");
+		return -ENODEV;
+	}
 	str2eaddr(onboard_eth_addr, ep);
 	return sgiseeq_init(dev,
 			    (struct sgiseeq_regs *) (KSEG1ADDR(0x1fbd4000)),

--6TrnltStXW4iwmi0--
