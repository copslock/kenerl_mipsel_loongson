Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Dec 2002 10:32:40 +0100 (CET)
Received: from alg133.algor.co.uk ([62.254.210.133]:42716 "EHLO
	oalggw.algor.co.uk") by linux-mips.org with ESMTP
	id <S8225265AbSLEJcj>; Thu, 5 Dec 2002 10:32:39 +0100
Received: from arsenal.algor.co.uk (pubfw.algor.co.uk [62.254.210.129])
	by oalggw.algor.co.uk (8.11.6/8.10.1) with ESMTP id gB59WNW18309;
	Thu, 5 Dec 2002 09:32:23 GMT
Received: from dom by arsenal.algor.co.uk with local (Exim 3.35 #1 (Debian))
	id 18JsMk-0003Bi-00; Thu, 05 Dec 2002 09:32:18 +0000
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15855.7458.19248.593085@arsenal.algor.co.uk>
Date: Thu, 5 Dec 2002 09:32:18 +0000
To: Carsten Langgaard <carstenl@mips.com>
Cc: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@linux-mips.org,
	dom@mips.com, chris@mips.com, kevink@mips.com
Subject: Re: Prefetches in memcpy
In-Reply-To: <3DEE19EC.DD007304@mips.com>
References: <3DC7CB8B.E2C1D4E5@mips.com>
	<20021105163806.A24996@bacchus.dhis.org>
	<3DEE19EC.DD007304@mips.com>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Return-Path: <dom@algor.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 764
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@algor.co.uk
Precedence: bulk
X-list: linux-mips


Carsten,

> I think we should get rid of the prefetches until someone comes up with a
> version that doesn't prefetch beyond the copy destination/source area.

I agree.

--
Dominic
