Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2007 16:20:28 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.191]:62738 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20023366AbXKFQUS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Nov 2007 16:20:18 +0000
Received: by nf-out-0910.google.com with SMTP id c10so1471565nfd
        for <linux-mips@linux-mips.org>; Tue, 06 Nov 2007 08:20:09 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=oxC9FEdLrkbBIhvzSpJ7epBWT9C7GT36Rik/fcbPr1M=;
        b=Tz8xh16XYAJUnzpNhEGYBnzQyuquqdbTiyuioMIuJaQY1895UcO+LysXbVXHP3TrXdpbQHMWeB03uYXhgmZ8+LNAm8AUcMgS5lMQjabsT3VdvyCDxIS6r9NMabUVMPPTNqk4ioqbEWmhQ2/Bu+ZTcpEGezOMM42MQrePJekOb1U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=CFLXcgq/ZuKJy16mHDmj+saO7e4tbDAx2Muqw5fbkVksMpz+vuz/dw01+Cp9XGR2Mf57BpKhx66/fBzykft6UhC1QiodBWTXahi2xA8tOK7Mtw/Oj2KlOfdmwqAfy3NXwBCjp51GAQAObtoZngztjwdPw8x8JEwkpnvjFHOGPkk=
Received: by 10.86.26.11 with SMTP id 11mr4443418fgz.1194366008619;
        Tue, 06 Nov 2007 08:20:08 -0800 (PST)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id 13sm14664531fks.2007.11.06.08.20.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Nov 2007 08:20:06 -0800 (PST)
Message-ID: <473093E1.60507@gmail.com>
Date:	Tue, 06 Nov 2007 17:18:41 +0100
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Kill __bzero()
References: <472D8058.5080209@gmail.com> <20071105112429.GC27893@linux-mips.org> <472F906F.7080205@gmail.com> <20071105231818.GA18820@linux-mips.org> <47301AF8.2000700@gmail.com> <20071106103603.GA24844@linux-mips.org>
In-Reply-To: <20071106103603.GA24844@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Tue, Nov 06, 2007 at 08:42:48AM +0100, Franck Bui-Huu wrote:
> 
>>> Older gcc used to generate significantly worse code for inline functions
>>> than for macros so Linux became a fairly excessive user of macros.  This
>>> has very much improved since, so these days inlines are prefered over
>>> macros where possible.
>> Yes but ISTR that gcc generates some calls to memset and since
>> builtin functions are disabled the final link failed if memset
>> is inlined. I'll try to reproduce...
> 

OK, using Cobalt config and the patch below, I get the following link
failure:

$ make

[snip]

  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
kernel/built-in.o: In function `param_sysfs_init':
params.c:(.init.text+0x19ac): undefined reference to `memset'
params.c:(.init.text+0x19ac): relocation truncated to fit: R_MIPS_26 against `memset'
fs/built-in.o: In function `locks_remove_flock':
(.text+0x14518): undefined reference to `memset'
fs/built-in.o: In function `locks_remove_flock':
(.text+0x14518): relocation truncated to fit: R_MIPS_26 against `memset'
fs/built-in.o: In function `__blkdev_get':
block_dev.c:(.text+0x31d40): undefined reference to `memset'
block_dev.c:(.text+0x31d40): relocation truncated to fit: R_MIPS_26 against `memset'
block_dev.c:(.text+0x31d50): undefined reference to `memset'
block_dev.c:(.text+0x31d50): relocation truncated to fit: R_MIPS_26 against `memset'
make: *** [.tmp_vmlinux1] Error 1


> So both belt and suspenders then that is an inline/macro plus an outline
> version?
> 

I guess so.

>>>> Yes I noticed this. Actually I'm wondering if we couldn't add a new
>>>> function, fill_user() like the following:
>>>>
>>>> extern size_t fill_user(void __user *to, int c, size_t len);
>>> That's much better function name than the old __bzero - except that
>> Actually I named it '__fill_user', since it doesn't call access_ok().
>>
>>> __bzero effectivly took a long argument for the 2nd argument so 32-bit
>>> on 32-bit kernels and 64-bit on 64-bit kernels.
>> Isn't size_t meaning ?
>>
>> Perhaps in this case __kernel_size_t is better...
> 
> I wrote about the existing __bzero which takes the size_t length as third 
> argument and a long sized fill pattern as the second.
> 

Sorry I was confused (again) because of the invisible second parameter
of __bzero...

>> Yes I have a patchset which clean up a bit uaccess.h and does this but
>> it's under construction.  It actually tries to convert all macros into
>> inlines and the file is much more readable and as a bonus side we could
>> easily add __must_check annotations which are currently missing.
>>
>> I'll try to finish it this week but in the meantime can we just kill
>> __bzero or do you want me to include it in the future patchset ?
> 
> There is enough time until 2.6.25 to complete your cleanups; no more
> cleanups for 2.6.24.
> 

Sure.

		Franck
-- 8< --

diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index 3f8b8b3..23f0490 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -54,7 +54,7 @@
  */
 	.set	noreorder
 	.align	5
-LEAF(memset)
+LEAF(__memset)
 	beqz		a1, 1f
 	 move		v0, a0			/* result */
 
diff --git a/include/asm-mips/string.h b/include/asm-mips/string.h
index 436e3ad..b2ef64c 100644
--- a/include/asm-mips/string.h
+++ b/include/asm-mips/string.h
@@ -132,7 +132,12 @@ strncmp(__const__ char *__cs, __const__ char *__ct, size_t __count)
 #endif /* CONFIG_32BIT */
 
 #define __HAVE_ARCH_MEMSET
-extern void *memset(void *__s, int __c, size_t __count);
+static inline void *memset(void *__s, int __c, size_t __count)
+{
+	extern void *__memset(void *s, int c, size_t len);
+
+	return __memset(__s, __c, __count);
+}
 
 #define __HAVE_ARCH_MEMCPY
 extern void *memcpy(void *__to, __const__ void *__from, size_t __n);
