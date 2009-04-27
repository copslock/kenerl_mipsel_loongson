Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Apr 2009 04:43:58 +0100 (BST)
Received: from yw-out-1718.google.com ([74.125.46.154]:30442 "EHLO
	yw-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024966AbZD0Dnv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 27 Apr 2009 04:43:51 +0100
Received: by yw-out-1718.google.com with SMTP id 9so1303774ywk.24
        for <linux-mips@linux-mips.org>; Sun, 26 Apr 2009 20:43:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aG+abH2vJEVDIEv3I02KMQ7GR3AVeR6YgmC9Qn++tYw=;
        b=kgrd1AjcEx1qMpZyZxmNFbm6ZZpedrQa+8303Si74dGKljjoz21PCkQKAHtkRqi/xk
         We5B+t2JD1GgcMsn2onkAd3A3eoM3+lTnJtuk1IlGAFEX0Wz8jcSZ15VE9G/lyZ/NMN/
         m4vhazRU/mdeLqCFKa5PYmL1UbmjpF50GtI7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=G/1f2wB9haH1wukPOkMc0MKyIfl4Zm+TehaQxh+c2X8bz4fJNGjSWL26JGja1AooDh
         4P4O295y9KbasX9i81oMx+n3AoKmovJYcV9omY30QQ2+oyQH/ICugeC7t4IQen31qY8F
         fHYr0o/2d6FVJHi4rqh0canHjBwHA+v1YTVpI=
MIME-Version: 1.0
Received: by 10.151.129.5 with SMTP id g5mr8032351ybn.235.1240803829685; Sun, 
	26 Apr 2009 20:43:49 -0700 (PDT)
In-Reply-To: <777f39b10904262033o124be1f1o22297da7c67f9dbd@mail.gmail.com>
References: <777f39b10904262033o124be1f1o22297da7c67f9dbd@mail.gmail.com>
Date:	Mon, 27 Apr 2009 11:43:49 +0800
Message-ID: <777f39b10904262043l29558defu61c7caa0d454730d@mail.gmail.com>
Subject: =?GB2312?Q?Re=3A_how_to_debug_mips_AdEL_error=A3=BF_Cause_register=27s?=
	=?GB2312?Q?_ExcCode_field_equal_to_=274=27_=28AdEL=29?=
From:	Bob Zhang <2004.zhang@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	"bob.zhang2004" <bob.zhang2004@gmail.com>,
	"Christophe.Carvounas" <christophe.carvounas@gmail.com>,
	Bob Zhang <2004.zhang@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <2004.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: 2004.zhang@gmail.com
Precedence: bulk
X-list: linux-mips

through the kernel panic info:
CPU Regs : ===========================================================
$0 : 00000000 80290000 00000100 fffdffff 00000007 00000006 8023427c 820e83d4
$8 : 00000000 00000000 00000000 820e83dc 820e83f4 820e8000 80278010 00000000
$16: 8028f7b8 0000d32b 0000132b 802a53a0 0000d34d 7fff7d48 00000004 00000014
$24: 8200000c 2abe4090                   820e8000 820e9e70 00000000 0000000a

we can know , the ra register is 0x0000000a
after sub-function executed completely , it will return $ra.

through code trace , I know the last function is "__call_console_drivers" .

I dissable the vmlinux code,

and grab section:

00000000800b9364 <__call_console_drivers>:
    800b9364:	27bdffd8 	addiu	$sp,$sp,-40
    800b9368:	afb00010 	sw	$s0,16($sp)
    800b936c:	3c108028 	lui	$s0,0x8028
    800b9370:	8e107d1c 	lw	$s0,32028($s0)
    800b9374:	afb10014 	sw	$s1,20($sp)
    800b9378:	00808821 	move	$s1,$a0
    800b937c:	afb40020 	sw	$s4,32($sp)
    800b9380:	00a0a021 	move	$s4,$a1
    800b9384:	afbf0024 	sw	$ra,36($sp)    #save ra into SP
    800b9388:	afb3001c 	sw	$s3,28($sp)
    800b938c:	12000012 	beqz	$s0,800b93d8 <__call_console_drivers+74>
    800b9390:	afb20018 	sw	$s2,24($sp)
    800b9394:	32323fff 	andi	$s2,$s1,0x3fff
    800b9398:	3c13802a 	lui	$s3,0x802a
    800b939c:	267353a0 	addiu	$s3,$s3,21408
    800b93a0:	9602001c 	lhu	$v0,28($s0)
    800b93a4:	30420004 	andi	$v0,$v0,0x4
    800b93a8:	50400009 	beqzl	$v0,800b93d0 <__call_console_drivers+6c>
    800b93ac:	8e100024 	lw	$s0,36($s0)
    800b93b0:	8e020008 	lw	$v0,8($s0)
    800b93b4:	50400006 	beqzl	$v0,800b93d0 <__call_console_drivers+6c>
    800b93b8:	8e100024 	lw	$s0,36($s0)
    800b93bc:	02002021 	move	$a0,$s0
    800b93c0:	02532821 	addu	$a1,$s2,$s3
    800b93c4:	0040f809 	jalr	$v0
    800b93c8:	02913023 	subu	$a2,$s4,$s1
    800b93cc:	8e100024 	lw	$s0,36($s0)
    800b93d0:	5600fff4 	bnezl	$s0,800b93a4 <__call_console_drivers+40>
    800b93d4:	9602001c 	lhu	$v0,28($s0)
    800b93d8:	8fbf0024 	lw	$ra,36($sp)
    800b93dc:	8fb40020 	lw	$s4,32($sp)
    800b93e0:	8fb3001c 	lw	$s3,28($sp)
    800b93e4:	8fb20018 	lw	$s2,24($sp)
    800b93e8:	8fb10014 	lw	$s1,20($sp)
    800b93ec:	8fb00010 	lw	$s0,16($sp)
    800b93f0:	03e00008 	jr	$ra                      # error should be here.
    800b93f4:	27bd0028 	addiu	$sp,$sp,40



Any comment? thanks.
