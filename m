Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2006 14:51:53 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:12059 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8134414AbWAIOvf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jan 2006 14:51:35 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k09EsPre005527;
	Mon, 9 Jan 2006 14:54:26 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k09EsP66005526;
	Mon, 9 Jan 2006 14:54:25 GMT
Date:	Mon, 9 Jan 2006 14:54:25 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sathesh Babu Edara <satheshbabu.edara@analog.com>
Cc:	linux-mips-bounce@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: LL and SC instruction simulation
Message-ID: <20060109145425.GA4286@linux-mips.org>
References: <200601090742.k097gYaZ017304@lilac.hdcindia.analog.com> <200601090749.k097nFaZ017891@lilac.hdcindia.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601090749.k097nFaZ017891@lilac.hdcindia.analog.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 09, 2006 at 01:19:46PM +0530, Sathesh Babu Edara wrote:

>    We have ported linux-2.4.18 and linux-2-6.12 kernel (mips.org)onto MIPS
> processor (CPU type lx4189).
> 
>  We observed that on 2.4 kernel,ll and sc instruction exception handlers
> hitting very often.
> Where as on linux-2.6.12 this is not happening.

> Can anybody have idea why this instructions are hitting on 2.4.18 kernel and
> not on 2-6.12 kernel.

Only ll/sc instructions in application software can be emulated, so it
would seem your application is behaving different on 2.4 and 2.6 kernels.

> What is the significance of these instructions?.

All sorts of atomic operations.  I suggest you read up on them in See MIPS
Run or short of that in the MIPS32/64 specification.

  Ralf
