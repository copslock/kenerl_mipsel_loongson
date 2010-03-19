Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Mar 2010 00:00:59 +0100 (CET)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:48702 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492635Ab0CSXAz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Mar 2010 00:00:55 +0100
Received: by pwj2 with SMTP id 2so2619500pwj.36
        for <linux-mips@linux-mips.org>; Fri, 19 Mar 2010 16:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type;
        bh=1tzDxYAfqAtLoMHwYFgcWq9dbfsZKUf2DWMvSgF5PgA=;
        b=hQwPJ/Qxt5gDFY37hkHo1YlBHvU0VkJGAPfXnk4B7Qi0/LnzZes2OKllJ+W1L865ia
         g+mLrGyAoCIA3Z1OHEJgDPDtEZtJaMBRtR5AxDGcVmsMAdgt12Comrz3czwqD2prdzaZ
         AWHu0DgW3VMa3Zz2yBihITh6ToDjThoY12hH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        b=pDm70kyKr35R/G320D0rV1YlfB4M/1InCqfM2Iy3MR8gePY4mYeLVlXDuQ7InQ2x1i
         pYs7FO/pbi9Mxa0IBJeEdP+tu+jEIOPObsWOPcty2C+tUfVcVZQgLIyo1u+VJfEfC5Ig
         eE3wal9xCIvNG91jxQhvZJ31EbztwUkgdjsME=
Received: by 10.141.53.15 with SMTP id f15mr4747847rvk.119.1269039645697;
        Fri, 19 Mar 2010 16:00:45 -0700 (PDT)
Received: from dd_xps.caveonetworks.com ([12.108.191.226])
        by mx.google.com with ESMTPS id 20sm1260736pzk.3.2010.03.19.16.00.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Mar 2010 16:00:44 -0700 (PDT)
Message-ID: <4BA4021B.4010905@gmail.com>
Date:   Fri, 19 Mar 2010 16:00:43 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8) Gecko/20100301 Fedora/3.0.3-1.fc11 Thunderbird/3.0.3
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
CC:     Peter 'p2' De Schrijver <p2@debian.org>,
        Jan Rovins <janr@adax.com>, linux-mips@linux-mips.org
Subject: Re: linux 2.6.33 on movidis x16
References: <20100305141113.GD2437@apfelkorn> <4B9EB45D.8050106@adax.com> <20100318181734.GG2437@apfelkorn> <4BA27048.2010707@caviumnetworks.com>
In-Reply-To: <4BA27048.2010707@caviumnetworks.com>
Content-Type: multipart/mixed;
 boundary="------------040609090508020401050503"
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------040609090508020401050503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 03/18/2010 11:26 AM, David Daney wrote:
> On 03/18/2010 11:17 AM, Peter 'p2' De Schrijver wrote:
>> On 2010-03-15 18:27:41 (-0400), Jan Rovins<janr@adax.com>  wrote:
>>> Peter 'p2' De Schrijver wrote:
>>>> Hi,
>>>>
>>>> We are trying to get linux 2.6.33 to work on the movidis x16 board. 
>>>> Main thing
>>>> missing is the addresses of the PHYs. Does anyone know those ?
>>>> Unfortunately I don't have physical access to the board so I can't 
>>>> just look
>>>> for the PHY components being used.
>>>>
>>>> Thanks,
>>>>
>>>> Peter.
>>>>
>>>>
>>> Do you mean the Movidis x19 ?
>>
>> Maybe. AFAIK ours is called x16, and uses a cavium octeon CN3860 chip.
>>
>>> We have 2 of these in our lab. They are running the old 2.6.21.7  from
>>> the CnUsers 1.8.1  tool chain.
>>> They are currently being used by other developers for some application
>>> testing, but I can grab the serial console boot-up messages and send
>>> them to you, if the PHY info is in there.
>>
>> That would be helpful. Otherwise you could also try running ethtool 
>> on all the
>> interfaces. That should give you the PHY address as well.
>>
>
> I just found one of these.  Current theory is that the PHY addresses 
> are 0-7
>
> I don't think the PHY numbers are printed anywhere.

Can you try the attached patch?


from the back of the box we have:

---------------------------------------
| eth5 | eth7 |  | eth1 | eth3 |
---------------------------------------
| eth4 | eth6 |  | eth0 | eth2 |
---------------------------------------

I was able to boot 2.6.34-rc1 to a Debian root nfs mounted via eth1.

I didn't verify that eth4 - eth7 worked.

David Daney


--------------040609090508020401050503
Content-Type: text/plain;
 name="movidis.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="movidis.diff"

diff --git a/drivers/net/phy/mdio-octeon.c b/drivers/net/phy/mdio-octeon.c
index 61a4461..dfaaf30 100644
--- a/drivers/net/phy/mdio-octeon.c
+++ b/drivers/net/phy/mdio-octeon.c
@@ -87,6 +87,7 @@ static int octeon_mdiobus_write(struct mii_bus *bus, int phy_id,
 static int __init octeon_mdiobus_probe(struct platform_device *pdev)
 {
 	struct octeon_mdiobus *bus;
+	union cvmx_smix_en smi_en;
 	int i;
 	int err = -ENOENT;
 
@@ -102,6 +103,10 @@ static int __init octeon_mdiobus_probe(struct platform_device *pdev)
 	if (!bus->mii_bus)
 		goto err;
 
+	smi_en.u64 = 0;
+	smi_en.s.en = 1;
+	cvmx_write_csr(CVMX_SMIX_EN(bus->unit), smi_en.u64);
+
 	/*
 	 * Standard Octeon evaluation boards don't support phy
 	 * interrupts, we need to poll.
@@ -132,17 +137,22 @@ err_register:
 
 err:
 	devm_kfree(&pdev->dev, bus);
+	smi_en.u64 = 0;
+	cvmx_write_csr(CVMX_SMIX_EN(bus->unit), smi_en.u64);
 	return err;
 }
 
 static int __exit octeon_mdiobus_remove(struct platform_device *pdev)
 {
 	struct octeon_mdiobus *bus;
+	union cvmx_smix_en smi_en;
 
 	bus = dev_get_drvdata(&pdev->dev);
 
 	mdiobus_unregister(bus->mii_bus);
 	mdiobus_free(bus->mii_bus);
+	smi_en.u64 = 0;
+	cvmx_write_csr(CVMX_SMIX_EN(bus->unit), smi_en.u64);
 	return 0;
 }
 
diff --git a/drivers/staging/octeon/cvmx-helper-board.c b/drivers/staging/octeon/cvmx-helper-board.c
index 3085e38..fb8d3ee 100644
--- a/drivers/staging/octeon/cvmx-helper-board.c
+++ b/drivers/staging/octeon/cvmx-helper-board.c
@@ -153,6 +153,13 @@ int cvmx_helper_board_get_mii_address(int ipd_port)
 		 * through switch.
 		 */
 		return -1;
+	case CVMX_BOARD_TYPE_CUST_WSX16:
+		if (ipd_port >= 0 && ipd_port <= 3)
+			return ipd_port;
+		else if (ipd_port >= 16 && ipd_port <= 19)
+			return ipd_port - 16 + 4;
+		else
+			return -1;
 	}
 
 	/* Some unknown board. Somebody forgot to update this function... */

--------------040609090508020401050503--
