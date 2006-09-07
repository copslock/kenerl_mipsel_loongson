Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Sep 2006 08:58:27 +0100 (BST)
Received: from wx-out-0506.google.com ([66.249.82.224]:20243 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038487AbWIGH6V (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Sep 2006 08:58:21 +0100
Received: by wx-out-0506.google.com with SMTP id h30so165383wxd
        for <linux-mips@linux-mips.org>; Thu, 07 Sep 2006 00:58:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=PYlk3os/spA+hMwT15FXu5npIaW8GxOa5mtHzA8/XAUqpfsXFEhq3pyf+1zfjz/HQND79SV/NUnQY9FCOuAkIYGjfzvCJW/hiptlWWlpe7ryiqCN7XthVAs/yG6ij1zDbmShwoBbRSqGWCcU+FlswXTvz53yFtFuw1N8tYyeAWM=
Received: by 10.70.113.15 with SMTP id l15mr120753wxc;
        Thu, 07 Sep 2006 00:58:20 -0700 (PDT)
Received: by 10.70.25.11 with HTTP; Thu, 7 Sep 2006 00:58:20 -0700 (PDT)
Message-ID: <f21fe8a50609070058u2a01ac93gbae794295406361d@mail.gmail.com>
Date:	Thu, 7 Sep 2006 09:58:20 +0200
From:	"Erik Niessen" <erik.niessen@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: Weird output from pmap
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20060907040344.GC17965@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_167778_26410527.1157615900080"
References: <f21fe8a50609042355o19ab7b50nb5717bfe0d358232@mail.gmail.com>
	 <20060907040344.GC17965@linux-mips.org>
Return-Path: <erik.niessen@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: erik.niessen@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_167778_26410527.1157615900080
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Ralf,

Thanks for your response.
This is the output from readelf
 mipsel-linux-readelf -S helloworldmips
There are 29 section headers, starting at offset 0x1290:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk
Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0
0  0
  [ 1] .interp           PROGBITS        004000f4 0000f4 000014 00   A  0
0  1
  [ 2] .reginfo          MIPS_REGINFO    00400108 000108 000018 18   A  0
0  4
  [ 3] .dynamic          DYNAMIC         00400120 000120 0000f8 08   A  6
0  4
  [ 4] .hash             HASH            00400218 000218 0000b4 04   A  5
0  4
  [ 5] .dynsym           DYNSYM          004002cc 0002cc 0001a0 10   A  6
1  4
  [ 6] .dynstr           STRTAB          0040046c 00046c 00011b 00   A  0
0  1
  [ 7] .gnu.version      VERSYM          00400588 000588 000034 02   A  5
0  2
  [ 8] .gnu.version_r    VERNEED         004005bc 0005bc 000020 00   A  6
1  4
  [ 9] .init             PROGBITS        004005dc 0005dc 000088 00  AX  0
0  4
  [10] .text             PROGBITS        00400670 000670 0004c0 00  AX  0
0 16
  [11] .MIPS.stubs       PROGBITS        00400b30 000b30 000070 00  AX  0
0  4
  [12] .fini             PROGBITS        00400ba0 000ba0 000058 00  AX  0
0  4
  [13] .rodata           PROGBITS        00400c00 000c00 0000f0 00   A  0
0 16
  [14] .eh_frame         PROGBITS        00400cf0 000cf0 000004 00   A  0
0  4
  [15] .ctors            PROGBITS        10000000 001000 000008 00  WA  0
0  4
  [16] .dtors            PROGBITS        10000008 001008 000008 00  WA  0
0  4
  [17] .jcr              PROGBITS        10000010 001010 000004 00  WA  0
0  4
  [18] .data             PROGBITS        10000020 001020 000030 00  WA  0
0 16
  [19] .rld_map          PROGBITS        10000050 001050 000004 00  WA  0
0  4
  [20] .got              PROGBITS        10000060 001060 00004c 04 WAp  0
0 16
  [21] .sbss             NOBITS          100000ac 0010ac 000000 00 WAp  0
0  1
  [22] .bss              NOBITS          100000b0 0010ac 000020 00  WA  0
0 16
  [23] .comment          PROGBITS        00000000 0010ac 00005a 00      0
0  1
  [24] .pdr              PROGBITS        00000000 001108 0000a0 00      0
0  4
  [25] .mdebug.abi32     PROGBITS        00000000 0011a8 000000 00      0
0  1
  [26] .shstrtab         STRTAB          00000000 0011a8 0000e5 00      0
0  1
  [27] .symtab           SYMTAB          00000000 001718 000500 10     28
51  4
  [28] .strtab           STRTAB          00000000 001c18 00023f 00      0
0  1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings)
  I (info), L (link order), G (group), x (unknown)
  O (extra OS processing required) o (OS specific), p (processor specific)

This one tells me that the bss is writable?? Can you giev me a direction
where the problem is??

Cheers,


On 9/7/06, Ralf Baechle <ralf@linux-mips.org> wrote:
>
> On Tue, Sep 05, 2006 at 08:55:18AM +0200, Erik Niessen wrote:
>
> > /helloworldmips(86)
> > 00400000 (4 KB)        r-xp (00:0a 33243002)   linux/test/helloworldmips
> > 10000000 (4 KB)        rw-p (00:0a 33243002)   linux/test/helloworldmips
> > 10001000 (4 KB)        rwxp (00:00 0)        [heap]
> > 2aaa8000 (20 KB)       r-xp (00:07 1795853)
> > /lib/ld-uClibc-0.9.27.so<http://uclibc-0.9.27.so/>
> > 2aaad000 (4 KB)        rw-p (00:00 0)
> > 2aaed000 (4 KB)        rw-p (00:07 1795853)  /lib/ld-
> > uClibc-0.9.27.so<http://uclibc-0.9.27.so/>
> > 2aaee000 (48 KB)       r-xp (00:07 1795861)  /lib/libgcc_s.so.1
> > 2aafa000 (252 KB)      ---p (00:00 0)
> > 2ab39000 (4 KB)        rw-p (00:07 1795861)  /lib/libgcc_s.so.1
> > 2ab3a000 (368 KB)      r-xp (00:07 1795855)  /lib/libuClibc-0.9.27.so
> > 2ab96000 (256 KB)      ---p (00:00 0)
> > 2abd6000 (8 KB)        rw-p (00:07 1795855)  /lib/libuClibc- 0.9.27.so
> > 2abd8000 (16 KB)       rw-p (00:00 0)
> > 7fd49000 (84 KB)       rwxp (00:00 0)        [stack]
> > mapped:   1076 KB writable/private: 128 KB shared: 0 KB
> >
> > It seems that the bss segments of the shared libs are protected and
> mapped
> > to the zero page. I don't see this
> > when I run this on a linux pc. I have the following questions:
> > - Why is this segment protected? Accessing results in a seg fault.
>
> Protecting a bss segment doesn't make sense.
>
> The address and the "---p" flags make me suspect your executable might
> actually be wrong, so I suggest you check the binary with something like
> readelf -S.
>
> > - Why is it so big (252k/256K)?
> > - How much memory is physically allocated for this segment?
>
> None at this stage - the actuall allocation would happen lazily when
> a page is touched first which of course doesn't ever happen in your
> case.
>
>   Ralf
>

------=_Part_167778_26410527.1157615900080
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Ralf,<br><br>Thanks for your response.<br>This is the output from readelf <br>&nbsp;mipsel-linux-readelf -S helloworldmips<br>There are 29 section headers, starting at offset 0x1290:<br>&nbsp;<br>Section Headers:<br>&nbsp; [Nr] Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Addr&nbsp;&nbsp;&nbsp;&nbsp; Off&nbsp;&nbsp;&nbsp; Size&nbsp;&nbsp; ES Flg Lk Inf Al
<br>&nbsp; [ 0]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00000000 000000 000000 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp; 0&nbsp; 0<br>&nbsp; [ 1] .interp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PROGBITS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 004000f4 0000f4 000014 00&nbsp;&nbsp; A&nbsp; 0&nbsp;&nbsp; 0&nbsp; 1<br>&nbsp; [ 2] .reginfo&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MIPS_REGINFO&nbsp;&nbsp;&nbsp; 00400108 000108 000018 18&nbsp;&nbsp; A&nbsp; 0&nbsp;&nbsp; 0&nbsp; 4
<br>&nbsp; [ 3] .dynamic&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DYNAMIC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00400120 000120 0000f8 08&nbsp;&nbsp; A&nbsp; 6&nbsp;&nbsp; 0&nbsp; 4<br>&nbsp; [ 4] .hash&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HASH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00400218 000218 0000b4 04&nbsp;&nbsp; A&nbsp; 5&nbsp;&nbsp; 0&nbsp; 4<br>&nbsp; [ 5] .dynsym&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DYNSYM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 004002cc 0002cc 0001a0 10&nbsp;&nbsp; A&nbsp; 6&nbsp;&nbsp; 1&nbsp; 4
<br>&nbsp; [ 6] .dynstr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; STRTAB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0040046c 00046c 00011b 00&nbsp;&nbsp; A&nbsp; 0&nbsp;&nbsp; 0&nbsp; 1<br>&nbsp; [ 7] .gnu.version&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VERSYM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00400588 000588 000034 02&nbsp;&nbsp; A&nbsp; 5&nbsp;&nbsp; 0&nbsp; 2<br>&nbsp; [ 8] .gnu.version_r&nbsp;&nbsp;&nbsp; VERNEED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 004005bc 0005bc 000020 00&nbsp;&nbsp; A&nbsp; 6&nbsp;&nbsp; 1&nbsp; 4
<br>&nbsp; [ 9] .init&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PROGBITS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 004005dc 0005dc 000088 00&nbsp; AX&nbsp; 0&nbsp;&nbsp; 0&nbsp; 4<br>&nbsp; [10] .text&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PROGBITS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00400670 000670 0004c0 00&nbsp; AX&nbsp; 0&nbsp;&nbsp; 0 16<br>&nbsp; [11] .MIPS.stubs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PROGBITS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00400b30 000b30 000070 00&nbsp; AX&nbsp; 0&nbsp;&nbsp; 0&nbsp; 4
<br>&nbsp; [12] .fini&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PROGBITS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00400ba0 000ba0 000058 00&nbsp; AX&nbsp; 0&nbsp;&nbsp; 0&nbsp; 4<br>&nbsp; [13] .rodata&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PROGBITS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00400c00 000c00 0000f0 00&nbsp;&nbsp; A&nbsp; 0&nbsp;&nbsp; 0 16<br>&nbsp; [14] .eh_frame&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PROGBITS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00400cf0 000cf0 000004 00&nbsp;&nbsp; A&nbsp; 0&nbsp;&nbsp; 0&nbsp; 4
<br>&nbsp; [15] .ctors&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PROGBITS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10000000 001000 000008 00&nbsp; WA&nbsp; 0&nbsp;&nbsp; 0&nbsp; 4<br>&nbsp; [16] .dtors&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PROGBITS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10000008 001008 000008 00&nbsp; WA&nbsp; 0&nbsp;&nbsp; 0&nbsp; 4<br>&nbsp; [17] .jcr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PROGBITS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10000010 001010 000004 00&nbsp; WA&nbsp; 0&nbsp;&nbsp; 0&nbsp; 4
<br>&nbsp; [18] .data&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PROGBITS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10000020 001020 000030 00&nbsp; WA&nbsp; 0&nbsp;&nbsp; 0 16<br>&nbsp; [19] .rld_map&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PROGBITS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10000050 001050 000004 00&nbsp; WA&nbsp; 0&nbsp;&nbsp; 0&nbsp; 4<br>&nbsp; [20] .got&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PROGBITS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10000060 001060 00004c 04 WAp&nbsp; 0&nbsp;&nbsp; 0 16
<br>&nbsp; [21] .sbss&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NOBITS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 100000ac 0010ac 000000 00 WAp&nbsp; 0&nbsp;&nbsp; 0&nbsp; 1<br>&nbsp; [22] .bss&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NOBITS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 100000b0 0010ac 000020 00&nbsp; WA&nbsp; 0&nbsp;&nbsp; 0 16<br>&nbsp; [23] .comment&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PROGBITS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00000000 0010ac 00005a 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp; 0&nbsp; 1
<br>&nbsp; [24] .pdr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PROGBITS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00000000 001108 0000a0 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp; 0&nbsp; 4<br>&nbsp; [25] .mdebug.abi32&nbsp;&nbsp;&nbsp;&nbsp; PROGBITS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00000000 0011a8 000000 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp; 0&nbsp; 1<br>&nbsp; [26] .shstrtab&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; STRTAB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00000000 0011a8 0000e5 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp; 0&nbsp; 1
<br>&nbsp; [27] .symtab&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SYMTAB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00000000 001718 000500 10&nbsp;&nbsp;&nbsp;&nbsp; 28&nbsp; 51&nbsp; 4<br>&nbsp; [28] .strtab&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; STRTAB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00000000 001c18 00023f 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp; 0&nbsp; 1<br>Key to Flags:<br>&nbsp; W (write), A (alloc), X (execute), M (merge), S (strings)
<br>&nbsp; I (info), L (link order), G (group), x (unknown)<br>&nbsp; O (extra OS processing required) o (OS specific), p (processor specific)<br><br>This one tells me that the bss is writable?? Can you giev me a direction where the problem is??
<br><br>Cheers,<br><br><br><div><span class="gmail_quote">On 9/7/06, <b class="gmail_sendername">Ralf Baechle</b> &lt;<a href="mailto:ralf@linux-mips.org">ralf@linux-mips.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Tue, Sep 05, 2006 at 08:55:18AM +0200, Erik Niessen wrote:<br><br>&gt; /helloworldmips(86)<br>&gt; 00400000 (4 KB)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;r-xp (00:0a 33243002)&nbsp;&nbsp; linux/test/helloworldmips<br>&gt; 10000000 (4 KB)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rw-p (00:0a 33243002)&nbsp;&nbsp; linux/test/helloworldmips
<br>&gt; 10001000 (4 KB)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rwxp (00:00 0)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[heap]<br>&gt; 2aaa8000 (20 KB)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r-xp (00:07 1795853)<br>&gt; /lib/ld-<a href="http://uClibc-0.9.27.so">uClibc-0.9.27.so</a>&lt;<a href="http://uclibc-0.9.27.so/">
http://uclibc-0.9.27.so/</a>&gt;<br>&gt; 2aaad000 (4 KB)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rw-p (00:00 0)<br>&gt; 2aaed000 (4 KB)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rw-p (00:07 1795853)&nbsp;&nbsp;/lib/ld-<br>&gt; <a href="http://uClibc-0.9.27.so">uClibc-0.9.27.so</a>&lt;<a href="http://uclibc-0.9.27.so/">
http://uclibc-0.9.27.so/</a>&gt;<br>&gt; 2aaee000 (48 KB)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r-xp (00:07 1795861)&nbsp;&nbsp;/lib/libgcc_s.so.1<br>&gt; 2aafa000 (252 KB)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;---p (00:00 0)<br>&gt; 2ab39000 (4 KB)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rw-p (00:07 1795861)&nbsp;&nbsp;/lib/libgcc_s.so.1
<br>&gt; 2ab3a000 (368 KB)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;r-xp (00:07 1795855)&nbsp;&nbsp;/lib/libuClibc-<a href="http://0.9.27.so">0.9.27.so</a><br>&gt; 2ab96000 (256 KB)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;---p (00:00 0)<br>&gt; 2abd6000 (8 KB)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rw-p (00:07 1795855)&nbsp;&nbsp;/lib/libuClibc- 
<a href="http://0.9.27.so">0.9.27.so</a><br>&gt; 2abd8000 (16 KB)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rw-p (00:00 0)<br>&gt; 7fd49000 (84 KB)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rwxp (00:00 0)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[stack]<br>&gt; mapped:&nbsp;&nbsp; 1076 KB writable/private: 128 KB shared: 0 KB<br>&gt;<br>
&gt; It seems that the bss segments of the shared libs are protected and mapped<br>&gt; to the zero page. I don't see this<br>&gt; when I run this on a linux pc. I have the following questions:<br>&gt; - Why is this segment protected? Accessing results in a seg fault.
<br><br>Protecting a bss segment doesn't make sense.<br><br>The address and the &quot;---p&quot; flags make me suspect your executable might<br>actually be wrong, so I suggest you check the binary with something like<br>readelf -S.
<br><br>&gt; - Why is it so big (252k/256K)?<br>&gt; - How much memory is physically allocated for this segment?<br><br>None at this stage - the actuall allocation would happen lazily when<br>a page is touched first which of course doesn't ever happen in your
<br>case.<br><br>&nbsp;&nbsp;Ralf<br></blockquote></div><br>

------=_Part_167778_26410527.1157615900080--
