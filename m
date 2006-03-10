Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Mar 2006 13:07:25 +0000 (GMT)
Received: from bender.bawue.de ([193.7.176.20]:38879 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S8133727AbWCJNHR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 10 Mar 2006 13:07:17 +0000
Received: from lagash (unknown [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id B3DD2446E1; Fri, 10 Mar 2006 14:15:58 +0100 (MET)
Received: from ths by lagash with local (Exim 4.60)
	(envelope-from <ths@networkno.de>)
	id 1FHhTl-0002rq-Pn; Fri, 10 Mar 2006 13:16:25 +0000
Date:	Fri, 10 Mar 2006 13:16:25 +0000
To:	Fuxin Zhang <fxzhang@ict.ac.cn>
Cc:	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: tools to convert debian sarge to 16K page size
Message-ID: <20060310131625.GA4821@networkno.de>
References: <44113DC6.1010607@ict.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44113DC6.1010607@ict.ac.cn>
User-Agent: Mutt/1.5.11+cvs20060126
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10779
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

On Fri, Mar 10, 2006 at 04:50:14PM +0800, Fuxin Zhang wrote:
> hi,
>   Some time ago I promised this:
> 
>   Attached is some program/scripts to convert sarge debs to 16k page
> compatible,that is, a kernel with PAGE_SIZE == 16K can use it.
> 
>   There is a simple README in the tar file.

Can you provide information about the performance impact? That is,
what system(s) you use, and some basic benchmark numbers. Did you also
try 64k pages?


Thiemo
