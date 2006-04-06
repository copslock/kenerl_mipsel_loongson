Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2006 17:29:51 +0100 (BST)
Received: from amdext4.amd.com ([163.181.251.6]:22737 "EHLO amdext4.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133525AbWDFQ3m (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2006 17:29:42 +0100
Received: from SAUSGW01.amd.com (sausgw01.amd.com [163.181.250.21])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k36Gew1b006061;
	Thu, 6 Apr 2006 11:40:59 -0500
Received: from 139.95.53.182 by SAUSGW02.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Thu, 06 Apr 2006 11:40:47 -0500
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Received: from ldcmail.amd.com ([147.5.200.40]) by SSVLEXBH1.amd.com
 with Microsoft SMTPSVC(6.0.3790.0); Thu, 6 Apr 2006 09:40:45 -0700
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id BF22C2028; Thu, 6 Apr 2006
 10:40:44 -0600 (MDT)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k36HGjXD002073; Thu, 6 Apr 2006 11:16:45
 -0600
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k36HGjsJ002072; Thu, 6 Apr 2006 11:16:45 -0600
Date:	Thu, 6 Apr 2006 11:16:45 -0600
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"Rodolfo Giometti" <giometti@linux.it>
cc:	"Linux MIPS" <linux-mips@linux-mips.org>
Subject: Re: sysfs interface for Au1xxx power management
Message-ID: <20060406171645.GL22446@cosmic.amd.com>
References: <20060405221933.GN7029@enneenne.com>
MIME-Version: 1.0
In-Reply-To: <20060405221933.GN7029@enneenne.com>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 06 Apr 2006 16:40:45.0530 (UTC)
 FILETIME=[DA1443A0:01C65998]
X-WSS-ID: 682B9B053H42812326-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11053
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

On 06/04/06 00:19 +0200, Rodolfo Giometti wrote:
> Hello,
> 
> here a patch to support new sysfs interface for Au1xxx's power
> management. Now we can put the system into sleeping mode by using:
> 
>    hostname:~# echo mem > /sys/power/state 
> 
> The patch keeps also the file "/proc/sys/pm/freq" from the old
> interface.

Generally looks good, thought I just glanced it over and I didn't take
it for a test run.

>  /* Quick acpi hack. This will have to change! */
> -#define	CTL_ACPI 9999
> -#define	ACPI_S1_SLP_TYP 19
> -#define	ACPI_SLEEP 21
> +#define	CTL_ACPI	9999
> +#define	ACPI_S1_SLP_TYP	19
> +#define	ACPI_SLEEP	21

Code review comment - you have lots of minor typo fixes and whitespace
changes.  You should Keep whitespace changes to a minimum, or better yet
put then in a separate  patch.  They detract from the actual meat of your 
effort, and makes it tough to code review.

Jordan
-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>
