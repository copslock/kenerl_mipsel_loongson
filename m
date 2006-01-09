Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2006 15:42:41 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:55277 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8134425AbWAIPmX
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jan 2006 15:42:23 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k09Fj9Iq012017;
	Mon, 9 Jan 2006 07:45:10 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.12.9/8.12.11) with SMTP id k09Fj7Yr007778;
	Mon, 9 Jan 2006 07:45:08 -0800 (PST)
Message-ID: <00fd01c61533$ef797e30$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	"Sathesh Babu Edara" <satheshbabu.edara@analog.com>,
	<linux-mips-bounce@linux-mips.org>, <linux-mips@linux-mips.org>
References: <200601090742.k097gYaZ017304@lilac.hdcindia.analog.com> <200601090749.k097nFaZ017891@lilac.hdcindia.analog.com> <20060109145425.GA4286@linux-mips.org> <00af01c6152f$dc1863f0$10eca8c0@grendel> <20060109152148.GD4286@linux-mips.org> <20060109153028.GA6542@linux-mips.org>
Subject: Re: LL and SC instruction simulation
Date:	Mon, 9 Jan 2006 16:47:01 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> > > Is there an interface where 2.6 might be telling library code to use system calls
> > > instead LL/SC, where the 2.4 kernel didn't?
> > 
> > No.
> 
> And I think it's not really worth it.  MIPS II did introduce ll/sc in
> 1991 and it was becoming widely available with MIPS III and some pseudo-
> MIPS II R3000 variants also in the embedded markets and MIPS32/MIPS64
> were based on that.  So ll/sc-less processors are a very small part of
> the market of Linux/MIPS these days, not really worth to optimize for.

Hmm.  I can think of at least one *very* high volume MIPS Linux platform still
manufactured by a very large Japanese electronics company where LL/SC
either isn't implemented or doesn't work...  

            Regards,

            Kevin K.
