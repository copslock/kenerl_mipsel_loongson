Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jan 2006 15:07:58 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:36868 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S3686579AbWATPHf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Jan 2006 15:07:35 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id B560664D40; Fri, 20 Jan 2006 15:10:27 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 0FEAF8ECE; Fri, 20 Jan 2006 15:10:06 +0000 (GMT)
Date:	Fri, 20 Jan 2006 15:10:05 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Fix a CPU definition for Cobalt
Message-ID: <20060120151005.GH4343@deprecation.cyrius.com>
References: <20060119192414.GA26798@deprecation.cyrius.com> <20060119210440.GE3398@linux-mips.org> <20060119214546.GB10040@deprecation.cyrius.com> <20060120150126.GB30415@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060120150126.GB30415@linux-mips.org>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10018
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Ralf Baechle <ralf@linux-mips.org> [2006-01-20 16:01]:
> > > pointer is eventually called as a function.  So I suggest this below.
> > > Can you test it?
> > Doesn't work.
> Indeed - for quite obvioius reasons even.  I hope I now covered all cases
> in the new patch below.

You attached the SERIO patch. ;-)
-- 
Martin Michlmayr
http://www.cyrius.com/
