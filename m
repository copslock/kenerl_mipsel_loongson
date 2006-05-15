Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 May 2006 19:30:56 +0200 (CEST)
Received: from sorrow.cyrius.com ([65.19.161.204]:7184 "HELO sorrow.cyrius.com")
	by ftp.linux-mips.org with SMTP id S8133677AbWEORas (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 15 May 2006 19:30:48 +0200
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id CF46064D54; Mon, 15 May 2006 17:30:39 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 1AC1366F5B; Mon, 15 May 2006 19:30:24 +0200 (CEST)
Date:	Mon, 15 May 2006 19:30:24 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Qemu system shutdown support
Message-ID: <20060515173023.GA13776@deprecation.cyrius.com>
References: <20060515172558.GD9026@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060515172558.GD9026@networkno.de>
User-Agent: Mutt/1.5.11+cvs20060330
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11438
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Thiemo Seufer <ths@networkno.de> [2006-05-15 18:25]:
> +{
> +        volatile unsigned int *reg = (unsigned int *)QEMU_RESTART_REG;

This should be a tab.
-- 
Martin Michlmayr
http://www.cyrius.com/
