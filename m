Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Sep 2008 17:33:10 +0100 (BST)
Received: from homer.mvista.com ([63.81.120.155]:19515 "EHLO
	imap.sh.mvista.com") by ftp.linux-mips.org with ESMTP
	id S20100620AbYIJQZU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Sep 2008 17:25:20 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 1CA563EC9; Wed, 10 Sep 2008 09:25:14 -0700 (PDT)
Message-ID: <48C7F513.2090203@ru.mvista.com>
Date:	Wed, 10 Sep 2008 20:25:55 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
References: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>	<48C6B768.4010200@ru.mvista.com> <20080911.003222.51867360.anemo@mba.ocn.ne.jp> <48C7EDE4.3090400@ru.mvista.com>
In-Reply-To: <48C7EDE4.3090400@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, I just wrote:

>    Acltually, this is somewhat wrong WRT the programming the command PIO 
> timings in the bits 8..10: they should be set to the same value 

    Hmm, probably isn't actually wrong, though usually IDE controllers have a 
single command timings register per channel.

MBR, Sergei
