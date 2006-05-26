Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 May 2006 18:00:32 +0200 (CEST)
Received: from sorrow.cyrius.com ([65.19.161.204]:4110 "HELO sorrow.cyrius.com")
	by ftp.linux-mips.org with SMTP id S8133813AbWEZQAW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 26 May 2006 18:00:22 +0200
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 5442164D54; Fri, 26 May 2006 16:00:09 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 7FCA666B44; Fri, 26 May 2006 17:55:51 +0200 (CEST)
Date:	Fri, 26 May 2006 17:55:51 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Linux MIPS <linux-mips@linux-mips.org>,
	Jordan Crouse <jordan.crouse@amd.com>, ralf@linux-mips.org
Subject: Re: [PATCH] Save write-only Config.OD from being clobbered (take 4)
Message-ID: <20060526155551.GA7022@deprecation.cyrius.com>
References: <20051122205938.GR18119@cosmic.amd.com> <43838957.2020106@ru.mvista.com> <442457A6.4080508@dev.rtsoft.ru> <44767979.6020106@ru.mvista.com> <44772276.2020005@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44772276.2020005@ru.mvista.com>
User-Agent: Mutt/1.5.11+cvs20060330
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11569
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Sergei Shtylyov <sshtylyov@ru.mvista.com> [2006-05-26 19:44]:
> +	/* We need to catch the ealry Alchemy SOCs with
                                ^^^^^
typo

> +	 * We need to catch the ealry Alchemy SOCs with

likewise.

-- 
Martin Michlmayr
http://www.cyrius.com/
