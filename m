Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 May 2006 22:29:13 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:50824 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133797AbWEDV2y
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 May 2006 22:28:54 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k44LSiWd015499;
	Thu, 4 May 2006 14:28:44 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with SMTP id k44LSgiR000803;
	Thu, 4 May 2006 14:28:43 -0700 (PDT)
Message-ID: <028901c66fc2$3ff139f0$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Kevin D. Kissell" <kevink@mips.com>,
	"Tom Rini" <trini@kernel.crashing.org>,
	"Thiemo Seufer" <ths@networkno.de>
Cc:	"Tim Bird" <tim.bird@am.sony.com>, <linux-mips@linux-mips.org>
References: <445A577D.7090507@am.sony.com> <20060504205517.GF18218@networkno.de> <20060504210449.GA12676@smtp.west.cox.net> <028201c66fc1$4f724d20$10eca8c0@grendel>
Subject: Re: [PATCH] fix mips/Makefile to support CROSS_COMPILE from environment var
Date:	Thu, 4 May 2006 23:32:29 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> > Let me ask a stupid question.  With all of the ways to otherwise do a
> > cross compile, why a config option on MIPS?  ARM*/SH*, which are at
> > least as likely to not be native-compiled, don't do that.  Just
> > something I've always wondered, really.
> 
> Probably because, unlike ARM and SH, the MIPS architecture began life
> as a workstation/server processor, and for a while there cross-compilation
> was the exception rather than the rule.

Before anyone else jumps in, yeah, ARM was sort-of a workstation processor
to begin with, too, but I don't think the original Acorn RISC Machine was set
up to run a "real" OS, with memory management, etc., whereas MIPS was.

            Regards,

            Kevin K.
