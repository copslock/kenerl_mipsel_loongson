Received:  by oss.sgi.com id <S553998AbRAYTZJ>;
	Thu, 25 Jan 2001 11:25:09 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:4696 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S553990AbRAYTYx>;
	Thu, 25 Jan 2001 11:24:53 -0800
Received: from dhcp-163-154-5-240.engr.sgi.com (dhcp-163-154-5-240.engr.sgi.com [163.154.5.240]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id LAA22923
	for <linux-mips@oss.sgi.com>; Thu, 25 Jan 2001 11:23:55 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S870762AbRAYRhn>; Thu, 25 Jan 2001 09:37:43 -0800
Date: 	Thu, 25 Jan 2001 09:37:43 -0800
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Justin Carlson <carlson@sibyte.com>
Cc:     Pete Popov <ppopov@mvista.com>,
        "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: floating point on Nevada cpu
Message-ID: <20010125093743.A1288@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jan 24, 2001 at 06:57:04PM -0800, Justin Carlson wrote:

> How are you compiling the code?  And are you compiling it the same way on
> both platforms?  Do you have fpu emulation enabled on a kernel that doesn't
> need it? 

All MIPS FPUs need it; the architecture specification leaves it to the
implementor of a CPU which parts of the FP architecture are implemented
in hardware if at all; the missing parts have to be replaced in
software.

This piece of code shouldn't result in any FPU operations as printf is
very careful to avoid inaccuracies that might result from floating point
operations.

  Ralf
