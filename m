Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Dec 2004 07:16:28 +0000 (GMT)
Received: from fri.itea.ntnu.no ([IPv6:::ffff:129.241.7.60]:5028 "EHLO
	fri.itea.ntnu.no") by linux-mips.org with ESMTP id <S8224774AbULUHQX>;
	Tue, 21 Dec 2004 07:16:23 +0000
Received: from localhost (localhost [127.0.0.1])
	by fri.itea.ntnu.no (Postfix) with ESMTP id D407981BB;
	Tue, 21 Dec 2004 08:16:07 +0100 (CET)
Received: from invalid.ed.ntnu.no (invalid.ed.ntnu.no [129.241.179.15])
	by fri.itea.ntnu.no (Postfix) with ESMTP;
	Tue, 21 Dec 2004 08:16:07 +0100 (CET)
Received: from invalid.ed.ntnu.no (localhost.ed.ntnu.no [127.0.0.1])
	by invalid.ed.ntnu.no (8.12.9p2/8.12.9) with ESMTP id iBL7G718012458
	(version=TLSv1/SSLv3 cipher=DHE-DSS-AES256-SHA bits=256 verify=NO);
	Tue, 21 Dec 2004 08:16:07 +0100 (CET)
	(envelope-from jonah@omegav.ntnu.no)
Received: from localhost (jonah@localhost)
	by invalid.ed.ntnu.no (8.12.9p2/8.12.9/Submit) with ESMTP id iBL7G7Ax012455;
	Tue, 21 Dec 2004 08:16:07 +0100 (CET)
	(envelope-from jonah@omegav.ntnu.no)
X-Authentication-Warning: invalid.ed.ntnu.no: jonah owned process doing -bs
Date: Tue, 21 Dec 2004 08:16:07 +0100 (CET)
From: Jon Anders Haugum <jonah@omegav.ntnu.no>
X-X-Sender: jonah@invalid.ed.ntnu.no
To: "Steven J. Hill" <sjhill@realitydiluted.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [Patch] Au1550 PSC SPI irq mask fix
In-Reply-To: <41C7A73A.2000800@realitydiluted.com>
Message-ID: <20041221080552.O12280@invalid.ed.ntnu.no>
References: <20041220122328.M3626@invalid.ed.ntnu.no> <41C7A73A.2000800@realitydiluted.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Content-Scanned: with sophos and spamassassin at mailgw.ntnu.no.
Return-Path: <jonah@omegav.ntnu.no>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonah@omegav.ntnu.no
Precedence: bulk
X-list: linux-mips

On Mon, 20 Dec 2004, Steven J. Hill wrote:
> REFUSED. Your patch is out of date. Please update to latest
> CVS and try again. Next time, please also denote what kernel
> version you are applying against. Thanks.

Sorry, it's intended for the latest on linux_2_4 branch (2.4.29-pre1). 
Since 2.6/HEAD is currently outdated on this and is missing these SPI 
defines completely.


-- 
Jon Anders Haugum
