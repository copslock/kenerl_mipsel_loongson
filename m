Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 15:13:50 +0000 (GMT)
Received: from amdext4.amd.com ([163.181.251.6]:57272 "EHLO amdext4.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133769AbWBTPNi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Feb 2006 15:13:38 +0000
Received: from SAUSGW01.amd.com (sausgw01.amd.com [163.181.250.21])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k1KFKA6N014079;
	Mon, 20 Feb 2006 09:20:26 -0600
Received: from 163.181.22.101 by SAUSGW02.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Mon, 20 Feb 2006 09:20:19 -0600
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Received: from ldcmail.amd.com ([147.5.200.40]) by sausexbh1.amd.com
 with Microsoft SMTPSVC(6.0.3790.0); Mon, 20 Feb 2006 07:20:19 -0800
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id 04B682028; Mon, 20 Feb 2006
 08:20:18 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k1KFRYrX028827; Mon, 20 Feb 2006 08:27:35
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k1KFRYJw028826; Mon, 20 Feb 2006 08:27:34
 -0700
Date:	Mon, 20 Feb 2006 08:27:34 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"Martin Michlmayr" <tbm@cyrius.com>
cc:	linux-mips@linux-mips.org
Subject: Re: Diff between Linus' and linux-mips git: drivers!
Message-ID: <20060220152734.GM30429@cosmic.amd.com>
References: <20060219234318.GA16311@deprecation.cyrius.com>
MIME-Version: 1.0
In-Reply-To: <20060219234318.GA16311@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 20 Feb 2006 15:20:19.0381 (UTC)
 FILETIME=[28E19E50:01C63631]
X-WSS-ID: 6FE701B91VK1024672-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10569
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

On 19/02/06 23:43 +0000, Martin Michlmayr wrote:
> We should find out whether these drivers are still needed, and if so,
> send them to the appropriate sub-system maintainer.  If they're no
> longer useful, they should be removed from the linux-mips tree.

Meh - I think there's something to be said for platform specific trees.
Why bother Linus with code that 99% of the users will never compile?
That said...

 
>  drivers/video/au1200fb.c                   | 1940 +++++++++++++++++++++++++++
>  drivers/video/au1200fb.h                   |  288 ++++

Not sure why this hasn't been sent up, but it should be good to go, 
right Ralf?

>  sound/oss/au1550_i2s.c                     | 2029 ++++++++++++++++++++++++++++

I thought we agreed that this would stay in linux-mips until such time that
somebody (probably me) got annoyed enough to write an ALSA driver.

Jordan
-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>
