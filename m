Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3GKNK8d013260
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 16 Apr 2002 13:23:20 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3GKNK2F013259
	for linux-mips-outgoing; Tue, 16 Apr 2002 13:23:20 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3GKNB8d013240
	for <linux-mips@oss.sgi.com>; Tue, 16 Apr 2002 13:23:11 -0700
Received: from localhost.localdomain (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.11.6/8.11.6) with ESMTP id g3GKKIM03538
	for <linux-mips@oss.sgi.com>; Tue, 16 Apr 2002 16:20:18 -0400
Received: from mx.hsv.redhat.com (IDENT:root@spot.hsv.redhat.com [172.16.16.7])
	by localhost.localdomain (8.11.6/8.11.6) with ESMTP id g3GKO5932532
	for <linux-mips@oss.sgi.com>; Tue, 16 Apr 2002 16:24:05 -0400
Received: from redhat.com (slurm.hsv.redhat.com [172.16.16.102])
	by mx.hsv.redhat.com (8.11.6/8.11.0) with ESMTP id g3GKO6828614;
	Tue, 16 Apr 2002 15:24:06 -0500
Message-ID: <3CBC88C5.1000604@redhat.com>
Date: Tue, 16 Apr 2002 15:25:41 -0500
From: Louis Hamilton <hamilton@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Patch SR71K support - questions
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

First a little background for the problem I'm looking at:
I picked up an SR71000 support patch (from Jason Gunthorpe <jgg@debian.org>
sent to this list) and have applied it to our 2.4 MIPS kernel tree. 
 This is a Sandcraft
EV-SR71000-500 cpu module running on a Galileo EV-64240-BP base board in big
endian mode.

What happens is the kernel comes up to the point in init where /sbin/init is
execve'd and hangs (or waits) forever.  Since our QED RM7000 module 
(which we
also ported) is able to bootup all the way we don't suspect file system 
problems.

This board has the PMON Galileo Technology monitor ver. 1.4 in 8-bit 
flash which
does some SR71K cache init by doing a secondary/tertiary flash 
initialize operation
as outlined in the SR71K Cpu Spec in section 7.5.18.

At the load_mmu stage of bring-up I noticed I cannot call the 
"clear_enable_caches"
routine without suffering an exeception.  This is in 
arch/mips/mm/c-sr71000.c, routine
ld_mmu_sr71000 where the call is made to clear_enable_caches as a KSEG1 
address.
I noticed the config register K0 is already set (before load_mmu) to 0x3 
(Cached, Write-back)
and that L2, L3 are enabled, no doubt due to some init done by the PMON 
monitor.
Temporarily commenting out the call to clear_enable_caches step, the 
kernel gets past
the exception problem and progresses to the point where execve seems to 
hang.

So my questions are:
Is this the latest SR71K support patch?  (I can't get access in my 
browser to
http://oss.sgi.com/mips/archive to see prior postings on this...)
Is anyone else using this patch?
If so, is it working ok and what hardware flavor(s) are you using?
What SR71K cpu init is your bootloader or monitor doing before your 
kernel runs?
Any ideas why the tag init loop and secondary/tertiary flash invalidate 
step in
clear_enable_caches crashes the boot-up?

Tia, Louis

Louis Hamilton
Red Hat, Inc.
hamilton@redhat.com
