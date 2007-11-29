Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Nov 2007 05:49:54 +0000 (GMT)
Received: from wr-out-0506.google.com ([64.233.184.234]:1428 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20023068AbXK2Ftq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 Nov 2007 05:49:46 +0000
Received: by wr-out-0506.google.com with SMTP id 67so1479040wri
        for <linux-mips@linux-mips.org>; Wed, 28 Nov 2007 21:48:44 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        bh=tIpK1S7RUrvimCqJjunIXmLgtNnqwdlZruVg9h1lvew=;
        b=cfFvrJTDutxYu/xfhBeG107yN5SLUidd9kK+uqt/k8+cpS/ypciO3PwctNX2l6MnDUr6+vYjtVJ9M+GouWNm+bZlt+Yu8Gv8BG5QbQkJNntzJ6HAW+ADVpTMKm+caiXCElaO/09dzTjVC8XZrRPRPfVyzB5fh4XMZ5DmOrPURUg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=EgQcLRlH6Q0Cf5Pylmokd9g8CjcaQD5Nsju0WBB+9YGVjjLGR8GmugF4RgdPnjcUTqRksmq3rKgGkvoeh+FXTPkXU60gQOfvNIVGfJb5h0Jz/OdfXsMkrcQcMegXdOEPghU8pmBP2lufdXGKKLQ3jtUNFtnSsaD1c5TJ4wyGJ64=
Received: by 10.114.209.1 with SMTP id h1mr631902wag.1196315323282;
        Wed, 28 Nov 2007 21:48:43 -0800 (PST)
Received: by 10.114.135.16 with HTTP; Wed, 28 Nov 2007 21:48:43 -0800 (PST)
Message-ID: <eea8a9c90711282148g67ec85e0q9decd3e0e1f4325f@mail.gmail.com>
Date:	Thu, 29 Nov 2007 11:18:43 +0530
From:	kaka <share.kt@gmail.com>
To:	linux-mips@linux-mips.org, uclinux-dev@uclinux.org,
	celinux-dev@tree.celinuxforum.org,
	linux-fbdev-users@lists.sourceforge.net
Subject: Problem in the usage of mmap command(in directFB)
Cc:	directfb-users@directfb.org, directfb-dev@directfb.org
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_9132_25423566.1196315323274"
Return-Path: <share.kt@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: share.kt@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_9132_25423566.1196315323274
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> Hi All,
>
> void *mmap(void *start, size_t length, int prot, int flags,           int
> fd, off_t offset);
>
> I am providing 1.6MB as length parameter in mmap command.
> It is giving me error as Can't mmap region with error number EINVAL. I
> searched for the probable causes for EINVAL error number, and cheked it that
> i am satisfying all of them
>
> on the other hand when i am providing 1.384MB as length parameter in mmap
> command.
> It is successful.
> This mmap command is being issued from User space(from the DIrectFB code
> in systems/fbdev.c)
>
> The exact command which i am writing is
> addr = mmap(NULL, dfb_fbdev->shared->fix.mmio_len, PROT_READ | PROT_WRITE,
> MAO_SHARED, dfb_fbdev->fd, 0);
>
> Can anybody provide any clue on it?
> I want to access the mmio regs at offset (0.9MB to 1.6MB offset).
> Also in my system MIPS board(broadcom chip), the framebuffer driver
> contains support for MMIO length as 1.6MB.
>
> --
> Thanks & Regards,
> kaka
>

------=_Part_9132_25423566.1196315323274
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>Hi All,</div>
<div>&nbsp;</div>
<div>void *mmap(void *start, size_t length, int prot, int flags,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int<br>fd, off_t offset);<br>&nbsp;</div>
<div>I am providing&nbsp;1.6MB as length parameter in mmap command.</div>
<div>It is giving me error as Can&#39;t mmap region with error number EINVAL. I searched for the probable causes for EINVAL error number, and cheked it that i am satisfying all of them</div>
<div>&nbsp;</div>
<div>on the other hand when i am providing&nbsp;1.384MB as length parameter in mmap command.</div>
<div>It is successful.<br clear="all">This mmap command is being issued from User space(from the DIrectFB code in systems/fbdev.c)</div>
<div>&nbsp;</div>
<div>The exact command which i am writing is </div>
<div>addr = mmap(NULL, dfb_fbdev-&gt;shared-&gt;fix.mmio_len, PROT_READ | PROT_WRITE, MAO_SHARED, dfb_fbdev-&gt;fd, 0);</div>
<div>&nbsp;</div>
<div>Can anybody provide any clue on it?</div>
<div>I want to access the mmio regs at offset (0.9MB to 1.6MB offset).</div>
<div>Also&nbsp;in my system MIPS board(broadcom chip), the framebuffer driver contains support for MMIO length as 1.6MB. </div>
<div><br>-- <br>Thanks &amp; Regards,<br>kaka </div></blockquote></div>

------=_Part_9132_25423566.1196315323274--
