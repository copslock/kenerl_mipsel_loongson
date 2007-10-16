Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Oct 2007 13:59:21 +0100 (BST)
Received: from dmz.mips-uk.com ([194.74.144.194]:55053 "EHLO dmz.mips-uk.com")
	by ftp.linux-mips.org with ESMTP id S20039963AbXJPM7N (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 16 Oct 2007 13:59:13 +0100
Received: from internal-mx1 ([192.168.192.240] helo=ukservices1.mips.com)
	by dmz.mips-uk.com with esmtp (Exim 3.35 #1 (Debian))
	id 1Ihm0t-0003yA-00; Tue, 16 Oct 2007 13:59:11 +0100
Received: from ukcvpn18.mips-uk.com ([192.168.193.18])
	by ukservices1.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Ihm0h-0003PF-00; Tue, 16 Oct 2007 13:58:59 +0100
Message-ID: <4714B58E.8020005@mips.com>
Date:	Tue, 16 Oct 2007 13:58:54 +0100
From:	Nigel Stephens <nigel@mips.com>
User-Agent: IceDove 1.5.0.12 (X11/20070607)
MIME-Version: 1.0
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
CC:	Thiemo Seufer <ths@networkno.de>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
References: <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com> <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl> <4705EFE5.7090704@gmail.com> <Pine.LNX.4.64N.0710051312490.17849@blysk.ds.pg.gda.pl> <470A4349.9090301@gmail.com> <Pine.LNX.4.64N.0710081611460.8873@blysk.ds.pg.gda.pl> <470BE1F4.3070800@gmail.com> <Pine.LNX.4.64N.0710101231290.9821@blysk.ds.pg.gda.pl> <47126EDC.1060305@gmail.com> <20071014195324.GT3379@networkno.de> <4713C11F.3010903@gmail.com> <4713C958.8080805@mips.com> <47147551.1010004@gmail.com>
In-Reply-To: <47147551.1010004@gmail.com>
X-Enigmail-Version: 0.94.2.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MIPS-Technologies-UK-MailScanner: Found to be clean
X-MIPS-Technologies-UK-MailScanner-From: nigel@mips.com
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips



Franck Bui-Huu wrote:
> cmd_kernel/user.o := mipsel-linux-gcc -Wp,-MD,kernel/.user.o.d  -nostdinc -isystem /usr/lib/gcc/mipsel-linux/3.4.4/include -D__KERNEL__ -Iinclude  -include include/linux/autoconf.h -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -O2  -mabi=32 -G 0 -mno-abicalls -fno-pic -pipe -msoft-float -ffreestanding  -march=mips32r2 -Wa,-mips32r2 -Wa,--trap -msmartmips -Iinclude/asm-mips/mach-usip -Iinclude/asm-mips/mach-generic -D"VMLINUX_LOAD_ADDRESS=0xffffffffc0000000" -fomit-frame-pointer -g  -Wdeclaration-after-statement     -D"KBUILD_STR(s)=\#s" -D"KBUILD_BASENAME=KBUILD_STR(user)"  -D"KBUILD_MODNAME=KBUILD_STR(user)" -c -o kernel/user.o kernel/user.c
>
>   

Could you run that gcc command manually, adding the options "-v 
--save-temps", and post the resulting output messages, and the user.s file.

Nigel
