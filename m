Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Oct 2005 19:13:11 +0100 (BST)
Received: from web201.biz.mail.re2.yahoo.com ([68.142.224.163]:37551 "HELO
	web201.biz.mail.re2.yahoo.com") by ftp.linux-mips.org with SMTP
	id S3465647AbVJRSMu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Oct 2005 19:12:50 +0100
Received: (qmail 90192 invoked by uid 60001); 18 Oct 2005 18:12:43 -0000
Message-ID: <20051018181243.90190.qmail@web201.biz.mail.re2.yahoo.com>
Received: from [161.88.255.139] by web201.biz.mail.re2.yahoo.com via HTTP; Tue, 18 Oct 2005 11:12:42 PDT
Date:	Tue, 18 Oct 2005 11:12:42 -0700 (PDT)
From:	Peter Popov <ppopov@embeddedalley.com>
Subject: RE: power management on mips
To:	"Mitchell, Earl" <earlm@mips.com>,
	Ivan Korzakow <ivan.korzakow@gmail.com>,
	linux-mips@linux-mips.org
In-Reply-To: <3CB54817FDF733459B230DD27C690CEC01049437@Exchange.MIPS.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9258
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips



--- "Mitchell, Earl" <earlm@mips.com> wrote:

> 
> True. PDAs and mobile devices also use it. 
> So it may be supported for platforms like
> AMD's Alchemy (e.g. they have a PDA reference
> design).


Yes, although I don't think AMD recommends switching
frequencies anymore. I think they rate/test the chip
only at its advertised speed. So static power
management could be implemented but Dynamic Power
Management (where most of the complexity is anyway)
would probably not be recommended by the manufacturer.

Pete
