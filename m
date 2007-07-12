Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2007 17:14:42 +0100 (BST)
Received: from mu-out-0910.google.com ([209.85.134.187]:62857 "EHLO
	mu-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20022563AbXGLQOk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jul 2007 17:14:40 +0100
Received: by mu-out-0910.google.com with SMTP id w1so205571mue
        for <linux-mips@linux-mips.org>; Thu, 12 Jul 2007 09:14:29 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Zvas0NVNKQCHAfgQHI0flCoZku2zr5S82rD6FP1IJZjBg6qCgIJ8xWi/XMCGIB3Ib45HFWWOo4veO4tzCLZWzLCPw0mZI9k45fQMdsPvQNR2IlAXEKJ1oXk1R9heLu1U84huDUH6AGGeBXnmgYJqPGz8u+T9d/q3UEh/qEk5XUE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=R7hy2VVnvbfXMY4KnsP/A7/p3llvX52ElR97g7L5xca6o7ENJQbxxsEVI/0rCMFuSpc++fRbcGVXPR9krIRiA4j6fYBNQjxFK5S4x9bqqREWi/qqWZvd72IXW6lX492y7XoZROuEpZeiV/PblP9XP/R13nX7ngxOFZKvgAQnd+I=
Received: by 10.82.170.2 with SMTP id s2mr752971bue.1184256869324;
        Thu, 12 Jul 2007 09:14:29 -0700 (PDT)
Received: by 10.82.185.8 with HTTP; Thu, 12 Jul 2007 09:14:29 -0700 (PDT)
Message-ID: <40378e40707120914i623809che646d79c03c6439@mail.gmail.com>
Date:	Thu, 12 Jul 2007 18:14:29 +0200
From:	"Mohamed Bamakhrama" <bamakhrama@gmail.com>
Reply-To: bamakhrama@gmail.com
To:	linux-mips@linux-mips.org
Subject: CACHE instruction on MIPS32 24KE
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <bamakhrama@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bamakhrama@gmail.com
Precedence: bulk
X-list: linux-mips

Hi list,
I have one question regarding the cache instruction. In the MIPS32
24KE software user's manual (page 317), it mentions that it is
possible to perform "fetch & lock" operation on a given cache line.
I am developing a driver for 2.4.31 kernel and I want to be able to
lock some "hot spots" inside the instruction cache to maximize the
throughput. Nevertheless, the manual states that if all the 4-ways of
the cache set were locked, then the core will just replace one of
them. So theoretically, the core should overwrite one of the ways in
case of the first collision and then use that overwritten line for
subsequent collisions. What I observe in my program is different. The
# of I$ misses is the same. I tried to move the locking code around
and when I did it just before the basic block I got an improvement of
20% only!!
My questions are:
1) Is there any parts in the kernel which unlocks the I$ lines under
some circumstances?
2) Is there anyone who worked with the cache instruction under MIPS
before and have any ideas about this behaviour?

Here is the macro used for cache locking:


***** BEGIN CODE *****

#define	LOCK_IN_CACHE(address, lines)	\
	asm volatile (	".set	mips32 \n"	\
			".set	noreorder \n"	\
			"lock_me_" #address ": \n"	\
			"	cache	0x1C, 0x00(%0) \n"	\
			"	addiu	%z0, %z0, 0x20 \n"	\
			"	sub	%z1, %z1, %z3  \n"	\
			"	bgez	%z1, lock_me_" #address " \n" 	\
			".set	mips0 \n"	\
			: : "Jr" (&address),	\
			"Jr" (lines), "Jr" (0), "Jr" (1));

***** END CODE *****

Best Regards,

-- 
Mohamed
