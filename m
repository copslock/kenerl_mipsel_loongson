Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2007 08:33:09 +0000 (GMT)
Received: from directfb.org ([212.227.87.76]:31483 "EHLO www.directfb.org")
	by ftp.linux-mips.org with ESMTP id S20026795AbXKTIdA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Nov 2007 08:33:00 +0000
Received: from [88.134.87.7] (helo=[10.1.1.6])
	by www.directfb.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <dok@directfb.org>)
	id 1IuOUI-0006z5-Ri; Tue, 20 Nov 2007 09:29:42 +0100
Message-ID: <47429AEF.3010403@directfb.org>
Date:	Tue, 20 Nov 2007 09:29:35 +0100
From:	Denis Oliver Kropp <dok@directfb.org>
User-Agent: Thunderbird 2.0.0.6 (X11/20070803)
MIME-Version: 1.0
To:	kaka <share.kt@gmail.com>
CC:	linux-mips@linux-mips.org, uclinux-dev@uclinux.org,
	celinux-dev@tree.celinuxforum.org,
	linux-fbdev-users@lists.sourceforge.net,
	directfb-users@directfb.org, directfb-dev@directfb.org
Subject: Re: [directfb-dev] Usage of mmap command
References: <eea8a9c90711192239q6009cbb8y76790fa73bc4a5b7@mail.gmail.com>
In-Reply-To: <eea8a9c90711192239q6009cbb8y76790fa73bc4a5b7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <dok@directfb.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dok@directfb.org
Precedence: bulk
X-list: linux-mips

kaka wrote:
> Hi All,
> 
> void *mmap(void *start, size_t length, int prot, int flags,           int
> fd, off_t offset);
> 
> I am providing 16,00,000 as length parameter in mmap command.
> It is giving me error as Can't mmap region. on the other hand when i am
> providing 9,00,000 as length parameter in mmap command.
> It is successful.
> This mmap command is being issued from User space.
> 
> On the other hand in the framebuffer driver in the kernel spce i have
> specified the length of mmio in the ioremap as 16,00,000.

The ioremap() is independent of the values propagated to user space
and fbmem.c via fix.mmio_start and fix.mmio_len, please check these.

-- 
Best regards,
  Denis Oliver Kropp

.------------------------------------------.
| DirectFB - Hardware accelerated graphics |
| http://www.directfb.org/                 |
"------------------------------------------"
