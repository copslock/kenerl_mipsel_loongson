Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2006 17:32:46 +0000 (GMT)
Received: from amdext4.amd.com ([163.181.251.6]:21978 "EHLO amdext4.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133821AbWAFRcX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Jan 2006 17:32:23 +0000
Received: from SAUSGW02.amd.com (sausgw02.amd.com [163.181.250.22])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k06HYWIK013993;
	Fri, 6 Jan 2006 11:34:42 -0600
Received: from 163.181.250.1 by SAUSGW02.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Fri, 06 Jan 2006 11:34:35 -0600
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Received: from ldcmail.amd.com (ldcmail.amd.com [147.5.200.40]) by
 amdint2.amd.com (8.12.8/8.12.8/AMD) with ESMTP id k06HYZh5002156; Fri,
 6 Jan 2006 11:34:35 -0600 (CST)
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id EBF1B2028; Fri, 6 Jan 2006
 10:34:34 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k06HgO0T016686; Fri, 6 Jan 2006 10:42:24
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k06HgNS2016685; Fri, 6 Jan 2006 10:42:23 -0700
Date:	Fri, 6 Jan 2006 10:42:23 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"Russell King" <rmk@arm.linux.org.uk>
cc:	linux-mips@linux-mips.org, drzeus@drzeus.cx
Subject: Re: Force MMC/SD to 512 byte block sizes
Message-ID: <20060106174223.GB15617@cosmic.amd.com>
References: <20060106164406.GA15617@cosmic.amd.com>
 <20060106165930.GC16093@flint.arm.linux.org.uk>
MIME-Version: 1.0
In-Reply-To: <20060106165930.GC16093@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6FA075A10T02055239-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

On 06/01/06 16:59 +0000, Russell King wrote:
> On Fri, Jan 06, 2006 at 09:44:06AM -0700, Jordan Crouse wrote:
> > This patch is not specific to the AU1200 SD driver, but thats what
> > we used to debug and verify this, so thats why it is applied against
> > the linux-mips tree.   Pierre, I'm sending this to you too, because I thought
> > you may be interested.
> 
> NACK.  Please wait until the next round of patches get merged and then
> revalidate this.

Fair enough - I am only getting what Ralf and Linus put in their git tree -
I probably should have checked your tree before assuming the code was
current.

> It's obviously wrong in the case of cards which do not support partial
> block writes, and it does nothing to detect this (apart from violating
> their advertised capabilities.)

Ok - I can understand that - its unlikely that such cards would have a 
physical block size > 512 bytes, but its always better to be safe then sorry.
Thats a fairly straight forward fix, and I'll do it while waiting for your
code to bubble through.

Regards,
Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>
