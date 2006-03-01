Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Mar 2006 19:19:31 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:25101 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133619AbWCATTW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Mar 2006 19:19:22 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k21JQvkn030912;
	Wed, 1 Mar 2006 19:26:57 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k21JQv2O030910;
	Wed, 1 Mar 2006 19:26:57 GMT
Date:	Wed, 1 Mar 2006 19:26:57 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dominique Quatravaux <dom@kilimandjaro.dyndns.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Error trying to update www.linux-mips.org/wiki
Message-ID: <20060301192657.GA28396@linux-mips.org>
References: <440384D2.5040109@kilimandjaro.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440384D2.5040109@kilimandjaro.dyndns.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 28, 2006 at 12:01:38AM +0100, Dominique Quatravaux wrote:

> Hi, while trying to reorganize information a bit in the Linux-Mips wiki,
> I came across the following error when I try to save my changes. This
> apparently happens on all pages.
> 
> Best regards, Dom
> 
> == 8< == 8< ==
> 
> A database query syntax error has occurred. This may indicate a bug in
> the software. The last attempted database query was:
> 
>     (SQL query hidden)
> 
> from within function "SearchUpdate::doUpdate". MySQL returned error
> "1016: Can't open file: 'searchindex.MYI' (errno: 145) (localhost)".

MySQL for unknown reasons seems to love marking it's tables as crashed
every once in a while.  I just fixed that.

  Ralf
