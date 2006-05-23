Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 May 2006 17:39:47 +0200 (CEST)
Received: from amdext3.amd.com ([139.95.251.6]:57571 "EHLO amdext3.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133923AbWEWPjf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 23 May 2006 17:39:35 +0200
Received: from SSVLGW02.amd.com (ssvlgw02.amd.com [139.95.250.170])
	by amdext3.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k4NFepSI024059;
	Tue, 23 May 2006 08:40:52 -0700
Received: from 139.95.53.182 by SSVLGW01.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Tue, 23 May 2006 08:02:47 -0700
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
Received: from ldcmail.amd.com ([147.5.200.40]) by SSVLEXBH1.amd.com
 with Microsoft SMTPSVC(6.0.3790.2499); Tue, 23 May 2006 08:02:48 -0700
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id 49D602028; Tue, 23 May 2006
 09:01:20 -0600 (MDT)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k4NFBDPE000520; Tue, 23 May 2006 09:11:13
 -0600
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k4NFBD62000519; Tue, 23 May 2006 09:11:13
 -0600
Date:	Tue, 23 May 2006 09:11:13 -0600
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"Rodolfo Giometti" <giometti@linux.it>
cc:	linux-mips@linux-mips.org
Subject: Re: USB sleep & mount
Message-ID: <20060523151113.GK18042@cosmic.amd.com>
References: <20060523132418.GA28124@enneenne.com>
MIME-Version: 1.0
In-Reply-To: <20060523132418.GA28124@enneenne.com>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 23 May 2006 15:02:48.0299 (UTC)
 FILETIME=[F4643BB0:01C67E79]
X-WSS-ID: 686DFB9D2T42304697-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

On 23/05/06 15:24 +0200, Rodolfo Giometti wrote:
> Hello,
> 
> When I put the system to sleep and then it wakes up everything works
> well _if_ the USB key is not mounted before the sleep. For instance,
> if I mount partition "/dev/sda1" (first USB key partition) and then go
> to sleep, at wake up the system forgets device "/dev/sda" and
> registers a new device "/dev/sdb" so, obviously, the filesystem
> previously mounted is not accessible anymore.

Thats exactly right - USB sleep is a very delicate and broken procedure.
Basically, the controller seems to be giving up and re-enumerating 
everything.

> My question is: is that correct since the userland, before going to
> sleep, should umount all external filesystems or it's a bug? :)

The userland technically *shouldn't* have to unmount the filesystems, but
its the safest option we have - between enumeration issues, and the age 
old problem of unplugging the external device while in sleep - its just
better to unmount the device before heading for nap time (or mount the
thing with '-a' so data isn't lost).

Is that ideal?  Of course not - but welcome to the wonderful world of
USB in Linux.

Jordan
