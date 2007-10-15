Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2007 21:14:53 +0100 (BST)
Received: from dmz.mips-uk.com ([194.74.144.194]:37125 "EHLO dmz.mips-uk.com")
	by ftp.linux-mips.org with ESMTP id S20037654AbXJOUOp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 15 Oct 2007 21:14:45 +0100
Received: from internal-mx1 ([192.168.192.240] helo=ukservices1.mips.com)
	by dmz.mips-uk.com with esmtp (Exim 3.35 #1 (Debian))
	id 1IhWHa-0001Lw-00; Mon, 15 Oct 2007 21:11:22 +0100
Received: from ukcvpn18.mips-uk.com ([192.168.193.18])
	by ukservices1.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1IhWHN-0002xz-00; Mon, 15 Oct 2007 21:11:10 +0100
Message-ID: <4713C958.8080805@mips.com>
Date:	Mon, 15 Oct 2007 21:11:04 +0100
From:	Nigel Stephens <nigel@mips.com>
User-Agent: IceDove 1.5.0.12 (X11/20070607)
MIME-Version: 1.0
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
CC:	Thiemo Seufer <ths@networkno.de>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
References: <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com> <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl> <4705EFE5.7090704@gmail.com> <Pine.LNX.4.64N.0710051312490.17849@blysk.ds.pg.gda.pl> <470A4349.9090301@gmail.com> <Pine.LNX.4.64N.0710081611460.8873@blysk.ds.pg.gda.pl> <470BE1F4.3070800@gmail.com> <Pine.LNX.4.64N.0710101231290.9821@blysk.ds.pg.gda.pl> <47126EDC.1060305@gmail.com> <20071014195324.GT3379@networkno.de> <4713C11F.3010903@gmail.com>
In-Reply-To: <4713C11F.3010903@gmail.com>
X-Enigmail-Version: 0.94.2.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MIPS-Technologies-UK-MailScanner: Found to be clean
X-MIPS-Technologies-UK-MailScanner-From: nigel@mips.com
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips



Franck Bui-Huu wrote:
> Thiemo Seufer wrote:
>   
>> Could you check what "-march=mips32r2 -smartmips -mtune=4ksd" does?
>> I expect it to have the same result than "-march=4ksd".
>>
>>     
>
> OK, I give it a try and here are some figures:
>
> $ mipsel-linux-size mipssde-6.05.00-20061023/vmlinux~*
>    text    data     bss     dec     hex filename
> 1446130   58456   93056 1597642  1860ca mipssde-6.05.00-20061023/vmlinux~4ksd
> 1472034   58456   93056 1623546  18c5fa mipssde-6.05.00-20061023/vmlinux~mips32r2-smartmips
> 1446130   58456   93056 1597642  1860ca mipssde-6.05.00-20061023/vmlinux~mips32r2-smartmips-mtune4ksd
>
> So you're right "-march=mips32r2 -smartmips -mtune=4ksd" gives the
> same result as "-march=4ksd"
>
>   

IIRC that should be -msmartmips, not -smartmips.

> And the extra space given by "-march=mips32r2 -smartmips" is coming
> from some additional nop instructions:
>
> $ mipsel-linux-objdump -D vmlinux~mips32r2-smartmips > vmlinux~mips32r2-smartmips.S
> $ mipsel-linux-objdump -D vmlinux~4ksd > vmlinux~4ksd.S
> $ grep -c nop *.S
> vmlinux~4ksd.S:18708
> vmlinux~mips32r2-smartmips.S:27895
>
> It seems that these extra nops are used for load delays. For example:
>
> vmlinux~4ksd.S:
> --------------
> <snip>
> c00008b4:      8fa40040        lw      a0,64(sp)
> c00008b8:      27a40018        addiu   a0,sp,24
> c00008bc:      0c000148        jal     c0000520 <try_name>
> <snip>
>
> vmlinux~mips32r2-smartmips.S:
> ---------------------------
> c00008b8:      8fa40040        lw      a0,64(sp)
> c00008bc:      00000000        nop
> c00008c0:      27a40018        addiu   a0,sp,24
> c00008c4:      0c000148        jal     c0000520 <try_name>
>
>   

That's weird: load delay slots should only be required by -march=mips1 
(or no -march)

Are you sure that the -march=mips32r2 option is really getting passed to 
the compiler and assembler?

Nigel
