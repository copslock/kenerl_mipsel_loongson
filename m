Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 20:12:25 +0100 (CET)
Received: from userp1040.oracle.com ([156.151.31.81]:32456 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992181AbdK2TMT2EEsi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Nov 2017 20:12:19 +0100
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id vATJBvm6026419
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Nov 2017 19:11:59 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id vATJBsr1006629
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Nov 2017 19:11:54 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id vATJBnSj017589;
        Wed, 29 Nov 2017 19:11:51 GMT
Received: from mwanda (/41.202.241.38)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Nov 2017 11:11:49 -0800
Date:   Wed, 29 Nov 2017 22:11:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     David Daney <david.daney@cavium.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, Carlos Munoz <cmunoz@cavium.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        "Steven J. Hill" <steven.hill@cavium.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        James Hogan <james.hogan@mips.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v4 7/8] netdev: octeon-ethernet: Add Cavium Octeon III
 support.
Message-ID: <20171129191138.ntlfw5fb4xacwyun@mwanda>
References: <20171129005540.28829-1-david.daney@cavium.com>
 <20171129005540.28829-8-david.daney@cavium.com>
 <CAFqt6zabdQhyjUc4WsjzJ6CxMr70H3V_JdipJVwRi8LuOG54tA@mail.gmail.com>
 <CAFqt6zZAPxKm663yEHD0Rx2SPye9Nvoax0RMroDQuF8BpZchsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zZAPxKm663yEHD0Rx2SPye9Nvoax0RMroDQuF8BpZchsA@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Source-IP: userv0021.oracle.com [156.151.31.71]
Return-Path: <dan.carpenter@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan.carpenter@oracle.com
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

On Wed, Nov 29, 2017 at 09:37:15PM +0530, Souptick Joarder wrote:
> >> +static int bgx_port_sgmii_set_link_speed(struct bgx_port_priv *priv, struct port_status status)
> >> +{
> >> +       u64     data;
> >> +       u64     prtx;
> >> +       u64     miscx;
> >> +       int     timeout;
> >> +
> 
> >> +
> >> +       switch (status.speed) {
> >> +       case 10:
> >
> > In my opinion, instead of hard coding the value, is it fine to use ENUM ?
>    Similar comments applicable in other places where hard coded values are used.
> 

10 means 10M right?  That's not really a magic number.  It's fine.

> >> +static int bgx_port_init_xaui_link(struct bgx_port_priv *priv)
> >> +{
> 
> >> +
> >> +               if (use_ber) {
> >> +                       timeout = 10000;
> >> +                       do {
> >> +                               data =
> >> +                               oct_csr_read(BGX_SPU_BR_STATUS1(priv->node, priv->bgx, priv->index));
> >> +                               if (data & BIT(0))
> >> +                                       break;
> >> +                               timeout--;
> >> +                               udelay(1);
> >> +                       } while (timeout);
> >
> > In my opinion, it's better to implement similar kind of loops inside macros.

I don't understand what you mean here.  For what it's worth this code
seems clear enough to me (except for the bad indenting of oct_csr_read().

It should be something like:
				data = oct_csr_read(BGX_SPU_BR_STATUS1(priv->node,
						priv->bgx, priv->index));

That's over the 80 char limit but so is the original code.

regards,
dan carpenter
