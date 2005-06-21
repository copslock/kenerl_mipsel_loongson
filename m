Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jun 2005 23:59:30 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.194]:11716 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8224913AbVFUW7N> convert rfc822-to-8bit;
	Tue, 21 Jun 2005 23:59:13 +0100
Received: by wproxy.gmail.com with SMTP id 57so3196wri
        for <linux-mips@linux-mips.org>; Tue, 21 Jun 2005 15:57:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sbzyWzfqJnl8SRGwxjALrojGVJIeK2bJ6J3v899E/A2LrTSl5d1ddol/q8mxjmOZNaC4lL/3Zw3Ds6W3tSKztDFQya2m8ziZ09D7g7RNjzTBeBpyNVpfRItujzFFHuSntTGQTTMabgyjUS1fK3ThUk9utSLkTfg8f4QjZy40XUo=
Received: by 10.54.76.6 with SMTP id y6mr66545wra;
        Tue, 21 Jun 2005 15:57:59 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Tue, 21 Jun 2005 15:57:59 -0700 (PDT)
Message-ID: <2db32b720506211557673163e2@mail.gmail.com>
Date:	Tue, 21 Jun 2005 15:57:59 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Error duing compiling 2.4.29 using SDE for Db1550
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

The error is:

##pci_fixup.c:80: parse error before `prid'
pci_fixup.c:80: `__res' undeclared (first use in this function)
pci_fixup.c:80: (Each undeclared identifier is reported only once
pci_fixup.c:80: for each function it appears in.)
pci_fixup.c: At top level:
pci_fixup.c:80: parse error before `)'
pci_fixup.c:83: parse error before string constant
pci_fixup.c:83: warning: type defaults to `int' in declaration of `printk'
pci_fixup.c:83: warning: function declaration isn't a prototype
pci_fixup.c:83: warning: data definition has no type or storage class
pci_fixup.c:85: parse error before string constant
pci_fixup.c:85: warning: type defaults to `int' in declaration of `printk'
pci_fixup.c:85: warning: function declaration isn't a prototype
pci_fixup.c:85: warning: data definition has no type or storage class
pci_fixup.c:134: warning: `fixup_resource' defined but not used
make[1]: *** [pci_fixup.o] Error 1
make[1]: Leaving directory `/home/rolf/linux/arch/mips/au1000/common'
make: *** [_dir_arch/mips/au1000/common] Error 2
#

I can't find where __res is used in pci_fixup.c. Any suggestions?

Thanks
