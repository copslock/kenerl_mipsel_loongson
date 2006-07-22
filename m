Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Jul 2006 10:13:57 +0100 (BST)
Received: from buzzloop.caiaq.de ([212.112.241.133]:48395 "EHLO
	buzzloop.caiaq.de") by ftp.linux-mips.org with ESMTP
	id S8133437AbWGVJNs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 22 Jul 2006 10:13:48 +0100
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id BC9E37F4028;
	Sat, 22 Jul 2006 11:13:42 +0200 (CEST)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 17390-03; Sat, 22 Jul 2006 11:13:42 +0200 (CEST)
Received: by buzzloop.caiaq.de (Postfix, from userid 1000)
	id 655AD7F4024; Sat, 22 Jul 2006 11:13:42 +0200 (CEST)
Date:	Sat, 22 Jul 2006 11:13:42 +0200
From:	Daniel Mack <daniel@yoobay.net>
To:	Rodolfo Giometti <giometti@linux.it>
Cc:	i2c@lm-sensors.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] AU1100 I2C support
Message-ID: <20060722091342.GA22158@ipxXXXXX>
References: <20060719180204.GK25330@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060719180204.GK25330@enneenne.com>
User-Agent: Mutt/1.5.11
Return-Path: <daniel@yoobay.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12053
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@yoobay.net
Precedence: bulk
X-list: linux-mips

Hi,

On Wed, Jul 19, 2006 at 08:02:04PM +0200, Rodolfo Giometti wrote:
> here a patch to add I2C support to AU1100 processors by using two
> GPIOs.

Is there any reason why it is limited to this very processor and
should not work with all au1xxx types?

Daniel
