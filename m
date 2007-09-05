Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2007 11:49:43 +0100 (BST)
Received: from dmz.mips-uk.com ([194.74.144.194]:62220 "EHLO dmz.mips-uk.com")
	by ftp.linux-mips.org with ESMTP id S20024818AbXIEKtf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 5 Sep 2007 11:49:35 +0100
Received: from internal-mx1 ([192.168.192.240] helo=ukservices1.mips.com)
	by dmz.mips-uk.com with esmtp (Exim 3.35 #1 (Debian))
	id 1ISsRx-0006bA-00; Wed, 05 Sep 2007 11:49:33 +0100
Received: from hendon.mips.com ([192.168.192.184])
	by ukservices1.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1ISsRq-0007yX-00; Wed, 05 Sep 2007 11:49:26 +0100
Message-ID: <46DE89B6.3010709@mips.com>
Date:	Wed, 05 Sep 2007 11:49:26 +0100
From:	Chris Dearman <chris@mips.com>
Organization: MIPS Technologies
User-Agent: Icedove 1.5.0.12 (X11/20070607)
MIME-Version: 1.0
To:	yshi <yang.shi@windriver.com>
CC:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] malta4kec hang in calibrate_delay fix
References: <46DD1CD1.5040306@windriver.com>	 <20070904124444.GB23736@linux-mips.org> <1188971483.4145.17.camel@yshi.CORP>
In-Reply-To: <1188971483.4145.17.camel@yshi.CORP>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MIPS-Technologies-UK-MailScanner: Found to be clean
X-MIPS-Technologies-UK-MailScanner-From: chris@mips.com
Return-Path: <chris@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@mips.com
Precedence: bulk
X-list: linux-mips

yshi wrote:
> According MIPS32 Release 2 specification, IntCtl.IPTI bits should not be
> zero, at least 2 and it's readonly. So, is my board defective or an old
> version? Thanks.

   The IntCtl.IPTI field is initialised by some external signals going 
into the core. These signals should be driven by some wrapper code built 
into the FPGA bitfile. It sounds like you may have an old or 
misconfigured bitfile. I think the best bet is to contact MIPS support 
(support@mips.com) who can supply you with an updated bitfile if required.

Chris

-- 
Chris Dearman          7200 Cambridge Research Park     +44 1223 203108
MIPS Technologies (UK) Waterbeach, Cambs CB25 9TL  fax  +44 1223 203181
