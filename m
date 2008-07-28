Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jul 2008 12:04:08 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:40626 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20023893AbYG1LD7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 28 Jul 2008 12:03:59 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 0054F3ED2; Mon, 28 Jul 2008 04:03:55 -0700 (PDT)
Message-ID: <488DA79D.1020900@ru.mvista.com>
Date:	Mon, 28 Jul 2008 15:03:57 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Kevin Hickey <khickey@rmicorp.com>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/1] Initialization of Alchemy boards
References: <1217002430.10968.30.camel@kh-ubuntu.razamicroelectronics.com>
In-Reply-To: <1217002430.10968.30.camel@kh-ubuntu.razamicroelectronics.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19986
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Kevin Hickey wrote:

> I found this when I updated to version 2.6.26.  None of my development
> boards would boot.  It appears that a previous update changed some calls
> to simple_strtol to strict_strtol but did not account for the different
> call semantics.

    Oops, that was me who changed/overlooked that, sorry. :-<
    The patch is fine but you forgot to sign it off.

WBR, Sergei
