Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Feb 2007 14:49:41 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:54479 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20039134AbXB0Otg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Feb 2007 14:49:36 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 9BAF664D3D; Tue, 27 Feb 2007 14:48:58 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 2E00C54D50; Tue, 27 Feb 2007 15:48:18 +0100 (CET)
Date:	Tue, 27 Feb 2007 14:48:18 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: Creating infrastructure to allow one kernel for multiple machines
Message-ID: <20070227144818.GA25883@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14255
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

On ARM and PowerPC, you can compile one kernel that will support
multiple machines, as long as they all belong to the same group (e.g.
have a compatible CPU).  On ARM, each machine needs to register a
machine id at http://www.arm.linux.org.uk/developer/machines/ and then
the boot loader passes this value to the kernel via a register.  On
PowerPC, information about the machine can be found in OF's
device-tree.

On MIPS, you need a separate kernel for each machine, which makes it
hard for distros to support many machines.  For example, it would be
nice if you could compile one kernel for vr41xx devices since they
only differ slightly, e.g. in their PCI mappings.  I'm therefore
wondering if there are any plans to introduce a scheme on MIPS that
would allow one kernel for several machines.
-- 
Martin Michlmayr
http://www.cyrius.com/
