Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2007 16:00:01 +0000 (GMT)
Received: from mail.hcrest.com ([12.173.51.131]:60382 "EHLO mail.hcrest.com")
	by ftp.linux-mips.org with ESMTP id S20021730AbXCWP77 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Mar 2007 15:59:59 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: flush_anon_page for MIPS
Date:	Fri, 23 Mar 2007 11:59:32 -0400
Message-ID: <36E4692623C5974BA6661C0B18EE8EDF6CD391@MAILSERV.hcrest.com>
In-Reply-To: <20070323155641.GA31853@linux-mips.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
thread-topic: flush_anon_page for MIPS
Thread-Index: AcdtY9wHcM81+jWCRfuMXP9BvqJGBAAAE9OQ
From:	"Ravi Pratap" <Ravi.Pratap@hillcrestlabs.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>, <miklos@szeredi.hu>,
	<linux-mips@linux-mips.org>
Return-Path: <Ravi.Pratap@hillcrestlabs.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14639
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Ravi.Pratap@hillcrestlabs.com
Precedence: bulk
X-list: linux-mips

> From: Ralf Baechle [mailto:ralf@linux-mips.org] 
> Sent: Friday, March 23, 2007 11:57 AM
> To: Ravi Pratap
> Cc: Atsushi Nemoto; miklos@szeredi.hu; linux-mips@linux-mips.org
> Subject: Re: flush_anon_page for MIPS
> 
> On Fri, Mar 23, 2007 at 11:47:20AM -0400, Ravi Pratap wrote:
> 
> > The standard FUSE hello program triggers the bug every single time. 
> > All you have to do is follow the example on the FUSE web page:
> > http://fuse.sourceforge.net
> > 
> > ~/fuse/example$ mkdir /tmp/fuse
> > ~/fuse/example$ ./hello /tmp/fuse
> > ~/fuse/example$ ls -l /tmp/fuse
> > total 0
> > -r--r--r--  1 root root 13 Jan  1  1970 hello ~/fuse/example$ cat 
> > /tmp/fuse/hello Hello World!
> > ~/fuse/example$ fusermount -u /tmp/fuse ~/fuse/example$
> > 
> > 
> > It hangs when you do ls -l /tmp/fuse, in the above example.
> 
> What processor does it fail on?

# cat /proc/cpuinfo
system type             : Sigma Designs TangoX
processor               : 0
cpu model               : MIPS 4KEc V6.8
BogoMIPS                : 299.00
wait instruction        : yes
microsecond timers      : yes
tlb_entries             : 32
extra interrupt vector  : yes
hardware watchpoint     : yes
ASEs implemented        : mips16
VCED exceptions         : not available
VCEI exceptions         : not available
