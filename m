Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 14:47:45 +0100 (CET)
Received: from vps0.lunn.ch ([185.16.172.187]:44939 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990484AbdK2NrjHr7l0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Nov 2017 14:47:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=KF10D5RTj9kZnX0rVE0Cbkma98kABqy2n8lW1DkOA04=;
        b=MxaPWjCT30SlK7rwtsQeTE9eMENCveMdkQFYS+LEBt6A/kezUgBbZulykQPWE+jGbIwIZfKzUtXXVx5LeUsA5/ikCritXM3fT5DniGcVgUk0DAw+MB/81rgRY/VwJ+9iFuApg32vCVQmdbXfh3GYHitX5BnIJAnIVWUpIHha3/A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1eK2hw-0005jM-Fb; Wed, 29 Nov 2017 14:47:24 +0100
Date:   Wed, 29 Nov 2017 14:47:24 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, James Hogan <james.hogan@mips.com>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Carlos Munoz <cmunoz@cavium.com>
Subject: Re: [PATCH v4 7/8] netdev: octeon-ethernet: Add Cavium Octeon III
 support.
Message-ID: <20171129134724.GA21166@lunn.ch>
References: <20171129005540.28829-1-david.daney@cavium.com>
 <20171129005540.28829-8-david.daney@cavium.com>
 <CAFqt6zabdQhyjUc4WsjzJ6CxMr70H3V_JdipJVwRi8LuOG54tA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zabdQhyjUc4WsjzJ6CxMr70H3V_JdipJVwRi8LuOG54tA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61183
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

On Wed, Nov 29, 2017 at 04:00:01PM +0530, Souptick Joarder wrote:

Hi Souptick

Please trim the code when giving reviews. We don't want to have to
page through 8K lines of code it find a few comments mixed in. Just
keep the beginning of the function you are commented on to make the
context clear. Cut the rest.

Thanks
	Andrew
