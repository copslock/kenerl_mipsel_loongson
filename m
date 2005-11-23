Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2005 00:08:15 +0000 (GMT)
Received: from amdext4.amd.com ([163.181.251.6]:12758 "EHLO amdext4.amd.com")
	by ftp.linux-mips.org with ESMTP id S8134456AbVKWAHy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 23 Nov 2005 00:07:54 +0000
Received: from SAUSGW02.amd.com (sausgw02.amd.com [163.181.250.22])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id jAN0AUno025543;
	Tue, 22 Nov 2005 18:10:30 -0600
Received: from 163.181.250.1 by SAUSGW01.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Tue, 22 Nov 2005 18:10:21 -0600
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Received: from ldcmail.amd.com (ldcmail.amd.com [147.5.200.40]) by
 amdint2.amd.com (8.12.8/8.12.8/AMD) with ESMTP id jAN0ALeP026648; Tue,
 22 Nov 2005 18:10:21 -0600 (CST)
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id 61F771FF4; Tue, 22 Nov 2005
 17:10:20 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id jAN0FY5e006378; Tue, 22 Nov 2005 17:15:34
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id jAN0FYUc006377; Tue, 22 Nov 2005 17:15:34
 -0700
Date:	Tue, 22 Nov 2005 17:15:34 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"Dan Malek" <dan@embeddedalley.com>
cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: Fix board type in db1x00
Message-ID: <20051123001534.GA18119@cosmic.amd.com>
References: <20051122221526.GZ18119@cosmic.amd.com>
 <6dabaec28e238ccc915f20f51ee28327@embeddedalley.com>
MIME-Version: 1.0
In-Reply-To: <6dabaec28e238ccc915f20f51ee28327@embeddedalley.com>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F9D6CE72EC608102-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9543
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

On 22/11/05 17:31 -0500, Dan Malek wrote:
> 
> On Nov 22, 2005, at 5:15 PM, Jordan Crouse wrote:
> 
> >+	/* Set the platform # */
> >+#if	defined (CONFIG_MIPS_DB1550)
> >+	mips_machtype = MACH_DB1550;
> >+#elif	defined (CONFIG_MIPS_DB1500)
> >+	mips_machtype = MACH_DB1500;
> >+#elif	defined (CONFIG_MIPS_DB1100)
> >+	mips_machtype = MACH_DB1100;
> >+#else
> >+	mips_machtype = MACH_DB1000;
> >+#endif
> 
> Can't we just do something like
> 	#define MACH_ALCHEMY_TYPE  xxxxx
> 
> in the include files and not have this mess in the
> actual code?  Then, all we have to do here is:
> 
> 	mips_machtype = MACH_ALCHEMY_TYPE;

The problem with db1x00 in particular is that its sort of a 
catch all for all the Alchemy boards that don't have a proper home
of their own, so there really isn't a DB1000/DB1100/DB1500/DB1550 
header file.  That means either the mess goes in here or it goes
in asm-mips/mach-db1x00/db1x00.h, and I think I rather prefer it to
be in the .c file, just so one doesn't have to chase down the 
MACH_ALCHEMY_TYPE define. 

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>
