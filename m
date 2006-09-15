Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Sep 2006 21:39:43 +0100 (BST)
Received: from web31506.mail.mud.yahoo.com ([68.142.198.135]:12696 "HELO
	web31506.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20037845AbWIOUji (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 15 Sep 2006 21:39:38 +0100
Received: (qmail 80611 invoked by uid 60001); 15 Sep 2006 20:39:31 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=OWj05PFDDQ6/9kHLDZ+cu9Pj9vr5XVLegPY854UKl5RW2c04xeymUhl+8CJLery9oSu54TYlTY74ZsFDTp6lVqCl5K27jMi0klCdikk6VSMrv16SXQsa+GFPLm6aLLp1T4GmVN6sh6c4aDtysOEaYSqprjN9DLUz0A8vf/cn/F8=  ;
Message-ID: <20060915203931.80609.qmail@web31506.mail.mud.yahoo.com>
Received: from [70.103.67.194] by web31506.mail.mud.yahoo.com via HTTP; Fri, 15 Sep 2006 13:39:31 PDT
Date:	Fri, 15 Sep 2006 13:39:31 -0700 (PDT)
From:	Jonathan Day <imipak@yahoo.com>
Subject: Kernel debugging question
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,

So that I can stop pestering the list with kernel
boot-time problems that (from the looks of it) aren't
easily reproduced or tracked, I'd like a few
suggestions on how to diagnose these sorts of problems
myself.

Specifically, there seem to be two areas that jam up
most often - kernel initialization and between freeing
up the memory & running the MIPS FPU emulator.

Are there any specific debug flags I can set in the
kernel that will dump to the console (which is on the
serial port) more detailed information on what is
going on at these times?

Alternatively, I've had problems getting the kernel to
link to a debugger live (eg: gdb), but presumably
there are ways to do effective non-live debugging.
What experience do people have with doing this?

Jonathan Day


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
