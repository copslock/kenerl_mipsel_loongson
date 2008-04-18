Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Apr 2008 10:53:03 +0100 (BST)
Received: from oss.sgi.com ([192.48.170.157]:13782 "EHLO oss.sgi.com")
	by ftp.linux-mips.org with ESMTP id S20022225AbYDRJxB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 18 Apr 2008 10:53:01 +0100
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m3I9qBFk019835
	for <linux-mips@linux-mips.org>; Fri, 18 Apr 2008 02:52:14 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m3I9qqjU023558;
	Fri, 18 Apr 2008 10:52:52 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m3I9qqm0023557;
	Fri, 18 Apr 2008 10:52:52 +0100
Date:	Fri, 18 Apr 2008 10:52:52 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Patches for 34K APRP
Message-ID: <20080418095252.GA23316@linux-mips.org>
References: <4805FFE6.5080903@mips.com> <20080417124319.GA31453@linux-mips.org> <480752B8.9040601@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <480752B8.9040601@mips.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 17, 2008 at 03:38:00PM +0200, Kevin D. Kissell wrote:

>> That will be incorrect for systems with highmem.  So I think the right
>> fix is to replace all references to max_pfn in vpe.c with max_low_pfn.
>>   
> Which will still be incorrect for systems with highmem, right?  The reason
> I propose fixing max_pfn instead of just hacking vpe.c is that, as per my
> email of a couple of weeks ago, there are other, architecture independent,
> bits of code in the 2.6.24 kernel where max_pfn is assumed to be sane,
> and the value of zero may result in otherwise inexplicable Bad Things
> happening.  So even if you want to change vpe.c to use max_low_pfn
> instead of max_pfn, I believe that we really want that patch to setup.c
> until such time as we've verified that the kernel is max_pfn-free.

Hmm..  yes.  But your 0002-Propagate-max_low_pfn-as-max_pfn-fo patch
uses max_low_pfn after it has already been cut down to exclude highmem.
Moving the assignment a few lines up just before the if statement should
fix the issue.

  Ralf
