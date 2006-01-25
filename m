Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2006 01:35:00 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:38155 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133606AbWAYBef (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Jan 2006 01:34:35 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 0C6ED64D3D; Wed, 25 Jan 2006 01:38:54 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id AF16F8D5E; Wed, 25 Jan 2006 01:38:45 +0000 (GMT)
Date:	Wed, 25 Jan 2006 01:38:45 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Kumba <kumba@gentoo.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: check of endianess?
Message-ID: <20060125013845.GD30418@deprecation.cyrius.com>
References: <20060124233846.GA10784@deprecation.cyrius.com> <43D6CF69.1050204@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D6CF69.1050204@gentoo.org>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10120
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Kumba <kumba@gentoo.org> [2006-01-24 20:07]:
> >I made a copy&paste typo in my build script and used mipsel-linux-cc
> >to compile.  Shouldn't this be detected earlier on?
> That actually booted? I thought SGIs were hardwired specifically for BE, 
> and the prom should've rejected an LE kernel (Granted, there is a jumper on 
> the IP32 board labelled "Big Endian", so it's anyone's guess).

I *think* mipsel-linux-cc can produce big endian code too but I guess
something went wrong.
-- 
Martin Michlmayr
http://www.cyrius.com/
