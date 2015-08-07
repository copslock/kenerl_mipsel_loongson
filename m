Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2015 13:56:52 +0200 (CEST)
Received: from mail-bl2on0092.outbound.protection.outlook.com ([65.55.169.92]:18655
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011711AbbHGL4u0mKuo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Aug 2015 13:56:50 +0200
Received: from BN3PR0701MB1607.namprd07.prod.outlook.com (10.163.38.30) by
 BN3PR0701MB1576.namprd07.prod.outlook.com (10.163.38.23) with Microsoft SMTP
 Server (TLS) id 15.1.225.19; Fri, 7 Aug 2015 11:56:42 +0000
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Robert.Richter@caviumnetworks.com; 
Received: from rric.localhost (92.224.195.216) by
 BN3PR0701MB1607.namprd07.prod.outlook.com (10.163.38.30) with Microsoft SMTP
 Server (TLS) id 15.1.225.19; Fri, 7 Aug 2015 11:56:39 +0000
Date:   Fri, 7 Aug 2015 13:56:22 +0200
From:   Robert Richter <robert.richter@caviumnetworks.com>
To:     Tomasz Nowicki <tomasz.nowicki@linaro.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-mips@linux-mips.org>, Sunil Goutham <sgoutham@cavium.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>,
        "David Daney" <david.daney@cavium.com>
Subject: Re: [PATCH 2/2] net, thunder, bgx: Add support for ACPI binding.
Message-ID: <20150807115622.GS4914@rric.localhost>
References: <1438907590-29649-1-git-send-email-ddaney.cavm@gmail.com>
 <1438907590-29649-3-git-send-email-ddaney.cavm@gmail.com>
 <55C467A0.4020601@linaro.org>
 <20150807104320.GQ1820@rric.localhost>
 <55C48DF9.70406@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <55C48DF9.70406@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [92.224.195.216]
X-ClientProxiedBy: AM2PR03CA0016.eurprd03.prod.outlook.com (25.160.207.26) To
 BN3PR0701MB1607.namprd07.prod.outlook.com (25.163.38.30)
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1607;2:Ve5YwcyFyUrxEjz1hjqQA+LnN78PPWXo5PN8EQLe+tz3ALev2EEKf7Ks0cGsiD11GH7aZ6KXq1p+mZZlAoNKzyp3fL+65hfayK4AbQAHPvWYuYQvW7HREnuDRvL7fJuwJu1Eeoe6rVh4ScN12UZiNmL8/QW3YdXD5MoH8d/BDHg=;3:L6HhJZtMwm9TIfDOS28KNHI2Fi1vD/bXznebOwIUaltOyNQmVwFrHSfiW8SZPNsUGPSg1B3nrWPYFrkAuMEBTKCUHtz2G76l8yVVMqRAE93nPZylO57X8GS+Ccl6cIeXHuFhb8hJo+uMpy4lBMX3lA==;25:eXGk+vJb57I31OBLRQ4WFMdHM1+2GpdUudaRcsy6KUaUmk74frMSM1xu+C/Khx6cbDh8gWoazCk5u+pboHcOdobC4s/Os4TKytXiwkfXBB0An5q+vlCveE9EhsFOUnnBAi3TeZzloILUaKAMWaGUe6OH7hPA88IsLtby536134fHnaIUQYWYiymNjbUMqDLobxLaD0O0/qFkZX81S1o8Djv/Q8ILf6LkvcnM3F5gXBnUQeGDPc6OWkVpqYV46P+N2myxBRpV1pKntEzCRg4Pnw==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1607;UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1576;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1607;20:VO+skJcyi5P/1z9IpQfZjfoOJfmI4gV1LOmpKwWnzZ90oCV35BSSpd2L+9u7TKBBT1V3g6rjLIcpOFZoM+b49gAds1syVgbViC0TV4Y1Jdq8jTp83rT88uBAOOOXRNV/o70VLnpt9pBdD7STzuk5nNCmh1FW5MQDIuWYv6uQiEPTfTSgYbrExrf989B1/h4ntDcjpvzKdFHB7QSLALfDOh3pZoJbpdFbfyaHiLQCAfNcDARerNp4HUacbz2NdbXdFD/JIlOsXpfnHVgSvVodrVaPnL0zy5C3QsBR3SHDAl6QgkDCGu6PsEGQfRf3h52+r/CUgu/CTWt/IGHywX66MAbOD8kUjL98GMGf5EGNaghlaOPDFz/2snmu8dsFeXxsNRYCzrVziupFb7JOaWTzrmF44cp82G/9A1sHYIZKCBO/0qE+t/eOHrBnk8iCunJkSkAu9JjdarPWRvqEWt+nHn9oaslJyWp6cTNqdmzJey0CtCwA69kYYnylmXnnXkYB+BuA2Ii8uaCGDjWYCn61bCXnINcw+PfOGribgXcdbOtNl0im6ogX8VaETRl5igzztQd1Zt0F6FjMQYdGr1S7phERfTyKUohiQlSoeunfLIA=;4:SIH5vDHUfZalcVL81RnELZzBgZWBb/IEMxHRjRb+81JOR8lzsyaeLTOdwROO8oMmIErt+w9rciN0465m/ioJke4GFswgc5Zoht06Drq5bEEFZeoVfgkvGAyWDn+tYM3gd1gvwgzg0pBYt3pqzDqW8xaN5sZziF7x/X3kjY+jP+t5vIAIeW8aY43wxyU55aUQywdV1Nmvkjd3nK04JsirgbI9p6KrHIMGXywgltS4GscJ/ubmSnWym0yc+9Nk56b91U3XnPiQ5qMlRD99kHRAS2H7Ofx1FtZQ3Qxaz8YdvHg=
X-Microsoft-Antispam-PRVS: <BN3PR0701MB160788A58A2B7D8A1D638BEBFC730@BN3PR0701MB1607.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(5005006)(3002001);SRVR:BN3PR0701MB1607;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1607;
X-Forefront-PRVS: 066153096A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(6009001)(189002)(199003)(24454002)(50986999)(97736004)(189998001)(50466002)(110136002)(122386002)(87976001)(46102003)(4001350100001)(5001830100001)(5001960100002)(101416001)(42186005)(81156007)(5001860100001)(105586002)(4001540100001)(97756001)(76506005)(86362001)(2950100001)(47776003)(54356999)(83506001)(68736005)(77096005)(76176999)(33656002)(93886004)(106356001)(64706001)(62966003)(40100003)(92566002)(77156002)(46406003)(23726002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0701MB1607;H:rric.localhost;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR0701MB1607;23:KIx+QVgSPiaxO7+RUIWeLUEQBSQ1/qboI/IMRoK?=
 =?us-ascii?Q?KeGrvYWWj4mbu/8fjMGj0+D4EfcVS8xdElVGPLVH11mtqbfLuhgdJscAgA6N?=
 =?us-ascii?Q?bpDT2jxe1jE7g+SDjneZbPvc82yZsALgxnau36tdGapcQDFh7u9TZYp+PaxD?=
 =?us-ascii?Q?R+0bpDW5IVWzTV1Qm7WcJOWt/oPy8ISiKjFHbg9woeXb+5tVhsZYZ5TyX0Hd?=
 =?us-ascii?Q?uE0Nl4/JrHV75ytXbrjPdycFfk/SK3QUnuCYxstRvOi+O30stN2BhiZSZMgn?=
 =?us-ascii?Q?8o0P9HN8dqnsH7+JIa6AV3TnRxyuo0RTk/oVyPy6i4eAwGSEVmqSOtwWIfCb?=
 =?us-ascii?Q?ObL0MqbMsXE6uWWm/NgT+EExiCBaUjWrK17E0IKDBuMwKSwAze5XsiiD0LKn?=
 =?us-ascii?Q?bhoriqx7mwL4pXbhenrkLnX43PKAaeKriEhlwbYFSu8xoA+metxNfDVylGTK?=
 =?us-ascii?Q?K946POdK8xY8W99U/yLkWXwfKKFmrz9+LXQjDOF0CcRpdCwyRt6XvpnCTGZl?=
 =?us-ascii?Q?ykT+qeKMspi0x0jyLrB1ay6iV6HXhtFU740zZsRol9AuHGzzkswoXyrfwuR7?=
 =?us-ascii?Q?0/ReBouLmwlR9dzgVBvYanVNfyPB3UbGwKWosmQZGjfUQ6rERQnGRHqu9blt?=
 =?us-ascii?Q?pfTTzHKKVNJt3Fjb3DOnKmgt6cpNfy9V1Ni83ygArb9+9xIoTU6aZMUNpxWN?=
 =?us-ascii?Q?AulSanysl7LHYpP3adPp4r9jRbtd7r/s6s/9B35Piek6jYS9kXU4GQ1G29/m?=
 =?us-ascii?Q?xIgCmCeJG/q1vowN6KGWmAO2AIKOSCrxJms13eoMlHRy2OpJWsSj1cPkrmhW?=
 =?us-ascii?Q?8CrWZs+DjmsWOIcDPik0UYWFkn8TXEgIgCKfWpuW6Y2q+HUaS+zO27Ll3ksu?=
 =?us-ascii?Q?oRmNCtjvb94nS5QXmSC5UWnQwIZuRSiiOWewlaFehY+2sJ1kuo8zmWGMl26X?=
 =?us-ascii?Q?rvDyBZIZdOW4S5KhuloBElTd/vikabNLBuFQsnxxC/ngZjtuyFzWv8UT9o2+?=
 =?us-ascii?Q?3/qWakGSckLsdYFsULrY1PE1ax5mRwkf9GkZp/mo7I7j0CCsxR7EC8wMYHSr?=
 =?us-ascii?Q?cDu5Hq/Bq7iWbPSCws8IdkljRdPbLPItdgJvS55ydjvwEv1RFyT2pbVQkkSU?=
 =?us-ascii?Q?FPMHnC2mVyNY=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1607;5:LjoIzWclGO8zAynXiYtkoXFTZTSUonx81afaqPqEj48w0j9JzypaB/EOzOmcz2rCfWi3nrWtzzDF5PTuKzE/oT5ssEzH0slYMgi1DjqTWULQ/yBbSMYce+Fu+b5T5wIkRSx3zo52/atJWGVqbT/UpQ==;24:gnIFo6j6c7f3Fd8b5viyGZDk1V4swGLNou1956ngFWEW63GkLimuuIDR3liK5ARKLqyiQwDHNqHULWDO5oNgmO4257Bdj9Ra96BPL9bovrQ=;20:c9K8AJVLssFyWXpDf6mKMH6MY81aO8oQ0JUNgouj+EyHfDi3YZ0lS0KiSvRovn/8Pb3kDJ2py4P3qkx10TEtmQ==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2015 11:56:39.2971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0701MB1607
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1576;2:kSjt/DyIlQRH9ooiVnZoeq7JniL3/towyNdZMphSCdMDB+fdQYJ0ih+AD1AsjkLaaEEx/KxLEKafDILv3LhOYIycBqIUl6cqWLoAAgVwR49xeZWT2p42E/ZUbxifhNx8+q4VetCpLX9ZelWTlNbPH0y9+6B7kmDOUB2GBzHtaQE=;3:jxd/K3mYhluYZo0bUD6e4y5ATnA+DhNjQDu972+o3rXWB4q96/uZp0N9z7ZCRdM4mTKB4K6RsXntlrKIq0cB4MveHAmvsj6Cyny85Ct4PsYY9VxK2QrZJuLQjU82/pQvuubDpYJY2qDEKKe5nhHM0A==;25:W0I33Uob4gbAKOpfHLG7pDTsYz5BSmLtR9uFBfwxMYWsqY4W20lEruQp46cUiy9DpRmpwsfM4xtUPBUnmb8dJJc3y5FYHJRjVy0IU9sAs8xBaey11zJEYItMYGGEZOe2G9zjFTM9hBdOQc8vRwJA0tMa4loZgnK7E7ytKdwJ41k/DsJ/7ydIR4vL2rEaSpuPpAuS3Znte5CA7w+N0l70qVLttC7OfQMrESmDe6YLj1EhoKDYhUhVzpg2SLcJL9tGT3rdn1DS2kKWzYOquWlp6g==;23:GXaqpwj2DA06I3ALHVsKXpu0dYiaBJ31IylOmJXx8gMgu5vo0GdNAHhJaKue4r8EfvKSVOx0kIvI8a4jzvE8YN7mL+JVQdNHrhCasOYz22fHSkpNPs2tfzTjH3I/0azt/VIDrE2PNm/ApWX9XDjk+YePBtdcri/kFEPORIGRB6toaOLoP1ITM33QEmAm7z6rs7mgempuom41LYUzi/VJqOScDZtk75HGgwE/1PXNngIJJtIItu38wgM3C1nwItOs
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Robert.Richter@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robert.richter@caviumnetworks.com
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

On 07.08.15 12:52:41, Tomasz Nowicki wrote:
> On 07.08.2015 12:43, Robert Richter wrote:
> >On 07.08.15 10:09:04, Tomasz Nowicki wrote:
> >>On 07.08.2015 02:33, David Daney wrote:
> >
> >...
> >
> >>>+#else
> >>>+
> >>>+static int bgx_init_acpi_phy(struct bgx *bgx)
> >>>+{
> >>>+	return -ENODEV;
> >>>+}
> >>>+
> >>>+#endif /* CONFIG_ACPI */
> >>>+
> >>>  #if IS_ENABLED(CONFIG_OF_MDIO)
> >>>
> >>>  static int bgx_init_of_phy(struct bgx *bgx)
> >>>@@ -882,7 +1010,12 @@ static int bgx_init_of_phy(struct bgx *bgx)
> >>>
> >>>  static int bgx_init_phy(struct bgx *bgx)
> >>>  {
> >>>-	return bgx_init_of_phy(bgx);
> >>>+	int err = bgx_init_of_phy(bgx);
> >>>+
> >>>+	if (err != -ENODEV)
> >>>+		return err;
> >>>+
> >>>+	return bgx_init_acpi_phy(bgx);
> >>>  }
> >>>
> >>
> >>If kernel can work with DT and ACPI (both compiled in), it should take only
> >>one path instead of probing DT and ACPI sequentially. How about:
> >>
> >>@@ -902,10 +925,9 @@ static int bgx_probe(struct pci_dev *pdev, const struct
> >>pci_device_id *ent)
> >>  	bgx_vnic[bgx->bgx_id] = bgx;
> >>  	bgx_get_qlm_mode(bgx);
> >>
> >>-	snprintf(bgx_sel, 5, "bgx%d", bgx->bgx_id);
> >>-	np = of_find_node_by_name(NULL, bgx_sel);
> >>-	if (np)
> >>-		bgx_init_of(bgx, np);
> >>+	err = acpi_disabled ? bgx_init_of_phy(bgx) : bgx_init_acpi_phy(bgx);
> >>+	if (err)
> >>+		goto err_enable;
> >>
> >>  	bgx_init_hw(bgx);
> >
> >I would not pollute bgx_probe() with acpi and dt specifics, and instead
> >keep bgx_init_phy(). The typical design pattern for this is:
> >
> >static int bgx_init_phy(struct bgx *bgx)
> >{
> >#ifdef CONFIG_ACPI
> >         if (!acpi_disabled)
> >                 return bgx_init_acpi_phy(bgx);
> >#endif
> >         return bgx_init_of_phy(bgx);
> >}
> >
> >This adds acpi runtime detection (acpi=no), does not call dt code in
> >case of acpi, and saves the #else for bgx_init_acpi_phy().
> >
> 
> I am fine with keeping it in bgx_init_phy(), however we can drop there
> #ifdefs since both of bgx_init_{acpi,of}_phy calls have empty stub for !ACPI
> and !OF case. Like that:
> 
> static int bgx_init_phy(struct bgx *bgx)
> {
> 
>         if (!acpi_disabled)
>                 return bgx_init_acpi_phy(bgx);
> 	else
>         	return bgx_init_of_phy(bgx);
> }

As said, keeping it in #ifdefs makes the empty stub function for !acpi
obsolete, which makes the code smaller and better readable. This style
is common practice in the kernel. Apart from that, the 'else' should
be dropped as it is useless.

-Robert
