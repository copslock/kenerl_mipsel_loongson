Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2006 15:13:33 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:50925 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8134420AbWAIPNQ
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jan 2006 15:13:16 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k09FFxrM011933;
	Mon, 9 Jan 2006 07:16:00 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.12.9/8.12.11) with SMTP id k09FFvYr007330;
	Mon, 9 Jan 2006 07:15:57 -0800 (PST)
Message-ID: <00af01c6152f$dc1863f0$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>,
	"Sathesh Babu Edara" <satheshbabu.edara@analog.com>
Cc:	<linux-mips-bounce@linux-mips.org>, <linux-mips@linux-mips.org>
References: <200601090742.k097gYaZ017304@lilac.hdcindia.analog.com> <200601090749.k097nFaZ017891@lilac.hdcindia.analog.com> <20060109145425.GA4286@linux-mips.org>
Subject: Re: LL and SC instruction simulation
Date:	Mon, 9 Jan 2006 16:17:50 +0100
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
X-archive-position: 9813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

Ralf writes:
> On Mon, Jan 09, 2006 at 01:19:46PM +0530, Sathesh Babu Edara wrote:
> 
> >    We have ported linux-2.4.18 and linux-2-6.12 kernel (mips.org)onto MIPS
> > processor (CPU type lx4189).
> > 
> >  We observed that on 2.4 kernel,ll and sc instruction exception handlers
> > hitting very often.
> > Where as on linux-2.6.12 this is not happening.
> 
> > Can anybody have idea why this instructions are hitting on 2.4.18 kernel and
> > not on 2-6.12 kernel.
> 
> Only ll/sc instructions in application software can be emulated, so it
> would seem your application is behaving different on 2.4 and 2.6 kernels.

Is there an interface where 2.6 might be telling library code to use system calls
instead LL/SC, where the 2.4 kernel didn't?

            Regards,

            Kevin K.
