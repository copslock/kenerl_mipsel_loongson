Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2003 03:05:05 +0100 (BST)
Received: from [IPv6:::ffff:202.145.53.89] ([IPv6:::ffff:202.145.53.89]:29374
	"EHLO miao.coventive.com") by linux-mips.org with ESMTP
	id <S8225254AbTEICEx>; Fri, 9 May 2003 03:04:53 +0100
Received: from pc208 (PC208.ia.kh.coventive.com [192.168.23.208] (may be forged))
	by miao.coventive.com (8.11.6/8.11.6) with SMTP id h4924ex21902;
	Fri, 9 May 2003 10:04:43 +0800
Message-ID: <000a01c315cf$8171ac70$d017a8c0@pc208>
From: "smills_ho" <smills_ho@coventive.com>
To: "Linux/MIPS Development" <linux-mips@linux-mips.org>
Cc: <gcc@gcc.gnu.org>
References: <3EB0B329.9030603@ict.ac.cn> <16048.55936.346808.522687@cuddles.redhat.com> <3EB0DDC6.5080108@ict.ac.cn> <16048.57054.224964.883062@cuddles.redhat.com> <20030501085018.GA1885@greglaptop.attbi.com>
Subject: Problem of cross-mipsel-compiler GLIBC-2.3.X
Date: Fri, 9 May 2003 10:05:43 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Return-Path: <smills_ho@coventive.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: smills_ho@coventive.com
Precedence: bulk
X-list: linux-mips

Dear All,
    I want to make a cross-compilered glibc-2.3.x and I get the source from
ftp.gun.org. GCC version is 3.2.3, binutils is 2.13.2.1. The step is as
following:

1. Try to build binutils
2. Try to make static GCC
3. Try to make glibc -----> Then it is failed

Is there anybody know what's going on or somebody had successfully to build
the crossed glibc-2.3.x?

Thanks and best regs,
