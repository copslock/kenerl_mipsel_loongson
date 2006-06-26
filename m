Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jun 2006 22:41:35 +0100 (BST)
Received: from w099.z064220152.sjc-ca.dsl.cnc.net ([64.220.152.99]:11466 "EHLO
	duck.specifix.com") by ftp.linux-mips.org with ESMTP
	id S8133925AbWFZVlZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Jun 2006 22:41:25 +0100
Received: from [127.0.0.1] (duck.corp.specifix.com [192.168.1.1])
	by duck.specifix.com (Postfix) with ESMTP
	id 2A327FC77; Mon, 26 Jun 2006 14:41:05 -0700 (PDT)
Subject: Re: sb1250-mac broadcom ethernet driver
From:	James E Wilson <wilson@specifix.com>
To:	Tom Christoffel <tomc@bluesocket.com>
Cc:	linux-mips@linux-mips.org, Patrick Foy <pfoy@bluesocket.com>,
	Tom Guevin <tguevin@bluesocket.com>
In-Reply-To: <0240FDD68D6C1F4289F73D134A2536A1CA168F@mail1.bluesocket.com>
References: <0240FDD68D6C1F4289F73D134A2536A1CA168F@mail1.bluesocket.com>
Content-Type: text/plain
Message-Id: <1151358064.9127.107.camel@aretha.corp.specifix.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date:	Mon, 26 Jun 2006 14:41:05 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <wilson@specifix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilson@specifix.com
Precedence: bulk
X-list: linux-mips

On Mon, 2006-06-26 at 14:20, Tom Christoffel wrote:
> We are experiencing intermittent lockups,

Try the NAPI patch that Tom Rix wrote.
  http://www.linux-mips.org/archives/linux-mips/2006-06/msg00031.html
-- 
Jim Wilson, GNU Tools Support, http://www.specifix.com
