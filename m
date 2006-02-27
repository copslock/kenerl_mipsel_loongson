Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Feb 2006 18:05:45 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:4883 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133464AbWB0SFd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Feb 2006 18:05:33 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1RIC3ic019045;
	Mon, 27 Feb 2006 18:12:03 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1RIC1Hp019044;
	Mon, 27 Feb 2006 18:12:01 GMT
Date:	Mon, 27 Feb 2006 18:12:01 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Diff between Linus' and linux-mips git: tulip
Message-ID: <20060227181201.GA16801@linux-mips.org>
References: <20060219234318.GA16311@deprecation.cyrius.com> <20060220000141.GX10266@deprecation.cyrius.com> <20060220001907.GC17967@deprecation.cyrius.com> <20060220230349.GB1122@colonel-panic.org> <20060224011324.GN9704@deprecation.cyrius.com> <20060224014957.GB26157@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060224014957.GB26157@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10661
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 24, 2006 at 01:49:57AM +0000, Martin Michlmayr wrote:

> OK, I managed to track down when this change was introduced, namely in
> the merge with Linux 2.6.13-rc1.  See
> http://www.linux-mips.org/git?p=linux.git;a=blobdiff;h=e6781ea5ba055ec445f35c734a59db24e748be3a;hp=cfc346e72d6234ae37ee11b794791ee99fcec24e;hb=aa5fcc48f9ae2887b6c570411e73ef965f72a746;f=drivers/net/tulip/tulip_core.c
> 
> Ralf, please apply this to the mips-tree only (not for-linus).

Applied,

  Ralf
