Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Feb 2003 02:42:03 +0000 (GMT)
Received: from web40401.mail.yahoo.com ([IPv6:::ffff:66.218.78.98]:6742 "HELO
	web40401.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225240AbTBECmC>; Wed, 5 Feb 2003 02:42:02 +0000
Message-ID: <20030205024153.67587.qmail@web40401.mail.yahoo.com>
Received: from [157.165.41.125] by web40401.mail.yahoo.com via HTTP; Tue, 04 Feb 2003 18:41:53 PST
Date: Tue, 4 Feb 2003 18:41:53 -0800 (PST)
From: Long Li <long21st@yahoo.com>
Subject: Specify the as path when gcc runs
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <long21st@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1325
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: long21st@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,

Is there a way that I can specify the path for 'as' on
the fly when I use gcc? I have a MIPS cross compiler
xgcc on Redhat 7.1. However, in the Makefile, I use
both the native compiler as well as the crosscompiler.
They both search the path to find the as to use, which
is incorrect. I don't want to rebuild the
crosscompiler to specify the path for as using
--with-as=pathname, and wonder if I can specify the as
path for the crosscompiler on the fly?


Thanks a lot!


Long

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
