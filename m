Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Feb 2018 18:56:26 +0100 (CET)
Received: from vps0.lunn.ch ([185.16.172.187]:35914 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993004AbeBRR4S1kWeQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 18 Feb 2018 18:56:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=kyEmDJUqK8c2uEh0aZ8cedCMbOK8lAwAD/kB0Z/dPdw=;
        b=WB4PfBW+/+j1yqUuHhMPVYY5vZytZc1GMaxUDFY69Xsm56LEe58mUnieqXk76xQFgQBt6+AW99blAdAhqAFUZQ/atQQEfaIQWMF0FwRqaZeCenJXnR8nCDPudvzAOJOPJIFZEym0MrjJyl7Z3srLe3TBIuQd3s8N1clIxkv/jEA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1enTC3-0008QV-SA; Sun, 18 Feb 2018 18:56:07 +0100
Date:   Sun, 18 Feb 2018 18:56:07 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Paul Burton <paul.burton@mips.com>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        hassan.naveed@mips.com, matt.redfearn@mips.com,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v5 00/14] net: pch_gbe: Fixes & MIPS support
Message-ID: <20180218175607.GB31083@lunn.ch>
References: <20180217201037.3006-1-paul.burton@mips.com>
 <20180218.103112.1461192916516173265.davem@davemloft.net>
 <20180218170310.lpwjtnxe6awrhgen@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180218170310.lpwjtnxe6awrhgen@pburton-laptop>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62615
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

On Sun, Feb 18, 2018 at 09:03:10AM -0800, Paul Burton wrote:
> Hi David,
> 
> On Sun, Feb 18, 2018 at 10:31:12AM -0500, David Miller wrote:
> > Nobody is going to see and apply these patches if you don't CC: the
> > Linux networking development list, netdev@vger.kernel.org
> 
> You're replying to mail that was "To: netdev@vger.kernel.org" and I see
> the whole series in the archives[1] so it definitely reached the list.
> 
> I'm not sure I see the problem?

Hi Paul

I'm guess that David is wondering about version 1-4 of this patchset?
As far as i can see, they were sent to the mips list, not the netdev
list.

	Andrew
