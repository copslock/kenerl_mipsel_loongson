Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2008 18:14:50 +0100 (BST)
Received: from sj-iport-3.cisco.com ([171.71.176.72]:36656 "EHLO
	sj-iport-3.cisco.com") by ftp.linux-mips.org with ESMTP
	id S20024551AbYELROr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 May 2008 18:14:47 +0100
Received: from sj-dkim-4.cisco.com ([171.71.179.196])
  by sj-iport-3.cisco.com with ESMTP; 12 May 2008 10:14:37 -0700
Received: from sj-core-2.cisco.com (sj-core-2.cisco.com [171.71.177.254])
	by sj-dkim-4.cisco.com (8.12.11/8.12.11) with ESMTP id m4CHEZXw027073;
	Mon, 12 May 2008 10:14:35 -0700
Received: from cliff.cisco.com (cliff.cisco.com [171.69.11.141])
	by sj-core-2.cisco.com (8.13.8/8.13.8) with ESMTP id m4CHEZmw027962;
	Mon, 12 May 2008 17:14:35 GMT
Received: from [127.0.0.1] ([64.101.20.200]) by cliff.cisco.com (8.6.12/8.6.5) with ESMTP id RAA13188; Mon, 12 May 2008 17:14:34 GMT
Message-ID: <48287AEC.6090300@cisco.com>
Date:	Mon, 12 May 2008 10:14:20 -0700
From:	David VomLehn <dvomlehn@cisco.com>
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
MIME-Version: 1.0
To:	"Ralf Baechle [ralf"@linux-mips.org]
CC:	linux-mips@linux-mips.org
Subject: Re: [RFC] [PATCH 1/1] [MIPS] Advanced Kernel Stack Backtrace
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=549; t=1210612475; x=1211476475;
	c=relaxed/simple; s=sjdkim4002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20[RFC]=20[PATCH=201/1]=20[MIPS]=20Advanc
	ed=20Kernel=20Stack=20Backtrace
	|Sender:=20;
	bh=8OiEY+e8tXIW4lt0qnwUg2gK9fVczFbQ8M26giiSO9Y=;
	b=fJmG+y3nMRPkoNPb81wFk9u+LXakFjcrn4rGXvaxKNj+8IJyqmbhr4M5k1
	wxD3qQGdPNRn12ftiDWIlJAM97QxEsuDz9EGAzhJJpdET8LFXc70Vi6HAeLb
	fT+ErOHp7L;
Authentication-Results:	sj-dkim-4; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim4002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

> On Wed, May 07, 2008 at 04:49:53PM -0700, David VomLehn wrote:
> 
>> This patch contains the kernel stack backtrace code we've been running 
>> for about a year on our MIPS-based settop box. ...

>  o Use ARRAY_SIZE() from <linux/kernel.h> instead of numberof.

Oops, missed this one in the port from 2.6.14 to 2.6.24.

>  o Please run the patch through scripts/checkpatch.pl and fix the resulting
>    errors.

Will do.

>  o Your patch got linewrapped by your mail client.

Ouch. I'll fix that next time.

>   Ralf

Thanks!
