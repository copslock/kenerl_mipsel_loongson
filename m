Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Jan 2005 19:54:26 +0000 (GMT)
Received: from alg138.algor.co.uk ([IPv6:::ffff:62.254.210.138]:63401 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224920AbVAWTyQ>; Sun, 23 Jan 2005 19:54:16 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j0NJpU4d010133;
	Sun, 23 Jan 2005 19:51:30 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j0NJpTlR010132;
	Sun, 23 Jan 2005 19:51:29 GMT
Date:	Sun, 23 Jan 2005 19:51:29 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc:	Manish Lachwani <mlachwani@mvista.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] TX4927 processor can support different speeds
Message-ID: <20050123195129.GA1806@linux-mips.org>
References: <20050123192318.GA22681@prometheus.mvista.com> <20050123194140.GL15265@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050123194140.GL15265@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jan 23, 2005 at 08:41:40PM +0100, Thiemo Seufer wrote:

> > Based on the feedback from Toshiba, the TX4927 processor can support different 
> > speeds. Attached patch takes care of that. If you find this approach reasonable, 
> > can you please check it in
> 
> Shoudn't this better be tunable via /proc?

By the time that interface becomes available interrupt timers would
already have been missprogrammed.  Try to calibrate the CPU timer against
some external timer such as the RTC instead.  It's already being done
on the Indy.

  Ralf
