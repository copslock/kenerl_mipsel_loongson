Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Dec 2016 03:22:44 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17145 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992186AbcLPCWgRYvTO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Dec 2016 03:22:36 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id C664A81505F59;
        Fri, 16 Dec 2016 02:22:28 +0000 (GMT)
Received: from [10.20.78.233] (10.20.78.233) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Fri, 16 Dec 2016
 02:22:28 +0000
Date:   Fri, 16 Dec 2016 02:22:16 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: MIPS: IP22: Fix binutils due to binutils 2.25 uselessnes.
In-Reply-To: <S23993072AbcLOP7sNw5Hx/20161215155948Z+1597@eddie.linux-mips.org>
Message-ID: <alpine.DEB.2.00.1612160206450.6743@tp.orcam.me.uk>
References: <S23993072AbcLOP7sNw5Hx/20161215155948Z+1597@eddie.linux-mips.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.233]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56059
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Thu, 15 Dec 2016, linux-mips@linux-mips.org wrote:

> Fix build with binutils 2.25 by open coding the offending
> 
> 	dli $1, 0x9000000080000000
> 
> as
> 
> 	li	$1, 0x9000
> 	dsll	$1, $1, 48
> 
> which is ugly be the only thing that will build on all binutils vintages.

 What about bit #31?  Shouldn't this be say:

	lui	$1, 0x9000
	dsll	$1, $1, 16
	ori	$1, $1, 0x8000
	dsll	$1, $1, 16

?

  Maciej
