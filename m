Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Feb 2003 22:15:37 +0000 (GMT)
Received: from 66-122-194-201.ded.pacbell.net ([IPv6:::ffff:66.122.194.201]:130
	"EHLO localhost.localdomain") by linux-mips.org with ESMTP
	id <S8225197AbTBRWPh>; Tue, 18 Feb 2003 22:15:37 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.12.5/8.12.5) with ESMTP id h1IMFWaq001540
	for <linux-mips@linux-mips.org>; Tue, 18 Feb 2003 14:15:32 -0800
Received: (from lindahl@localhost)
	by localhost.localdomain (8.12.5/8.12.5/Submit) id h1IMFWig001538
	for linux-mips@linux-mips.org; Tue, 18 Feb 2003 14:15:32 -0800
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Tue, 18 Feb 2003 14:15:32 -0800
From: Greg Lindahl <lindahl@keyresearch.com>
To: linux-mips@linux-mips.org
Subject: Re: Exec from Memory
Message-ID: <20030218221531.GA1526@greglaptop.internal.keyresearch.com>
Mail-Followup-To: linux-mips@linux-mips.org
References: <NDBBKEAAOJECIDBJKLIHCEOGCHAA.turcotte@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NDBBKEAAOJECIDBJKLIHCEOGCHAA.turcotte@broadcom.com>
User-Agent: Mutt/1.4i
Return-Path: <lindahl@keyresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lindahl@keyresearch.com
Precedence: bulk
X-list: linux-mips

On Tue, Feb 18, 2003 at 05:08:51PM -0500, Maurice Turcotte wrote:

> Suppose there is no file system available, since there is no disk.

You lost me, there. Linux has filesystems like /dev, /proc, and for
your current dilemma, it has some "ramdisk" filesystems which are
careful not to not make a duplicate copy of a file when you mmap it.

So you can execute code right out of that filesystem without much
extra overhead.

If you don't want to keep a copy of the entire program in RAM (some of
it might not be executed at all or only once), then NFS mount a
remotely filesystem and run it from there.

-- greg
