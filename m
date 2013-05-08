Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 May 2013 18:29:00 +0200 (CEST)
Received: from mail-pd0-f172.google.com ([209.85.192.172]:50474 "EHLO
        mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827468Ab3EHQ25uRTtP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 May 2013 18:28:57 +0200
Received: by mail-pd0-f172.google.com with SMTP id 6so1316394pdd.31
        for <linux-mips@linux-mips.org>; Wed, 08 May 2013 09:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=CVPJXwYMbEp//EWiawWKp3SyJ/ssCWfEvhwDFiutW6w=;
        b=MDzZP9ckxWM/jXp+UOP/2fxNNTbbGr5W0fUZaxfFfoF0lq5nuUaBGQvYOHrazvIayF
         f84OnBUnPSexDHCA5k7mHuUJJN/0m6EdDCn+YNsMqiE+uMUb7WilPJ1EPSxhfHRB0s10
         n7tPd3fS/S3nnijsmKuvDXAVv4Jr8pRL9vPgYyVtUQe9yP4uYdnsfw7uYb2fQuMT9yEQ
         7VKYPqRuhifsmfW/sXFvTuhdUqa0M6C4RVwPCKnd63O5DdD5F9Jpsdxpkls9qEzVPh4h
         VMERZMK/A+XyEn4dhJgczsvHhCHEiq9dJM9ngYNPDPO5EG6qSFWIJ7cDET0UA9Ca+Uce
         YStQ==
X-Received: by 10.66.230.164 with SMTP id sz4mr8843605pac.124.1368030531246;
        Wed, 08 May 2013 09:28:51 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id uq10sm15037000pbc.5.2013.05.08.09.28.49
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 08 May 2013 09:28:50 -0700 (PDT)
Message-ID: <518A7D40.1060502@gmail.com>
Date:   Wed, 08 May 2013 09:28:48 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@realitydiluted.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH v99,11/13] MIPS: microMIPS: Optimise 'strncpy' core library
 function.
References: <1354856737-28678-1-git-send-email-sjhill@mips.com> <1354856737-28678-12-git-send-email-sjhill@mips.com> <518987BD.7030900@gmail.com> <5189C41D.3000005@realitydiluted.com>
In-Reply-To: <5189C41D.3000005@realitydiluted.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 05/07/2013 08:18 PM, Steven J. Hill wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 05/07/2013 06:01 PM, David Daney wrote:
>> On 12/06/2012 09:05 PM, Steven J. Hill wrote:
>>> From: "Steven J. Hill" <sjhill@mips.com>
>>>
>>> Optimise 'strncpy' to use microMIPS instructions and/or optimisations for
>>> binary size reduction. When the microMIPS ISA is not being used, the
>>> library function compiles to the original binary code.
>>
>> This is an untrue statement.  Why mislead us by saying the original binary
>> code is obtained?
>>
> I you are building a classic MIPS kernel, the instructions generated will be
> the same even with this patch. The changes only make a difference when
> building a pure microMIPS kernel.

You are wrong:

--- strncpy_user.o.before.dis	2013-05-08 09:14:35.895555668 -0700
+++ strncpy_user.o.after.dis	2013-05-08 09:14:12.870485085 -0700
@@ -1,5 +1,5 @@

-strncpy_user.o.before:     file format elf64-tradbigmips
+strncpy_user.o.after:     file format elf64-tradbigmips


  Disassembly of section .text:
@@ -7,27 +7,26 @@
  0000000000000000 <__strncpy_from_user_asm>:
     0:	df820028 	ld	v0,40(gp)
     4:	00451024 	and	v0,v0,a1
-   8:	14400011 	bnez	v0,50 <__strncpy_from_user_nocheck_asm+0x40>
+   8:	14400010 	bnez	v0,4c <__strncpy_from_user_nocheck_asm+0x3c>
     c:	00000000 	nop

  0000000000000010 <__strncpy_from_user_nocheck_asm>:
-  10:	0000102d 	move	v0,zero
+  10:	0000602d 	move	t0,zero
    14:	00a0182d 	move	v1,a1
-  18:	906c0000 	lbu	t0,0(v1)
+  18:	90620000 	lbu	v0,0(v1)
    1c:	64630001 	daddiu	v1,v1,1
-  20:	11800005 	beqz	t0,38 <__strncpy_from_user_nocheck_asm+0x28>
-  24:	a08c0000 	sb	t0,0(a0)
-  28:	64420001 	daddiu	v0,v0,1
-  2c:	64840001 	daddiu	a0,a0,1
-  30:	1446fff9 	bne	v0,a2,18 <__strncpy_from_user_nocheck_asm+0x8>
-  34:	00000000 	nop
-  38:	00a2602d 	daddu	t0,a1,v0
-  3c:	01856026 	xor	t0,t0,a1
-  40:	05800003 	bltz	t0,50 <__strncpy_from_user_nocheck_asm+0x40>
-  44:	00000000 	nop
-  48:	03e00008 	jr	ra
-  4c:	00000000 	nop
-  50:	2402fff2 	li	v0,-14
-  54:	03e00008 	jr	ra
-  58:	00000000 	nop
-  5c:	00000000 	nop
+  20:	10400004 	beqz	v0,34 <__strncpy_from_user_nocheck_asm+0x24>
+  24:	a0820000 	sb	v0,0(a0)
+  28:	658c0001 	daddiu	t0,t0,1
+  2c:	1586fffa 	bne	t0,a2,18 <__strncpy_from_user_nocheck_asm+0x8>
+  30:	64840001 	daddiu	a0,a0,1
+  34:	00ac102d 	daddu	v0,a1,t0
+  38:	00451026 	xor	v0,v0,a1
+  3c:	04400003 	bltz	v0,4c <__strncpy_from_user_nocheck_asm+0x3c>
+  40:	00000000 	nop
+  44:	03e00008 	jr	ra
+  48:	0180102d 	move	v0,t0
+  4c:	2402fff2 	li	v0,-14
+  50:	03e00008 	jr	ra
+  54:	00000000 	nop
+	...

They are different, and you said they would be the same.

I am fine if you want to change things.  Just don't say that your patch 
makes no change when it in fact does.


>
>> You don't really explain how the change helps optimization either.
>>
> The exercise is left to the reader. Build a microMIPS kernel yourself and
> figure it out.

This isn't some sort of programming text book.  Your job in the change 
log (and the mailing list) isn't to force us to learn by doing a lot of 
independent analysis of the code.  Instead I would prefer a concise 
explanation of why the change is beneficial.

You are dumping a lot of new code into the kernel.  That is fine, but 
you could consider making the process easier by improving the quality of 
the changelogs  that accompany it.

David Daney



>
> - -Steve
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/
>
> iEYEARECAAYFAlGJxBcACgkQgyK5H2Ic36c4hQCeLGI8MI2rr6KgOv7G15lnBdok
> bbcAoKY+BvVyTCzG033Bc+pJ07xCtGMq
> =xJmM
> -----END PGP SIGNATURE-----
>
>
>
