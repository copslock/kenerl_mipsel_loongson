Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Oct 2002 15:03:13 +0200 (CEST)
Received: from webmail23.rediffmail.com ([203.199.83.145]:43974 "HELO
	webmail23.rediffmail.com") by linux-mips.org with SMTP
	id <S1123398AbSJJNDM>; Thu, 10 Oct 2002 15:03:12 +0200
Received: (qmail 25650 invoked by uid 510); 10 Oct 2002 13:07:04 -0000
Date: 10 Oct 2002 13:07:04 -0000
Message-ID: <20021010130704.25649.qmail@webmail23.rediffmail.com>
Received: from unknown (202.54.89.103) by rediffmail.com via HTTP; 10 Oct 2002 13:07:04 -0000
MIME-Version: 1.0
From: "atul srivastava" <atulsrivastava9@rediffmail.com>
Reply-To: "atul srivastava" <atulsrivastava9@rediffmail.com>
To: linux-mips@linux-mips.org
Subject: ioremapping pci mem window points to same location
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Return-Path: <atulsrivastava9@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: atulsrivastava9@rediffmail.com
Precedence: bulk
X-list: linux-mips

Hello,

in asm-mips/io.h
ioremap() just mask the first three bits then add the KSEG offset. 
[ (address & 0x1fffffff) + KSEG ]

suppose my pci bridge provides two memory windows
physical 40000000  to 40ffffff   and
physical 60000000  to 60ffffff

doesn't after iorremapping addresses in above two ranges
will point to same location after applying mathematics
of ioremap() ..how i will take care of this ..should i use only 
one window at a time.

Best Regards,
Ashish
__________________________________________________________
Give your Company an email address like
ravi @ ravi-exports.com.  Sign up for Rediffmail Pro today!
Know more. http://www.rediffmailpro.com/signup/
