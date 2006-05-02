Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 May 2006 11:45:39 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:8871 "HELO bender.bawue.de")
	by ftp.linux-mips.org with SMTP id S8133705AbWEBKp1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 May 2006 11:45:27 +0100
Received: from lagash (unknown [194.74.144.146])
	by bender.bawue.de (Postfix) with ESMTP
	id A3E3C44348; Tue,  2 May 2006 12:45:26 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.61)
	(envelope-from <ths@networkno.de>)
	id 1FasMz-0002vC-PN; Tue, 02 May 2006 11:44:41 +0100
Date:	Tue, 2 May 2006 11:44:41 +0100
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Make interrupt handler works for all cases
Message-ID: <20060502104441.GA5004@networkno.de>
References: <cda58cb80605020055r2597bf3ds9fb380aab8cbf7b3@mail.gmail.com> <20060502094123.GB4301@linux-mips.org> <cda58cb80605020330hfd0352ds11f7f80603092cde@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80605020330hfd0352ds11f7f80603092cde@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Franck Bui-Huu wrote:
> 2006/5/2, Ralf Baechle <ralf@linux-mips.org>:
> >On Tue, May 02, 2006 at 09:55:51AM +0200, Franck Bui-Huu wrote:
> >
> >> specially when the kernel is mapped.
> >
> >At which time you're on very fragile ice because TLB instructions should
> >better be executed from an unmapped address ...
> >
> 
> well TLB entry used by the kernel is wired, so it should work fined,
> shouldn't it ?

The architecture spec doesn't guarantee it will.


Thiemo
