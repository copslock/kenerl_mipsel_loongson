Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 May 2008 23:43:14 +0100 (BST)
Received: from dns0.mips.com ([63.167.95.198]:56304 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S20031652AbYEVWnM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 May 2008 23:43:12 +0100
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id m4MMftMN016144
	for <linux-mips@linux-mips.org>; Thu, 22 May 2008 15:41:56 -0700 (PDT)
Received: from [192.168.236.12] (cthulhu [192.168.236.12])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id m4MMgblJ009887
	for <linux-mips@linux-mips.org>; Thu, 22 May 2008 15:42:53 -0700 (PDT)
Message-ID: <4835F6DD.4090409@mips.com>
Date:	Fri, 23 May 2008 00:42:37 +0200
From:	"Kevin D. Kissell" <kevink@mips.com>
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
MIME-Version: 1.0
To:	Linux MIPS Org <linux-mips@linux-mips.org>
Subject: Still More MIPS 34K APRP Patches
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19339
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

This message will be followed by a couple more patches
to the APRP support for the 34K.  The first fixes a few
bugs (minor memory leak, some ELF loader failure cases)
and reorganizes functions so as to allow for more than
just the RTLX service for run-time support. This assumes
that the 0001-Rewrite-of-APRP-VPE-ELF-Loader.patch patch
that I sent out on May 3 has already been applied.

The second patch adds a new driver to drivers/net,
along with some platform support in
arch/mips/mips-boards/generic.  I call this a M3P
(pronounced "mehp") driver, for MIPS Memeory Message
Passing.  It creates a ethernet-compatible networking
interface between Linux and the RP.  With a little more
work, it could also be used for message passing between
Linux and other OSes in a software-heterogeneous SMP
environment.  Dropping it into drivers/net will make
it harder to propagate, but the more narrowly specialized
mipsnet driver is already there, and in principle the
driver module could have the remaining MIPSisms filed
off and become useful in heterogeneous multiprocessors.

	Regards,

	Kevin K.
