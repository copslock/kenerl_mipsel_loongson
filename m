Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Sep 2002 15:04:59 +0200 (CEST)
Received: from webmail23.rediffmail.com ([203.199.83.145]:12196 "HELO
	webmail23.rediffmail.com") by linux-mips.org with SMTP
	id <S1123961AbSI0NE6>; Fri, 27 Sep 2002 15:04:58 +0200
Received: (qmail 4100 invoked by uid 510); 27 Sep 2002 13:09:55 -0000
Date: 27 Sep 2002 13:09:55 -0000
Message-ID: <20020927130955.4099.qmail@webmail23.rediffmail.com>
Received: from unknown (202.54.89.85) by rediffmail.com via HTTP; 27 Sep 2002 13:09:55 -0000
MIME-Version: 1.0
From: "atul srivastava" <atulsrivastava9@rediffmail.com>
Reply-To: "atul srivastava" <atulsrivastava9@rediffmail.com>
To: linux-mips@linux-mips.org
Subject: ioremap in MIPS-IDT..?
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Return-Path: <atulsrivastava9@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: atulsrivastava9@rediffmail.com
Precedence: bulk
X-list: linux-mips

Hello,

I am using MIPs-IDT79S334A.
just now i noted that there is no ioremap.c file in
source tree.

this made me to think if physical memory that is
normally
ioremapped is already a part of processor
memory map after startup
hence no need to call it explicitly in drivers .

Am i thinking right ..?

pls let me know .
Best Regards,
Atul
__________________________________________________________
Give your Company an email address like
ravi @ ravi-exports.com.  Sign up for Rediffmail Pro today!
Know more. http://www.rediffmailpro.com/signup/
