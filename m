Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Oct 2004 12:50:18 +0100 (BST)
Received: from mailhub.fokus.fraunhofer.de ([IPv6:::ffff:193.174.154.14]:18106
	"EHLO mailhub.fokus.fraunhofer.de") by linux-mips.org with ESMTP
	id <S8224919AbUJLLuN>; Tue, 12 Oct 2004 12:50:13 +0100
Received: from [193.175.133.84] (aquin [193.175.133.84])
	by mailhub.fokus.fraunhofer.de (8.11.6p2/8.11.6) with ESMTP id i9CBnjD02277;
	Tue, 12 Oct 2004 13:49:46 +0200 (MEST)
Message-ID: <416BC4D9.2060904@fokus.fraunhofer.de>
Date: Tue, 12 Oct 2004 13:49:45 +0200
From: Bjoern Riemer <riemer@fokus.fraunhofer.de>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ppopov@embeddedalley.com, linux-mips@linux-mips.org
Subject: meshcube patch for au1000 network driver
Content-Type: multipart/mixed;
 boundary="------------060404000700030408000807"
Return-Path: <riemer@fokus.fraunhofer.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: riemer@fokus.fraunhofer.de
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------060404000700030408000807
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

hi
i fixed the ioctl support in the net driver to support link detection by
   ifplugd ond maybe netplugd(not tested)
here my patch for
drivers/net/au1000.c

bjoern riemer


--------------060404000700030408000807
Content-Type: text/x-patch;
 name="au1000.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="au1000.c.patch"

9,11c9
<  *         Bjoern Riemer 2004
<  *           riemer@fokus.fraunhofer.de or riemer@riemer-nt.de
<  *             // fixed the link beat detection with ioctls (SIOCGMIIPHY)
---
>  *
120c118
<     "au1000eth.c:1.5 ppopov@mvista.com\n";
---
>     "au1000eth.c:1.4 ppopov@mvista.com\n";
1388,1391d1385
< 	/*riemer: fix for startup without cable */
< 	if (!link) 
< 		dev->flags &= ~IFF_RUNNING;
< 
1448d1441
< 
1846,1856c1839
< /*
< // This structure is used in all SIOCxMIIxxx ioctl calls 
< struct mii_ioctl_data {
<  0      u16             phy_id;
<  1      u16             reg_num;
<  2      u16             val_in;
<  3      u16             val_out;
< };*/
< 	u16 *data = (u16 *)&rq->ifr_data;
< 	struct au1000_private *aup = (struct au1000_private *) dev->priv;
< 	//struct mii_ioctl_data *data = (struct mii_ioctl_data *) & rq->ifr_data;
---
> 	//u16 *data = (u16 *)&rq->ifr_data;
1859d1841
< 
1862,1865c1844
< 		case SIOCGMIIPHY:
< 		        if (!netif_running(dev))
<                 		return -EINVAL;
< 			data[0] = aup->phy_addr;
---
> 		//data[0] = PHY_ADDRESS;
1867,1870c1846,1847
< 		case SIOCGMIIREG:
< 			data[3] =  mdio_read(dev, data[0], data[1]); 
< 			//data->val_out = mdio_read(dev,data->phy_id,data->reg_num);
< 			return 0;
---
> 		//data[3] = mdio_read(ioaddr, data[0], data[1]); 
> 		return 0;
1872,1876c1849,1850
< 		case SIOCSMIIREG: 
< 			if (!capable(CAP_NET_ADMIN))
< 				return -EPERM;
< 			mdio_write(dev, data[0], data[1],data[2]);
< 			return 0;
---
> 		//mdio_write(ioaddr, data[0], data[1], data[2]);
> 		return 0;
1878c1852
< 			return -EOPNOTSUPP;
---
> 		return -EOPNOTSUPP;


--------------060404000700030408000807--
