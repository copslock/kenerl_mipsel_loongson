Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2005 11:22:05 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:43541 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3466284AbVKVLVr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 Nov 2005 11:21:47 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jAMBOMgb007445;
	Tue, 22 Nov 2005 11:24:22 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jAMBOHnN007444;
	Tue, 22 Nov 2005 11:24:17 GMT
Date:	Tue, 22 Nov 2005 11:24:17 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Nigel Stephens <nigel@mips.com>
Cc:	"Kevin D. Kissell" <kevink@mips.com>,
	"Knittel, Brian" <Brian.Knittel@powertv.com>,
	linux-mips@linux-mips.org
Subject: Re: Saving arguments on the stack
Message-ID: <20051122112417.GB2706@linux-mips.org>
References: <762C0A863A7674478671627FEAF5848105AF92D2@hqmail01.powertv.com> <4382DC76.60506@mips.com> <4382FF29.2020605@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4382FF29.2020605@mips.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9530
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 22, 2005 at 11:21:13AM +0000, Nigel Stephens wrote:

> >>I'd like to force the compiler to store arguments on the stack with 
> >>otherwise optimized code.
> >>
> >>I found a refernce in the archives (form 2001) for using -0 (no 
> >>optimization). Has anyone found another way to do this?
> >
> >
> >If I recall correctly, if you specify -g to enable debugger support,
> >the subroutine prologues store the arguments into their stack slots,
> >even if a higher level of optimization is otherwise specified.
> 
> 
> 'Fraid not: the -g option only adds debug info to the object file, it 
> shouldn't alter the generated code. Using -O0 will certainly store 
> everything on the stack, but it also won't be "with otherwise optimized 
> code".

And the kernel won't build without optimization - but that's FAQ since
10 years.

  Ralf
