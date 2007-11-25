Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Nov 2007 12:29:51 +0000 (GMT)
Received: from wa-out-1112.google.com ([209.85.146.183]:62058 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20032663AbXKYM3n (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 25 Nov 2007 12:29:43 +0000
Received: by wa-out-1112.google.com with SMTP id m16so397511waf
        for <linux-mips@linux-mips.org>; Sun, 25 Nov 2007 04:29:30 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        bh=JEiy+YF1SU11hb8V+AFo7uPH0pjIlltlFtGpWpN5+eE=;
        b=UCmwoIW2TpCFfP2IAWUhxIc1DgfErv8FA+FW0go9V1NGy0H+6j33e5LeVPfmq78Mo4+LHPz76+GWDO2AH43Ky2CYvdFmgE35QLzYMYq1djo4VAdG8HKq/Wnn2uKlzh+C9t5AF0jTMlImpC6z0nX9/7Kxun1tOu3q7CO2yqVA9Ks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=E96zLSvffVTkbWhRF3S9n0Y4BjCLGIBepfhUimdl1Vm30fP+i9489S/TJpm9MLpcnR1chpdT+CuCjAPdIC3/EV259jhKbbwAmkuDOzmUYKKYF+mk3HixjSmNEMOykMu4RwFOnWTx/BVbsJW8T9pRyTzZUBSETdhEBeKmS080GoY=
Received: by 10.114.153.18 with SMTP id a18mr34312wae.1195993770311;
        Sun, 25 Nov 2007 04:29:30 -0800 (PST)
Received: by 10.114.158.17 with HTTP; Sun, 25 Nov 2007 04:29:30 -0800 (PST)
Message-ID: <eea8a9c90711250429v3de6b33ra00fecb39e81a8a7@mail.gmail.com>
Date:	Sun, 25 Nov 2007 17:59:30 +0530
From:	kaka <share.kt@gmail.com>
To:	linux-mips@linux-mips.org, uclinux-dev@uclinux.org,
	celinux-dev@tree.celinuxforum.org,
	linux-fbdev-users@lists.sourceforge.net
Subject: Usage of mmap command(in directFB)
Cc:	directfb-users@directfb.org, directfb-dev@directfb.org
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_35026_14554447.1195993770305"
Return-Path: <share.kt@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17573
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: share.kt@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_35026_14554447.1195993770305
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,

void *mmap(void *start, size_t length, int prot, int flags,           int
fd, off_t offset);

I am providing 1.6MB as length parameter in mmap command.
It is giving me error as Can't mmap region with error number EINVAL. I
searched for the probable causes for EINVAL error number, and cheked it that
i am satisfying all of them

on the other hand when i am providing 1.384MB as length parameter in mmap
command.
It is successful.
This mmap command is being issued from User space(from the DIrectFB code in
systems/fbdev.c)

The exact command which i am writing is
addr = mmap(NULL, dfb_fbdev->shared->fix.mmio_len, PROT_READ | PROT_WRITE,
MAO_SHARED, dfb_fbdev->fd, 0);

Can anybody provide any clue on it?
I want to access the mmio regs at offset (0.9MB to 1.6MB offset).
Also in my system MIPS board(broadcom chip), the framebuffer driver contains
support for MMIO length as 1.6MB.

-- 
Thanks & Regards,
kaka


-- 
Thanks & Regards,
kaka

------=_Part_35026_14554447.1195993770305
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

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
<div><br>-- <br>Thanks &amp; Regards,<br>kaka </div><br clear="all"><br>-- <br>Thanks &amp; Regards,<br>kaka 

------=_Part_35026_14554447.1195993770305--
