Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Aug 2015 22:13:00 +0200 (CEST)
Received: from mail-bn1bon0066.outbound.protection.outlook.com ([157.56.111.66]:15676
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012670AbbHKUM6pM2UF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Aug 2015 22:12:58 +0200
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Robert.Richter@caviumnetworks.com; 
Received: from rric.localhost (92.224.197.8) by
 CY1PR0701MB1614.namprd07.prod.outlook.com (10.163.20.151) with Microsoft SMTP
 Server (TLS) id 15.1.225.19; Tue, 11 Aug 2015 20:12:48 +0000
Date:   Tue, 11 Aug 2015 22:12:37 +0200
From:   Robert Richter <robert.richter@caviumnetworks.com>
To:     David Daney <ddaney@caviumnetworks.com>
CC:     David Miller <davem@davemloft.net>, <ddaney.cavm@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <tomasz.nowicki@linaro.org>,
        <sgoutham@cavium.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <mark.rutland@arm.com>,
        <rafael@kernel.org>, <david.daney@cavium.com>
Subject: Re: [PATCH v2 0/2] net: thunder: Add ACPI support.
Message-ID: <20150811201237.GW4914@rric.localhost>
References: <1439254717-2875-1-git-send-email-ddaney.cavm@gmail.com>
 <20150811.114908.1384923604512568161.davem@davemloft.net>
 <55CA5567.9010002@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <55CA5567.9010002@caviumnetworks.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [92.224.197.8]
X-ClientProxiedBy: DB5PR06CA0008.eurprd06.prod.outlook.com (25.162.165.18) To
 CY1PR0701MB1614.namprd07.prod.outlook.com (25.163.20.151)
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1614;2:sIg/F0DMl/ZXH3DYPMn3aFS1vwBe6W6/UdJhZAtLqkSsdk7vVGEX0uEi2I0caWp6kFhG0pbriQ2sc+iN7QX+ftCPKp8ZvArPxFh4XHC9Z8Xuh2CTouIsG5/NvHr4JEwSp/Bq3A1cCUNomYrEsTNTH4W4W/bQHWO4FcF7XO7yACQ=;3:Y/+FCru1Z2nmIWBFYgiC2dWLYBjDf8ynbiysOeIHMS5QtqKgTGmwJo6dVUXLNGbX+AJV6DAalnqRR5admDyskZpejZ7V4I0Wzq63DL9Meav5AfXsVOQLBj/2fkbDbCVe4ID62NhuFqjI4lV8nr2baA==;25:dkwrbIgv4gljvBxHnz5ViMebSd20NBbuv1HTNndud6eRTNXXtCMx0SoG6xIAX9BuoDCqBy35muXzoiWsrDB9a+IhW8oBlLLlRkB80MtdLtXdU0D86OUDNun9025wLIufUGDVZn0WxZ8O5XB5HIVZRC4bds2c64PBnFtAp8D6vnrsbD2H33WuIZsFbZkDg3VE1e1O0AywKfdrPjiFnncYamcRCkx8GguftfbeN32F+D5uVWAbag7DsGTVulTozEJQf2wJia4aiR6J5dhUl3v3mQ==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1614;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1614;20:sD4oV6EwTEaP75Q2Lq7N25hXnHvV3oQFHwP8RT3QQEuluTDaKbfksYL+vNmTppubQ6jsHUHYvqrHAsUN0/eQeI3JMIlhFrbtGa29igudg+BmfjaaBJCfOSIlxPkVbzIFX8ZvKhXGwEzHu2Kq/rT/u7aW/54x3ZUYohVI0skZttywp4Cl+CVzCGR/xFCdlS+6Tlj8oIdxXtu/GG2lkmCqTkUatMJndlFi+7dPnn6jFEmtXxllGGySLq4/RyRc0ipFhLbzzgn6AbLAZ3cbqcTLln3xqTVQ3aGjxzlLCYI+zdgC9c4R9pWomx6GbGlI4aph+HOiDaTXuw+Tpx8Kpm8v+y0sh2bI64IJeWKcgQbHMMUDLkmDvmmKh/eVqpMu9vfWMX1/AjEl88tiSbFxI23f64fkMZGsObGwhorQVPWZWnbaoi9pkQklxgBG4pfT2NJyl6+N6yyQ0ULazK3omVLYPlbjVWEFMuMK8yGL1ztSTAyXs3skvRf28IiWrD5k0lcVXJwlWJC8hM7yIN2dfVxEOSHUK976PRkeg9C30AuVRA4ciwBk8V4uNLBdq1yoPXkvKlXtOdoUKaJmXZ9G9p/tH28eCWm9h/FYerXNxZ+dFr4=;4:abEE2NeWizeh2/OXVh21yxCFYLK0pK1IQXzoYTxObWmmlsHVUxPxRuDT3whqlibvaznaY4YnVGL25tLhw9qwSOgvQgHp6rMsBnozB4mJSZXttk/WTnQoW0an35st4sjTSZEptqIqiRsBR65945tm4hncKYqxOFlDH8zc8xQvhW5L+Jxl820QMfjbCQFCf/naSqT1AWPA+LbucAsTnoYElYsQsqGwlQMC/Pusr3ek+aVe6ce54IFbSEFdz56yUu3h6MMHck+R+p9lAYJbAQU5GWtFASGdBXLqTp54AEfDq/k=
X-Microsoft-Antispam-PRVS: <CY1PR0701MB161480F7F87DFDED08D61BEFFC7F0@CY1PR0701MB1614.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(5005006)(3002001);SRVR:CY1PR0701MB1614;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1614;
X-Forefront-PRVS: 066517B35B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(6009001)(189002)(24454002)(199003)(23726002)(76176999)(54356999)(46102003)(50986999)(2950100001)(87976001)(68736005)(77096005)(83506001)(4001450100002)(47776003)(64706001)(101416001)(66066001)(5001860100001)(40100003)(33656002)(122386002)(5001830100001)(189998001)(105586002)(106356001)(86362001)(81156007)(97736004)(4001350100001)(4001540100001)(5001960100002)(110136002)(76506005)(50466002)(62966003)(77156002)(97756001)(42186005)(46406003)(92566002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1614;H:rric.localhost;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0701MB1614;23:6QV6QFGC/ARTah/SJjkkwYP8VRZWl0gLJc4eak7?=
 =?us-ascii?Q?20xYL2ylVg311sEH1TeCHpPVrIG13cJMly8h3kRwtfPhycXpSyDP4vBZZkc3?=
 =?us-ascii?Q?PwIo3PVAiWH+01NrcAMpXdBN9WTFTspSAbX5jccHJt/5eZdEo6Jt6MEH4vYo?=
 =?us-ascii?Q?SE5ei0u+qOovTnanf1ziqu5Lzs2qdtIBwH0/tSELULWZ9loUJxzxNPSzur1A?=
 =?us-ascii?Q?bq6TA5ICXksM2W8+4Vu0KaOPMceUamoXdXqtnX9SKHfLH5QgzNsjDWIMeqaY?=
 =?us-ascii?Q?mfRg7fkdag/3ZeT6lTF72EDCUb75KnTFzpnENrKVY3N0SO9BmQohzO2Mr2OB?=
 =?us-ascii?Q?Vfxp4v/iKosfFeCKQ/vkpt0ISrk7AF9OmojrihvMeyz4KuEwz49WUTAI6Nmi?=
 =?us-ascii?Q?NyiBArx4Lm6sn/KwlGE4cWc6aBHaLMLo48rrUVv8JxifqT0mLYXWfMeGiXtk?=
 =?us-ascii?Q?PB+3uaeq6WPj382RRTzMu37qAj/dykn5OeJGDw4YTvoKucsYzHk2Cjp5Jhs2?=
 =?us-ascii?Q?BO8NC0NOaP6C9oUGMPVqhvmACF4l/kyB4SM0kE/GB1axIb78NNZ0m/2fFidX?=
 =?us-ascii?Q?cewFn+CVfhgKGd/eknxIAveTvKoAX255LE/dyQtV7n6E/ryskebLE57qyyHx?=
 =?us-ascii?Q?r9UbUWIoRVKsF2FPadWgiKQpyaabxFHFFPiuplfEIjuacMecbSedpu6RbfE2?=
 =?us-ascii?Q?wgIaVTZuyL8GbFWzf3GLhtoHCjruxtgjDesAT8tDB/9zr5n4z3UdOoo0EfXp?=
 =?us-ascii?Q?Y4teqdnvYisPHrCcrmk0h4pw0/pl1cIXt+TVThTP5IYTDqisFB+XEIp4u4OI?=
 =?us-ascii?Q?hJplVtSBXrN5UqTszJTtaA0RXPlZL/ceAlRoU58aImGpPIrkJb5NX+Z1CPx4?=
 =?us-ascii?Q?gPZDZc+yGbzCOrwWTB1TEkASzzsFai4aCoIgnf2CpuSjioMUN/ZoxIEjWDuW?=
 =?us-ascii?Q?uaOHBAxwOGh33bHyXq+Mwrl8/Geas6hepvn13WT/idX5NlwAeQzaEc2mnQvc?=
 =?us-ascii?Q?YV7qMY/6c84031qDosmRL/9vvbZ+ZR1G5QL5uhdcOVRiJDt4NQMw/fa0+iv/?=
 =?us-ascii?Q?UVD6+3aPbniMNRdZSj8s/dYarx1Niblu5OKo5kxmWA1JXp3ypnsFc2wIKJj+?=
 =?us-ascii?Q?2TAJVLee9YCnX6hMVcozwj3OjUz8qSHdn?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1614;5:N+vjM8wNJRr4A52tZy5whTu51S7KfhPh6HcIfhHIaDgv9gfKVELZn5pZrw/XR5Bnjl3sZ+QXzN9Qkp+UEH3iyWxWnbELCv6ZTMoydsgkVTKY/3mPd4ai8h7ycJcY64kgVlxZ3N41SKoF34Q4vdBR8Q==;24:SJqt1wVSR+hZ6debE+Ojok9WxknQydrq7+AgybSOEkPnxvKNHUJ+PJDLU+awcuFhc19ItS+x30VrxH5QmQYw/iNjO/bzcY5wAK2oMSZ+9nw=;20:0CdWJz1Qfu928O7B/IuR0ztEh/oMGhdLAoYggzsSw5pWgf8wv+59snYlM4aJyUl06cJ+QUHh4xLVKzfUkPIt+A==
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2015 20:12:48.2937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1614
Return-Path: <Robert.Richter@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48773
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

On 11.08.15 13:04:55, David Daney wrote:
> >In the future it might be better structured to try and get the OF
> >node, and if that fails then try and use the ACPI method to obtain
> >these values.
> 
> Our current approach, as you can see in the patch, is the opposite.  If ACPI
> is being used, prefer that over the OF device tree.
> 
> You seem to be recommending precedence for OF.  It should be consistent
> across all drivers/sub-systems, so do you really think that OF before ACPI
> is the way to go?

If ACPI is enabled then no OF function may be called at all.

With !ACPI or acpi=no kernel parameter, then acpi_disabled is set and
no ACPI function should be called. It always falls back to and only
uses OF/devicetree in this case.

So there is now way to try devicetree first and then use acpi or vice
versa. There is no mixup using acpi or devicetree with the same boot,
either one or the other.

-Robert
