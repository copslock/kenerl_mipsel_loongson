Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Nov 2016 10:19:56 +0100 (CET)
Received: from mail-co1nam03on0051.outbound.protection.outlook.com ([104.47.40.51]:18432
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991859AbcK2JTs5BasR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Nov 2016 10:19:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=E9i+eIWk96nwDWoOJMxQcfXuOHpxHT5hcTUON+nXjHI=;
 b=LC9OubTAOaW1QQKJxtHVY1CxftGFQducrCnuRrwi5AQhVthPlNzbGGE4moxHH44o94xNt2KTInRs+r7iVZ5P3iXNI+bJCwoKUBFb5KwR4kfJNTXeAgoYKpzlEe5g1M3BPSBpUQQ5vC4Yi5mTyCVU2KupGextuGfj5vlQ7nfHtAY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jan.Glauber@cavium.com; 
Received: from hardcore (46.223.156.18) by
 SN2PR07MB2592.namprd07.prod.outlook.com (10.167.15.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.747.13; Tue, 29 Nov 2016 09:19:37 +0000
Date:   Tue, 29 Nov 2016 10:19:28 +0100
From:   Jan Glauber <jan.glauber@caviumnetworks.com>
To:     Wolfram Sang <wsa-dev@sang-engineering.com>
CC:     "Steven J. Hill" <Steven.Hill@cavium.com>,
        Wolfram Sang <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>,
        <linux-mips@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v2 0/3] i2c: octeon: thunder: Fix i2c not working on
 Octeon
Message-ID: <20161129091928.GB29487@hardcore>
References: <1479149445-4663-1-git-send-email-jglauber@cavium.com>
 <99500824-4c63-b769-ad66-c136529b14b2@cavium.com>
 <20161122120106.GB3993@katana>
 <20161122145539.GA7716@hardcore>
 <20161128142208.GA3916@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20161128142208.GA3916@katana>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [46.223.156.18]
X-ClientProxiedBy: AM3PR04CA0096.eurprd04.prod.outlook.com (10.163.180.150) To
 SN2PR07MB2592.namprd07.prod.outlook.com (10.167.15.22)
X-MS-Office365-Filtering-Correlation-Id: c6e3d5f9-9513-4627-f295-08d41838d839
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:SN2PR07MB2592;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR07MB2592;3:yBwXqpD9CmmlAduwaL+h9C170hzHTf2KAEOpTDBoWNs8/H6RDMwQUMeJjgnOL7so5KAC3OT45n8rVJ1eaPx1zkcKAMBwQnFFCEVJiertgRJF7tg+Ln2O2JUxIS8B1DAQ0fgyLuIVy+WSvD7+TKJNB76D5aay20EzS4vIQKsZ08YLucb4GwLjww38Hm+iIZ0/1j5+ImQgnNJVyt8ovoO4KA+AUdFFKNoXbaKYWf/pmSXBYGRYBWqt/1tljAzlTzRFf57VhEAbzMBn6WLS812Tzg==;25:8DA2ruQh4/Xc5bOZbvW+tAs5UUS0Wb69YxTAGkJspiOXPS+oNjkETdciXPfIGFtCeGPc4EZMHxxUBzVh8COSCaY4S1T3/wdKocsVEu6HVanc+/kUhV9jkbGZ6hyOMfr31kfMKFEJeXDmRz0CDIb2sd5BQ7Y4ObVLQI68LpW82/5uAnKzCENR53At6cwRv2sRM3A30gLFVK71/VdK3liCuYQvepj5J2qbjXR67lBxT21BxNaWBJmt8dyzcIM1SIdz+q/H76v58ixAAak87M9zIHc8KZOuT0Nt/AVpj8u1B+pIdzow1EPK+b0QnZlLFZD7OT1JnrcSyH9mD0N6aWUC77sqBP0Pyx7rJawIiUuUKGb7XKrhFi6aC5QHnk2Fn7mFSBfbrG8RIfuRlgWES9NAicgUMzPzjFWY9PhmdIAPkUgm7+h/JZQD98eKFHKrmaXP/SzCQmtBfDckbRXH6Q4QDA==
X-Microsoft-Exchange-Diagnostics: 1;SN2PR07MB2592;31:BcPSD+fqYxFIDIcKZy02/C+4xTGIpVJfY3nNq6Szu4yRYIf4dKehZc0GC1FzdC/oqi8vEwJaxZoL/pDgkXB3Axaw6XEYbs8INnsYHe8zp31iPXu9qdOTCZRfGfFgWEgzgb9nbNE+Vk5eI/b1dRe4R2stPSZbfnqqbxPt0kmpHtipbg3Cttf892MguamYsHb6NNgx+Ae2mtJFe2WHVKGkKWYzhzvjSvosKCQgwOHQbxbcCi1DozcqGGfCU6MysB1Es+ykjGC4lJZ5m/iQJK7o4WPzMx2xsyJpAsC5jY1D/Vw=;20:yCUmAMVLBnlOzyuXVtpiT0vaKyeSZMM9Vi360KFWbydXCSfCDAghts6G0RIZ6fnkzwuwd+4i+A2eTzQ0N99AynhLs/f3PyPzV+J2/yt+VHaXLd7z1cv9ta7an4A2kzy+HWvv+bksuts8l24mQo6XXZNW1wRfy6+Ac7IQeyetI4JWKMpKH7kAY5Q5lTKNZ2DknwEmuYHTxIXK1wKpBS/bC15qkhHgVff2UNn+e0CH4yoQGSXOkygGrMjy89+DLGwGyUoNxJ9vgjURKgtS9Lg15itgDxGGXGcwq6XkMyMKqzrjFVP7Fg8Kg/VkqcRf4ewlx+rE67yOPcVe1YrUtp7dp+nCuGDjQjRgLhi1yUkl+SRUdVLfIlsFyrA6M+VmabznCJH53gM+Snqb03p3uxoEuDqua10z3T5jTPLpD2cNd6WaFb4XcsU/dmU5HVlqCXn+gcI4ge5hJrFkrVlMth+49S8KEIsgbqdyvhl+/t2iTJK+nbkVHvZeOzV8ggFzm6phGgLFL964mj/JERox2CAa1IzWxQjfdCRQNKDoIwo0SKpjVmSVmhYzYkbLcwPeYWHEZq92CasDn3Zcd357LooAFhkx0b0HJ9LBUQyjuK7jYaQ=
X-Microsoft-Antispam-PRVS: <SN2PR07MB25929FC4A243A5190CA57F6A918D0@SN2PR07MB2592.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6060326)(6040361)(6045199)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(6041248)(6061324)(20161123564025)(20161123562025)(20161123560025)(20161123555025);SRVR:SN2PR07MB2592;BCL:0;PCL:0;RULEID:;SRVR:SN2PR07MB2592;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR07MB2592;4:NSj+yAJgF92i3gvxvI3EierT9Orwi/GVKfSD1aG7hJ1QK09ZWBcw3Rvct4T1K+QP68w6cJiJTZHF/AIvy1Y3NIS3C7D3L9Jl4ixIFjgaaxUBiDq33IBV44G6lkVhpNeCYdvDvcIg/JlwLi4nY+Vf/xALrWbgJKgVsQyJG09TL5G83zDFTHoMhLmh3N15au8oauwxgGKaTHwoZH7ochPaQKzGcXYfYMaTFsYLprP05XJIrPZ+jkwgYhOjiVZDCq1DBQnu5+e6Wp0aCRlFDQghntVacma7I26DWglP6UTN6562D4ln4mLrg0EHbdQxFqsaXKLFTGEW4460G4UWPsgx2RNKWny/JMaP3uCdzei9wVsnlBVjYODCIzsuK+dVbEBNGgRhOplmpzrcKtyLb7EzsZDR4wd0Lpjzgewk6bNdxDCu5W17PeApymtCYmLAdh+eA/FuUo97lRFS30CubhGGP5+31pNv8q+W8kyVMelsk7eULw7L9CWCgojRZOHJyPYE1FSn1ez1y5axybvRNn7B3Yhv4E/0s3m4EKdR9FjJpkZl7Eu8Bfdc/MUmBCfWNs3lEp0W9UbGC+9IzMBW692CEfV/0fu44rnolXnT8QqL39w=
X-Forefront-PRVS: 01415BB535
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(24454002)(199003)(189002)(33656002)(106356001)(54356999)(50986999)(76176999)(42186005)(33716001)(101416001)(105586002)(229853002)(4001350100001)(46406003)(97756001)(50466002)(66066001)(733004)(38730400001)(39410400001)(6496003)(39380400001)(39400400001)(39450400002)(97736004)(189998001)(47776003)(81156014)(93886004)(81166006)(8676002)(9686002)(83506001)(7846002)(7736002)(4326007)(4001430100002)(2906002)(5660300001)(1076002)(68736007)(23726003)(6116002)(3846002)(92566002)(2950100002)(6666003)(305945005)(110136003)(42882006)(6916009)(107886002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR07MB2592;H:hardcore;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR07MB2592;23:E+TZYON9YJPjU8YZFrV4HdE0IGXM5bVUsCcxCBgZq?=
 =?us-ascii?Q?dy+yx375oQUdEOvhprRFCqvr44kvHQRkxZuR0yk48AMqzdXb0EjGgGnixqaU?=
 =?us-ascii?Q?WjOxfQoh1KSSzChu4+JfDO4ohBrNsKe2xO/vY72M6ErstUe9ZyToaj1Ii2xn?=
 =?us-ascii?Q?J1paCtLUPu8Ns0flSc4SU5qu1V+vamzjaK7S2ceFnT+kYgVJJq9yYOEZfar7?=
 =?us-ascii?Q?FAAKGDoiC2/x6tFmQtsoWyiNStkN1OCMKtX4T9h5+2z+cubxSdxq59PO7c1B?=
 =?us-ascii?Q?HXhQEKni6bb/vZPk4laLM98iE0KCP9NCru636AUi63QmjLuRQvyyaK57jP3f?=
 =?us-ascii?Q?r4h7INKE4AMW0yWoyt1m4jSm3/RpbLDuoS5etGqiMBsf2p6SlzilYec5napu?=
 =?us-ascii?Q?z6DkkcbXDEFXbZpGumHkhlmRvLMV7I53NjiZzfCxmPL73SqPQum8uHnutYSj?=
 =?us-ascii?Q?JSCtUB49Ykktx9OP0SpS6kKCaa06BZyq67Jm3lCtWGLCSIduJ0H33hJxL4r8?=
 =?us-ascii?Q?YabknvH8cs62LemYIkFIzT4rMnyugC9ifFlCUFqScncGkPgqrpkdeKahiU+Q?=
 =?us-ascii?Q?8DoDYp1d+E+vZxl4+N8HfccNXj3lFShaiENftc/5BdRycFIp3i508GeoZWED?=
 =?us-ascii?Q?a8UWnytNSCk/8tSAEa+A+QTk4UtEC6NK5BJzBYVCJZ9g8CzwIYksOHVr5uSS?=
 =?us-ascii?Q?1/dfG6HBkmirr4nrxMh/SDbbtqb9Wl8mam/GC+YNt4zuWooDz8zkfxCGLtT7?=
 =?us-ascii?Q?FZ6cIu4U2LAcDQH3W+kk2PpXGmshtbGe424fW+cZHqc7P9nhkb9YmdRNdqwG?=
 =?us-ascii?Q?UHyZWz5eHcq1On/Mdr1bTKaIz3kEaCRvm67QS9So8uurpWwt3FjTFyXLzbqR?=
 =?us-ascii?Q?ct60+4DXC1Gbq/T/MJjo8lURfpbJ/MLGg285nR8dvM5n4nIM6ujcrZRjQ1q6?=
 =?us-ascii?Q?h0rTFJQRcotO0G/bgkpvSD8ymBRjVx84r+GHkJe3aftSreTdEj83ngQ26Tpc?=
 =?us-ascii?Q?IV32LHlEZTCEZ/bCW+ZBNo147GTGKC3EwtJaGE+0w/uBIdZSp94ym/VW5vGt?=
 =?us-ascii?Q?DDiyPvEdEmyBleFq04mywuH8NncBBvy7EjJG3+pEL3YYefke6VbgvNNGaByD?=
 =?us-ascii?Q?BoLd4SpB9GGKrZ1y6Vro7fMs1YUaKOb2+6vKXxdorHa9YMjjaLVR+a/MUgb+?=
 =?us-ascii?Q?BxYHLng0BCrzjBVCik6G5E2vKxYvoupzD8v0qlZFJ+/TLH5GGt3vXpw8h8zx?=
 =?us-ascii?Q?Phbes6DQr83Zr/JbEyMgcMP9XAGPYHyJNEUvBzbKAnqJE2uhuI09M3CCH4nk?=
 =?us-ascii?Q?SXeymcFJWkHG+vp72of1izzZ7ycZ/l3rcWBuYLmYgJRRZ3a9aDQhrVONuy3a?=
 =?us-ascii?Q?UaDqVUc/QIdi7y++zNsN8yMEU8=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN2PR07MB2592;6:ZVIaNSby5E/QjiCRLjh0Sl4f7yoTDZGv2uF8wl7q34+w2rabrxa5OCjwO9FDkDB705NHvJVmEuv3E8m7zSwSo78bOKSJTLq0yKqEAaeHbsoRuZ6+ZxYQHzBKUF91Jx2rVTBar8QVEflJ1OoNvxYJbYOKUqg8EAeecuqf90pu9i4aOT7EIyD8IVomn6g2lgau4s6plMgI3e4jVslMMzbLnWxLmqPinFquZnGOT4lwQD8WwbQ1lXFDReY2qY0mUFm9gziPJzDN71pWMkHQPUYCsbW04pyJDa1sQxpIXoy4BPtYO3UhxBjJPOxAxgH1TEkWfjCylgaAsDiPnP6Q0ndMWNsBFYz08ZafyrodXda0oNzJgAne+D/kv1mSaylMxIr8I5W2P+zCfxz3RWKwOsdCwccAdNxhAHgV0FKcsRBm4NAU81w+mt2UkTi2ypOjGAMjofaNyRNeTxCmvzX8smLmFQ==;5:i/wLkYzwXXh8aRrvtXmdXR36+50Q6qY8uzD520YyzP2/Wns8K5cv32EWES4XVyVFlNyqX2UHLJ97049HGwZfR5l247IA2KqIWYs5pqnEAQvz8sOwoWB/fTX3glSrVkSzfP+Y2/HJ5d7d53YyvA2qnCK391rtjW4GsXvIa6Uks2A=;24:XeDuaEmxqv3hBuxFdVaacpwRSWQajefR20X1s1xQnvXktJMqoaVYHekhlc5M2B1QAkJR8x7wkNjmhax9raQpzDZCqyjaGg7ggifLw4wv9Y4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN2PR07MB2592;7:550BOjKOWdMFH9ZtfAsZs6zAfQKcdAseyK2r8bKgPuW9RLJ+jrFfR6o/9xqcqdNWKvPe/Id8mMjQOHWYhbEQXHkxv+IYsNqrqEM/l16grpRel4CfH1OJz9q1UUjqImeiro4vZtsa5DXm2RMDQfUGtJ3iaz+3L7K0UFt47Li3sxJaFQyF1p49D/Yf3Juvze+PO8ZIXHwacBWaBbr6IreHIZz++aRv/T2fy2EHWMRbna+SDwByBi3aNANM84XrQvioo4PwgwBTbdMLWtg/q/QT586vnyMZSxdTF1y9of1POP1AAamIV5GlRUIGjhx6eQZTY5pHJIw7FjZdtQGAJqgpkPdp4TSPbIMFA6kPBihouO+Oxe3D9WqLmMw+Kc+R/HpkTJ4dcpkv1fkuKOPMUnc/eCQnxb/qCiZOXslcR7KPwYbIMoYGPW8Xe1hKQzpu4WLy4Gj4I4zecW12FJ0ompuPRQ==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2016 09:19:37.7594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR07MB2592
Return-Path: <Jan.Glauber@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55907
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

On Mon, Nov 28, 2016 at 03:22:08PM +0100, Wolfram Sang wrote:
> 
> > > > This does not work on Octeon 71xx platforms. I will look at it more
> > > > closely tomorrow.
> > > 
> > > What's the outcome here? It seems we want a bugfix for 4.9 but this
> > > report keeps me reluctant to apply the series.
> > > 
> > 
> > Steven, did you have a chance to check which of the patches makes
> > Octeon 71xx fail?
> 
> How do we proceed with this one? Is somebody at Cavium able to contact
> Steven internally? I mentioned this on-going regression to Linus and
> said an rc8 would help us, but reading LWN it seems we shouldn't count
> on it...
> 

Hi Wolfram,

if possible we should at least revert commit 70121f7f3725. I should get
access to an Octeon 71xx board tomorrow, but I'm afraid we'll miss the
deadline for a well tested fix that works across all machines.

--Jan
