Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Feb 2007 19:02:19 +0000 (GMT)
Received: from w099.z064220152.sjc-ca.dsl.cnc.net ([64.220.152.99]:45737 "EHLO
	bluesmobile.specifix.com") by ftp.linux-mips.org with ESMTP
	id S20039087AbXBPTCP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Feb 2007 19:02:15 +0000
Received: from localhost.localdomain (bluesmobile.specifix.com [64.220.152.99])
	by bluesmobile.specifix.com (Postfix) with ESMTP id F31BB3B8BD;
	Fri, 16 Feb 2007 11:01:35 -0800 (PST)
Subject: Re: Who know latest Linux/MIPS ABI ?
From:	Jim Wilson <wilson@specifix.com>
To:	=?UTF-8?Q?=EA=B9=80=EB=AF=BC=EC=B0=AC?= <barrioskmc@gmail.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <1171651846.2577.18.camel@localhost.localdomain>
References: <000701c750a3$24ecf9b0$8aab580a@swcenter.sec.samsung.co.kr>
	 <1171651846.2577.18.camel@localhost.localdomain>
Content-Type: text/plain
Date:	Fri, 16 Feb 2007 11:01:42 -0800
Message-Id: <1171652502.2577.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Return-Path: <wilson@specifix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilson@specifix.com
Precedence: bulk
X-list: linux-mips

On Fri, 2007-02-16 at 10:50 -0800, Jim Wilson wrote:
> 1) Buy an SGI Irix5 and/or Irix6 machine, and start reading header files
> in /usr/include.  Irix5 has ECOFF and ELF o32 support.  Irix6 has ELF
> o32, n32, and n64 support.

If you are desperate enough to try this, make sure the machine has a
compiler.  Some of the header files you need may be part of the compiler
package, and I don't recall if the compiler comes standard with Irix.
It might be an extra package.
-- 
Jim Wilson, GNU Tools Support, http://www.specifix.com
