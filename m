Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 May 2008 18:28:15 +0100 (BST)
Received: from sj-iport-5.cisco.com ([171.68.10.87]:40355 "EHLO
	sj-iport-5.cisco.com") by ftp.linux-mips.org with ESMTP
	id S20035224AbYEOR2L (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 May 2008 18:28:11 +0100
X-IronPort-AV: E=Sophos;i="4.27,492,1204531200"; 
   d="scan'208";a="27253225"
Received: from sj-dkim-1.cisco.com ([171.71.179.21])
  by sj-iport-5.cisco.com with ESMTP; 15 May 2008 10:28:02 -0700
Received: from sj-core-2.cisco.com (sj-core-2.cisco.com [171.71.177.254])
	by sj-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id m4FHS2Dd019094;
	Thu, 15 May 2008 10:28:02 -0700
Received: from cliff.cisco.com (cliff.cisco.com [171.69.11.141])
	by sj-core-2.cisco.com (8.13.8/8.13.8) with ESMTP id m4FHS1Fd021458;
	Thu, 15 May 2008 17:28:01 GMT
Received: from [127.0.0.1] ([64.101.20.200]) by cliff.cisco.com (8.6.12/8.6.5) with ESMTP id RAA00168; Thu, 15 May 2008 17:27:57 GMT
Message-ID: <482C7293.4040203@cisco.com>
Date:	Thu, 15 May 2008 10:27:47 -0700
From:	David VomLehn <dvomlehn@cisco.com>
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
MIME-Version: 1.0
To:	rkota@broadcom.com
CC:	linux-mips@linux-mips.org
Subject: Re: Enabling JFFS as Root FS
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=972; t=1210872482; x=1211736482;
	c=relaxed/simple; s=sjdkim1004;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20Enabling=20JFFS=20as=20Root=20FS
	|Sender:=20;
	bh=5r6F4LuS/k5zPt3LXYtcxKQZPvg16qyCXvkHTsEr3EM=;
	b=TTSyW1CYfQ/7xxpD95whYAzZbAqGdtFc/miOOt0vMDThPEKzqpDTC6B6zJ
	8CltwM7OACxjDP4v0+FBqFvPehxJkZsA8lAKZwtoxuLm7qpAi9yeXi3sawRh
	rAzS/XukLWNzhYq1oCHWuKmSgW95p3wRClEKWP9SV0mQeuLF7fpuk=;
Authentication-Results:	sj-dkim-1; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim1004 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19287
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

> Hi Remgopal,
> 
> On Wed, May 14, 2008 at 08:58:47AM -0700, Ramgopal Kota wrote:
>> Now I want to have the rootfs (jffs) on flash. Is there any document 
>> which tells me how to do that ?
> 
> As a learning exercise you could start by reading the Filesystem Hierarchy Standard: http://www.pathname.com/fhs/. This is a great document to give you some insight into a Unix filesystem.
...

In addition, you should know that the kernel and device drivers may automatically 
create device special files in the /dev directory. The mtd layer is one of the 
components that does this. Automatic /dev file creation is normally done through 
the kernel hotplug framework. You can read more about this at kernel.org 
(http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev.html) or the Wikipedia 
article http://en.wikipedia.org/wiki/Udev.
-- 
David VomLehn, dvomlehn@cisco.com
The opinions expressed herein are likely mine, but might not be my employer's...
