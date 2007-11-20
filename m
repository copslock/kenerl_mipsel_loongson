Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2007 06:39:47 +0000 (GMT)
Received: from wa-out-1112.google.com ([209.85.146.181]:61348 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20023566AbXKTGjh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Nov 2007 06:39:37 +0000
Received: by wa-out-1112.google.com with SMTP id m16so2258501waf
        for <linux-mips@linux-mips.org>; Mon, 19 Nov 2007 22:39:26 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        bh=ykgqxqYmkYOAssyTf1g4BM2JoF4kjk9+u4w/BC2YaQM=;
        b=jbJ7LFyD6EfkLPSWbfSm5Ph8EAvCrgv4gUw6uvGqlscp+/AdjCVbJFSDLYvvp1equ1DEwqQSf7/O2gCxglU/A9c77lVu/o1VUUbyRhytt825ZNdQOvptmOs9jRjMalaYKUhPwKY4fbTrSywTWtDe1qIs57YAjUMG4hnnYiUSBoo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=BMCvFSKscZ7GaksxRcnLUhu9CxVVLABOHm3ZmVYXnK1xTiRypjiSPrcB/+7qIFwC6Kp9k+KeCVX7msvSEYLwkyLBtVZ3ucXq2su+ph8K6nMl+qA4zTenZejkieTG7OIISiQxeYAwRCSi3fTakgaIEt1HzA89NzXavswgNjQYovc=
Received: by 10.114.149.2 with SMTP id w2mr314830wad.1195540766175;
        Mon, 19 Nov 2007 22:39:26 -0800 (PST)
Received: by 10.114.158.17 with HTTP; Mon, 19 Nov 2007 22:39:26 -0800 (PST)
Message-ID: <eea8a9c90711192239q6009cbb8y76790fa73bc4a5b7@mail.gmail.com>
Date:	Tue, 20 Nov 2007 12:09:26 +0530
From:	kaka <share.kt@gmail.com>
To:	linux-mips@linux-mips.org, uclinux-dev@uclinux.org,
	celinux-dev@tree.celinuxforum.org,
	linux-fbdev-users@lists.sourceforge.net
Subject: Usage of mmap command
Cc:	directfb-users@directfb.org, directfb-dev@directfb.org
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_21593_1843271.1195540766162"
Return-Path: <share.kt@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: share.kt@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_21593_1843271.1195540766162
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,

void *mmap(void *start, size_t length, int prot, int flags,           int
fd, off_t offset);

I am providing 16,00,000 as length parameter in mmap command.
It is giving me error as Can't mmap region. on the other hand when i am
providing 9,00,000 as length parameter in mmap command.
It is successful.
This mmap command is being issued from User space.

On the other hand in the framebuffer driver in the kernel spce i have
specified the length of mmio in the ioremap as 16,00,000.

Can anybody provide any clue on it?
I want to access the mmio regs at offset ( 0 to  16,00,000).

-- 
Thanks & Regards,
kaka

------=_Part_21593_1843271.1195540766162
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi All,</div>
<div>&nbsp;</div>
<div>void *mmap(void *start, size_t length, int prot, int flags,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int<br>fd, off_t offset);<br>&nbsp;</div>
<div>I am providing 16,00,000 as length parameter in mmap command.</div>
<div>It is giving me error as Can&#39;t mmap region. on the other hand when i am providing 9,00,000 as length parameter in mmap command.</div>
<div>It is successful.<br clear="all">This mmap command is being issued from User space.</div>
<div>&nbsp;</div>
<div>On the other hand in the framebuffer driver in the kernel spce i have specified the length of mmio in the ioremap as 16,00,000.</div>
<div>&nbsp;</div>
<div>Can anybody provide any clue on it?</div>
<div>I want to access the mmio regs at offset (&nbsp;0 to&nbsp; 16,00,000).</div>
<div><br>-- <br>Thanks &amp; Regards,<br>kaka </div>

------=_Part_21593_1843271.1195540766162--
