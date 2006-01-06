Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2006 17:40:29 +0000 (GMT)
Received: from amdext4.amd.com ([163.181.251.6]:7387 "EHLO amdext4.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133835AbWAFRkH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Jan 2006 17:40:07 +0000
Received: from SAUSGW01.amd.com (sausgw01.amd.com [163.181.250.21])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k06HgGth015227;
	Fri, 6 Jan 2006 11:42:31 -0600
Received: from 163.181.250.1 by SAUSGW02.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Fri, 06 Jan 2006 11:42:20 -0600
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Received: from ldcmail.amd.com (ldcmail.amd.com [147.5.200.40]) by
 amdint2.amd.com (8.12.8/8.12.8/AMD) with ESMTP id k06HgKh5002423; Fri,
 6 Jan 2006 11:42:20 -0600 (CST)
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id D70262028; Fri, 6 Jan 2006
 10:42:19 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k06Ho9cp016715; Fri, 6 Jan 2006 10:50:09
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k06Ho8Zs016714; Fri, 6 Jan 2006 10:50:08 -0700
Date:	Fri, 6 Jan 2006 10:50:08 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"Pierre Ossman" <drzeus@drzeus.cx>
cc:	linux-mips@linux-mips.org, rmk+lkml@arm.linux.org.uk
Subject: Re: Force MMC/SD to 512 byte block sizes
Message-ID: <20060106175008.GC15617@cosmic.amd.com>
References: <20060106164406.GA15617@cosmic.amd.com>
 <43BEA317.8010203@drzeus.cx>
MIME-Version: 1.0
In-Reply-To: <43BEA317.8010203@drzeus.cx>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6FA074760T02056895-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9795
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

On 06/01/06 18:04 +0100, Pierre Ossman wrote:
> This will not work. Some cards do not accept block sizes larger than the
> one they've specified.
>
> This issue has been discussed on the arm kernel ml and Russell has begun
> producing patches to resolve the issue.

Which just goes to prove that if I'm going to do SD development, I need
to start watching the right mailing lists.

I'll defer to the previous work on this - I do know that this has
worked for pretty much every 2G and 4G card we could get our hands on,
so that was enough for me to throw it at you guys and see what sticks.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>
