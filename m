Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2004 19:05:08 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:22525 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8224914AbUASTFI>;
	Mon, 19 Jan 2004 19:05:08 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id i0JJ57C16395;
	Mon, 19 Jan 2004 11:05:07 -0800
Date: Mon, 19 Jan 2004 11:05:06 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [ralf@linux-mips.org: CVS Update@-mips.org: linux]
Message-ID: <20040119110506.C14131@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4044
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


This check-in seems to break malta build.

arch/mips/mips-boards/malta/malta_int.c: In function `mips_pcibios_iack':
arch/mips/mips-boards/malta/malta_int.c:63: error: `MIPS_REVISION_CORID_CORE_FPGA2' undeclared (first use in this function)
arch/mips/mips-boards/malta/malta_int.c:63: error: (Each undeclared identifier is reported only once
...

Jun

----- Forwarded message from ralf@linux-mips.org -----

X-Sieve: CMU Sieve 2.2
Delivered-To: jsun@mvista.com
From: ralf@linux-mips.org
To: linux-cvs@linux-mips.org
Subject: CVS Update@-mips.org: linux 
Date: Mon, 19 Jan 2004 16:47:25 +0000
X-archive-position: 3587
X-ecartis-version: Ecartis v1.0.0
Errors-to: linux-cvs-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
Reply-to: linux-mips@linux-mips.org
X-list: linux-cvs
X-Spam-Status: No, hits=-1.1 required=5.0
	tests=AWL,BAYES_30,NO_REAL_NAME
	version=2.55
X-Spam-Level: 
X-Spam-Checker-Version: SpamAssassin 2.55 (1.174.2.19-2003-05-19-exp)


CVSROOT:	/home/cvs
Module name:	linux
Changes by:	ralf@ftp.linux-mips.org	04/01/19 16:47:25

Modified files:
	arch/mips/mips-boards/malta: malta_int.c malta_setup.c 

Log message:
	More Malta updates.



----- End forwarded message -----
