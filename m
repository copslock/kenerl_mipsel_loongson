Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 May 2004 13:55:28 +0100 (BST)
Received: from [IPv6:::ffff:145.253.187.130] ([IPv6:::ffff:145.253.187.130]:1286
	"EHLO proxy.baslerweb.com") by linux-mips.org with ESMTP
	id <S8225990AbUENMz1>; Fri, 14 May 2004 13:55:27 +0100
Received: from comm1.baslerweb.com ([172.16.13.2]) by proxy.baslerweb.com
          (Post.Office MTA v3.5.3 release 223 ID# 0-0U10L2S100V35)
          with ESMTP id com; Fri, 14 May 2004 14:54:59 +0200
Received: from [172.16.13.253] (localhost [172.16.13.253]) by comm1.baslerweb.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id JHN38ZDG; Fri, 14 May 2004 14:55:24 +0200
From: Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To: linux-mips@linux-mips.org
Subject: Re: titan ethernet driver
Date: Fri, 14 May 2004 14:58:01 +0200
User-Agent: KMail/1.6.1
Cc: Manish Lachwani <Manish_Lachwani@pmc-sierra.com>,
	Ralf Baechle <ralf@linux-mips.org>
References: <9DFF23E1E33391449FDC324526D1F259022536FB@sjc1exm02.pmc_nt.nt.pmc-sierra.bc.ca>
In-Reply-To: <9DFF23E1E33391449FDC324526D1F259022536FB@sjc1exm02.pmc_nt.nt.pmc-sierra.bc.ca>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405141458.01277.thomas.koeller@baslerweb.com>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

Manish Lachwani wrote:

> Are you referring to 2.4 or 2.6? You have already downloaded 2.4.26 and
> 2.4.21 versions (with source code) from the PMC-Sierra ftp site. These are
> fully functional and several customers are using it from the last 3-4
> months now. The patches for 2.4 have been sent out to Ralf.

This is all about 2.6. From the CVS change logs I see that Ralf is
applying 2.6-specific changes to the driver. Now that there is no
working support for 2.6 on the yosemite, the only platform I know of
that has this H/W, I just wondered how these changes are tested.

tk
-- 
--------------------------------------------------

Thomas Koeller, Software Development

Basler Vision Technologies
An der Strusbek 60-62
22926 Ahrensburg
Germany

Tel +49 (4102) 463-390
Fax +49 (4102) 463-46390

mailto:thomas.koeller@baslerweb.com
http://www.baslerweb.com

==============================
