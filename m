Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Dec 2006 11:00:09 +0000 (GMT)
Received: from phoenix.bawue.net ([193.7.176.60]:19682 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20038715AbWLMLAE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 13 Dec 2006 11:00:04 +0000
Received: from lagash (88-106-179-150.dynamic.dsl.as9105.com [88.106.179.150])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 2EF89B8D49;
	Wed, 13 Dec 2006 12:02:50 +0100 (CET)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1GuRql-0006S8-Gg; Wed, 13 Dec 2006 11:00:35 +0000
Date:	Wed, 13 Dec 2006 11:00:35 +0000
To:	KokHow.Teh@infineon.com
Cc:	linux-mips@linux-mips.org, info@denx.de, Bing-Tao.Xu@infineon.com
Subject: Re: MIPS32v2 toolchain for MIPS32 24KE Core?
Message-ID: <20061213110035.GA4148@networkno.de>
References: <5049F8BE55F36348A315EFBE6CF34386E5D89E@sinse301.ap.infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5049F8BE55F36348A315EFBE6CF34386E5D89E@sinse301.ap.infineon.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

KokHow.Teh@infineon.com wrote:
> Hi;
> 	Which toolchain can I use to build linux kernel for 24KEc core
> in order to use MIPS32v2 ISA?

MIPS32R2 support was added in gcc-3.4.6, as mentioned in the release
notes at http://gcc.gnu.org/


Thiemo
