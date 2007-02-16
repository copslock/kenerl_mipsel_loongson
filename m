Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Feb 2007 18:51:31 +0000 (GMT)
Received: from w099.z064220152.sjc-ca.dsl.cnc.net ([64.220.152.99]:42409 "EHLO
	bluesmobile.specifix.com") by ftp.linux-mips.org with ESMTP
	id S20039087AbXBPSv1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Feb 2007 18:51:27 +0000
Received: from localhost.localdomain (bluesmobile.specifix.com [64.220.152.99])
	by bluesmobile.specifix.com (Postfix) with ESMTP id 3C7A13B81F;
	Fri, 16 Feb 2007 10:50:40 -0800 (PST)
Subject: Re: Who know latest Linux/MIPS ABI ?
From:	Jim Wilson <wilson@specifix.com>
To:	=?UTF-8?Q?=EA=B9=80=EB=AF=BC=EC=B0=AC?= <barrioskmc@gmail.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <000701c750a3$24ecf9b0$8aab580a@swcenter.sec.samsung.co.kr>
References: <000701c750a3$24ecf9b0$8aab580a@swcenter.sec.samsung.co.kr>
Content-Type: text/plain; charset=utf-8
Date:	Fri, 16 Feb 2007 10:50:46 -0800
Message-Id: <1171651846.2577.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 8bit
Return-Path: <wilson@specifix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilson@specifix.com
Precedence: bulk
X-list: linux-mips

On Thu, 2007-02-15 at 10:46 +0900, 김민찬 wrote:
> I hope I get a latest MIPS ABI and ELF Spec on Linux/MIPS. 
> Who know where I get it?

There is some documentation available from SGI.  Try
  http://docs.sgi.com
You start by searching for ABI, but there may also be other docs you
want to look at.  There may also be relevant documentation available
from MIPS.  Try them also.
  http://www.mips.com
and then hunt around for documentation.

You can find good info on calling conventions in these places, but you
aren't going to find good info on low level stuff like object file
formats.  For that, you will probably need to read code.  You have two
basic choices here.
1) Buy an SGI Irix5 and/or Irix6 machine, and start reading header files
in /usr/include.  Irix5 has ECOFF and ELF o32 support.  Irix6 has ELF
o32, n32, and n64 support.
2) Start reading the MIPS bfd support in GNU binutils.

jcr is a gcc feature for java.  Something like "java class record".  It
should be safe to ignore it unless you are using java.  This isn't MIPS
specific.

pdr is procedure descriptor record.  It is a left over from the SGI
Irix5 ECOFF days, which SGI carried forward into their ELF
implementation, and which was copied by the GNU and linux tools.

For MIPS.stubs, that one I didn't know, I had to look it up.  The bfd
comments say it is for dynamic linking, so that function pointer
comparisons work correctly for functions defined in shared libraries.
-- 
Jim Wilson, GNU Tools Support, http://www.specifix.com
