Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Feb 2008 02:16:57 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:15076 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20031907AbYBCCQz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 3 Feb 2008 02:16:55 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m132GnPJ016019;
	Sun, 3 Feb 2008 03:16:50 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m132GmRD016018;
	Sun, 3 Feb 2008 03:16:48 +0100
Date:	Sun, 3 Feb 2008 03:16:48 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kumba <kumba@gentoo.org>
Cc:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Florian Lohoff <flo@rfc822.org>, linux-mips@linux-mips.org,
	debian-mips@lists.debian.org
Subject: Re: Tester with IP27/IP30 needed
Message-ID: <20080203021647.GA15910@linux-mips.org>
References: <20080115112420.GA7347@alpha.franken.de> <20080115112719.GB7920@paradigm.rfc822.org> <20080117004054.GA12051@alpha.franken.de> <479609A6.2020204@gentoo.org> <20080122154958.GA29108@linux-mips.org> <479AA532.5040603@gentoo.org> <20080126143949.GA6579@alpha.franken.de> <47A4E9DF.5070603@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47A4E9DF.5070603@gentoo.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Feb 02, 2008 at 05:08:31PM -0500, Kumba wrote:

> 
> Thomas Bogendoerfer wrote:
>> no suprise here. As Ralf already noted cache barrier is a restricted
>> instruction, it will always cause a illegal instruction when used
>> in user space. Nevertheless it looks like all IP28 are affected
>> by the simple exploit. Flo built glibc 2.7 with LLSC war workaround
>> and this avoids triggering the hang.
>
> Ah, didn't know the 'cache' instructions was kernel-mode only.  Explains 
> why it survived then :)
>
> How does one enable the LLSC war workaround in glibc?

By modifying the code ;-)

  Ralf
