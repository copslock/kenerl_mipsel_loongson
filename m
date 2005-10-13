Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Oct 2005 20:32:46 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:54047 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465602AbVJMTca (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Oct 2005 20:32:30 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9DJWP8i003908
	for <linux-mips@linux-mips.org>; Thu, 13 Oct 2005 20:32:25 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9DJWPsL003907
	for linux-mips@linux-mips.org; Thu, 13 Oct 2005 20:32:25 +0100
Date:	Thu, 13 Oct 2005 20:32:25 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Tftp problems with ARC firmware
Message-ID: <20051013193225.GA3137@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9221
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

I'd like to point those who you need to use these crude workarounds:

  echo 1 > /proc/sys/net/ipv4/ip_no_pmtu_disc
  echo 4096 32767 > /proc/sys/net/ipv4/ip_local_port_range

at a new version of tftp-hpa which solves the PMTU problem by disabling it
only for the tftp client and introduces a new -R begin:end option which
allows to limit the port number range.  The changes are about to become
available in the tftp-hpa git repository at
http://www.kernel.org/pub/scm/network/tftp/tftp-hpa.git; see also
http://www.linux-mips.org/wiki/ARC#tftp-hpa.  Please send test reports to
syslinux@zytor.com and linux-mips@linux-mips.org.

  Ralf
