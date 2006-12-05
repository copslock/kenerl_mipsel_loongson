Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Dec 2006 12:43:35 +0000 (GMT)
Received: from phoenix.bawue.net ([193.7.176.60]:32943 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20038987AbWLEMna (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 5 Dec 2006 12:43:30 +0000
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id C2AE1B908A;
	Tue,  5 Dec 2006 13:45:46 +0100 (CET)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1GrZeO-0001sx-1q; Tue, 05 Dec 2006 12:43:56 +0000
Date:	Tue, 5 Dec 2006 12:43:56 +0000
To:	"Fu, He Wei PSE NKG" <hewei.fu@siemens.com>
Cc:	Daniel Jacobowitz <dan@debian.org>, linux-mips@linux-mips.org
Subject: Re: The difference between mips*-gnu and mips*-linux when configure tool-chain
Message-ID: <20061205124355.GB26046@networkno.de>
References: <20061203170514.GA11258@nevyn.them.org> <96E7D5519FC3D741BEE27AB88C7387970167840A@PEKW934A.cn001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96E7D5519FC3D741BEE27AB88C7387970167840A@PEKW934A.cn001.siemens.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13343
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Fu, He Wei PSE NKG wrote:
> Thanks, sorry for I missed the mips*-elf for mips*-gnu.
> 
> I think that for ld,the difference between mips*-elf and mips*-linux
> produces only some minor impact on the default ld script, for the
> behavior of ld itself, it has not serious impact.Is it my understanding
> correct?
> 
> But for bfd, does the difference of these two config-choice have impact
> on the behavior of two different bfd-target? . 

For both cases the resulting object file layout is different. mips*-elf
uses SGI-style, mips*-linux uses "traditional" style. I expect the
"traditional" format to get better long-term maintenance.

For a stand-alone bootloader both do for now, but I would prefer
mips*-linux since it eliminates the need for one extra compiler
when building a Linux environment.


Thiemo
