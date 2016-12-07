Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Dec 2016 21:17:23 +0100 (CET)
Received: from userp1040.oracle.com ([156.151.31.81]:35051 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993376AbcLGURQu3bGY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Dec 2016 21:17:16 +0100
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id uB7KDOjI023462
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Dec 2016 20:13:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id uB7KDOPK030888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Dec 2016 20:13:24 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id uB7KDMgJ010259;
        Wed, 7 Dec 2016 20:13:23 GMT
Received: from elgon.mountain (/197.157.0.50)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Dec 2016 12:13:21 -0800
Date:   Wed, 7 Dec 2016 23:04:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     blogic@openwrt.org
Cc:     linux-mips@linux-mips.org
Subject: [bug report] MIPS: lantiq: implement support for FALCON soc
Message-ID: <20161207200455.GA25376@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Source-IP: userv0021.oracle.com [156.151.31.71]
Return-Path: <dan.carpenter@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55964
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

Hello John Crispin,

The patch d41ced01f21d: "MIPS: lantiq: implement support for FALCON
soc" from Apr 19, 2012, leads to the following static checker warning:

	arch/mips/lantiq/falcon/sysctrl.c:152 falcon_gpe_enable()
	warn: mask and shift to zero

arch/mips/lantiq/falcon/sysctrl.c
   140  /* enable the ONU core */
   141  static void falcon_gpe_enable(void)
   142  {
   143          unsigned int freq;
   144          unsigned int status;
   145  
   146          /* if if the clock is already enabled */
   147          status = sysctl_r32(SYSCTL_SYS1, SYS1_INFRAC);
   148          if (status & (1 << (GPPC_OFFSET + 1)))
   149                  return;
   150  
   151          freq = (status_r32(STATUS_CONFIG) &
   152                  GPEFREQ_MASK) >>
   153                  GPEFREQ_OFFSET;

The mask is 0xC0 and we >> 10 which means that freq is always zero.

   154          if (freq == 0)
   155                  freq = 1; /* use 625MHz on unfused chip */

So we always use 625MHz.

   156  
   157          /* apply new frequency */
   158          sysctl_w32_mask(SYSCTL_SYS1, 7 << (GPPC_OFFSET + 1),
   159                  freq << (GPPC_OFFSET + 2) , SYS1_INFRAC);
   160          udelay(1);
   161  
   162          /* enable new frequency */
   163          sysctl_w32_mask(SYSCTL_SYS1, 0, 1 << (GPPC_OFFSET + 1), SYS1_INFRAC);
   164          udelay(1);
   165  }

regards,
dan carpenter
