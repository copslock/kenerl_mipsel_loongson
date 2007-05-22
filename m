Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 May 2007 12:39:40 +0100 (BST)
Received: from dmz.mips-uk.com ([194.74.144.194]:51214 "EHLO dmz.mips-uk.com")
	by ftp.linux-mips.org with ESMTP id S20022564AbXEVLji (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 22 May 2007 12:39:38 +0100
Received: from internal-mx1 ([192.168.192.240] helo=ukservices1.mips.com)
	by dmz.mips-uk.com with esmtp (Exim 3.35 #1 (Debian))
	id 1HqSiG-00069S-00; Tue, 22 May 2007 12:39:36 +0100
Received: from hendon.mips.com ([192.168.192.184])
	by ukservices1.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1HqSi1-0001RX-00; Tue, 22 May 2007 12:39:21 +0100
Message-ID: <4652D669.6030409@mips.com>
Date:	Tue, 22 May 2007 12:39:21 +0100
From:	Chris Dearman <chris@mips.com>
Organization: MIPS Technologies (UK)
User-Agent: Icedove 1.5.0.8 (X11/20061208)
MIME-Version: 1.0
To:	Martin Michlmayr <tbm@cyrius.com>
CC:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: malta broken on mainline
References: <20070522102538.GY18323@deprecation.cyrius.com>
In-Reply-To: <20070522102538.GY18323@deprecation.cyrius.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MIPS-Technologies-UK-MailScanner: Found to be clean
X-MIPS-Technologies-UK-MailScanner-From: chris@mips.com
Return-Path: <chris@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@mips.com
Precedence: bulk
X-list: linux-mips

Martin Michlmayr wrote:
> malta is broken on mainline.  lmo contain a patch "[MIPS] SOCitSC support"
> (which looks okay but mainline has a different change, namely "[MIPS] MT:
> Reenable EIC support and add support for SOCit SC" which uses some defines
> without updating the header file.

   There were 2 separate patches. Unfortunately they got applied in the 
wrong order several days apart. I suppose that in the intervening period 
the changes got pushed to kernel.org.
See 
http://www.linux-mips.org/git?p=linux.git;a=commit;h=d1d5c41425124d5fa4a1ce6a59e13c7da48279c6
for the other patch

Chris

-- 
Chris Dearman          7200 Cambridge Research Park     +44 1223 203108
MIPS Technologies (UK) Waterbeach, Cambs CB25 9TL  fax  +44 1223 203181
