Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2003 01:18:47 +0100 (BST)
Received: from mail.ocs.com.au ([IPv6:::ffff:203.34.97.2]:22788 "HELO
	mail.ocs.com.au") by linux-mips.org with SMTP id <S8225271AbTFEASp>;
	Thu, 5 Jun 2003 01:18:45 +0100
Received: (qmail 31381 invoked from network); 5 Jun 2003 00:18:35 -0000
Received: from ocs3.intra.ocs.com.au (192.168.255.3)
  by mail.ocs.com.au with SMTP; 5 Jun 2003 00:18:35 -0000
Received: by ocs3.intra.ocs.com.au (Postfix, from userid 16331)
	id D2B9FD8F46; Thu,  5 Jun 2003 10:18:33 +1000 (EST)
Received: from ocs3.intra.ocs.com.au (localhost [127.0.0.1])
	by ocs3.intra.ocs.com.au (Postfix) with ESMTP id D012791336
	for <linux-mips@linux-mips.org>; Thu,  5 Jun 2003 10:18:33 +1000 (EST)
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: linux-mips@linux-mips.org
Subject: Re: [RFC] synchronized CPU count registers on SMP machines 
In-reply-to: Your message of "Wed, 04 Jun 2003 15:39:30 MST."
             <20030604153930.H19122@mvista.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 05 Jun 2003 10:18:28 +1000
Message-ID: <9636.1054772308@ocs3.intra.ocs.com.au>
Return-Path: <kaos@sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2529
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaos@sgi.com
Precedence: bulk
X-list: linux-mips

On Wed, 4 Jun 2003 15:39:30 -0700, 
Jun Sun <jsun@mvista.com> wrote:
>There are many benefits of having perfectly synchronized CPU
>count registers on SMP machines.
>
>I wonder if this is something which have been done before,
>and if this is feasible.

IA64 has to do this, arch/ia64/kernel/smpboot.c:ia64_sync_itc.  That
function is only called at boot time, but there have been discussions
about calling it regularly to resync the itc values, like NTP.  Of
course, it has no chance of working if you install cpus with different
itc frequencies.
