Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jun 2003 03:58:00 +0100 (BST)
Received: from web41205.mail.yahoo.com ([IPv6:::ffff:66.218.93.38]:20902 "HELO
	web41205.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8224821AbTF1C56>; Sat, 28 Jun 2003 03:57:58 +0100
Message-ID: <20030628025749.40346.qmail@web41205.mail.yahoo.com>
Received: from [64.132.226.151] by web41205.mail.yahoo.com via HTTP; Sat, 28 Jun 2003 12:57:49 EST
Date: Sat, 28 Jun 2003 12:57:49 +1000 (EST)
From: =?iso-8859-1?q?fpga=20dsp?= <fpga_dsp@yahoo.com.au>
Subject: schedule() and mipsel processor
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2024463263-1056769069=:39713"
Content-Transfer-Encoding: 8bit
Return-Path: <fpga_dsp@yahoo.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2717
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fpga_dsp@yahoo.com.au
Precedence: bulk
X-list: linux-mips

--0-2024463263-1056769069=:39713
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi all,
 
I may ask a stupid question here but I have problem of calling any functions such as interruptible_sleep_on_timeout, sleep_on ... in a timer handler, the kernel just crash straight away in the function schedule(). Now I go and do a diff between kern/sched.c on i686 source and mipsel source. clearly , they are different. So the question is from kernel programming point of view, the bottom-half of interrupt handler is still considered interrupt handler? I don't see any platform dependent code in the scheduler at all. So why a mips scheduler is different from intel scheduler ?
 
Many thanks
 
Duy Do



---------------------------------
Yahoo! Mobile
- Check & compose your email via SMS on your Telstra or Vodafone mobile.
--0-2024463263-1056769069=:39713
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV>Hi all,</DIV>
<DIV>&nbsp;</DIV>
<DIV>I may ask a stupid question here but I have problem of calling any functions such as interruptible_sleep_on_timeout, sleep_on ... in a timer handler, the kernel just crash straight away in the function schedule(). Now I go and do a diff between kern/sched.c on i686 source and mipsel source. clearly , they are different. So the question is from kernel programming point of view, the bottom-half of interrupt handler is still considered interrupt handler? I don't see any platform dependent code in the scheduler at all. So why a mips scheduler is different from intel scheduler ?</DIV>
<DIV>&nbsp;</DIV>
<DIV>Many thanks</DIV>
<DIV>&nbsp;</DIV>
<DIV>Duy Do</DIV><p><br><hr size=1>
<a href="http://au.rd.yahoo.com/mail/tagline/?http://au.mobile.yahoo.com/sms/mail/index.html" target=_blank><b>Yahoo! Mobile</b></a><br>
- Check & compose your email via SMS on your Telstra or Vodafone mobile.
--0-2024463263-1056769069=:39713--
