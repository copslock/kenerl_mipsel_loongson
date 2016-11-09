Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2016 15:44:00 +0100 (CET)
Received: from mail-bl2nam02on0077.outbound.protection.outlook.com ([104.47.38.77]:46016
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992544AbcKIOnwzKo1E (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Nov 2016 15:43:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=2vkUdjVDaU+r/aCo+jfLGEUhRWSiztQQJq0fhTpbEr4=;
 b=XgTLFtufGIvJxRxT8uzADczXYChZkkio3YEkjK7qyC+/SgeWN/5uMn5V0KUTvB6TNyVMIXZQvTrTjL+ri9wodxnl+ZkHaqmkpnoLp+9Zqm+DBDkAOuDyoZUDxKoELf1Fw9dzNQsCmPLo4yDRPF48zSP/+KSc3NYmjv6p++XdMt8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jan.Glauber@cavium.com; 
Received: from hardcore (88.66.102.28) by
 CY1PR07MB2585.namprd07.prod.outlook.com (10.167.16.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.649.16; Wed, 9 Nov 2016 14:43:44 +0000
Date:   Wed, 9 Nov 2016 15:43:31 +0100
From:   Jan Glauber <jan.glauber@caviumnetworks.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-i2c@vger.kernel.org>, <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Wolfram Sang <wsa@the-dreams.de>, <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] i2c: octeon: Fix register access
Message-ID: <20161109144331.GF2960@hardcore>
References: <20161107200921.30284-1-paul.burton@imgtec.com>
 <20161108071337.GA4601@hardcore>
 <10136944.jCslgNClvG@np-p-burton>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <10136944.jCslgNClvG@np-p-burton>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [88.66.102.28]
X-ClientProxiedBy: HE1PR0802CA0003.eurprd08.prod.outlook.com (10.172.123.141)
 To CY1PR07MB2585.namprd07.prod.outlook.com (10.167.16.135)
X-MS-Office365-Filtering-Correlation-Id: 7406bf37-3856-4ed7-6c63-08d408aecf4f
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2585;2:feYbni3dnsz6ijprlzmVtgxaCx3YsTkp+kiSfThZxkFZGXmbJGAhywnVgiVd8WP8M8l+kRk6GzLYuzTWgiClyPwIZiEPAvHiDZPCdQzgprzseNADz2BykruxWWmbPmnPvukSiy1Us2NU1E+5Cd8uCIu5zKlnEi/uTT6AQoWUgg2NwMZEdEAld9i/lcpiKGrxY3yk09fZVVsIoQxmG3bE+A==;3:rzv/jPaN8qYNnh36svk4qc801Ese2gceq0jfZfGc5J6+J83u5nFYXJp7N4z7vhVxn5YX6wIw2cedh4OwKJKmoLDHjhXknyasxtOVCgrV5J1jS4TcI7oK8B7NjQTvuINEBeRIQ0ryriaFweZcRDj4qA==;25:bD4qPIQLjsVCOOzwAlh1ynx/fFfe/qsLYtT8oXc+AtxTZ2iqb00bVautToejrsKSCC13i3P6RLv5k2iKtBpb2A8Uylfqa19ekIe/P9SNiOUowWkPNaOBKe1Wi6zQcZ1/9qKuVRNhHblVuKcn5t2NRcytWlBEIX0n2CkpSgtgNWEYEViYX7mOw342WIJ5c/a22U114d/j/ZQ27nRPX7vlMcov27wos47kzYPa7d/16e8N7F+7iS48EjXzZhhVsyHs35lr90SOtbkz4JjS67OKQ6Ee2JY+uFknjoMv32IXOE2nR5I8Ny/QEorRr99SJc9+h+ffvvAsdYglIEowWQYd81Ne+1AldLnkN0ZBH/Gv83bI37gmbgkruXG+A6oR7/pSHGCEEsif23ghMkFusIvZfpWMvkfN1OzKQU3RIz4ItLihoDZ4a1z4Ix3/Ob/jlinV
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2585;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2585;31:01Q+IyIWzlMD2Ycf7/UUrwja+mVvVpxwZF5YYnclRUDCDn3q9reEdIn4xF9g7ZyvUc8uVJhPLAGrSyfamdOwr36Gb3bsHvAqXSCh6HkL7HYPF4GdlzqwU+emkq5L/JTRMoXhgGKriO6J396m9hw7uS3o2DHvps5usewer9WVOa416JHN+cfmH6+BcHuZtA180tvCpxc9EhBHWMPATskday3D+bpRuBczy8wDoj1mBIRz4FOnb3PS1WCMzGUi8a7xg0nvx7JNgmkjUvTPuDHNbw==;20:VV1wPyDtp6KgyXLdFxezz79DuPC5nUz3fLU/IaiX81aJfDFB5rYGtQbbZBPGzx4vtkn4yZq49/BHn5i4fx4u7AwB5OzgR94BMtdTsrmID3Vszg6hCy4aWg5mm4uQ+FiWG6o8z1eU40IhopN4LfQlOdMUdleGnaC+Meq9CcA0AogI5VX6WfFTD71BXdil5H66/mXG5mYrm/jmuXkB7Tw/i5VpYGo9CYkXAsV3dAQKaf6C+uMlKVuZVAzJePlGDoAqoixgcfz0APmD7cgemSNE9w6Ud99EKlnFbrrFYyZrRWFygAt00tWVoqnUWlaPpafj+w3/0OnLVEtI5OgwNud6QP7yqJQmNvhkk6h2W1AvYwgOgPXVy2xf6F8vUicDiZiQn4fQFZjT+MJ+M9SwE14IHpyMKljbvzpK8fS5rGlpUu7SfCe6K7vn2rQ0Rwq68wfGcgB+5tW35HwrwBt/68IBxLfo2DhQe0GihemzeVIb4bF4hU6c0EfxY/VT4K45iq03JEre7GYCNjW3l9BlvpxvAI+G3ai6pzAx8yFac5/GFHle7zwRGjprfnTnsvJhqPNrtkrC/bBR+mFgZNpF1zj5GLj28M0s11S72uqS2HiNwbk=
X-Microsoft-Antispam-PRVS: <CY1PR07MB2585CBEC227E60AF31F5941C91B90@CY1PR07MB2585.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001);SRVR:CY1PR07MB2585;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2585;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2585;4:RnjX6NjOSJ6RUieuxzbjrJWFsY0D+xPquM2nW1DwlWqPfViSlEwzvLXLhrmY3v2vCxE4tYbSquUGm60nkSm+jdkpqYVQ6W7cxfMNaicku0THjR9yExIOArK0pQTIGFw3RTMfE5vGDWwA1afBszhNs2iT5HjAjeQ2d8PHBqDHGJUAivxJ4zRA89sAAFlR5k7R9fTKqPBJloLVg7zQvJNd4F4cZhf9Zl9RK2loXWtNmxqyuGhLgkJPUrwC578y1VpgRvEM0JYxjfn3adXEcxQTKnjIB0AF0zbCnZCsrS+r+RCotEVDCiBlK+gjwRtxGBxZZzv4T8u7PN7AcFpQsoQId0cEu0abefcM2DB6dtjCOSmgx6f9N9ZLnHrIudxFx6xR61cwIrdCgDATWuh1mF/F9kF+03lSTqYPlMI7EeOo+mcl4KJUH3my2dRuMzSWIccv1/cl3apX6Jn9ffNPBFHhG+lmujUvLtMkQk9XUxnKPYQ=
X-Forefront-PRVS: 0121F24F22
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(979002)(6009001)(7916002)(24454002)(189002)(199003)(47776003)(1076002)(8676002)(6666003)(50986999)(42882006)(76176999)(6916009)(81166006)(81156014)(68736007)(54356999)(97756001)(101416001)(105586002)(33716001)(586003)(77096005)(305945005)(5660300001)(3846002)(23726003)(6116002)(83506001)(33656002)(97736004)(2950100002)(4001350100001)(50466002)(189998001)(9686002)(46406003)(7846002)(66066001)(2906002)(4326007)(7736002)(42186005)(106356001)(92566002)(110136003)(18370500001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2585;H:hardcore;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR07MB2585;23:F0WmE6kjW0Q1GXgTQkIuvAR147IYILfGdKP1C8ksQ?=
 =?us-ascii?Q?ccv25VNTFEHvf14OpdTeGDPu/1bCuPVLkZjGHEgGuDrZiTSim25HbMQOWrpw?=
 =?us-ascii?Q?eDpj+9z0cbSK+CL9cYtEqdxgNpuLR32gda/1mJEs6z5naf2gbpjZrHOHqoA9?=
 =?us-ascii?Q?NPoWPMtS9hOk22tD/odXv1HZwPC9UPPlubxHB/096SXFvWNqwcj7CJHKFXnI?=
 =?us-ascii?Q?5zA66cyxUYe6hH0dQmIwdKrue/3af8dpdyA3VXFN/OT+s8cOs1zv/hlnQsjQ?=
 =?us-ascii?Q?83yhu7ipQDInvfhJ9esiAosMZFVCIoZhCGVmI9dqPHrr9NmhX854v7sSorer?=
 =?us-ascii?Q?aK2SzgdYe3ZdC8Tr1/0mAJoC9a7iddoHEfHeGgsiHYEqbK3R9JqoD3dM2iia?=
 =?us-ascii?Q?cx8GZ//mFEYGnx9Y/w+p8Q9U1pY9XhCHqlBgyXWsWZb3X521L7IZ8HpjR1N8?=
 =?us-ascii?Q?HB/wg335Uxin9t3h600ogzDmbthloSkE6K+rttj/pR7r8K8A69PdqLBQ1fnQ?=
 =?us-ascii?Q?SnnCCVNvq7b/8010ZJQQ2ZiWf0O+I99iSP+2MWbHDMV62T7O4FR0mSq3qHTE?=
 =?us-ascii?Q?1YjQEzhxTo2bz0LWFMKNyVefTeuudwTkSn3zrY5UvYfd2k9v8LKwHDUDS93n?=
 =?us-ascii?Q?m1JTG1ta7OB3XVJ76+rev9omzz1u7pWjxrwUkQzZIfNYwfmMoBJbil3sUuF+?=
 =?us-ascii?Q?NJZK6B9b/ndud6oKV+TzjR9Zpur4JE5W0Fdb6vXLEnpb7MxLZ+J8BqpIyzAc?=
 =?us-ascii?Q?MAPEAbb7/qBqe0Xjnr+kwkdDVIP4goggUWnZ6FUnP0xTIymfHEi2hkjFHVBF?=
 =?us-ascii?Q?FB50m9nCRTlYYi45qqLwkNkqA1CM9swV8yRayqfHfOv2L3+CvZar5irlsfrK?=
 =?us-ascii?Q?YHu6fu0+LPVTHc7HR1wmCM4dfWd9MKXbRB9Q28X6QAQjzbLWKXPpZRV2y5XZ?=
 =?us-ascii?Q?oBFsn7C7Sd5+aTWXV1EgtilZ5Rwg3CG2lGkoz+G6KGgs2fuy0qa0IRznYXId?=
 =?us-ascii?Q?G4t+9F7eQxfzJXJBu2QaPqGbtUaABLRaIMFsLM6q6viV6ORcdfJpzvH9yKHB?=
 =?us-ascii?Q?mSE6xlsoHdtUSgKFtewstNAj7xqZKAFg3JBwxJzFZX8fsvhxiIoeuFBFcetD?=
 =?us-ascii?Q?gd4WpnQkCXLYfn7klkUMEK/X9O1wCgv7UwZRqX5/IaEEYSC/OYRgmfGPd7MB?=
 =?us-ascii?Q?MMO73Th4ltXBYDouYoqrJGsFzhiyDylsPU7Vgow3Lr2WnVFJ7+7k3HIU8/pM?=
 =?us-ascii?Q?P8Hy7ZG+yKrvoCrDOjPCSvwsyciMCPbtmqc5KWDpJbG9cC1g9RZAO0O15kl0?=
 =?us-ascii?B?dz09?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2585;6:VSxDPzmuIyWI5c1bzTlssaJkJWlZuxe99+Liob1rRu61ud8TStYq66B89NhkRiHVS82a0JrSgHcIIEuzqxXk3Ww862pmmW8glIgR8L9R+W3vsKH4rvRJuIjmoWq/W4EzWnOzG6mZF7kRMovis0Vrcg1ZNYbDRYJ499XJy3wDSapBJPBocULj4EE6nQqUCkvJ+ZsJ4twc00B2Sx0wn9kWD1Ts+YUG1ZZ77TWc9f6X7v2T5y/GbDHGmP438l/hFrVUA6f33wj0yT58GJu6Jda239+27y0Q4SlMxSGs3CJz4YdlQEQSTiQCaIxoU78Gy931;5:Izgo4mD/FkBXKPE4ODufKag5LOIYibcMbKv1Rpw/ZJOXE6EYyTcGMyQIFUfZ333r9TVilH5yRPU9nZboNeIW42mCKeIUY62GPEwWKqE56xqTjITI1mCeG0g3WLnt4tjNhXZ8qODZnQl7BDE8l6v8o90lXcGVPejM6Ms8E5GsWug=;24:VzlHzxohBw0CDhsMS3YYRvaSTflwW+bCpYUJELeNjzkY8VGA4JYaA8kYJITs36+75bGSZRFjCLKrKeG1vCYhZD1acYUjP6z7PDx26jni1og=;7:D1m1rBpUNv6q4o+W56TMnmqdeIlKGPQtFAZIvIpfLaDm0zEeFws7V6fdkzG0HFsqAof75JUldGEgYjLItCvxo8fQKk9rh2l6W9IiADsUR0f/5hhPufnxEXvmOCtM7OyeY4TkYrATwHK37nbFhVsYAUVs7cvOZY2K5oyVQqqbyM1nfDMctgIs3tDu7EJ8EBKF+WG16qFn+I35KXM/SJ8ZitXl5Z1cR2+xCNUeNk7wZrKdi/+fu4YRk3PYzScCaTTZLetsJ/XiBugOzNwDvDSTULpAhfKevd1WCEmzWP4M9waobIyZUwuru15qWvG6w6wRImJJ85ArKKBiJM9LOOoI4UJNmIbTv/28DAzUY0dfaKY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2016 14:43:44.1656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2585
Return-Path: <Jan.Glauber@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55745
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jan.glauber@caviumnetworks.com
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

On Wed, Nov 09, 2016 at 02:09:38PM +0000, Paul Burton wrote:
> On Tuesday, 8 November 2016 08:13:37 GMT Jan Glauber wrote:
> > On Mon, Nov 07, 2016 at 08:09:20PM +0000, Paul Burton wrote:
> > > Commit 70121f7f3725 ("i2c: octeon: thunderx: Limit register access
> > > retries") attempted to replace potentially infinite loops with ones
> > > which will time out using readq_poll_timeout, but in doing so it
> > > inverted the condition for exiting this loop.
> > > 
> > > Tested on a Rhino Labs UTM-8 with Octeon CN7130.
> > > 
> > > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > > Cc: Jan Glauber <jglauber@cavium.com>
> > > Cc: David Daney <david.daney@cavium.com>
> > > Cc: Wolfram Sang <wsa@the-dreams.de>
> > > Cc: linux-i2c@vger.kernel.org
> > > 
> > > ---
> > 
> > Acked-by: Jan Glauber <jglauber@cavium.com>
> > 
> > Thanks for spotting this. I think this should go into stable too for
> > 4.8, so adding Cc: stable@vger.kernel.org.
> 
> Hi Jan,
> 
> ...but the bad patch was only merged for v4.9-rc1?

true, I've misread it.

> Thanks,
>     Paul
> 
> > 
> > >  drivers/i2c/busses/i2c-octeon-core.h | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/i2c/busses/i2c-octeon-core.h
> > > b/drivers/i2c/busses/i2c-octeon-core.h index 1db7c83..d980406 100644
> > > --- a/drivers/i2c/busses/i2c-octeon-core.h
> > > +++ b/drivers/i2c/busses/i2c-octeon-core.h
> > > @@ -146,8 +146,9 @@ static inline void octeon_i2c_reg_write(struct
> > > octeon_i2c *i2c, u64 eop_reg, u8> 
> > >  	__raw_writeq(SW_TWSI_V | eop_reg | data, i2c->twsi_base + 
> SW_TWSI(i2c));
> > > 
> > > -	readq_poll_timeout(i2c->twsi_base + SW_TWSI(i2c), tmp, tmp & 
> SW_TWSI_V,
> > > -			   I2C_OCTEON_EVENT_WAIT, i2c->adap.timeout);
> > > +	readq_poll_timeout(i2c->twsi_base + SW_TWSI(i2c), tmp,
> > > +			   !(tmp & SW_TWSI_V), I2C_OCTEON_EVENT_WAIT,
> > > +			   i2c->adap.timeout);
> > > 
> > >  }
> > >  
> > >  #define octeon_i2c_ctl_write(i2c, val)					\
> > > 
> > > @@ -173,7 +174,7 @@ static inline int octeon_i2c_reg_read(struct
> > > octeon_i2c *i2c, u64 eop_reg,> 
> > >  	__raw_writeq(SW_TWSI_V | eop_reg | SW_TWSI_R, i2c->twsi_base +
> > >  	SW_TWSI(i2c));
> > >  	
> > >  	ret = readq_poll_timeout(i2c->twsi_base + SW_TWSI(i2c), tmp,
> > > 
> > > -				 tmp & SW_TWSI_V, I2C_OCTEON_EVENT_WAIT,
> > > +				 !(tmp & SW_TWSI_V), I2C_OCTEON_EVENT_WAIT,
> > > 
> > >  				 i2c->adap.timeout);
> > >  	
> > >  	if (error)
> > >  	
> > >  		*error = ret;
> 
