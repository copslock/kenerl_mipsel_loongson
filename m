Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Aug 2015 22:05:12 +0200 (CEST)
Received: from mail-by2on0081.outbound.protection.outlook.com ([207.46.100.81]:7392
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012670AbbHKUFKzU8OF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Aug 2015 22:05:10 +0200
Received: from BY1PR0701MB1722.namprd07.prod.outlook.com (10.162.111.141) by
 BY1PR0701MB1126.namprd07.prod.outlook.com (10.160.104.24) with Microsoft SMTP
 Server (TLS) id 15.1.225.19; Tue, 11 Aug 2015 20:05:04 +0000
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@caviumnetworks.com; 
Received: from dl.caveonetworks.com (64.2.3.194) by
 BY1PR0701MB1722.namprd07.prod.outlook.com (10.162.111.141) with Microsoft
 SMTP Server (TLS) id 15.1.225.19; Tue, 11 Aug 2015 20:04:59 +0000
Message-ID: <55CA5567.9010002@caviumnetworks.com>
Date:   Tue, 11 Aug 2015 13:04:55 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     David Miller <davem@davemloft.net>
CC:     <ddaney.cavm@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <rrichter@cavium.com>, <tomasz.nowicki@linaro.org>,
        <sgoutham@cavium.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <mark.rutland@arm.com>,
        <rafael@kernel.org>, <david.daney@cavium.com>
Subject: Re: [PATCH v2 0/2] net: thunder: Add ACPI support.
References: <1439254717-2875-1-git-send-email-ddaney.cavm@gmail.com> <20150811.114908.1384923604512568161.davem@davemloft.net>
In-Reply-To: <20150811.114908.1384923604512568161.davem@davemloft.net>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: SN1PR0701CA0072.namprd07.prod.outlook.com (25.163.126.40)
 To BY1PR0701MB1722.namprd07.prod.outlook.com (25.162.111.141)
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1722;2:LFZuo4vUz1kBB+6gamCIFuMh9x+r2d+OSP18d6xYeQxfdZLQKY0Ve9wRDgRE9bh8xGNXllmhe2um8UgaPs0fqBlUY4JvWqS6arMuYSFnHVxBwopaPuT/M9+jTpY7bd4UqB2m0Sv9S6yU7eROfafEnXwPemGoVlqELm2QmI1D+yA=;3:h1LyVur7bnm0g/whUIp2FnAUY7oA0yHQG75UD93BXt5hBPaD6gyJNV1de5KwYcHUwLHrgSn3l+yFLSrgLEgR247ihtUhCc8uLFziufOMAXoV5xuSK17gSs4drTVd1ktJnEp/i7mfqU82tl5bjb8O2g==;25:W3YE6VE/OOq2cp4H/MjXBbQ7URdLHjZOgbZAsQ/5OUjB10lxng6O/PjiL6imbTahb2VxJDI2dtSMLnon8ZARUY0jCS114wKZ9ebG1gXTx4RXuScksHGzJHNrHRxngQIkXgn+IBN9YPiZpNmYcmvkTGd88egS9SlEllCKZ/keT93wCcxDlM800pqmu9Z0Apoloze6fHCph3ilTQpDHZoOWNjdf7U7QtJFVTKYSnvgeWfEEp0YPLX2V2salzJ5JuNM3iAbVg5p0bXV4ZPZmu0BMg==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1722;UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1126;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1722;20:DObS/Unjfp7OjN9AQq0igTHW+HW2LiQ2f0Ob+r2FBnrqQK/74i31Uaes8W48jIw5qHWUWdqQhZHbdkS4CtHGNCCkM8g3eXtv0XmwW5eIr/5YuASmJSmADW9AimJzUyrwFuge5ocfJvE6rA40B7eVetYEjTvl988wj3sbyuKnHQVXTlgGM+TpTxdmrMdUZ75ATKWVPtmvqFnL8emxrHGOYT57obuHZmxETv93liJk60Yfy01Y4mZU0+D+j1whUk1tvn80sK9WwZOkRjZdPWJVf/h29ALutkelj4xJyrXaHO4ltlZ6WxhUrPOceuJl4tcMFDLrXblE+MZZbp2itervAQes0QdylC/s7lArXWGdBiuZL846ribMsgNVPsMOYYYylKxEutFS+j/8Y4f6DTxhZhJzAbDNq3PLuSKnlwWbi9aMkOSJS62YgAlSfuzp6Ft+HP92TC9rPKSxjELp1ObCTlBFa1ViS1vacbfaXcdU5HAI7r0s/k2FYWBt0mfU27bHUuAZCo1/3iFVq6BMMDIcTgpmNDveucUlBiewX18rbB5sybxhqY89r4nDBTKa+iQGDfuucZnkpI93LUAz/GF+j7PLmlNXPTTnPIA+g0mMiSU=;4:p04TVMxqpm25wD26RjqlKGYPzsJJooHWunvfBEJGlntz7Sxk3F+joDjUDTT3dmvBdQr2BM9zltLEqQLA01nRdT/GnQY7XhFNZhEACdu9yyWJ41a/rh4j1y5S1SXmivI27sHnhiCZM2uF1zMW6CKz3V4zvW3dJ9D9vmRLBZPM7wFLqkrxHPi0rNKnE88zw41mHllof0A+nYuTUPm6n/MscS3pJ24avMXabOazAaWTLjUw5SCiZ2WIP4rCB8IrUq5kkPUuMNT6B2yfjepYU4OByovL9BvYwGMK7fx/59BqqR0=
X-Microsoft-Antispam-PRVS: <BY1PR0701MB17223B0DD229C319D7DA0E439A7F0@BY1PR0701MB1722.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(5005006)(3002001);SRVR:BY1PR0701MB1722;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1722;
X-Forefront-PRVS: 066517B35B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(164054003)(377454003)(24454002)(45984002)(199003)(479174004)(189002)(110136002)(46102003)(5001960100002)(122386002)(50466002)(53416004)(101416001)(76176999)(59896002)(23756003)(66066001)(5001830100001)(64706001)(65816999)(54356999)(106356001)(40100003)(65806001)(80316001)(87266999)(42186005)(50986999)(64126003)(65956001)(105586002)(33656002)(92566002)(81156007)(189998001)(77156002)(19580395003)(4001540100001)(83506001)(19580405001)(62966003)(4001350100001)(87976001)(47776003)(5001860100001)(68736005)(2950100001)(77096005)(69596002)(36756003)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0701MB1722;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;BY1PR0701MB1722;23:gxjxWEHYdBHALI8TggpaPQK17SHyktM2eF8qH?=
 =?iso-8859-1?Q?VHg0RD47eWzDA219ucM2H/yqncEHHZqJ8kJv7VoKXkGhkQBIsjp01AiQOS?=
 =?iso-8859-1?Q?qFzhu3vNdJdZi4pk1/0NLJ7xbw39T5X7YguXvTL/9J4ool5IwI/UePabkj?=
 =?iso-8859-1?Q?iHEFkVSFfY1pErVKLR8EbdNC9Y8tr2JDTzK6cHi18KEbzNH8IzNBj6V46I?=
 =?iso-8859-1?Q?Pic3mPD23lQndr1j3nsE4RlKk6OnIcBuNUqaQ379iIfrVPN6cBtfgVHZAK?=
 =?iso-8859-1?Q?kXhTbsShpKHAck52KrtdXnQM6Trt13l/qMvVv8fkDsZ2lHDlYkBRivWaCc?=
 =?iso-8859-1?Q?UJsSZgSm36hwCeQ0FWeyOgDVUOXvFczu6EXRBvjwVxps2xFg2bErGsnj+E?=
 =?iso-8859-1?Q?wcerspB3YvxZ1LXpz21gBNP8AdrqxVz0uzeWe7UMVL4o5KstJm+XuLKVSh?=
 =?iso-8859-1?Q?4TspZPBfXfdkYJFRHPkhiZLEZ97Jmq1HOx6hDLz6YeiTP+FY8GNb5rtKDj?=
 =?iso-8859-1?Q?SvrhvP09OkxA73T2xzrbxiiHCUvFFVhcmwcHjy+m942QO4ZTi2wPE6japg?=
 =?iso-8859-1?Q?8OyO/hHuLEXmDmdzKdwvrrbbx3wgmPUdq89REFidZsZKZVTSBpt4sRus/V?=
 =?iso-8859-1?Q?2mKnTPsF/WB+ASb1L0N5r1/MGHPWPmxbqqMoi2LC6OxjWSZFb8tBR131d8?=
 =?iso-8859-1?Q?HCjLggfRQvJ/BM9S37SE6uSJ+FxWD7ZsOshPZlwlTt1yTSRgn6sVVo7kOi?=
 =?iso-8859-1?Q?DRjRahNXF+duTAvFZGYhJSq3Zh8hPhjjfL3Mvg9jFSPWFyudipnrQm5VXX?=
 =?iso-8859-1?Q?OqgIni6ZSpXNaWFC6946pItV+JridbXo+DegtDymwibw0oF3sbj+rJEetY?=
 =?iso-8859-1?Q?rCMogZjaPxUOgCZFynwj9YztI0iCrgGUITwV6cv6v+PK2Vb7AgCmH0EDqE?=
 =?iso-8859-1?Q?5F/ZSOb0zmuPj2Udmy7rm1Lai0KUfPAExy98ghyZGaBtHXifYflAU4bytB?=
 =?iso-8859-1?Q?qB3hV+rWLHqFQD87KTfpDiH8tw7u/wNvdLY+RyvrDLCg5h1lh9NcU1oLB8?=
 =?iso-8859-1?Q?5aFHtUCFA9gZsRU4NSaij8Nh9+/k9Loquk1K6Wzn+frP6Q6aFmhyEv7bbK?=
 =?iso-8859-1?Q?jQbJ4BwYw3gU8nvqFVa4LRuUZZ0cLBrZtTFEi50/dew4IFUJPVBPQGiHkY?=
 =?iso-8859-1?Q?8Cd8OuLNA8xSOuNEaoPMHrXjZwzfl0ZWqHA5TZSUiNhuvNKvySDmjfnz/W?=
 =?iso-8859-1?Q?CiHX9VrWmOVcOdejee6mpM33qFSFY+RU6TFart5BU3h2R7+ZwwF7/Wpg/T?=
 =?iso-8859-1?Q?KdPT+aQYSdwVDgL4MZjDDIeN6/1/gyMHAycWlTyC+Aj5N0ZLGJQJxAe9g+?=
 =?iso-8859-1?Q?sbft5tF1nrFfXIB9abGNT+qVy0SP/Jt72FiL9DNFdvsmnjlwcnXMw=3D?=
 =?iso-8859-1?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1722;5:8sFH8FFGukFWkAboXxBfD/oDRX7guw11MYNT7EdU78ZDOMAqMplT3gYj7fkIBL93r8/58yh2Fgd12ZjFJ4OVPNrOlB28QqsXtu2wKftmk6tu4zhHbdlk8o8n2r3afseBlPKtxWiougzhPRJvcbc/gg==;24:3JO64rk7mLqFcseeF5XoMDpAAobAkmLlJ1YlykCGly34z2/8FEQT4x/IPf2PpJsCT+PICdLu6fbWoj1PRcHqHgvC9u2Vb4zrOMaXEB/iRBk=;20:yPJhWP1p0MwG/1Y/SIG9jAJ6t4enV2WhktynRNhLiiKBGddu/eunEadmqeYtkdd3PVtH3gcRpH2WKJirPBgxlA==
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2015 20:04:59.8326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0701MB1722
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1126;2:VNUoCrMUTNNhyEvmj9rf6KKily7u2OZ9c+oapXWj2tSwJT2zjDNyXPHOsLN4CFNfmAh3tGvTcgoZo7uTL0H0fnYrewJuw5w4cZL6aVHay1LSBiHILIhLaKNKCD2LHaS0+6KVqYoR6p401xpcEAcCOzHk0hEobfQiS6n+a8P8Jrc=;3:M65WEeQnUeBCIgLiV4hyV2i/2Ic6HsuufmGcfHmRL+3VLN3r+xgdJ1zitCQ4uZ30aS8R7ybi3fuRBr54GwC8uW4m6PLivXbOZYR9IAtGMVucY9G1k9Cc/2ftP0bv4NhCCuu4dnbsTVdvb4ffo0bD6A==;25:NClsV2tVvurV3CK9pJItpn9HrM3rZetgpicx9Urnk3M2eOZkgoo3LNl/ONjAs3x0NiIdZLVDALypovq8ptFE7xE09cLQA2WAXBl6Vvz1srAEenF9Gh6fh0t07n5QTw/0sfsjsCG4EOyosj/XFM2GNvFLPfzygnSrXlX8bxhT7uQEifg98psScWal3D7WmcvdTdg6xU+mjT5vo9xMBf8E5ce0MmB7Xfgv8opHriR+PaJWYRVqKbI6TN0W4dVw/uZ5RkBDWRX50lnXMH62Qca65A==;23:319wVtGZtpDcdmOGFFxDKpElKL+TPNJyXsLT2IGzM66Nvj5AhX6KrcXghLQZch8FbGc/wg0ExlIJcCu9kPyAvY/nxIMQMXVnivr9Tpj1qPJnlSOrDdwepkqr0YvNze/C/cALVmAXMVKCynpk1V9p4Y4rQ2RZAC51Njui57ty3UCqRLhvul+lwAdi5r15GxmABSZoc4/uQEOeqOngy9Py3ucBmxG02KZ9KRbBCpVU8YDcBJVHxTCRfnCmB9O5VZnO
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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

On 08/11/2015 11:49 AM, David Miller wrote:
> From: David Daney <ddaney.cavm@gmail.com>
> Date: Mon, 10 Aug 2015 17:58:35 -0700
>
>> Change from v1:  Drop PHY binding part, use fwnode_property* APIs.
>>
>> The first patch (1/2) rearranges the existing code a little with no
>> functional change to get ready for the second.  The second (2/2) does
>> the actual work of adding support to extract the needed information
>> from the ACPI tables.
>
> Series applied.

Thank you very much.

>
> In the future it might be better structured to try and get the OF
> node, and if that fails then try and use the ACPI method to obtain
> these values.

Our current approach, as you can see in the patch, is the opposite.  If 
ACPI is being used, prefer that over the OF device tree.

You seem to be recommending precedence for OF.  It should be consistent 
across all drivers/sub-systems, so do you really think that OF before 
ACPI is the way to go?

Thanks,
David Daney
