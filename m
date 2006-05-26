Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 May 2006 18:03:27 +0200 (CEST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:27069 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133801AbWEZQDS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 26 May 2006 18:03:18 +0200
Received: (qmail 5133 invoked from network); 26 May 2006 20:11:11 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 26 May 2006 20:11:11 -0000
Message-ID: <44772691.7060900@ru.mvista.com>
Date:	Fri, 26 May 2006 20:02:25 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Martin Michlmayr <tbm@cyrius.com>
CC:	Linux MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Save write-only Config.OD from being clobbered (take
 4)
References: <20051122205938.GR18119@cosmic.amd.com> <43838957.2020106@ru.mvista.com> <442457A6.4080508@dev.rtsoft.ru> <44767979.6020106@ru.mvista.com> <44772276.2020005@ru.mvista.com> <20060526155551.GA7022@deprecation.cyrius.com>
In-Reply-To: <20060526155551.GA7022@deprecation.cyrius.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11570
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Martin Michlmayr wrote:
> * Sergei Shtylyov <sshtylyov@ru.mvista.com> [2006-05-26 19:44]:

>>+	/* We need to catch the ealry Alchemy SOCs with
                                 ^^^^^
> typo

>>+	 * We need to catch the ealry Alchemy SOCs with

> likewise.

    Too late, after 6 or so months, it's in. :-)

WBR, Sergei
