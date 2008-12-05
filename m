Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Dec 2008 17:59:12 +0000 (GMT)
Received: from mx1.moondrake.net ([212.85.150.166]:15588 "EHLO
	mx1.mandriva.com") by ftp.linux-mips.org with ESMTP
	id S24145223AbYLER7F (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 5 Dec 2008 17:59:05 +0000
Received: by mx1.mandriva.com (Postfix, from userid 501)
	id 25EC527400E; Fri,  5 Dec 2008 18:59:01 +0100 (CET)
Received: from office-abk.mandriva.com (office-abk.mandriva.com [84.55.162.90])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.mandriva.com (Postfix) with ESMTP id 5505527401C
	for <linux-mips@linux-mips.org>; Fri,  5 Dec 2008 18:58:59 +0100 (CET)
Received: from anduin.mandriva.com (fw2.mandriva.com [192.168.2.3])
	by office-abk.mandriva.com (Postfix) with ESMTP id 124E18291C
	for <linux-mips@linux-mips.org>; Fri,  5 Dec 2008 19:00:15 +0100 (CET)
Received: from anduin.mandriva.com (localhost [127.0.0.1])
	by anduin.mandriva.com (Postfix) with ESMTP id C333FFF855
	for <linux-mips@linux-mips.org>; Fri,  5 Dec 2008 18:59:35 +0100 (CET)
From:	Arnaud Patard <apatard@mandriva.com>
To:	linux-mips@linux-mips.org
Subject: Re: xorg-server-1.5.2 doesn't work because of missing sysfs pci resource files
References: <20081205154339.GA14327@adriano.hkcable.com.hk>
Organization: Mandriva
Date:	Fri, 05 Dec 2008 18:59:35 +0100
In-Reply-To: <20081205154339.GA14327@adriano.hkcable.com.hk> (Zhang Le's message of "Fri, 5 Dec 2008 23:43:42 +0800")
Message-ID: <m3ljuumrjs.fsf@anduin.mandriva.com>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <arnaud.patard@mandriva.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apatard@mandriva.com
Precedence: bulk
X-list: linux-mips

Zhang Le <r0bertz@gentoo.org> writes:

> Hi, all,

Hi,

> Then I tried to read kernel code. I found it seems that for mips linux to have
> this file, HAVE_PCI_MMAP must be defined. However, it is currently not defined.
>
> Since I am not familiar with PCI, yet.
> So could someone please shed some light on this?
> Why HAVE_PCI_MMAP is not defined?

HAVE_PCI_MMAP must be defined when you have a pci_mmap_page_range()
function (see Documentation/filesystems/sysfs-pci.txt) and we don't have
a pci_mmap_page_range() on mips.

Hope that helps you.

Arnaud
