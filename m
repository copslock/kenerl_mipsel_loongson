Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g687CvRw007972
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 8 Jul 2002 00:12:57 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g687Cv4I007971
	for linux-mips-outgoing; Mon, 8 Jul 2002 00:12:57 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g687CmRw007960;
	Mon, 8 Jul 2002 00:12:48 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id AAA27616;
	Mon, 8 Jul 2002 00:16:58 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA02435;
	Mon, 8 Jul 2002 00:16:59 -0700 (PDT)
Received: from coplin09.mips.com (IDENT:root@coplin09 [192.168.205.79])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g687Gvb08858;
	Mon, 8 Jul 2002 09:16:57 +0200 (MEST)
Received: (from hartvige@localhost)
	by coplin09.mips.com (8.11.6/8.11.6) id g687GvM10243;
	Mon, 8 Jul 2002 09:16:57 +0200
From: Hartvig Ekner <hartvige@mips.com>
Message-Id: <200207080716.g687GvM10243@coplin09.mips.com>
Subject: Re: MIPS Atlas board
To: ralf@oss.sgi.com (Ralf Baechle)
Date: Mon, 8 Jul 2002 09:16:57 +0200 (CEST)
Cc: muthu5@sbcglobal.net (Muthukumar Ratty), linux-mips@oss.sgi.com
In-Reply-To: <20020707211930.A26692@dea.linux-mips.net> from "Ralf Baechle" at Jul 07, 2002 09:19:30 
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



Ralf Baechle writes:
> On Sun, Jul 07, 2002 at 11:09:00AM -0700, Muthukumar Ratty wrote:

> > BTW I was running network performance tools and the max I could read from
> > Atlas board is ~0.3M. Is this a problem with the hardware?
> 
> Hard to say without any kind of closer analysis.  The number certainly
> seems to be too low.  What network benchmark did you run, what processor
> and clock rate does your Atlas have?

There are known issues with the ethernet controller in the Philips 9730
device. For network-intensive applications, use a plug-in card.

/Hartvig
