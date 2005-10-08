Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Oct 2005 14:52:51 +0100 (BST)
Received: from sccrmhc14.comcast.net ([63.240.76.49]:64486 "EHLO
	sccrmhc14.comcast.net") by ftp.linux-mips.org with ESMTP
	id S8133616AbVJHNwf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 8 Oct 2005 14:52:35 +0100
Received: from buzz (c-67-171-115-157.hsd1.ut.comcast.net[67.171.115.157])
          by comcast.net (sccrmhc14) with SMTP
          id <2005100813522701400ok6bde>; Sat, 8 Oct 2005 13:52:27 +0000
From:	"Kyle Unice" <unixe@comcast.net>
To:	"'Ilya A. Volynets-Evenbakh'" <ilya@total-knowledge.com>,
	"'David Daney'" <ddaney@avtrex.com>
Cc:	<ppopov@embeddedalley.com>, "'Brett Foster'" <fosterb@uoguelph.ca>,
	<linux-mips@linux-mips.org>
Subject: RE: Cross-compiling Linux problem
Date:	Sat, 8 Oct 2005 07:52:24 -0600
Message-ID: <003c01c5cc0f$83a19e30$0400a8c0@buzz>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <4346FD34.8000100@total-knowledge.com>
Return-Path: <unixe@comcast.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: unixe@comcast.net
Precedence: bulk
X-list: linux-mips

It appears that the function __fixup_bigphys_addr is not inline anymore but 
A callable function.  I removed the "inline " qualifier from the extern
declaration in
Ioremap.h (if CONFIG_64BIT_PHYS_ADDR is declared) and linux built ok.
Kyle 

-----Original Message-----
From: Ilya A. Volynets-Evenbakh [mailto:ilya@total-knowledge.com] 
Sent: Friday, October 07, 2005 4:57 PM
To: David Daney
Cc: Kyle Unice; ppopov@embeddedalley.com; 'Brett Foster';
linux-mips@linux-mips.org
Subject: Re: Cross-compiling Linux problem

CVS is not where development happens, but it is still updated, according 
to Ralf.

David Daney wrote:

> Kyle Unice wrote:
>
>> I am using gcc-3.4.4 and the cvs checkout of linux-mips.org tree.
>> Kyle
>
>
> Not withstanding Maciej's comment about the real problem being the 
> broken header file, I give you a quote from 
> http://www.linux-mips.org/wiki/Git : "At this time only the linux.git 
> repository is in production use.... all other archives are only 
> historical."
>
> You might consider getting your code from the git repository as the 
> CVS repository is no longer being maintained.
>
> David Daney
>
>

-- 
Ilya A. Volynets-Evenbakh
Total Knowledge. CTO
http://www.total-knowledge.com
