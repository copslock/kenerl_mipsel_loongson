Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Feb 2005 00:12:04 +0000 (GMT)
Received: from alg138.algor.co.uk ([IPv6:::ffff:62.254.210.138]:24038 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225313AbVBIALt>; Wed, 9 Feb 2005 00:11:49 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j1906f6x018620;
	Wed, 9 Feb 2005 00:06:41 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j1906eBQ018619;
	Wed, 9 Feb 2005 00:06:40 GMT
Date:	Wed, 9 Feb 2005 00:06:40 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Rojhalat Ibrahim <ibrahim@schenk.isar.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: More than 512MB of memory
Message-ID: <20050209000640.GA10651@linux-mips.org>
References: <41ED20E3.60309@schenk.isar.de> <20050204004028.GC22311@linux-mips.org> <42072264.6000001@schenk.isar.de> <20050208001742.GA15336@linux-mips.org> <42088CFA.6090605@schenk.isar.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42088CFA.6090605@schenk.isar.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 08, 2005 at 10:57:14AM +0100, Rojhalat Ibrahim wrote:

> I presume CKSEG is CKSEG0 in the above patch. With that it works
> about the same as before. So do you have any clue what the problem
> behind all that really is? Furthermore I still have all those
> "Illegal instruction" and "Segmentation fault" messages that
> shouldn't be there.

Sorry, yes I indeed meant CKSEG0. And this version of the patch really was
only meant to optimize the large performance impact your previous patch
had; it wasn't meant to fix anything beyond that.

As I can't replicate your configuration I'm still starring at the code to
find what's wrong ...

  Ralf
