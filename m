Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Oct 2003 23:01:18 +0100 (BST)
Received: from mx20a.rmci.net ([IPv6:::ffff:205.162.184.37]:32690 "HELO
	mx20a.rmci.net") by linux-mips.org with SMTP id <S8225568AbTJHWAh>;
	Wed, 8 Oct 2003 23:00:37 +0100
Received: (qmail 11728 invoked from network); 8 Oct 2003 22:00:33 -0000
Received: from webmailb.rmci.net (HELO velocitus.net) (205.162.184.93)
  by mx20.rmci.net with SMTP; 8 Oct 2003 22:00:33 -0000
Received: from 156.153.254.2
        (SquirrelMail authenticated user exister99@velocitus.net)
        by webmail.rmci.net with HTTP;
        Wed, 8 Oct 2003 16:00:33 -0600 (MDT)
Message-ID: <5334.156.153.254.2.1065650433.squirrel@webmail.rmci.net>
Date: Wed, 8 Oct 2003 16:00:33 -0600 (MDT)
Subject: mips 32 bit HIGHMEM support
From: <exister99@velocitus.net>
To: <ralf@oss.sgi.com>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <linux-mips@linux-mips.org>
X-Mailer: SquirrelMail (version 1.2.7)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <exister99@velocitus.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: exister99@velocitus.net
Precedence: bulk
X-list: linux-mips

Hello Ralf,

I work for HP in Boise, ID, USA.  For the last six months I have been
working with Linux in HP Laser jet Printers.  It is running in a formatter
board that features an ASIC with a MIPS 20Kc core.

The original Linux port was achieved by others working before me.  I began
working on applications for it when I started here (to make it print
actually).  As I have tried to milk more performance out of this board the
recurrent bottleneck has been the fact that the kernel only recognizes
512Mb of RAM.  So my current endeavor is fix the kernel so it sees the 1G
of RAM that is physically present in the system.

I reconfigured and rebuilt the kernel with HIGHMEM support.  HIGHMEM is
seen and booting up goes splendidly until init (pid 1) kicks off.  Early
on in the execution of init the system crashes.  Specifically it crashes
in do_page_fault().  A couple of strange things I have noticed:

1.  All memory pages are divied up between the DMA Zone and the HIGHMEM
Zone at bootup.  the NORMAL zone gets 0 pages.  Not sure if this is
normal.

2.  The virtual address that do_page_fault() chokes on is 0x00000000. 
This doesn't seem like a reasonable address for init to be accessing
especially considering its mem map only contains the chunks
0x10000000-0x10001000 and 0x400000-0x40b000 (I got these by traversing
init's mm->mm_rb tree).

I decided to contact you about this after digging up this old posting of
yours:

>Is anybody using 32-bit MIPS CPUs which have more than 512mb of memory or
>to be more exact have RAM that isn't accessible via the KSEG0 / KSEG1
>window?
>
>So far I haven't ever seen such a machine.  For 64-bit CPUs the right
>thing to do is easy - use a 64-bit kernel.  But for 32-bit CPUs the Intel
>highmem stuff in the memory managment now gives us a sane way to use
>the memory of such configuration with just a little bit of extra code.
>
>So if anybody wants support for such a configuration, please drop me a
>note.
>
>Thanks,
>
>  Ralf

I think this describes my machine.

If this is an issue who's solution is old news please point me to the
solution.  In any case any ideas or guidance regarding this crash would be
greatly appreciated.

Regards, Andrew Stone
