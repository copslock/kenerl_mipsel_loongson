Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2009 19:28:50 +0100 (BST)
Received: from sj-iport-1.cisco.com ([171.71.176.70]:23027 "EHLO
	sj-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20022123AbZEFS2o (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 May 2009 19:28:44 +0100
X-IronPort-AV: E=Sophos;i="4.40,303,1238976000"; 
   d="scan'208";a="181799443"
Received: from sj-dkim-3.cisco.com ([171.71.179.195])
  by sj-iport-1.cisco.com with ESMTP; 06 May 2009 18:28:37 +0000
Received: from sj-core-2.cisco.com (sj-core-2.cisco.com [171.71.177.254])
	by sj-dkim-3.cisco.com (8.12.11/8.12.11) with ESMTP id n46ISba1004978;
	Wed, 6 May 2009 11:28:37 -0700
Received: from cuplxvomd02.corp.sa.net ([64.101.20.155])
	by sj-core-2.cisco.com (8.13.8/8.13.8) with ESMTP id n46ISbFF014371;
	Wed, 6 May 2009 18:28:37 GMT
Date:	Wed, 6 May 2009 11:28:37 -0700
From:	David VomLehn <dvomlehn@cisco.com>
To:	Jon Fraser <jfraser@broadcom.com>
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/3] mips:powertv: Make kernel command line size
	configurable (resend)
Message-ID: <20090506182837.GB14025@cuplxvomd02.corp.sa.net>
References: <20090504225719.GA22417@cuplxvomd02.corp.sa.net> <20090506163518.GA19624@linux-mips.org> <1241628240.10498.4.camel@chaos.ne.broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1241628240.10498.4.camel@chaos.ne.broadcom.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=693; t=1241634517; x=1242498517;
	c=relaxed/simple; s=sjdkim3002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20[PATCH=202/3]=20mips=3Apowertv=3A=20Mak
	e=20kernel=20command=20line=20size=0A=09configurable=20(rese
	nd)
	|Sender:=20;
	bh=519UXxPYcPmJjjixdzLSdGWh51/lCBSgNHe9r9WS2XU=;
	b=hCW6vmxOOPN+DLx/zYF03eaHMwuPFGv5eE4O+/Hzz6ufzAiX536NQcfAox
	Lix5dGumO5GgJKutyJnoc79+z8fva/68bBDb3fBdj8+Y/P39QI2T38+M5iOm
	eXcSSLkVe4;
Authentication-Results:	sj-dkim-3; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim3002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Wed, May 06, 2009 at 12:44:00PM -0400, Jon Fraser wrote:
> David,
> 
> We found huge command lines to be awkward.  In our platform support
> code, we can pass environment variables from our bootstrap (CFE) to the
> kernel.  Would something like this work for you?

I agree that large command lines are awkward. Environment variables are
the standard Linux way to pass the bulk of what we pass on the command line.
Unfortunately, the kernel team does not own the bootloader and consideration
for making the bootloader/kernel interface look like other platforms does
not appear to have a high priority. So, I'm stuck with using the command
line for everything.

> Jon

David
