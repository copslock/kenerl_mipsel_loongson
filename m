Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Nov 2008 23:01:12 +0000 (GMT)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:5834 "EHLO
	smtp1.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S23822789AbYKUXBC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Nov 2008 23:01:02 +0000
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mALN0OfU008704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 21 Nov 2008 15:00:25 -0800
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id mALN0NRH009588;
	Fri, 21 Nov 2008 15:00:23 -0800
Date:	Fri, 21 Nov 2008 15:00:23 -0800
From:	Andrew Morton <akpm@linux-foundation.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Make BUG() __noreturn.
Message-Id: <20081121150023.032f7b5b.akpm@linux-foundation.org>
In-Reply-To: <49260E4C.8080500@caviumnetworks.com>
References: <49260E4C.8080500@caviumnetworks.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21377
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Thu, 20 Nov 2008 17:26:36 -0800
David Daney <ddaney@caviumnetworks.com> wrote:

> MIPS: Make BUG() __noreturn.
> 
> Often we do things like put BUG() in the default clause of a case
> statement.  Since it was not declared __noreturn, this could sometimes
> lead to bogus compiler warnings that variables were used
> uninitialized.
> 
> There is a small problem in that we have to put a magic while(1); loop to
> fool GCC into really thinking it is noreturn.  This makes the new
> BUG() function 3 instructions long instead of just 1, but I think it
> is worth it as it is now unnecessary to do extra work to silence the
> 'used uninitialized' warnings.
> 
> I also re-wrote BUG_ON so that if it is given a constant condition, it
> just does BUG() instead of loading a constant value in to a register
> and testing it.
> 

Yup, this change will fix some compile warnings which will never be
fixed in any other way for mips.

> +static inline void __noreturn BUG(void)
> +{
> +	__asm__ __volatile__("break %0" : : "i" (BRK_BUG));
> +	/* Fool GCC into thinking the function doesn't return. */
> +	while (1)
> +		;
> +}

This kind of sucks, doesn't it?  It adds instructions into the kernel
text, very frequently on fast paths.  Those instructions are never
executed, and we're blowing away i-cache just to quash compiler
warnings.

For example, this:

--- a/arch/x86/include/asm/bug.h~a
+++ a/arch/x86/include/asm/bug.h
@@ -22,14 +22,12 @@ do {								\
 		     ".popsection"				\
 		     : : "i" (__FILE__), "i" (__LINE__),	\
 		     "i" (sizeof(struct bug_entry)));		\
-	for (;;) ;						\
 } while (0)
 
 #else
 #define BUG()							\
 do {								\
 	asm volatile("ud2");					\
-	for (;;) ;						\
 } while (0)
 #endif
 
_

reduces the size of i386 mm/vmalloc.o text by 56 bytes.

I wonder if there is any clever way in which we can do this without
introducing additional runtime cost.
