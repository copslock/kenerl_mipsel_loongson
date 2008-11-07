Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2008 09:44:44 +0000 (GMT)
Received: from fk-out-0910.google.com ([209.85.128.188]:23648 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S23328653AbYKGJom (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Nov 2008 09:44:42 +0000
Received: by fk-out-0910.google.com with SMTP id b27so1299084fka.0
        for <linux-mips@linux-mips.org>; Fri, 07 Nov 2008 01:44:40 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type;
        bh=8whUIU07qyjAVlFkbQlFIid8J3OoT/MpL0/FHvOKCPE=;
        b=gB6Bn3mByUpU+nPBf++s0O4MqAIdhjkNoEpxNNE9M1gmKkkR6yVnRq9rlztyORfkl4
         O9vP2C5qCFFsa9o6v4ZrW4ZYUwBy1N6tphFFwCLxRcgvTg9N0aRlrWBqW+65C7Y3sMAA
         HTijGCTdVcVDGrGR0pSF/oL9axCg8+4irfeCw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type;
        b=EuS+BwAPlE/8ImX1OEfO4WENKsEPIfZa0bt2GYTRIz5Jsjfub4KDTTvpu10ZxomL6I
         y78U1ZscWiO5l3jeGSnqxY6aEM46XYmuRmX5zJfbJ0tP5uq+esdhLm8P4EH7F1v6yr7J
         WQ+lPDin60Mz0lqVt1t9V6T8l2im2ZtfB1l58=
Received: by 10.181.55.2 with SMTP id h2mr987191bkk.52.1226051080169;
        Fri, 07 Nov 2008 01:44:40 -0800 (PST)
Received: by 10.181.21.7 with HTTP; Fri, 7 Nov 2008 01:44:40 -0800 (PST)
Message-ID: <f20f2d1b0811070144o79e6b84dp4e0cae40a5cd748c@mail.gmail.com>
Date:	Fri, 7 Nov 2008 17:44:40 +0800
From:	"Lennox Wu" <lennox.wu@gmail.com>
To:	linux-mips@linux-mips.org
Subject: The flush_cache_all() is empty, but it is still called by some function? And what's the difference between flush_cache_all() and __flush_cache_all()?
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_43334_33001322.1226051080136"
Return-Path: <lennox.wu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21228
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lennox.wu@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_43334_33001322.1226051080136
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
    I traced the cache operations of R3000 and R4000  (the Kernel version is
2.6.27).
I found the flush_cache_all() is empty, but it is still called by some
function, e.g. remap_area_pages() .
I don't understand why the function is empty and what's the difference
between flush_cache_all() and
__flush_cache_all(). Does calling a empty flush_cache_all() make some
problem ?

Thanks,
Lennox

------=_Part_43334_33001322.1226051080136
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>Hi,<br>&nbsp;&nbsp;&nbsp; I traced the cache operations of R3000 and R4000&nbsp; (the Kernel version is 2.6.27).<br>I found the flush_cache_all() is empty, but it is still called by some function, e.g. remap_area_pages() .<br>I don&#39;t understand why the function is empty and what&#39;s the difference between flush_cache_all() and <br>
__flush_cache_all(). Does calling a empty flush_cache_all() make some problem ?<br>&nbsp;&nbsp;&nbsp; <br>Thanks, <br>Lennox<br><br>

------=_Part_43334_33001322.1226051080136--
