Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Dec 2008 19:01:00 +0000 (GMT)
Received: from mx1.moondrake.net ([212.85.150.166]:41884 "EHLO
	mx1.mandriva.com") by ftp.linux-mips.org with ESMTP
	id S24109657AbYLITAw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 9 Dec 2008 19:00:52 +0000
Received: by mx1.mandriva.com (Postfix, from userid 501)
	id 226DC274011; Tue,  9 Dec 2008 20:00:48 +0100 (CET)
Received: from office-abk.mandriva.com (office-abk.mandriva.com [84.55.162.90])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.mandriva.com (Postfix) with ESMTP id 030D0274002;
	Tue,  9 Dec 2008 20:00:47 +0100 (CET)
Received: from anduin.mandriva.com (fw2.mandriva.com [192.168.2.3])
	by office-abk.mandriva.com (Postfix) with ESMTP id F21FC8285F;
	Tue,  9 Dec 2008 20:02:14 +0100 (CET)
Received: from anduin.mandriva.com (localhost [127.0.0.1])
	by anduin.mandriva.com (Postfix) with ESMTP id 47501FF855;
	Tue,  9 Dec 2008 20:01:57 +0100 (CET)
From:	Arnaud Patard <apatard@mandriva.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: xorg-server-1.5.2 doesn't work because of missing sysfs pci resource files
References: <20081205154339.GA14327@adriano.hkcable.com.hk>
	<20081206102030.GA9410@linux-mips.org>
	<m3k5a9kyc6.fsf@anduin.mandriva.com>
	<20081209183634.GA2418@linux-mips.org>
Organization: Mandriva
Date:	Tue, 09 Dec 2008 20:01:57 +0100
In-Reply-To: <20081209183634.GA2418@linux-mips.org> (Ralf Baechle's message of "Tue, 9 Dec 2008 18:36:34 +0000")
Message-ID: <m3fxkxkw9m.fsf@anduin.mandriva.com>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <arnaud.patard@mandriva.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apatard@mandriva.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle <ralf@linux-mips.org> writes:

Hi,

> On Tue, Dec 09, 2008 at 07:17:13PM +0100, Arnaud Patard wrote:
>
>> What about things like _CACHE_UNCACHED_ACCELERATED ? Is there a way to
>> use this flag ?
>
> That's possible but will require some additional care in the code.
> Multiple mappings using different cache modes need to be avoided and
> also not all processors support _CACHE_UNCACHED_ACCELERATED.

well, for that, one can always define a Kconfig entry for that. It would
be usefull for using _CACHE_UNCACHED_ACCELERATED in fb_pgprotect in
asm/fb.h too.

>
> If you know your software is playing nice and your CPU supports
> _CACHE_UNCACHED_ACCELERATED, you can hack the mmap function to use
> _CACHE_UNCACHED_ACCELERATED if write_combine is set.  Just for now
> and for something which I'm planning to push for 2.6.28 I don't want
> anything that's more than trivial.

Ok, no problem. I'm only asking if it will be possible to use it. For
now, I don't have the pci_mmap_page_range requirement on my systems.


Thanks,
Arnaud
