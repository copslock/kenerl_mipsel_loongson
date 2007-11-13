Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2007 14:47:07 +0000 (GMT)
Received: from dns0.mips.com ([63.167.95.198]:62648 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S20026641AbXKMOq5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Nov 2007 14:46:57 +0000
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id lADEciPK026008;
	Tue, 13 Nov 2007 06:38:44 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with SMTP id lADEd9kP006753;
	Tue, 13 Nov 2007 06:39:10 -0800 (PST)
Message-ID: <019e01c82602$f5463bf0$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>,
	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	"Andrew Haley" <aph-gcc@littlepinkcloud.com>,
	"David Daney" <ddaney@avtrex.com>, <linux-mips@linux-mips.org>,
	"Richard Sandiford" <rsandifo@nildram.co.uk>, <gcc@gcc.gnu.org>
References: <473957B6.3030202@avtrex.com> <18233.36645.232058.964652@zebedee.pink> <20071113121036.GA6582@linux-mips.org> <cda58cb80711130514x16356ea3x4069616c9ee3caac@mail.gmail.com>
Subject: Re: Cannot unwind through MIPS signal frames with ICACHE_REFILLS_WORKAROUND_WAR
Date:	Tue, 13 Nov 2007 15:37:39 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1896
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

Franck a dit:
> > Another reason is to get rid of the classic trampoline the kernel installs
> > on the stack.  On some multiprocessor systems it requires a cacheflush
> > operation to be performed on all processors which is expensive.  Having
> > the trampoline in a vDSO would solve that.
> >
> 
> And the stack wouldn't need to have exec permission anymore.

True, though it should perhaps be noted that currently it's only on 4KSc/Sd
systems (which I know you work on) where it's even possible for the stack
*not* to have exec permissions, since the classical MIPS MMU gives
execute permission to any page that is readable.

            Regards,

            Kevin K.
