Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jul 2006 18:45:40 +0100 (BST)
Received: from web31514.mail.mud.yahoo.com ([68.142.198.143]:31599 "HELO
	web31514.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133869AbWGTRp2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Jul 2006 18:45:28 +0100
Received: (qmail 67215 invoked by uid 60001); 20 Jul 2006 17:45:22 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=rKnZDtcKRkiZP9xebeUku0WbwXV0KLxnmfmiXggqxJSbpFDX4A7+vZsXIoz4W7z58/e/ghD9J0Uoid05tALE32sUDJqLnapmv+lH1b9H7WouCZArFvN7rWoMX9Nx+O0SJu4bgaPU9QP4C11HP+mLH7TfQPK2D6h/JNLo0BME2W0=  ;
Message-ID: <20060720174522.67213.qmail@web31514.mail.mud.yahoo.com>
Received: from [209.102.119.100] by web31514.mail.mud.yahoo.com via HTTP; Thu, 20 Jul 2006 10:45:22 PDT
Date:	Thu, 20 Jul 2006 10:45:22 -0700 (PDT)
From:	Jonathan Day <imipak@yahoo.com>
Subject: Re: Bit operations work differently on MIPS and IA32
To:	hemanth.venkatesh@wipro.com, linux-mips@linux-mips.org
In-Reply-To: <2156B1E923F1A147AABDF4D9FDEAB4CB09D3D8@blr-m2-msg.wipro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12047
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,

Well, looking at it, the word is aligned in exactly
the same way but the bitfields are applied in the
opposite direction. (In the ix32 example, the 6 bits
are counting from the low end of the word, but on the
MIPS are counting from the high end.)

The first question one must ask is whether you are
using the same toolchain for both and what compiler
directives you are giving in each case. (If you are
using GCC on the MIPS, it would also be good to know
what sort of code it was compiled to generate by
default. If you ask GCC for the version information,
it'll give the compiler flags used.)

Even with this information, as another poster noted,
bitfield operations are not guaranteed to be portable.
The best I, or anyone else, can do is see if there's
anything obviously inconsistant in the compiler flags.

If you absolutely need to use the bitfields you've
listed, you CAN do a workaround. Either you can use a
#ifdef to determine the order the bitfields are listed
in the union, OR you can take 6 bits off each end and
recombine the end you want to keep with the offset.

(Optimizing the code could break either of these
methods, as there is no guarantee where the optimizer
will decide to place the fields. That would presumably
be system-dependent, as different bytes may be easier
to access on different architectures, so would be
subject to different optimizations.)

--- hemanth.venkatesh@wipro.com wrote:

> Hi All,
> 
>  
> 
> I ran the below program on an IA32 and AU1100
> machine, both being little
> endian machines and got different results. Does
> anyone know what could
> be the cause of this behaviour. This problem is
> blocking us from booting
> the cramfs rootfs.
> 
>  
> 
> #include <stdio.h>
> 
> typedef unsigned int u32;
> 
> main()
> 
> {
> 
> struct tmp{
> 
> u32 namelen:6,offset:26;
> 
> }tmp1;
> 
>  
> 
> (*(int *)(&tmp1))=0x4c0;
> 
>  
> 
> printf("%d %d\n",tmp1.namelen,tmp1.offset);
> 
>  
> 
> }
> 
>  
> 
> Results on IA32 : 0 19
> 
>  
> 
> Results on AU1100 (MIPS):  0 1216
> 
>  
> 
> Thanks
> 
> hemanth
> 
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
