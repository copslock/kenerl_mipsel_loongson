Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 15:00:42 +0000 (GMT)
Received: from amdext4.amd.com ([163.181.251.6]:37017 "EHLO amdext4.amd.com")
	by ftp.linux-mips.org with ESMTP id S3458585AbWAWPAV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Jan 2006 15:00:21 +0000
Received: from SAUSGW01.amd.com (sausgw01.amd.com [163.181.250.21])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k0NF4OB5019466;
	Mon, 23 Jan 2006 09:04:28 -0600
Received: from 163.181.250.1 by SAUSGW02.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Mon, 23 Jan 2006 09:04:16 -0600
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Received: from ldcmail.amd.com (ldcmail.amd.com [147.5.200.40]) by
 amdint2.amd.com (8.12.8/8.12.8/AMD) with ESMTP id k0NF4Gh5006693; Mon,
 23 Jan 2006 09:04:16 -0600 (CST)
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id 1825E2028; Mon, 23 Jan 2006
 08:04:16 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k0NF5IWs004507; Mon, 23 Jan 2006 08:05:18
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k0NF5HRr004506; Mon, 23 Jan 2006 08:05:17
 -0700
Date:	Mon, 23 Jan 2006 08:05:17 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"David Brownell" <david-b@pacbell.net>
cc:	linux-usb-devel@lists.sourceforge.net, linux-mips@linux-mips.org,
	thomas.dahlmann@amd.com
Subject: Re: EHCI support for the AU1200
Message-ID: <20060123150517.GD4371@cosmic.amd.com>
References: <20060113183038.GK8925@cosmic.amd.com>
 <200601201736.47548.david-b@pacbell.net>
MIME-Version: 1.0
In-Reply-To: <200601201736.47548.david-b@pacbell.net>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6FCA2FFA0BO194144-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10059
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

On 20/01/06 17:36 -0800, David Brownell wrote:
> On Friday 13 January 2006 10:30 am, Jordan Crouse wrote:
> > ALCHEMY: ?Add EHCI support for AU1200
> 
> Unfortunately it doesn't apply to my current tree, and I see that
> you were reverting some of the updates in current kernel GIT ...

Doh - reverting changes is wicked bad - I must have screwed up the merge
somewhere along the line.

> Please let me know if the updated version I'm posting does not
> behave for you.

Will do.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>
