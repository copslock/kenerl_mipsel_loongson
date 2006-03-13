Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Mar 2006 20:36:41 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:28305 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133814AbWCMUgd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 13 Mar 2006 20:36:33 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k2DKjZW2017112;
	Mon, 13 Mar 2006 20:45:35 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k2DKjZpj017111;
	Mon, 13 Mar 2006 20:45:35 GMT
Date:	Mon, 13 Mar 2006 20:45:35 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kurt Schwemmer <kurts@vitesse.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Cross compile kernel w/ buildroot toolchain
Message-ID: <20060313204535.GA17046@linux-mips.org>
References: <389E6A416914954182ECDFCD844D8269434FBF@MX-COS.vsc.vitesse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <389E6A416914954182ECDFCD844D8269434FBF@MX-COS.vsc.vitesse.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 13, 2006 at 01:39:53PM -0700, Kurt Schwemmer wrote:

> I got 2.6.15 "a while back" (>1 month). 
> 
> I'll try getting the most recent source. Sorry, I avoided this due to my
> company blocking rsync and thus making it a pain to get the sources... 

You can still download kernel tarballs from linux-mips.org via ftp and
http; the git repository is accessible through rsync (deprecated), git
and if everything else fails, http.

  Ralf
