Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Mar 2003 18:14:49 +0100 (BST)
Received: from mx2.mips.com ([IPv6:::ffff:206.31.31.227]:31118 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225192AbTCaROn>;
	Mon, 31 Mar 2003 18:14:43 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h2VHERUe019453;
	Mon, 31 Mar 2003 09:14:27 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id JAA03799;
	Mon, 31 Mar 2003 09:14:22 -0800 (PST)
Message-ID: <009401c2f7aa$0137f2a0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: <Amit.Lubovsky@infineon.com>, <linux-mips@linux-mips.org>
References: <04C8EDC5AE3FD611ABE40002B39CF69B07F37F@ntah901e.savan.com>
Subject: Re: mips5kc - cpu registers
Date: Mon, 31 Mar 2003 19:21:29 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1255"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

In general, gcc (and most other compilers)
will do this for you automatically if you enable
any reasonable level of optimization.  There
is no need to designate the variable as "FAST",
one simply needs to avoid having it be global,
static, or volatile.

----- Original Message ----- 
From: <Amit.Lubovsky@infineon.com>
To: <linux-mips@linux-mips.org>
Sent: Monday, March 31, 2003 6:45 PM
Subject: mips5kc - cpu registers


> Hi,
> is there a possibility to use cpu registers in the code (temporarily)
> instead of allocating 
> automatic variables something like:
> func a()
> {
> FAST int, i, tmp;
> tmp = ...
> ...
> }
> 
> as in vxWorks ?
> 
> Thanks,
> Amit.
> 
> 
