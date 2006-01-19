Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2006 19:13:08 +0000 (GMT)
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:39339 "EHLO
	ccerelbas04.cce.hp.com") by ftp.linux-mips.org with ESMTP
	id S3468182AbWASTMu (ORCPT <rfc822;Linux-mips@linux-mips.org>);
	Thu, 19 Jan 2006 19:12:50 +0000
Received: from ccerelint01.cce.cpqcorp.net (ccerelint01.cce.cpqcorp.net [16.110.74.103])
	by ccerelbas04.cce.hp.com (Postfix) with ESMTP id 073403493A;
	Thu, 19 Jan 2006 13:16:24 -0600 (CST)
Received: from hplms2.hpl.hp.com (hplms2.hpl.hp.com [15.0.152.33])
	by ccerelint01.cce.cpqcorp.net (Postfix) with ESMTP id C829634011;
	Thu, 19 Jan 2006 13:16:24 -0600 (CST)
Received: from frankl.hpl.hp.com (frankl.hpl.hp.com [15.4.89.73])
	by hplms2.hpl.hp.com (8.13.1/8.13.1/HPL-PA Hub) with ESMTP id k0JJGNoP026641;
	Thu, 19 Jan 2006 11:16:23 -0800 (PST)
Received: from frankl.hpl.hp.com (localhost [127.0.0.1])
	by frankl.hpl.hp.com (8.12.8/8.12.8) with ESMTP id k0JJE3vH021122;
	Thu, 19 Jan 2006 11:14:03 -0800
Received: (from eranian@localhost)
	by frankl.hpl.hp.com (8.12.8/8.12.8/Submit) id k0JJE3uZ021120;
	Thu, 19 Jan 2006 11:14:03 -0800
Date:	Thu, 19 Jan 2006 11:14:03 -0800
From:	Stephane Eranian <eranian@hpl.hp.com>
To:	Philip Mucci <mucci@cs.utk.edu>
Cc:	Ralf Baechle <ralf@linux-mips.org>, perfmon@napali.hpl.hp.com,
	Linux-mips@linux-mips.org
Subject: Re: [perfmon] Re: 2.6.13-rc2 perfmon2 new code base with MIPS5K/20K support + libpfm available
Message-ID: <20060119191403.GV19622@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <1137666602.6648.80.camel@localhost.localdomain> <20060119133609.GA3398@linux-mips.org> <20060119181608.GP19622@frankl.hpl.hp.com> <1137695936.6648.268.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137695936.6648.268.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail:	eranian@hpl.hp.com
Return-Path: <eranian@frankl.hpl.hp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;Linux-mips@linux-mips.org
Original-Recipient: rfc822;Linux-mips@linux-mips.org
X-archive-position: 10001
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eranian@hpl.hp.com
Precedence: bulk
X-list: linux-mips

Phil,

On Thu, Jan 19, 2006 at 07:38:56PM +0100, Philip Mucci wrote:
> Stefane,
> 
> Are you saying that oprofile user level tools don't even use the
> oprofile driver but rather just set up a system-wide IP-sampling context
> for perfmon2?
> 
Yes, I think that is the way this works. I will verify this.

> Think of all the work that Ralf just did. ;-)
> 
If you don't have perfmon2, then you have to provide you arch/mips/oprofile
files for sure.
