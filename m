Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Apr 2008 23:58:06 +0200 (CEST)
Received: from sj-iport-1.cisco.com ([171.71.176.70]:28993 "EHLO
	sj-iport-1.cisco.com") by lappi.linux-mips.net with ESMTP
	id S525971AbYDBV6B (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 2 Apr 2008 23:58:01 +0200
Received: from sj-dkim-1.cisco.com ([171.71.179.21])
  by sj-iport-1.cisco.com with ESMTP; 02 Apr 2008 14:56:58 -0700
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by sj-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id m32Luwg2013460;
	Wed, 2 Apr 2008 14:56:58 -0700
Received: from cliff.cisco.com (cliff.cisco.com [171.69.11.141])
	by sj-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id m32LuwTf020080;
	Wed, 2 Apr 2008 21:56:58 GMT
Received: from [127.0.0.1] ([64.100.150.211]) by cliff.cisco.com (8.6.12/8.6.5) with ESMTP id VAA16875; Wed, 2 Apr 2008 21:56:52 GMT
Message-ID: <47F4011F.9020604@cisco.com>
Date:	Wed, 02 Apr 2008 14:56:47 -0700
From:	David VomLehn <dvomlehn@cisco.com>
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
MIME-Version: 1.0
To:	"Jon Fraser [jfraser"@broadcom.com], linux-mips@linux-mips.org
Illegal-Object:	Syntax error in To: address found on lappi.linux-mips.net:
	To:	"Jon Fraser [jfraser"@broadcom.com]
							  ^-missing end of address
Subject: Re: [PATCH 2.6.24][MIPS]Work in progress: fix HIGHMEM-enabled dcache
 flushing on 32-bit processor
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=1118; t=1207173418; x=1208037418;
	c=relaxed/simple; s=sjdkim1004;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20[PATCH=202.6.24][MIPS]Work=20in=20progr
	ess=3A=20fix=20HIGHMEM-enabled=20dcache=0A=20flushing=20on=2
	032-bit=20processor
	|Sender:=20;
	bh=uOYvlErAfqKD8lrMpRH3pKnur3snz1z8iQ1zzvUcals=;
	b=LY4psVsAnXhwZ5irV2eOvLCprFnXsorilOAPUJqng7iRlw8wZkyqGzNdC2
	EClFNI7A/vLQk111JTCcU9cBEjllmQa8mmYZiu4HEct1bdzU35/4YmS19YnO
	6cZ5+43yqZaB6iCAZbwD2XTEwHKEHqWcPP7q3FX9zhsH46KktHxhw=;
Authentication-Results:	sj-dkim-1; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim1004 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18782
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

> Did this fix your NFS problem?
> 
> I'm working on discontiguous memory platforms as well.
> 
> Jon Fraser
> 
> On Wed, 2008-03-12 at 19:31 -0700, David VomLehn wrote:
>> This patch is a work in progress, per Ralf's suggestion from last 
>> week. It is intended to fix dcache flushing issues when using HIGHMEM 
>> support. We get much better results with this patch applied, but I 
>> would not characterize our 2.6.24 port as stable, yet, so there may be other HIGHMEM-related issues.

Yes, we are able to boot using NFS with this patch. There are some other minor 
changes that appear necessary for correct cache flushing but which don't seem to 
be causing any actual issues. (Cache stuff just works that way--you don't know 
you've got a problem until you get into some obscure corner case). I'll post 
these as soon as I can get to it.

I can't say whether these are all the changes required for high memory support, 
but we sure get a lot farther when we use them...
-- 
David VomLehn, dvomlehn@cisco.com
The opinions expressed herein are likely mine, but might not be my employer's...
