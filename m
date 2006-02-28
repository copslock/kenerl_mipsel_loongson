Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2006 20:53:28 +0000 (GMT)
Received: from amdext4.amd.com ([163.181.251.6]:53646 "EHLO amdext4.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133623AbWB1UxR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Feb 2006 20:53:17 +0000
Received: from SAUSGW02.amd.com (sausgw02.amd.com [163.181.250.22])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k1SL0sR8028411;
	Tue, 28 Feb 2006 15:00:55 -0600
Received: from 163.181.22.101 by SAUSGW01.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Tue, 28 Feb 2006 15:00:38 -0600
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Received: from ldcmail.amd.com ([147.5.200.40]) by sausexbh1.amd.com
 with Microsoft SMTPSVC(6.0.3790.0); Tue, 28 Feb 2006 13:00:38 -0800
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id E90232028; Tue, 28 Feb 2006
 14:00:37 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k1SLA24m031395; Tue, 28 Feb 2006 14:10:02
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k1SLA23c031394; Tue, 28 Feb 2006 14:10:02
 -0700
Date:	Tue, 28 Feb 2006 14:10:02 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"Martin Michlmayr" <tbm@cyrius.com>
cc:	"Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Diff between Linus' and linux-mips git: trivial changes
Message-ID: <20060228211002.GC27822@cosmic.amd.com>
References: <20060219234318.GA16311@deprecation.cyrius.com>
 <20060219234757.GW10266@deprecation.cyrius.com>
 <20060227223401.GA7986@deprecation.cyrius.com>
MIME-Version: 1.0
In-Reply-To: <20060227223401.GA7986@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 28 Feb 2006 21:00:38.0412 (UTC)
 FILETIME=[06E07CC0:01C63CAA]
X-WSS-ID: 681A667C3103418568-02-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10680
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

> [IDE] au1xxx_ide.h: Remove redefinition of drive_list_entry
 
> The mips tree (but not mainline) contains a definition of
> drive_list_entry in include/asm-mips/mach-au1x00/au1xxx_ide.h 

Right - Bart took this a while back - not sure how it hasn't made it down
from Ralfs periodic pulls from Linus.

Jordan

--
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>
