Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jul 2018 18:46:44 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:51612 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992479AbeGYQqlQyGBJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Jul 2018 18:46:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=KyriFzLDnunUwQPtqUKMIOh/MkxIQ5sg3dSqgxEl70U=;
        b=VcamVHjENObQfLRcExBaNjKh6lmmFZq6wRO6ikqCgQjklJOWhw5FSBDIHzTW8khjzuCKwn8/AKngHu3tTh0DBegrUdmNQXmaAEII6v19NlY9J8SCH0d6G/2gEi6oJd4rmCwt3moyuCwyyVdSEEQvWKcI5GIGk1hzLIXTWzeE7zE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fiMvf-0005F9-RG; Wed, 25 Jul 2018 18:46:23 +0200
Date:   Wed, 25 Jul 2018 18:46:23 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     John Crispin <john@phrozen.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, davem@davemloft.net,
        netdev@vger.kernel.org, vivien.didelot@savoirfairelinux.com,
        f.fainelli@gmail.com, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com
Subject: Re: [PATCH 4/4] net: dsa: Add Lantiq / Intel DSA driver for vrx200
Message-ID: <20180725164623.GE16819@lunn.ch>
References: <20180721191358.13952-1-hauke@hauke-m.de>
 <20180721191358.13952-5-hauke@hauke-m.de>
 <0dd1ff0b-92eb-5c8f-f7b8-266cb79475da@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dd1ff0b-92eb-5c8f-f7b8-266cb79475da@phrozen.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65145
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrew@lunn.ch
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

> 
> i extracted this struct/blob/voodoo from UGW3/4 7 years ago and was puzzled
> by it. for those of us that have worked with this table in the past, its
> semi understandable, yet its almost like a blackbox FW blob. can we try to
> make it a little more readable by adding a comment on each line explaining
> why its there and what it does ?

Hi John

I was wondering if there was any reverse engineered documentation. Do
you have any links?

Thanks
	Andrew
