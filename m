Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Sep 2002 21:27:19 +0200 (CEST)
Received: from mx2.mips.com ([206.31.31.227]:34701 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1123899AbSIXT1S>;
	Tue, 24 Sep 2002 21:27:18 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g8OJR7rZ004326;
	Tue, 24 Sep 2002 12:27:08 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id MAA28160;
	Tue, 24 Sep 2002 12:27:26 -0700 (PDT)
Message-ID: <002501c26400$b7fc0640$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Jun Sun" <jsun@mvista.com>
Cc: <linux-mips@linux-mips.org>
References: <008801c2639f$385b1b80$10eca8c0@grendel> <20020924103703.P14312@mvista.com>
Subject: Re: FCSR Management
Date: Tue, 24 Sep 2002 21:29:25 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 268
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

From: "Jun Sun" <jsun@mvista.com>
> > Am I missing something, or is this a problem?
> >
> 
> FPE exceptions, actually almost all exceptions, are cleared before their
> handlers are invoked.  See kernel/entry.S and look for BUILD_HANDLER().
> 
> Those macro defines are really mind-twisting and usually don't show up on
> grep radar...

Right you are.  Thanks.  Maciej gave me a bit of a scare there. ;-)
In an ideal universe, the unmodified FCSR which is correctly 
passed as a parameter to handle_fpe() (now that I look at entry.S,
it all comes back.. ;-) would be passed on as part of the
signal "payload" if SIGFPE is caught, but at least things
aren't drastically broken.

            Kevin K.
