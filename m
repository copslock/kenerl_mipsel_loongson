Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Apr 2008 12:34:44 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:56501 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S28576737AbYDQLem (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 17 Apr 2008 12:34:42 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 3DE843EC9; Thu, 17 Apr 2008 04:34:38 -0700 (PDT)
Message-ID: <480735A8.8010900@ru.mvista.com>
Date:	Thu, 17 Apr 2008 15:34:00 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Jens Seidel <jensseidel@users.sf.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Alchemy: kill useless #include's, #define's and extern's
 (take 3)
References: <200804162115.59620.sshtylyov@ru.mvista.com> <20080416200517.GA21402@merkur.sol.de>
In-Reply-To: <20080416200517.GA21402@merkur.sol.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Jens Seidel wrote:

>>Go thru the Alchemy code and hunt down every unneeded #include, #define, and
>>extern (some of which refer to already long dead functions).

> that's an impressive patch! Did you created it manually or do you have a
> script which does the checks for you?

    All hand work. :-)

WBR, Sergei
