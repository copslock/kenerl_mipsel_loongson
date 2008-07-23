Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2008 08:16:29 +0100 (BST)
Received: from wf-out-1314.google.com ([209.85.200.175]:39467 "EHLO
	wf-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20027385AbYGWHQ0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 Jul 2008 08:16:26 +0100
Received: by wf-out-1314.google.com with SMTP id 27so2100070wfd.21
        for <linux-mips@linux-mips.org>; Wed, 23 Jul 2008 00:16:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type;
        bh=y01RoQg/FYh12lNb5ucObbB4iU3dGmwnn1YIEVWA2+k=;
        b=sAQo5Lw56iQITLtw0BJDy9eon2rsHnwk3423jMjlnQNDg6QHFk7b5qnvBbkpuzcUQq
         b6Wr7zx2Mh0/2sWPVrVNr7IoF5YidsQkX8BXPKOwsjACHxolPI/TfiqNWb04kblf3Mar
         +N8ZtT6uOcE9s59bAjSkPkXN4ycZv9H6ObDZo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type;
        b=abit1QEcbI0EmZZrDKOpLfiMrvSVtaWg2hdJcPh75zkVx1lxVBS24KuaVfQmK5cCTp
         pCNhquZZjRugHklMEcCAs2/hqmmayl/vMifPj1NjqBgd0DggcCfmc1JiNWkHKdnP14IC
         1BIghHXaH/PE/ChqRyJkgftvmYoMGfcTBbd+w=
Received: by 10.142.148.10 with SMTP id v10mr2203302wfd.303.1216797384209;
        Wed, 23 Jul 2008 00:16:24 -0700 (PDT)
Received: by 10.142.108.7 with HTTP; Wed, 23 Jul 2008 00:16:24 -0700 (PDT)
Message-ID: <cf9b3c760807230016j6c1acc32qd1e54f3a9fa60403@mail.gmail.com>
Date:	Wed, 23 Jul 2008 12:46:24 +0530
From:	"Naresh Bhat" <nareshgbhat@gmail.com>
To:	linux-mips@linux-mips.org, linux-cvs@linux-mips.org
Subject: Kernel is Hanging for page size 16KB.
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_12321_6275097.1216797384184"
Return-Path: <nareshgbhat@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nareshgbhat@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_12321_6275097.1216797384184
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Guys,

I have a board MIPS Malta and Linux 2.6.10 is running on that. By default
4KB page size will be allocated in the kernel (I mean to say I saw it when I
do the "make menuconfig".

Problem is:

When I changed the page size to 16KB it will hang after mounting the file
system. I am using the NFS for booting the board.


Can anybody help me on this issue...

-- 
Thanks
Naresh Bhat

------=_Part_12321_6275097.1216797384184
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi Guys,<br><br>I have a board MIPS Malta and Linux 2.6.10 is running
on that. By default 4KB page size will be allocated in the kernel (I
mean to say I saw it when I do the &quot;make menuconfig&quot;.<br><br>
Problem is:<br><br>When I changed the page size to 16KB it will hang after mounting the file system. I am using the NFS for booting the board.<br clear="all"><br><br>Can anybody help me on this issue...<br><br>-- <br>Thanks<br>
Naresh Bhat<br></div>

------=_Part_12321_6275097.1216797384184--
