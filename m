Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2018 16:50:39 +0200 (CEST)
Received: from mail-bn3nam01on0107.outbound.protection.outlook.com ([104.47.33.107]:14050
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992241AbeITOudjwMGQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Sep 2018 16:50:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVW4wOwWiM0hEEpsyCOzA3YjTqwqwvBJrvrckb5YdPw=;
 b=EyEaaNL+JswgdCLcd20iA+p2g4ND4O4vh0hbsOtnFO/0MEqxJCWmYCj7o/JZGoz5oP1RWKEw/jaaTr9mMLi/LpRK6t8FddlFXP1DzTO+hVCUExiOXwapNgA2PqophY+8l9hjlDYdM3pjVq5CEDkmHpK+weiIl3ovu+B/YD1qIbk=
Received: from BN6PR21MB0161.namprd21.prod.outlook.com (10.173.200.7) by
 BN6PR21MB0131.namprd21.prod.outlook.com (10.173.199.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Thu, 20 Sep 2018 14:50:23 +0000
Received: from BN6PR21MB0161.namprd21.prod.outlook.com
 ([fe80::2dba:ece1:ce16:551a]) by BN6PR21MB0161.namprd21.prod.outlook.com
 ([fe80::2dba:ece1:ce16:551a%4]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 14:50:23 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Stephen Hemminger <stephen@networkplumber.org>,
        YueHaibing <yuehaibing@huawei.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "dmitry.tarnyagin@lockless.no" <dmitry.tarnyagin@lockless.no>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "hsweeten@visionengravers.com" <hsweeten@visionengravers.com>,
        "madalin.bucur@nxp.com" <madalin.bucur@nxp.com>,
        "pantelis.antoniou@gmail.com" <pantelis.antoniou@gmail.com>,
        "claudiu.manoil@nxp.com" <claudiu.manoil@nxp.com>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "sammy@sammy.net" <sammy@sammy.net>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "nico@fluxnic.net" <nico@fluxnic.net>,
        "steve.glendinning@shawell.net" <steve.glendinning@shawell.net>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "grygorii.strashko@ti.com" <grygorii.strashko@ti.com>,
        "w-kwok2@ti.com" <w-kwok2@ti.com>,
        "m-karicheri2@ti.com" <m-karicheri2@ti.com>,
        "t.sailer@alumni.ethz.ch" <t.sailer@alumni.ethz.ch>,
        "jreuter@yaina.de" <jreuter@yaina.de>,
        KY Srinivasan <kys@microsoft.com>,
        "wei.liu2@citrix.com" <wei.liu2@citrix.com>,
        "paul.durrant@citrix.com" <paul.durrant@citrix.com>,
        "arvid.brodin@alten.se" <arvid.brodin@alten.se>,
        "pshelar@ovn.org" <pshelar@ovn.org>,
        "dev@openvswitch.org" <dev@openvswitch.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-hams@vger.kernel.org" <linux-hams@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH net-next 17/22] hv_netvsc: fix return type of
 ndo_start_xmit function
Thread-Topic: [PATCH net-next 17/22] hv_netvsc: fix return type of
 ndo_start_xmit function
Thread-Index: AQHUUOBQeas9dNOwnEmY1OLbKFqIU6T5PuSAgAAA3gA=
Date:   Thu, 20 Sep 2018 14:50:23 +0000
Message-ID: <BN6PR21MB016180C794F26A279345A17FCA130@BN6PR21MB0161.namprd21.prod.outlook.com>
References: <20180920123306.14772-1-yuehaibing@huawei.com>
        <20180920123306.14772-18-yuehaibing@huawei.com>
 <20180920074341.3acef75c@xeon-e3>
In-Reply-To: <20180920074341.3acef75c@xeon-e3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-09-20T14:50:22.4293057Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR21MB0131;6:hh0y+DMiNgs8Qr1n50pd54leV50mokJ3QdsFLhdj3FV7j2jwIHqlvUVAog7BI4x3A8vOuqzd+L4DLqvnzEvIIiE5ACrrIhJtvviqPEzEJfPagRS1paus59GZE+62Nmzy7pRcEVuyss0/ZhyKvibQ7syr2ERgut2nPW492b9oJJekPWkSV/M37IHOYa6JUjd4vnrcXqq4EAgPXPIGIEFzxu7swxb3CrJ7XtFBlcxXxeXUGbk5d02zO1oNKlypVuBN+Jv3VS2rxF74Q5FotlPORCUqJ48xm4eieH2aEn50i2DcqBnh780XHMCf5NSf1ToFi2K+uJ1j/TzeJKbeCq/XTZDmtztbfP6qDy1JWUQEd34Py9qJUjaqxYJddTM2vEGn/LqJOc7QLWMezpk8WzRV30ajayUk8RZtelJlaXD9yECYHqbBeh0hWmfbiYt4mhspDvTDi2COWJ+Oo+zBq5h3Dg==;5:nUHn7qKQvqpXhhkUW93sj/h4zdGAiQyo33glZUL05lNpyawdUPH198aclQDut5x69P0zSTC/K81G+y0iFjY/moayahPxD5TRqp0CjHKyXG7LQd6JZ2I1vfbTHjPDdThMdpQ5tkX71i383AH9JjXTX4BXZXEjRaNXNLUJQzYAxDc=;7:YC3dSckj1gxSGJfBiMk/JrLMuTB/0ZNiVS6cYqnEUSFvcEmFkGr02lOEh7KjdYzAeGhWWgavH7f0IeSGjpDWhDHkuDuh/I2z9UNUOGoJlKNB0DHYPn5BAnEnbb+/dJYB4gjoH6Qt8gUOqgcnOMDDDFrtQ2EEZRR83Qv3x4a7N3rzUuds2jJzsSB57Wd5foxKAjfX6y7YXr9T+p8RTrQ7Z5v8LYV9BoO2xILP23J4ZwT6qLCd3jSAt1t0GrGxLwXf
x-ms-office365-filtering-correlation-id: 80945391-267a-4496-abfd-08d61f08654e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BN6PR21MB0131;
x-ms-traffictypediagnostic: BN6PR21MB0131:
x-microsoft-antispam-prvs: <BN6PR21MB013122F55F9DA6D3E69BFFF3CA130@BN6PR21MB0131.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192813158149592)(185117386973197)(85827821059158)(31051911155226)(70601490899591)(216315784871565)(58134797142442)(9452136761055)(65623756079841)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:BN6PR21MB0131;BCL:0;PCL:0;RULEID:;SRVR:BN6PR21MB0131;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(396003)(39860400002)(13464003)(189003)(199004)(71190400001)(71200400001)(8676002)(8936002)(102836004)(186003)(81156014)(81166006)(10290500003)(478600001)(97736004)(2900100001)(7736002)(66066001)(86362001)(68736007)(7406005)(7416002)(14454004)(446003)(11346002)(256004)(5250100002)(74316002)(486006)(86612001)(476003)(22452003)(316002)(110136005)(33656002)(54906003)(39060400002)(5660300001)(4326008)(25786009)(99286004)(9686003)(106356001)(7696005)(105586002)(6246003)(305945005)(26005)(53936002)(53546011)(6506007)(6346003)(10090500001)(229853002)(3846002)(6116002)(8990500004)(6436002)(2906002)(55016002)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0131;H:BN6PR21MB0161.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-microsoft-antispam-message-info: DDolmzShwxZfhasXEvCyyAjxWWVMsuLx95AsoqJxx7b1XVOSNQg/0FHZDT6NymKa9faMAwnqN3PHAKkM0Zr9+c7yfU7uAbsfrhCH0+VOpuE7uCHxJxBodw0C25qbqOBiHVDRpv7CJg7d0udm/qsSPGpLuUIxeqvsPFiB4Lnl99sQs89Hb4MxCV/31S6ClLBKRTnNCFP7AcB0CDCckv+WsSg9Ts+UIXbY5xxHCTpC4pwjKEEHKESh33VN7NJgtSfzLsubUQ2BcZKjqNbt8ydQtEjMGWlrmWeQuk7VhzvL9dRya+vXeFN7XD8umwck7Zvdi+UbWEI9Ceyi/dpZbrIN/tjmL6tyLy+gBn98No0QOkM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80945391-267a-4496-abfd-08d61f08654e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 14:50:23.8437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0131
Return-Path: <haiyangz@microsoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: haiyangz@microsoft.com
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



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Thursday, September 20, 2018 10:44 AM
> To: YueHaibing <yuehaibing@huawei.com>
> Cc: davem@davemloft.net; dmitry.tarnyagin@lockless.no;
> wg@grandegger.com; mkl@pengutronix.de; michal.simek@xilinx.com;
> hsweeten@visionengravers.com; madalin.bucur@nxp.com;
> pantelis.antoniou@gmail.com; claudiu.manoil@nxp.com; leoyang.li@nxp.com;
> linux@armlinux.org.uk; sammy@sammy.net; ralf@linux-mips.org;
> nico@fluxnic.net; steve.glendinning@shawell.net; f.fainelli@gmail.com;
> grygorii.strashko@ti.com; w-kwok2@ti.com; m-karicheri2@ti.com;
> t.sailer@alumni.ethz.ch; jreuter@yaina.de; KY Srinivasan <kys@microsoft.com>;
> Haiyang Zhang <haiyangz@microsoft.com>; wei.liu2@citrix.com;
> paul.durrant@citrix.com; arvid.brodin@alten.se; pshelar@ovn.org;
> dev@openvswitch.org; linux-mips@linux-mips.org; xen-
> devel@lists.xenproject.org; netdev@vger.kernel.org; linux-usb@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-can@vger.kernel.org;
> devel@linuxdriverproject.org; linux-hams@vger.kernel.org; linux-
> omap@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH net-next 17/22] hv_netvsc: fix return type of
> ndo_start_xmit function
> 
> On Thu, 20 Sep 2018 20:33:01 +0800
> YueHaibing <yuehaibing@huawei.com> wrote:
> > int netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
> >  	 */
> >  	vf_netdev = rcu_dereference_bh(net_device_ctx->vf_netdev);
> >  	if (vf_netdev && netif_running(vf_netdev) &&
> > -	    !netpoll_tx_running(net))
> > -		return netvsc_vf_xmit(net, vf_netdev, skb);
> > +	    !netpoll_tx_running(net)) {
> > +		ret = netvsc_vf_xmit(net, vf_netdev, skb);
> > +		if (ret)
> > +			return NETDEV_TX_BUSY;
> > +	}
> 
> Sorry, the new code is wrong. It will fall through if ret == 0 (NETDEV_TX_OK)
> Please review and test your patches.

Plus consideration of -- For error case, please just return NETDEV_TX_OK. We 
are not sure if the error can go away after retrying, returning NETDEV_TX_BUSY 
may cause infinite retry from the upper layer.

So, let's just always return NETDEV_TX_OK like this:
		netvsc_vf_xmit(net, vf_netdev, skb);
		return NETDEV_TX_OK;

Thanks,
- Haiyang
