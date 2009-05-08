Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2009 18:05:13 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:37597 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S20025209AbZEHRFG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 8 May 2009 18:05:06 +0100
Received: from [192.168.11.226] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id F41D83ED2; Fri,  8 May 2009 10:05:01 -0700 (PDT)
Message-ID: <4A046659.1060800@ru.mvista.com>
Date:	Fri, 08 May 2009 21:05:29 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Peter 'p2' De Schrijver <p2@debian.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: kernel boot failure on swarm
References: <20090508165905.GL1835@apfelkorn>
In-Reply-To: <20090508165905.GL1835@apfelkorn>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Peter 'p2' De Schrijver wrote:

> I'm trying to boot 2.6.29 on swarm (BE) but it seems to panic in the ide driver.

    Note that you hardly need ide_generic on SWARM. It only probes legacy 
x86 addresses.

> Log attached.

MBR, Sergei
