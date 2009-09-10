Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Sep 2009 17:36:56 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47727 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492378AbZIJPgx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 10 Sep 2009 17:36:53 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n8AFbmEh012042;
	Thu, 10 Sep 2009 17:37:51 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n8AFbjxe012039;
	Thu, 10 Sep 2009 17:37:45 +0200
Date:	Thu, 10 Sep 2009 17:37:44 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Maxim Uvarov <muvarov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] TLB  handler fix for vmalloc'ed addresses
Message-ID: <20090910153744.GA10998@linux-mips.org>
References: <4AA656D8.9040608@ru.mvista.com> <20090910141518.GA10547@linux-mips.org> <4AA90F3B.6000204@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AA90F3B.6000204@ru.mvista.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24014
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 10, 2009 at 06:37:47PM +0400, Maxim Uvarov wrote:

>>> TLB exception handler incorrecly handles situation
>>> with wrong vmalloc'ed addresses.  This patch adds
>>> verifications for vmalloc'ed addresses (similar to
>>> x86_64 implementation). So the code now traps inside
>>> do_page_fault() on access to the wrong area.
>>>
>>> Signed-off-by: Maxim Uvarov <muvarov@ru.mvista.com>
>>>
>>> Test case:
>>>
>>> #include <linux/module.h>
>>> #include <linux/init.h>
>>> #include <linux/kernel.h>
>>> #include <linux/kthread.h>
>>> #include <linux/delay.h>
>>>
>>> static struct task_struct *ts;
>>> static int example_thread(void *dummy)
>>> {
>>> 	void *ptr;
>>> 	ptr = vmalloc(16*1024*1024);
>>> 	for(;;)
>>> 	{
>>> 		msleep(100);
>>> 	}
>>> }
>>
>> So your test case allocates vmalloc memory but never touches it.
>
> Yes, it is so. Bug occurs on rmmod this module. (Module does not free memory
> allocated with vmalloc().

Nor does it stop the thread on exit or avoid unloading.  So panicing is
expected.

  Ralf
