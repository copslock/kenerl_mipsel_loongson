Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Apr 2004 13:55:20 +0100 (BST)
Received: from sorrow.cyrius.com ([IPv6:::ffff:65.19.161.204]:17412 "EHLO
	sorrow.cyrius.com") by linux-mips.org with ESMTP
	id <S8225344AbUDEMzT>; Mon, 5 Apr 2004 13:55:19 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 724FA64D4F; Mon,  5 Apr 2004 12:55:13 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 805BBFEED; Mon,  5 Apr 2004 13:54:36 +0100 (BST)
Date: Mon, 5 Apr 2004 13:54:36 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch] swarm-cs4297a: Support little-endian configuration
Message-ID: <20040405125436.GA2741@deprecation.cyrius.com>
References: <Pine.LNX.4.55.0404051236290.31851@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0404051236290.31851@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4731
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Maciej W. Rozycki <macro@ds2.pg.gda.pl> [2004-04-05 13:09]:
> The swarm-cs4297a driver currently works only with a big-endian
> configuration -- if run in little-endian one, it floods the console with
> an infinite stream of error messages, making the kernel effectively

Since you seem to use a SWARM in little-endian, let me ask 2 questions.
Are you using their boot loader (sibyl), and did you notice it has
problems in little-endian?  (IF so, do you have patches?  ;-)  Also,
have you been able to compile sibyl against a normal e2fslibs rather
than their custom version?
-- 
Martin Michlmayr
tbm@cyrius.com
