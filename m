Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jan 2006 21:23:54 +0000 (GMT)
Received: from mail.ivivity.com ([64.238.111.98]:41556 "EHLO thoth.ivivity.com")
	by ftp.linux-mips.org with ESMTP id S3950817AbWATVXV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Jan 2006 21:23:21 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: how to emdedded ramdisk.gz in vmlinux for linux-2.6.14? 
Date:	Fri, 20 Jan 2006 16:27:12 -0500
Message-ID: <0F31272A2BCBBE4FA01344C6E69DBF501EAB34@thoth.ivivity.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: how to emdedded ramdisk.gz in vmlinux for linux-2.6.14? 
Thread-Index: AcYeBPqm1DKZFxXlSfSXFGF8q1HmBAAAvyIA
From:	"Marc Karasek" <marck@ivivity.com>
To:	<wd@denx.de>
Cc:	"P. Christeas" <p_christ@hol.gr>,
	"Linux-Mips" <linux-mips@linux-mips.org>
Return-Path: <marck@ivivity.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marck@ivivity.com
Precedence: bulk
X-list: linux-mips

I took a look at the page...

The one criteria, being able to update in a live system, trumps all of the other considerations.  If you cannot update a live system, then you might as well take your ball & bat and go home.  :-)

Seriously, that is a what I would call a no-brainer decision.    

Any content within this email is provided "AS IS" for informational purposes only. No contract will be formed between the parties by virtue of this email.
<**************************>
Marc Karasek
System Lead Technical Engineer
iVivity Inc.
PH: 678-990-1550 x238
Fax: 678-990-1551
<**************************>



-----Original Message-----
From: wd@denx.de [mailto:wd@denx.de]
Sent: Friday, January 20, 2006 4:04 PM
To: Marc Karasek
Cc: P. Christeas; Linux-Mips
Subject: Re: how to emdedded ramdisk.gz in vmlinux for linux-2.6.14? 


In message <1137790053.22994.58.camel@localhost.localdomain> you wrote:
> Basically due to design issues and cost issues having a flash based
> system is not possible.  Currently we have only 16MB total of flash and

If you have enough flash to store a compressed ramdisk image, you can
store a compressed flash file system as well. For example, you  could
use  a  cramfs file system. In most cases the ramdisk solution is the
worst option to chose. See for example
http://www.denx.de/wiki/view/DULG/RootFileSystemSelection


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
There are bugs and then there are bugs.  And then there are bugs.
                                                    - Karl Lehenbauer
