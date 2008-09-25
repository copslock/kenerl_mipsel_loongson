Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Sep 2008 13:35:02 +0100 (BST)
Received: from mail-gx0-f10.google.com ([209.85.217.10]:16843 "EHLO
	mail-gx0-f10.google.com") by ftp.linux-mips.org with ESMTP
	id S30637619AbYIYMez (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Sep 2008 13:34:55 +0100
Received: by gxk3 with SMTP id 3so6706948gxk.0
        for <linux-mips@linux-mips.org>; Thu, 25 Sep 2008 05:34:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3wRVwg6FI/hOc2vZWLHsN106Xg5NQULHkgkDs55nsO8=;
        b=TeBCWVhHb6oE0o9GCFVE3k6qbnIzAtnRL9oTfLmnx71eePO1O9gfTDNkWbbc0hMWB6
         62CpMbIewWGi83T70g5q20CPxwgodJUO7kyeTTnspKdAAJI8qHDnb/cVCR2/azVp+R5S
         n0y6CLrFmsxedV2nuWEDkwsEKYv+0uuPJ3n+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=JGNQauwlqGSUoep317FFfEwQs7sJa97DEfNTRpZcR/crl9DnxfnuaPWS4qUZ3qINRb
         LeKiultQNDWGhzcx4gsC/NzrqHzEeolzyQ7Es7fcO4zIp5nRdAYKyuWblLheAcLhQX+Q
         EcAtoHQmO3M+d7JgHkUnQLVunFrNduBMkgg9s=
Received: by 10.90.68.20 with SMTP id q20mr9915383aga.96.1222346088977;
        Thu, 25 Sep 2008 05:34:48 -0700 (PDT)
Received: by 10.90.63.18 with HTTP; Thu, 25 Sep 2008 05:34:48 -0700 (PDT)
Message-ID: <a664af430809250534i10ead6d0ydb25bb6646d3fdb1@mail.gmail.com>
Date:	Thu, 25 Sep 2008 16:34:48 +0400
From:	"Dinar Temirbulatov" <dtemirbulatov@gmail.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: mmap is broken for MIPS64 n32 and o32 abis
Cc:	linux-mips@linux-mips.org
In-Reply-To: <Pine.LNX.4.55.0809231238390.26757@cliff.in.clinika.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a664af430809182331i41c9e344w83ecb2830ac24@mail.gmail.com>
	 <Pine.LNX.4.55.0809191329080.29711@cliff.in.clinika.pl>
	 <a664af430809190953k486e2012hf3a09caa50c9574a@mail.gmail.com>
	 <Pine.LNX.4.55.0809191803390.29711@cliff.in.clinika.pl>
	 <a664af430809210355p62f6b848q87ed07f63a242c78@mail.gmail.com>
	 <Pine.LNX.4.55.0809231238390.26757@cliff.in.clinika.pl>
Return-Path: <dtemirbulatov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20630
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dtemirbulatov@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, Sep 23, 2008 at 4:32 PM, Maciej W. Rozycki <macro@linux-mips.org> wrote:

>  The problem is you cannot represent the file offset of 3053453312 or
> 0x00000000b6000000 using the 32-bit interface.  What you can represent is
> -1241513984 or 0xffffffffb6000000 and that is a valid offset for calls
> like lseek(), but not necessarily mmap() (though arguably we have a
> bug/feature in Linux where negative offsets are not explicitly checked for
> in mmap()).  To represent 3053453312 or 0x00000000b6000000 correctly you
> need to use the 64-bit interface LFS calls provide.  In this case that
> would be mmap64() or use _FILE_OFFSET_BITS as appropriate.
yes, this is correct, thanks Maciej.

but there is another problem on n32 abi, kernel does not provide
mmap64() system call for n32 and that results on following problem of
the glibc side: The generic implementation of __mmap64() returns an
error if the value passed in for the "offset" parameter is greater
than what can fit in a __off_t, which for  n32 is 2^32. This prevents
mmap64() from being used to map file offsets greater than 2^32 bytes
for n32.


I think this change is required:

diff -ruNp linux-2.6.27-rc6/arch/mips/kernel/scall64-n32.S
linux-2.6.27-rc6-fix/arch/mips/kernel/scall64-n32.S
--- linux-2.6.27-rc6/arch/mips/kernel/scall64-n32.S     2008-09-19
09:34:42.000000000 +0400
+++ linux-2.6.27-rc6-fix/arch/mips/kernel/scall64-n32.S 2008-09-25
16:21:52.000000000 +0400
@@ -413,4 +413,5 @@ EXPORT(sysn32_call_table)
        PTR     sys_dup3                        /* 5290 */
        PTR     sys_pipe2
        PTR     sys_inotify_init1
+        PTR    sys32_mmap2
        .size   sysn32_call_table,.-sysn32_call_table
diff -ruNp linux-2.6.27-rc6/include/asm-mips/unistd.h
linux-2.6.27-rc6-fix/include/asm-mips/unistd.h
--- linux-2.6.27-rc6/include/asm-mips/unistd.h  2008-09-19
09:34:43.000000000 +0400
+++ linux-2.6.27-rc6-fix/include/asm-mips/unistd.h      2008-09-19
09:50:26.000000000 +0400
@@ -966,11 +966,12 @@
 #define __NR_dup3                      (__NR_Linux + 290)
 #define __NR_pipe2                     (__NR_Linux + 291)
 #define __NR_inotify_init1             (__NR_Linux + 292)
+#define __NR_mmap2                     (__NR_Linux + 293)

 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_Linux_syscalls            292
+#define __NR_Linux_syscalls            293

 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */

                                             thanks, Dinar.
