Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Apr 2006 03:49:57 +0100 (BST)
Received: from nproxy.gmail.com ([64.233.182.186]:17401 "EHLO nproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133659AbWDWCtt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 23 Apr 2006 03:49:49 +0100
Received: by nproxy.gmail.com with SMTP id y38so569880nfb
        for <linux-mips@linux-mips.org>; Sat, 22 Apr 2006 20:02:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LxFjdRsJlNbYF+o3mWJpoyGmwlNAaC0xWdn71rtatRYQYEhnH44TTSiIqlz3BUQkZKKk+8gbVs2OadNM9/jt5YPvezajReuWjcfoaTb1aUa5DrsLTSP13eRZ5/PlFZuPiW76i2I9HSYyO2Oj3k4CeRAmUeFfYEIYQVKoQYMg+Ss=
Received: by 10.49.88.2 with SMTP id q2mr263701nfl;
        Sat, 22 Apr 2006 20:02:46 -0700 (PDT)
Received: by 10.48.144.12 with HTTP; Sat, 22 Apr 2006 20:02:46 -0700 (PDT)
Message-ID: <50c9a2250604222002x37b949fbi585ed5fb31087d5@mail.gmail.com>
Date:	Sun, 23 Apr 2006 11:02:46 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: "relocation truncated to fit: R_MIPS_CALL16"
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11176
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

i want to write a mini bootloader for my board, so i need jump to c
code from asm code
but when i compile and ld, i get "relocation truncated to fit:
R_MIPS_CALL16" messages for every function call..
i have try the mips_4KCle-gcc(worked for u-boot),
mips_fp_le-gcc(worked for mvita linux), and also a
mipsel-linux-gcc(worked for my linux 2.6 kernel), but they all failed,
even i add -G0 to gcc.
and i only compile success by using mips-elf-gcc under cygwin.
does it be caused by binutils version? or gcc compile CFLAGS?
thanks for any hints

Best Regards

Zhuzhenhua
