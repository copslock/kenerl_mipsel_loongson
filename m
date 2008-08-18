Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Aug 2008 22:17:02 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19750 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S28579416AbYHRVQ4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 18 Aug 2008 22:16:56 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B48a9e6c20000>; Mon, 18 Aug 2008 17:16:50 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 18 Aug 2008 14:16:47 -0700
Received: from [192.168.162.80] ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 18 Aug 2008 14:16:47 -0700
Message-ID: <48A9E6DA.8030208@caviumnetworks.com>
Date:	Mon, 18 Aug 2008 14:17:14 -0700
From:	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
User-Agent: Mozilla-Thunderbird 2.0.0.14 (X11/20080509)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [PATCH 0/2] Initial support for OCTEON
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Aug 2008 21:16:47.0763 (UTC) FILETIME=[B9423630:01C90177]
Return-Path: <Tomaso.Paoletti@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20243
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tpaoletti@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Hi all

This is a first (trivial) set of patches to pave the way for support of 
OCTEON processors in the kernel.

The set adds:
- Detection of OCTEON CPU variants in cpu_probe_cavium()
- Processor ID (PrID) constants
- Workaround (WAR) include file

Please consider for inclusion.
Thanks

   Tomaso Paoletti
