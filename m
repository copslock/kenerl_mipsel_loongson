Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Sep 2002 11:56:02 +0200 (CEST)
Received: from webmail23.rediffmail.com ([203.199.83.145]:11415 "HELO
	webmail23.rediffmail.com") by linux-mips.org with SMTP
	id <S1122961AbSIMJ4B>; Fri, 13 Sep 2002 11:56:01 +0200
Received: (qmail 24814 invoked by uid 510); 13 Sep 2002 09:54:49 -0000
Date: 13 Sep 2002 09:54:49 -0000
Message-ID: <20020913095449.24813.qmail@webmail23.rediffmail.com>
Received: from unknown (202.54.89.92) by rediffmail.com via HTTP; 13 Sep 2002 09:54:49 -0000
MIME-Version: 1.0
From: "atul srivastava" <atulsrivastava9@rediffmail.com>
Reply-To: "atul srivastava" <atulsrivastava9@rediffmail.com>
To: linux-mips@linux-mips.org
Subject: usable memory map..
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Return-Path: <atulsrivastava9@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 168
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: atulsrivastava9@rediffmail.com
Precedence: bulk
X-list: linux-mips

Hello ,

on MIPS IDT 79S334A i am getting following
usable memory regions by print_memory_map in
arch/mips/kernel/setup.c .

memory: 8000fc00 @ 80000400 (usable)
memory: 00e01d2b @ 001fe2db (usable)

note that first column is SIZE and second one is START
address.

my question is..

1> what is the significance of usable memory , in terms of 
availibility for linux..?

2> where it is initialised ..i guess must be passed from firmware 
or from tags..

3>on my board ram (16 MB)at 0x8000000 ,initial 0x400
is a room for exception table and hence effectively
it would start from 0x80000400 .

does this map relates to any way to LOAD ADRRESS ?
i would like to add that i have problem of starting any user space 
process it is reporting always a bad memory acess on address 
0x0fc01788.

Best Regards,


__________________________________________________________
Give your Company an email address like
ravi @ ravi-exports.com.  Sign up for Rediffmail Pro today!
Know more. http://www.rediffmailpro.com/signup/
