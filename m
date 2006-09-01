Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Sep 2006 17:40:13 +0100 (BST)
Received: from web31504.mail.mud.yahoo.com ([68.142.198.133]:23992 "HELO
	web31504.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20038519AbWIAQkL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 1 Sep 2006 17:40:11 +0100
Received: (qmail 49313 invoked by uid 60001); 1 Sep 2006 16:38:39 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=uN1DpCiNOo8KpBdfcXSN1O3uDVh4VXjs0rlvMIa8z1AmBI6lYEPMyeXLRb+jq9ChhrnAawSg/f4yc8aleo2pxCD8DNwzqfUVoO9yfVK+UkHRxbU0p7z3TByJod2A5mxI4I8GePPF+WTXBAJCiClrRodkiRMGuhEyOgi55WpPhlw=  ;
Message-ID: <20060901163839.49311.qmail@web31504.mail.mud.yahoo.com>
Received: from [70.103.67.194] by web31504.mail.mud.yahoo.com via HTTP; Fri, 01 Sep 2006 09:38:39 PDT
Date:	Fri, 1 Sep 2006 09:38:39 -0700 (PDT)
From:	Jonathan Day <imipak@yahoo.com>
Subject: Broadcom SB1 query
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12499
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,

Can anyone verify that the current kernel in
linux-mips git archive will work on a Broadcom 1250
(SB1), specifically the "Swarm" or the "Sentosa"
flavours of the BCM91250.

I have not been able to get anything more recent than
a 2.6.17 kernel to compile and boot, the 2.6.18-rc
kernels seem to randomly either lock up or reboot very
early on in the kernel initialization. However, I am
undecided whether it's a kernel issue, a hardware
issue (we've had nothing but trouble from these
boards) or a toolchain issue (versions: gcc 4.1.1,
libc 2.4, binutils 2.17.50) as I've found a few large
projects that should compile just fine are blowing the
compiler up.

If someone can post (or e-mail me direct) on what the
latest combination of kernel and toolchain that works
on the Swarm is, I would greatly appreciate it. This
problem is driving me nuts. (Ok, more nuts than
usual.)

Jonathan

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
