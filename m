Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2006 11:41:46 +0000 (GMT)
Received: from webmail.ict.ac.cn ([159.226.39.7]:44772 "HELO ict.ac.cn")
	by ftp.linux-mips.org with SMTP id S8133736AbWBBLl1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2006 11:41:27 +0000
Received: (qmail 13225 invoked by uid 507); 2 Feb 2006 11:11:56 -0000
Received: from unknown (HELO ?210.77.15.252?) (fxzhang@210.77.15.72)
  by ict.ac.cn with SMTP; 2 Feb 2006 11:11:56 -0000
Message-ID: <439C118B.20402@ict.ac.cn>
Date:	Sun, 11 Dec 2005 19:46:19 +0800
From:	Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
CC:	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: linker script for non-4k page size
References: <439B9104.6000605@ict.ac.cn> <439B9566.3020607@ict.ac.cn> <20060202110554.GA26789@networkno.de>
In-Reply-To: <20060202110554.GA26789@networkno.de>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips



Thiemo Seufer 写道:
> 
> AFAIR a 64k alignment between code and data segments was introduced
> in debian shortly before the sarge release, but no attempt to
> systematically rebuild with that toolchain was made (because debian
> sarge supports only 4k paged kernels). A rebuild of the respective
> sarge packages should be enough to work around the problem.
Rebuild is too much work:), I just wrote some scripts to convert all the
debian packages: extract the files, convert the binaries, and repack.

If anyone is interested, I can provide the scripts(and the resulting
16k-enable sarge mipsel isos), though he has to wait some days before I go
back to lab.
> 
> 
> Thiemo
> 
> 
> 
