Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Nov 2002 12:43:55 +0100 (CET)
Received: from [203.199.83.247] ([203.199.83.247]:40144 "HELO
	mailweb34.rediffmail.com") by linux-mips.org with SMTP
	id <S1123974AbSKRLnz>; Mon, 18 Nov 2002 12:43:55 +0100
Received: (qmail 22527 invoked by uid 510); 18 Nov 2002 11:43:17 -0000
Date: 18 Nov 2002 11:43:17 -0000
Message-ID: <20021118114317.22526.qmail@mailweb34.rediffmail.com>
Received: from unknown (203.197.184.93) by rediffmail.com via HTTP; 18 Nov 2002 11:43:17 -0000
MIME-Version: 1.0
From: "atul srivastava" <atulsrivastava9@rediffmail.com>
Reply-To: "atul srivastava" <atulsrivastava9@rediffmail.com>
To: linux-mips@linux-mips.org
Subject: -mips2 amd -mcpu=r4600 for Rc32334..?
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Return-Path: <atulsrivastava9@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 662
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: atulsrivastava9@rediffmail.com
Precedence: bulk
X-list: linux-mips

Hello,

here is a quick question ..?

what should be appropiate compilation flag for MIPS 
RC32134/Rc32334..?
currently i am trying in arch/mips/Makefile
  GCCFLAGS        += -mcpu=r4600 -mips2 -Wa,--trap

But I doubt it for two reasons.

1.I think mips1 should be used instead of mips2 because
if you follow mips literature mips 2* and 3* series fall under 
MIPS1 category.
4* and bigger series comes under MIP2 and MIPS3 series.

for example CONFIG_CPU_LLSC is not enabled for all MIPS1
category processors.

2.Is -mcpu=r4600 switch is alright for Rc32334?
I was just wondering why i should use -mcpu=r4600 for RC323334


Best Regards,
Atul
__________________________________________________________
Give your Company an email address like
ravi @ ravi-exports.com.  Sign up for Rediffmail Pro today!
Know more. http://www.rediffmailpro.com/signup/
