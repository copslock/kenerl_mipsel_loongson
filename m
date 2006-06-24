Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jun 2006 23:55:01 +0100 (BST)
Received: from outbound-res.frontbridge.com ([63.161.60.49]:49820 "EHLO
	outbound1-res-R.bigfish.com") by ftp.linux-mips.org with ESMTP
	id S8133719AbWFXWyu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 24 Jun 2006 23:54:50 +0100
Received: from outbound1-res.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound1-res-R.bigfish.com (Postfix) with ESMTP id 5F7E273439F;
	Sat, 24 Jun 2006 22:54:43 +0000 (UTC)
Received: from mail41-res-R.bigfish.com (unknown [172.18.16.1])
	by outbound1-res.bigfish.com (Postfix) with ESMTP id 576C173439D;
	Sat, 24 Jun 2006 22:54:43 +0000 (UTC)
Received: from mail41-res.bigfish.com (localhost.localdomain [127.0.0.1])
	by mail41-res-R.bigfish.com (Postfix) with ESMTP id 4C036B92F4B;
	Sat, 24 Jun 2006 22:54:43 +0000 (UTC)
X-BigFish: V
Received: by mail41-res (MessageSwitch) id 1151189683219473_17845; Sat, 24 Jun 2006 22:54:43 +0000 (UCT)
Received: from amdext4.amd.com (amdext4.amd.com [163.181.251.6])
	by mail41-res.bigfish.com (Postfix) with ESMTP id 1CB06B92CFF;
	Sat, 24 Jun 2006 22:54:42 +0000 (UTC)
Received: from SAUSGW01.amd.com (sausgw01.amd.com [163.181.250.21])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k5OLt8fW004478;
	Sat, 24 Jun 2006 16:55:23 -0500
Received: from 163.181.22.101 by SAUSGW01.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Sat, 24 Jun 2006 17:54:30 -0500
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Received: from ldcmail.amd.com ([147.5.200.40]) by sausexbh1.amd.com
 with Microsoft SMTPSVC(6.0.3790.2499); Sat, 24 Jun 2006 17:54:30 -0500
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id 6077F2028; Sat, 24 Jun 2006
 16:54:30 -0600 (MDT)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k5ON02wG008370; Sat, 24 Jun 2006 17:00:02
 -0600
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k5ON02Jj008369; Sat, 24 Jun 2006 17:00:02
 -0600
Date:	Sat, 24 Jun 2006 17:00:02 -0600
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"Daniel Mack" <daniel@caiaq.de>
cc:	linux-mips@linux-mips.org
Subject: Re: Au1200 SD/MMC again
Message-ID: <20060624230002.GA8277@cosmic.amd.com>
References: <4C89D389-49A7-4233-BD55-0315AD423274@caiaq.de>
MIME-Version: 1.0
In-Reply-To: <4C89D389-49A7-4233-BD55-0315AD423274@caiaq.de>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 24 Jun 2006 22:54:31.0145 (UTC)
 FILETIME=[276BCD90:01C697E1]
X-WSS-ID: 68831D2C40W13781164-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

On 24/06/06 16:02 +0200, Daniel Mack wrote:
> Hi there,
> 
> is there any progress on the work of SD/MMC support for Au1200?
> I followed the thread at
> 
> 	http://www.linux-mips.org/archives/linux-mips/2006-05/msg00007.html
> 
> and wondered whether anyone silently got it to work since then.
> On my board here, I have the very same effects.

Make sure you try different cards - I have been unable to recreate this
problem with the cards I have laying around the office.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>
