Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Dec 2005 15:07:34 +0000 (GMT)
Received: from amdext3.amd.com ([139.95.251.6]:12012 "EHLO amdext3.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133659AbVLEPG0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 5 Dec 2005 15:06:26 +0000
Received: from SSVLGW02.amd.com (ssvlgw02.amd.com [139.95.250.170])
	by amdext3.amd.com (8.12.11/8.12.11/AMD) with ESMTP id jB5F5vxY018804;
	Mon, 5 Dec 2005 07:05:57 -0800
Received: from 139.95.250.1 by SSVLGW01.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Mon, 05 Dec 2005 07:04:48 -0800
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
Received: from ldcmail.amd.com (ldcmail.amd.com [147.5.200.40]) by
 amdint.amd.com (8.12.8/8.12.8/AMD) with ESMTP id jB5F4hQe007486; Mon, 5
 Dec 2005 07:04:43 -0800 (PST)
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id 5EFC02026; Mon, 5 Dec 2005
 08:04:43 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id jB5FDEtV014945; Mon, 5 Dec 2005 08:13:14
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id jB5FDE0E014944; Mon, 5 Dec 2005 08:13:14 -0700
Date:	Mon, 5 Dec 2005 08:13:14 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"Komal Shah" <komal_shah802003@yahoo.com>
cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: ALCHEMY: SPI driver for Au1200
Message-ID: <20051205151314.GR28227@cosmic.amd.com>
References: <20051202190223.GG28227@cosmic.amd.com>
 <20051205114233.54232.qmail@web32903.mail.mud.yahoo.com>
MIME-Version: 1.0
In-Reply-To: <20051205114233.54232.qmail@web32903.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F8A889A1K82504283-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9602
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

On 05/12/05 03:42 -0800, Komal Shah wrote:
> --- Jordan Crouse <jordan.crouse@amd.com> wrote:
> 
> > A SPI driver for the Au1200 processor.  Sending now so it 
> > can be queued for the post 2.6.15 rush.
> 
> Good. As there is long discussion going on which SPI framework to
> accept in mainline, I would suggest you to implement the same master
> controller and protocol driver using either David Brownell's framework
> (right now in 2.6.15-rc3-mm1) or Dmitry/Wool framework.

Since the issue is very much in doubt, I would prefer to wait until a winner
has emerged before rewriting the driver again.  If the argument resolves
itself before 2.6.16, then all is good.  But if its going to drag out another
6 months, then I would prefer to have this in the mips tree at least, so that
its available to folks who need it.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>
