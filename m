Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jul 2004 09:12:26 +0100 (BST)
Received: from mailer.x-mail.net ([IPv6:::ffff:65.110.6.10]:25860 "EHLO
	mailer.xmail.net") by linux-mips.org with ESMTP id <S8225966AbUGFIMV>;
	Tue, 6 Jul 2004 09:12:21 +0100
Received: from [217.115.67.74] by www.xmail.net with HTTP for <linux-mips@linux-mips.org>; Tue, 06 Jul 2004 01:12:20 -0800
Message-ID: <1089101540.40ea5ee467311@www.x-mail.net>
Date: Tue, 06 Jul 2004 01:12:20 -0800
From: Thomas Kunze <thomas.kunze@xmail.net>
To: linux-mips@linux-mips.org
Subject: Linux on SNI RM300E ?
X-Mailer: Web XMail 3.2a
X-Mail.net: *** Free Web Based E-Mail & Hosting ***
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-Path: <thomas.kunze@xmail.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.kunze@xmail.net
Precedence: bulk
X-list: linux-mips

Hi,

i've tried to install Debian Woody MIPS on my SNI RM300E but i can't get it work.
bootp() and tftp() works. the bios load's the tftpboot.img over the net. after that
only an exception appears on the screen. the boot screen looks like this:

Obtaining /tftpboot/sash_pci from server
2027520+1762928+95120 entry 0x8800246C

EXCEPTION: <vector=UTLBMiss>
EXCEPTION pc: 0x8800246C
Cause register: 0x800C
Status register: 0x200010003
Bad Vaddress: 0x3C40

is anybody out there how can help me?

with best regards
thomas

-------------------------------------------------------------------------------------------
***Protect your PC from local E-Mail Application security holes***
***Maintain your Privacy - MS Passport Free***
***Anti SPAM "Whitelist" feature***

http://www.xmail.net Web E-Mail, accessible anywhere, 128 bit SSL Secure

Voice Messages, Voice Calls (VoIP), Video Conferencing,  
XMail Messenger, Personal Web Hosting, Private Disk Storage,  
Calendar, Bookmarks, Forwarding, Virtual Mail Map Aliasing

XMail Premium: 20 - 250MB Storage, 20MB Messages, SMTP, POP3, Ad Free
Starting at $9.95 per year
-------------------------------------------------------------------------------------------
Anonymous Web Surfing http://www.snoopblocker.com
Search http://www.teradex.com
