Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2006 15:49:18 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:10268 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8134423AbWAIPs7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jan 2006 15:48:59 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k09Fpqqf012712;
	Mon, 9 Jan 2006 15:51:52 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k09FpqnB012711;
	Mon, 9 Jan 2006 15:51:52 GMT
Date:	Mon, 9 Jan 2006 15:51:52 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	Sathesh Babu Edara <satheshbabu.edara@analog.com>,
	linux-mips@linux-mips.org
Subject: Re: LL and SC instruction simulation
Message-ID: <20060109155152.GF4286@linux-mips.org>
References: <200601090742.k097gYaZ017304@lilac.hdcindia.analog.com> <200601090749.k097nFaZ017891@lilac.hdcindia.analog.com> <20060109145425.GA4286@linux-mips.org> <00af01c6152f$dc1863f0$10eca8c0@grendel> <20060109152148.GD4286@linux-mips.org> <20060109153028.GA6542@linux-mips.org> <00fd01c61533$ef797e30$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00fd01c61533$ef797e30$10eca8c0@grendel>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9819
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 09, 2006 at 04:47:01PM +0100, Kevin D. Kissell wrote:

> Hmm.  I can think of at least one *very* high volume MIPS Linux platform still
> manufactured by a very large Japanese electronics company where LL/SC
> either isn't implemented or doesn't work...  

The user community of that platform of that four letter vendor still
hasn't managed to upgrade their kernels to something that would even be
remotely contemporary, so any 2.6 questions don't apply ...

  Ralf
