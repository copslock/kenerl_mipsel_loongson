Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2007 01:07:01 +0000 (GMT)
Received: from wa-out-1112.google.com ([209.85.146.177]:53297 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20035053AbXKTBGw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Nov 2007 01:06:52 +0000
Received: by wa-out-1112.google.com with SMTP id m16so2184705waf
        for <linux-mips@linux-mips.org>; Mon, 19 Nov 2007 17:06:39 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        bh=DLY1KFEzs7t0PUvtwSV11AfhuxmnkPOFTvIUmKAW0Cc=;
        b=LYtMiUoCvDbLZfIzGdjVHVfAPTy6DhhEZINrAnqVRZ1qgNd5SMFlXP4s1ZmXkmTkC+jGL38NbiXI37T7Hp9GDsH68U9w0WbVPrCwPOCW9hdAlkvkrNxB4+Tvtkd6+UxvRt3RzungDI9uynI6fmAIRVf3qfh9QcIfc+Wtr7Qze4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=J0OnGD7fbO4OrAYuCe+vkCKWKeuGBLaQgq+Ezp8gBNlcdSXP2KfbZE9+ffaKF9NJnB4Fp9yyFaP2bxfsaWKysdIt4If54cqzMC8V57hevCF8Y6A1Gl8QgulwU8dOHgz+iRlgj3IZe5QDypQJNsPoo5vL88aB7Y/OkmjCTlFjro8=
Received: by 10.114.153.18 with SMTP id a18mr466804wae.1195520799136;
        Mon, 19 Nov 2007 17:06:39 -0800 (PST)
Received: by 10.114.168.15 with HTTP; Mon, 19 Nov 2007 17:06:39 -0800 (PST)
Message-ID: <50c9a2250711191706g40744ab2w2027124c4bc8dbbb@mail.gmail.com>
Date:	Tue, 20 Nov 2007 09:06:39 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: how to use memory before kernel load address?
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_24399_24804143.1195520799125"
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17537
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_24399_24804143.1195520799125
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hello,all
          i want to place my kernel loadaddr=0x81008000 and set
EBASE=0x81000000, it workes.
         but there is still some memory usable before 0x81000000, for
example from 0x80100000 ~ 0x80200000
         i have try to pass param as mem=1M@1M mem=16M@16M  to the kernel,
it seems only take the 0x8000000 ~ kernel_end as reserved.
         is there any other options to set the memory useable? ( my kernel
version is 2.6.14)
         thanks for any hints


zzh

------=_Part_24399_24804143.1195520799125
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hello,all<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i want to place
my kernel loadaddr=0x81008000 and set EBASE=0x81000000, it workes.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; but there is still
some memory usable before 0x81000000, for example from 0x80100000 ~
0x80200000<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i have try to pass
param as mem=1M@1M mem=16M@16M&nbsp; to the kernel,&nbsp; it seems only
take the 0x8000000 ~ kernel_end as reserved.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; is there any other
options to set the memory useable? ( my kernel version is 2.6.14)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; thanks for any hints<br>
<br>
<br>
zzh<br>

------=_Part_24399_24804143.1195520799125--
