Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2003 18:44:35 +0100 (BST)
Received: from mcjekyll.mcdata.com ([IPv6:::ffff:144.49.6.25]:7108 "EHLO
	380GATE01out.mcdata.com") by linux-mips.org with ESMTP
	id <S8225410AbTJJRo3> convert rfc822-to-8bit; Fri, 10 Oct 2003 18:44:29 +0100
Received: from 380GATE01.mcdata.com ([172.18.1.72]) by 380GATE01out.mcdata.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 10 Oct 2003 11:44:21 -0600
Received: from MC4EXCH03.mcdata.com ([172.16.11.123]) by 380GATE01 with InterScan Messaging Security Suite; Fri, 10 Oct 2003 11:44:21 -0600
Received: from SNEXCH01.mcdata.com ([172.19.161.13]) by MC4EXCH03.mcdata.com with Microsoft SMTPSVC(5.0.2195.5329);
	 Fri, 10 Oct 2003 11:44:20 -0600
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: mips 32 bit HIGHMEM support
Date: Fri, 10 Oct 2003 10:44:19 -0700
Message-ID: <501EA67E9359C645A10C42EB5B52480D2AB2D0@SNEXCH01.mcdata.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: mips 32 bit HIGHMEM support
Thread-Index: AcOObmUOjHI27547Ra+7/Heevg8OnQA5s2qQ
From: "Krishna Kondaka" <Krishna.Kondaka@MCDATA.com>
To: "Ralf Baechle" <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 10 Oct 2003 17:44:20.0858 (UTC) FILETIME=[22B25DA0:01C38F56]
Return-Path: <Krishna.Kondaka@MCDATA.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3421
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Krishna.Kondaka@MCDATA.com
Precedence: bulk
X-list: linux-mips


Ralf,

How safe is it to enable HIGHMEM for sibyte/broadcom's BCM12500 processors?
Do you know if any one is using HIGHMEM enabled linux on BCM12500s?

Thanks
Krishna

-----Original Message-----
From: Ralf Baechle [mailto:ralf@linux-mips.org]
Sent: Thursday, October 09, 2003 7:03 AM
To: exister99@velocitus.net
Cc: linux-mips@linux-mips.org
Subject: Re: mips 32 bit HIGHMEM support


On Wed, Oct 08, 2003 at 04:00:33PM -0600, exister99@velocitus.net wrote:

> I work for HP in Boise, ID, USA.  For the last six months I have been
> working with Linux in HP Laser jet Printers.  It is running in a formatter
> board that features an ASIC with a MIPS 20Kc core.

Reminds me of the HP Laserjet code in the kernel.  Anybody still using
or testing that?

> The original Linux port was achieved by others working before me.  I began
> working on applications for it when I started here (to make it print
> actually).  As I have tried to milk more performance out of this board the
> recurrent bottleneck has been the fact that the kernel only recognizes
> 512Mb of RAM.  So my current endeavor is fix the kernel so it sees the 1G
> of RAM that is physically present in the system.
> 
> I reconfigured and rebuilt the kernel with HIGHMEM support.  HIGHMEM is
> seen and booting up goes splendidly until init (pid 1) kicks off.  Early
> on in the execution of init the system crashes.  Specifically it crashes
> in do_page_fault().  A couple of strange things I have noticed:
> 
> 1.  All memory pages are divied up between the DMA Zone and the HIGHMEM
> Zone at bootup.  the NORMAL zone gets 0 pages.  Not sure if this is
> normal.
> 
> 2.  The virtual address that do_page_fault() chokes on is 0x00000000. 
> This doesn't seem like a reasonable address for init to be accessing
> especially considering its mem map only contains the chunks
> 0x10000000-0x10001000 and 0x400000-0x40b000 (I got these by traversing
> init's mm->mm_rb tree).
> 
> I decided to contact you about this after digging up this old posting of
> yours:

[... ancient posting deleted ...]

> I think this describes my machine.
> 
> If this is an issue who's solution is old news please point me to the
> solution.  In any case any ideas or guidance regarding this crash would be
> greatly appreciated.

In the meantime there is a highmem implementation for the MIPS kernel.
It's got a limitation - it only works on physically indexed D-caches or
more exactly processors that don't suffer from cache aliases.  On
processors that have such aliases the necessary flushes are rather bad
for performance so this currently simply isn't suported.

Anyway, for a 64-bit processor such as the 20Kc I suggest a 64-bit kernel.
Highmem is a pain and 64-bit is the cure.

  Ralf


SPECIAL NOTICE 

All information transmitted hereby is intended only for the use of the
addressee(s) named above and may contain confidential and privileged
information. Any unauthorized review, use, disclosure or distribution
of confidential and privileged information is prohibited. If the reader
of this message is not the intended recipient(s) or the employee or agent
responsible for delivering the message to the intended recipient, you are
herby notified that you must not read this transmission and that disclosure,
copying, printing, distribution or use of any of the information contained
in or attached to this transmission is STRICTLY PROHIBITED.

Anyone who receives confidential and privileged information in error should
notify us immediately by telephone and mail the original message to us at
the above address and destroy all copies.  To the extent any portion of this
communication contains public information, no such restrictions apply to that
information. (gate01)
