Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Oct 2007 09:25:56 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.191]:33558 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20024027AbXJPIZq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Oct 2007 09:25:46 +0100
Received: by nf-out-0910.google.com with SMTP id c10so1503877nfd
        for <linux-mips@linux-mips.org>; Tue, 16 Oct 2007 01:25:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=KHrtkvQNqkFDBL5muiW1d65bOAh5y4/yCEl7UXcm0i0=;
        b=Djvn9eslx19pgx4ro9TwKUBsbcsrPSj9DtBymLDJq5oc6WkO+7gKFA9DmV67vHITOuL6pYUz0fi2sGTLmYRTo6R1NsYhLEZ1AWii7WbdbUbP3rNP8Op7VobdZhX7tcgnhv53jNX1/QTdCTo4a7IGq1HOgkmu9M5fxcngD8WOTYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=dbfUjQvgTPtuoPfZqtQPOseMNCpJJzfL7k5g2RfVKkdYAh0iMF34UV0K/etyf1e6hq/jnRC12PX4bRtnPjsfYpMdK0FXsZWzVgogq3yo2/l9rU/hr27tO+cXBVOtLb38eQK6ZD9HwmdvCIyl29hCUDQC/y4GimvVwxCgYJGtcqk=
Received: by 10.86.62.3 with SMTP id k3mr5682961fga.1192523145888;
        Tue, 16 Oct 2007 01:25:45 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id a37sm9725066fkc.2007.10.16.01.25.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Oct 2007 01:25:44 -0700 (PDT)
Message-ID: <47147551.1010004@gmail.com>
Date:	Tue, 16 Oct 2007 10:24:49 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Nigel Stephens <nigel@mips.com>
CC:	Thiemo Seufer <ths@networkno.de>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
References: <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com> <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl> <4705EFE5.7090704@gmail.com> <Pine.LNX.4.64N.0710051312490.17849@blysk.ds.pg.gda.pl> <470A4349.9090301@gmail.com> <Pine.LNX.4.64N.0710081611460.8873@blysk.ds.pg.gda.pl> <470BE1F4.3070800@gmail.com> <Pine.LNX.4.64N.0710101231290.9821@blysk.ds.pg.gda.pl> <47126EDC.1060305@gmail.com> <20071014195324.GT3379@networkno.de> <4713C11F.3010903@gmail.com> <4713C958.8080805@mips.com>
In-Reply-To: <4713C958.8080805@mips.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17058
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Nigel Stephens wrote:
> 
> 
> Franck Bui-Huu wrote:
>> Thiemo Seufer wrote:
>>  
>>> Could you check what "-march=mips32r2 -smartmips -mtune=4ksd" does?
>>> I expect it to have the same result than "-march=4ksd".
>>>
>>>     
>>
>> OK, I give it a try and here are some figures:
>>
>> $ mipsel-linux-size mipssde-6.05.00-20061023/vmlinux~*
>>    text    data     bss     dec     hex filename
>> 1446130   58456   93056 1597642  1860ca
>> mipssde-6.05.00-20061023/vmlinux~4ksd
>> 1472034   58456   93056 1623546  18c5fa
>> mipssde-6.05.00-20061023/vmlinux~mips32r2-smartmips
>> 1446130   58456   93056 1597642  1860ca
>> mipssde-6.05.00-20061023/vmlinux~mips32r2-smartmips-mtune4ksd
>>
>> So you're right "-march=mips32r2 -smartmips -mtune=4ksd" gives the
>> same result as "-march=4ksd"
>>
>>   
> 
> IIRC that should be -msmartmips, not -smartmips.

yes '-msmartmips' is used.

> 
>> And the extra space given by "-march=mips32r2 -smartmips" is coming
>> from some additional nop instructions:
>>
>> $ mipsel-linux-objdump -D vmlinux~mips32r2-smartmips >
>> vmlinux~mips32r2-smartmips.S
>> $ mipsel-linux-objdump -D vmlinux~4ksd > vmlinux~4ksd.S
>> $ grep -c nop *.S
>> vmlinux~4ksd.S:18708
>> vmlinux~mips32r2-smartmips.S:27895
>>
>> It seems that these extra nops are used for load delays. For example:
>>
>> vmlinux~4ksd.S:
>> --------------
>> <snip>
>> c00008b4:      8fa40040        lw      a0,64(sp)
>> c00008b8:      27a40018        addiu   a0,sp,24
>> c00008bc:      0c000148        jal     c0000520 <try_name>
>> <snip>
>>
>> vmlinux~mips32r2-smartmips.S:
>> ---------------------------
>> c00008b8:      8fa40040        lw      a0,64(sp)
>> c00008bc:      00000000        nop
>> c00008c0:      27a40018        addiu   a0,sp,24
>> c00008c4:      0c000148        jal     c0000520 <try_name>
>>
>>   
> 
> That's weird: load delay slots should only be required by -march=mips1
> (or no -march)
> 
> Are you sure that the -march=mips32r2 option is really getting passed to
> the compiler and assembler?
> 

Yes I'm pretty sure:

$ mispel-linux-readelf -h vmlinux~mips32r2-smartmips
File: vmlinux~mips32r2-smartmips
ELF Header:
  Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00 
  Class:                             ELF32
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              EXEC (Executable file)
  Machine:                           MIPS R3000
  Version:                           0x1
  Entry point address:               0xc015e000
  Start of program headers:          52 (bytes into file)
  Start of section headers:          12097028 (bytes into file)
  Flags:                             0x70001001, noreorder, o32, mips32r2
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         1
  Size of section headers:           40 (bytes)
  Number of section headers:         42
  Section header string table index: 39

$ head kernel/.user.o.cmd 
cmd_kernel/user.o := mipsel-linux-gcc -Wp,-MD,kernel/.user.o.d  -nostdinc -isystem /usr/lib/gcc/mipsel-linux/3.4.4/include -D__KERNEL__ -Iinclude  -include include/linux/autoconf.h -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -O2  -mabi=32 -G 0 -mno-abicalls -fno-pic -pipe -msoft-float -ffreestanding  -march=mips32r2 -Wa,-mips32r2 -Wa,--trap -msmartmips -Iinclude/asm-mips/mach-usip -Iinclude/asm-mips/mach-generic -D"VMLINUX_LOAD_ADDRESS=0xffffffffc0000000" -fomit-frame-pointer -g  -Wdeclaration-after-statement     -D"KBUILD_STR(s)=\#s" -D"KBUILD_BASENAME=KBUILD_STR(user)"  -D"KBUILD_MODNAME=KBUILD_STR(user)" -c -o kernel/user.o kernel/user.c

deps_kernel/user.o := \
  kernel/user.c \
    $(wildcard include/config/keys.h) \
    $(wildcard include/config/inotify/user.h) \
  include/linux/init.h \
    $(wildcard include/config/modules.h) \
    $(wildcard include/config/hotplug.h) \
    $(wildcard include/config/hotplug/cpu.h) \

		Franck
