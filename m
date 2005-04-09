Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Apr 2005 13:09:38 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.206]:44999 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8225742AbVDIMJX> convert rfc822-to-8bit;
	Sat, 9 Apr 2005 13:09:23 +0100
Received: by wproxy.gmail.com with SMTP id 57so896427wri
        for <linux-mips@linux-mips.org>; Sat, 09 Apr 2005 05:09:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=SL75hivYYRvQENuVO+yKsnInxdsLpmeln7ilZ2hyR9bgjlq7VGFusnnpMn9GFxeou0jLyRF5rtfNxbpNTxaPYVTOETYzCTrtZ588BLWwgYPA85pik68jcNRdexvNt3m1ejgTPnOSOWylaHAXR0rhmahFPqQ+Z5CP40wmBo5T3RE=
Received: by 10.54.50.73 with SMTP id x73mr556190wrx;
        Sat, 09 Apr 2005 05:09:14 -0700 (PDT)
Received: by 10.54.38.20 with HTTP; Sat, 9 Apr 2005 05:09:14 -0700 (PDT)
Message-ID: <e02bc66105040905091efb3dc6@mail.gmail.com>
Date:	Sat, 9 Apr 2005 14:09:14 +0200
From:	Sergio Ruiz <quekio@gmail.com>
Reply-To: Sergio Ruiz <quekio@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Linking assembled PIC code with Linux libc library
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <quekio@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7666
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quekio@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, i can't link assembled pic code against the libc running my
embedded-mips-box under debian, and this is what i do:

bluebox@bluebox:~$ as -al -EL -membedded-pic -mips1 -o prueba."o" prueba."s"

ld -L/usr/lib -lc -EL -o prueba prueba.o
ld: aviso: no se puede encontrar el símbolo de entrada __start; usando
por omisión 0000000000400280
prueba.o: En la función `main':
prueba.o(.text+0x8): relocation truncated to fit: R_MIPS_GNU_REL16_S2
printf@@GLIBC_2.0

I've been looking everywhere without any luck.
Any help is appreciated!
Thanks
