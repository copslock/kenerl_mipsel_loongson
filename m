Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2007 15:47:50 +0000 (GMT)
Received: from mail.hcrest.com ([12.173.51.131]:11996 "EHLO mail.hcrest.com")
	by ftp.linux-mips.org with ESMTP id S20022416AbXCWPrs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Mar 2007 15:47:48 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: flush_anon_page for MIPS
Date:	Fri, 23 Mar 2007 11:47:20 -0400
Message-ID: <36E4692623C5974BA6661C0B18EE8EDF6CD389@MAILSERV.hcrest.com>
In-Reply-To: <20070324.004146.41631259.anemo@mba.ocn.ne.jp>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
thread-topic: flush_anon_page for MIPS
Thread-Index: AcdtYcV4NOyVj69cRWOxO5zuQnun1AAAH0BQ
From:	"Ravi Pratap" <Ravi.Pratap@hillcrestlabs.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Cc:	<ralf@linux-mips.org>, <miklos@szeredi.hu>,
	<linux-mips@linux-mips.org>
Return-Path: <Ravi.Pratap@hillcrestlabs.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Ravi.Pratap@hillcrestlabs.com
Precedence: bulk
X-list: linux-mips

> From: Atsushi Nemoto [mailto:anemo@mba.ocn.ne.jp] 
> Sent: Friday, March 23, 2007 11:42 AM
> To: Ravi Pratap
> Cc: ralf@linux-mips.org; miklos@szeredi.hu; linux-mips@linux-mips.org
> Subject: Re: flush_anon_page for MIPS
> 
> On Fri, 23 Mar 2007 10:51:32 -0400, "Ravi Pratap" 
> <Ravi.Pratap@hillcrestlabs.com> wrote:
> > > Was this one found by code inspection or actually 
> triggered by like 
> > > FUSE?
> > 
> > It was actually triggered by FUSE.
> 
> Could you point us any good (simple, easy to install, 
> independent from any special device) FUSE program to test it?

The standard FUSE hello program triggers the bug every single time. All
you have to do is follow the example on the FUSE web page:
http://fuse.sourceforge.net 

~/fuse/example$ mkdir /tmp/fuse
~/fuse/example$ ./hello /tmp/fuse
~/fuse/example$ ls -l /tmp/fuse
total 0
-r--r--r--  1 root root 13 Jan  1  1970 hello
~/fuse/example$ cat /tmp/fuse/hello
Hello World!
~/fuse/example$ fusermount -u /tmp/fuse
~/fuse/example$


It hangs when you do ls -l /tmp/fuse, in the above example.


HTH,

Ravi.
