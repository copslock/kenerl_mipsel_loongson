Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Sep 2005 09:44:21 +0100 (BST)
Received: from smtp.wicomtechnologies.com ([195.234.214.162]:54502 "EHLO
	smtp.wicomtechnologies.com") by ftp.linux-mips.org with ESMTP
	id S8133568AbVI0Im0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Sep 2005 09:42:26 +0100
Received: from [192.168.0.24] (wcm-24.wicom.kiev.ua [192.168.0.24] (may be forged))
	by smtp.wicomtechnologies.com (8.12.10/8.12.10) with ESMTP id j8R8g7Xp091099;
	Tue, 27 Sep 2005 11:42:07 +0300 (EEST)
	(envelope-from jerry@wicomtechnologies.com)
Date:	Tue, 27 Sep 2005 11:42:08 +0300
From:	Jerry <jerry@wicomtechnologies.com>
X-Mailer: The Bat! (v3.51.10) Professional
Reply-To: Jerry <jerry@wicomtechnologies.com>
X-Priority: 3 (Normal)
Message-ID: <77412291.20050927114208@wicomtechnologies.com>
To:	Matej Kupljen <matej.kupljen@ultra.si>
CC:	linux-mips@linux-mips.org
Subject: Re: Floating point performance
In-Reply-To: <1127809027.26702.14.camel@localhost.localdomain>
References: <1127809027.26702.14.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <jerry@wicomtechnologies.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9047
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jerry@wicomtechnologies.com
Precedence: bulk
X-list: linux-mips

>[In reply to "Floating point performance" from Matej Kupljen <matej.kupljen@ultra.si> to linux-mips@linux-mips.org <linux-mips@linux-mips.org>  27.09.2005 11:17]

> Hi

> I've built soft float toolchain (with crosstool) and then build
> MPlayer with it. The performance is very low. I cannot even
> As it seems, all the time is spent in the FP routines.
> I decided to use SF toolchain, because they should be faster
> then FPU emulator (at least it is on ARM), but did no test
> this with emulator.

Decoding of mp3 (and/or other media) with FP routines is extremely
slow on systems w/o fp processor. No matter is it "soft-float" or
"kernel-trap emulator". Both cases it is the emulator.(but SF is a
litthe faster because it has no "trap" overhead).

> Does anybody use MPlayer on MIPS? 
> What performance do you get?

I used mplayed with libmad (libmad uses only integer ops to decode
mp3). It consumes about 10-15% of cpu time (au1200) to play mp3 file.



   ()_()
 -( ^,^ )- -[21398845]- -<The Bat! 3.51.10>- -<27.09.2005 11:33>-
  (") (")
