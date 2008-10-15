Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Oct 2008 01:03:52 +0100 (BST)
Received: from sj-iport-6.cisco.com ([171.71.176.117]:2259 "EHLO
	sj-iport-6.cisco.com") by ftp.linux-mips.org with ESMTP
	id S21521528AbYJOADt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 15 Oct 2008 01:03:49 +0100
X-IronPort-AV: E=Sophos;i="4.33,411,1220227200"; 
   d="scan'208";a="175217896"
Received: from sj-dkim-3.cisco.com ([171.71.179.195])
  by sj-iport-6.cisco.com with ESMTP; 15 Oct 2008 00:03:42 +0000
Received: from sj-core-2.cisco.com (sj-core-2.cisco.com [171.71.177.254])
	by sj-dkim-3.cisco.com (8.12.11/8.12.11) with ESMTP id m9F03gLG002718;
	Tue, 14 Oct 2008 17:03:42 -0700
Received: from cliff.cisco.com (cliff.cisco.com [171.69.11.141])
	by sj-core-2.cisco.com (8.13.8/8.13.8) with ESMTP id m9F03ggs016813;
	Wed, 15 Oct 2008 00:03:42 GMT
Received: from [127.0.0.1] ([64.101.20.200]) by cliff.cisco.com (8.6.12/8.6.5) with ESMTP id AAA19632; Wed, 15 Oct 2008 00:03:41 GMT
Message-ID: <48F53357.4040708@cisco.com>
Date:	Tue, 14 Oct 2008 17:03:35 -0700
From:	David VomLehn <dvomlehn@cisco.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	David Daney <ddaney@caviumnetworks.com>
CC:	linux-mips@linux-mips.org,
	"Paoletti, Tomaso" <Tomaso.Paoletti@caviumnetworks.com>
Subject: Re: [PATCH] MIPS: Rewrite cpu_to_name so it has one statement per
 line (version 2).
References: <48F51BF7.2040906@caviumnetworks.com>
In-Reply-To: <48F51BF7.2040906@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=452; t=1224029022; x=1224893022;
	c=relaxed/simple; s=sjdkim3002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20[PATCH]=20MIPS=3A=20Rewrite=20cpu_to_na
	me=20so=20it=20has=20one=20statement=20per=0A=20line=20(vers
	ion=202).
	|Sender:=20;
	bh=qee1ulnXsvvw7/Nx8Ue05vJywOB09Eogo3buzXCqpZA=;
	b=Q9Y/GM05g/X8QluVoad8cBkM0SLZd94S2BdvVodeGnG7h3TKsY+Hhueg50
	1+KOnRJEDDbAzPVA0bUQX10753XWVXdE9BXDeNyxRMGhDVzQBRDlP8Ok1YvH
	lGy7n5fEll;
Authentication-Results:	sj-dkim-3; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim3002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20767
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> Rewrite cpu_to_name so it has one statement per line.
> 
> David VomLehn shamed me into it...
> 
> Future changes can now pass checkpatch.pl
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>

<opensource_humor level="obscure" 
a="http://www.kernel.org/pub/linux/kernel/people/jsipek/guilt/man/">

So, Jeff Sipek isn't the only one who can use guilt to create patches.

</opensource_humor>

David VomLehn
