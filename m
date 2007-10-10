Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2007 11:02:07 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.183]:14131 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20022052AbXJJKB6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Oct 2007 11:01:58 +0100
Received: by py-out-1112.google.com with SMTP id p76so282951pyb
        for <linux-mips@linux-mips.org>; Wed, 10 Oct 2007 03:01:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        bh=SJWwjpylsBmkv/FrwH874el0pwsFER/AGTiVBQQE3GU=;
        b=WVerdxmSlfGUvMPPbZVyYmGSXwoBdOsq5s9BZ3eMHBxo8CnSKhw57Gm+X/S1LyE/KyJ/gDd9f03CQyFViHD5UTVbd57ZltJgjKbjzx4scmsKQnF+DmgcB9LOxt4jptNTSImbQxK//5A42AcZ+IGRabWWu+50fC/9ZAq8d9MYmlk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=txieATFF3KwZVRPuuyRP/8bIcq6LIjPodIFV5XFBQS3dk+TJWeoJZIIFUAty4m0xCRGBTqVg3ajqkVpuRLS6WA74FVxWyG5Ihk8GGtGyCjRnqiDJvqXDYUlkNOiM+09bL0XV/rmpqmXXE7YpgPa+dCFtxOeYwJurARYf5VKoG1w=
Received: by 10.35.109.2 with SMTP id l2mr626763pym.1192010494573;
        Wed, 10 Oct 2007 03:01:34 -0700 (PDT)
Received: by 10.35.39.19 with HTTP; Wed, 10 Oct 2007 03:01:34 -0700 (PDT)
Message-ID: <eea8a9c90710100301k391adf0bt6b6ff4f5803b0ecd@mail.gmail.com>
Date:	Wed, 10 Oct 2007 15:31:34 +0530
From:	kaka <share.kt@gmail.com>
To:	linux-mips@linux-mips.org
Subject: cross compiling kernel image for MIPS platform in Linux Intel box
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_53617_628129.1192010494573"
Return-Path: <share.kt@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: share.kt@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_53617_628129.1192010494573
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,

I have cross compiled kernel image for MIPS platform in Linux Intel box.
But when i am booting the image in the MIPS board.
There are 2 problems.
1.  Could not load vmlinuz:I/O error
2. The size of the image is huge.

Can somebody help in this regard?
If somebody have proper config file or steps for building the kernel image
for MIPS, then please mail me.
Thanks in advance.

-- 
Thanks & Regards,
kaka

------=_Part_53617_628129.1192010494573
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi All,</div>
<div>&nbsp;</div>
<div>I have cross compiled kernel image for MIPS platform in Linux Intel box.</div>
<div>But when i am booting the image in the MIPS board.</div>
<div>There are 2 problems.</div>
<div>1.&nbsp; Could not load vmlinuz:I/O error</div>
<div>2. The size of the image is huge.</div>
<div>&nbsp;</div>
<div>Can somebody help in this regard?</div>
<div>If somebody have proper config file or steps for building the kernel image for MIPS, then please mail me.</div>
<div>Thanks in advance.<br clear="all"><br>-- <br>Thanks &amp; Regards,<br>kaka </div>

------=_Part_53617_628129.1192010494573--
