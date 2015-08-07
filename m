Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2015 18:41:29 +0200 (CEST)
Received: from mail-bl2on0061.outbound.protection.outlook.com ([65.55.169.61]:42155
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012306AbbHGQl1qTbqv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Aug 2015 18:41:27 +0200
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@caviumnetworks.com; 
Received: from dl.caveonetworks.com (64.2.3.194) by
 BN3PR0701MB1717.namprd07.prod.outlook.com (10.163.39.16) with Microsoft SMTP
 Server (TLS) id 15.1.225.19; Fri, 7 Aug 2015 16:40:57 +0000
Message-ID: <55C4DF89.9060502@caviumnetworks.com>
Date:   Fri, 7 Aug 2015 09:40:41 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Tomasz Nowicki <tomasz.nowicki@linaro.org>
CC:     Robert Richter <robert.richter@caviumnetworks.com>,
        David Daney <ddaney.cavm@gmail.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-mips@linux-mips.org>, Sunil Goutham <sgoutham@cavium.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 2/2] net, thunder, bgx: Add support for ACPI binding.
References: <1438907590-29649-1-git-send-email-ddaney.cavm@gmail.com> <1438907590-29649-3-git-send-email-ddaney.cavm@gmail.com> <55C467A0.4020601@linaro.org> <20150807104320.GQ1820@rric.localhost> <55C48DF9.70406@linaro.org> <20150807115622.GS4914@rric.localhost> <55C4A7AC.1080902@linaro.org>
In-Reply-To: <55C4A7AC.1080902@linaro.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: SN1PR0701CA0050.namprd07.prod.outlook.com (25.163.126.18)
 To BN3PR0701MB1717.namprd07.prod.outlook.com (25.163.39.16)
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1717;2:W9TMb85dUCj7yDtq9kThhOpqfu0d4Iu43fTDPECVfAch0OkVsIeHeLiXG8qyCWmsGOXbHHCMFbrQupiTvaQgV7HwT6zMnXDeVchhJx9RAp77d6Zvloaq+tQEAeZDSI01ijdcgbwbUKKvrouea4lFOeOtFaUUszRP9kZXdkLfgus=;3:nWNSmHFhOjgeZgMyJdElutZTIFA/J5WXb5/0BMCluBLPvyWIuK0cjI0dMbKAKSAO8Zse41h3d59t22GdXuPIcEnHbeI9/EXZgbso24eXLF4ZYSFX5LOY6J1Dy3xoCldh50LDBAAo4K6sDk9aJ10oYQ==;25:Xo8Yi7lZ6EoHvoRTVhBeqEtIiPXQpfj3asyzSNqpSiugjbhFVYG6Q+hw4hm7aiKHo45uJX2q76d8XzaQHAEtPYhKUJfU72oJL2+lACKqDH1C0UcVdDIwzlf7WYC5lAb/06godN2aCRSnrMbsCtXpqQ5xIIFyg0BlgBF/Dqh6vTbOvTF2xdvlM8JFltpChr92zs3NX8S/2lehAt9l/YY6n0o9aAP4E1qC0FDHmrm8DZbFdRE41L0gSySMLAd0ZIyv7oUG66WejVJ5IbqRFKMu5Q==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1717;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1717;20:hEneLuyr/AyHS3l++UQbDyKMwhdAxpCGohYCPYHkAmYIFbTlmdjIUQgI9rlq3G3xuK5nTcUB8BpWALckPSDgQI7a5abKVrm0/RX4LnyvVVn0qNKyaya7ey+SpTl3vyQa0ril4/tk5mlsIbdRoLLXgFFXveslGAiJxHwtTHr4m1cVa1nEJa1biufix2SHm26RLPqqP1rRxIeetDtdtScDqtdUwOWq/v7F3ITiM2siTkhelgMoSr+sNc2NA4Ujt12qc3QrNmUgGQSBJDNimu9fTvhdblYea7rgZ0XDTDWCvlZOvIKOpvG+ggF8Ec/MddF8E468iqGka5mfU33VoOqwzfC2eWglwZdqIx261cF8okvOuqoOimRdoBR10xtjGoo6RJ6iC7mHrNGNvDf8R8LGuy/2Wm1TonVVw7jNrzieuNPlYabSuHR9qCM0Fu4J+V6OwT5RWKm7CRZXXWCGLRjyF0sHGXuBO4O2Z3WMchniv+Lvicdg4rNgpFhwmtQuJqVILnE1YfnwAkrxLRmbmqgwppGRFtXk7JTveq9Irb/2h9ahteDIC5MqCHBUjxLAD5U30L6ix3ZLjCwiEmrJK+I06lubr38rWu6T6BDl3H5JbgU=;4:ATDDUGfH6948LOPnC9+iRmCY3LSZlNTu3sIRjo0SeaRMb9/4hlpFbRBUs/GmtxnfGRTlcp0lk4TbmJiHH0GG2OI4cKqoz2QQEf8zPRiS5pkXYFnrtT9r05cTieDqaxFc7+6mEs6/RXiCi2rEqhsdOrh8hYwc7tZv1v3nc3yE3TmJN6proLlG5LY6TjXQDYFaDPgl6lrWAtk/nwn3BNqBHUZh35b+Wp5ekIsUFkVH+sfTvqirp0IE5s2KTwe6MitKznmJd9hEg/Jr2gB/3pXQZwEkMvJROZ3iDDsFslTzjms=
X-Microsoft-Antispam-PRVS: <BN3PR0701MB1717AEA73289E098EDE135A99A730@BN3PR0701MB1717.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(5005006)(3002001);SRVR:BN3PR0701MB1717;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1717;
X-Forefront-PRVS: 066153096A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(479174004)(189002)(377454003)(199003)(24454002)(68736005)(77096005)(2950100001)(83506001)(87976001)(92566002)(80316001)(69596002)(65816999)(50466002)(40100003)(42186005)(33656002)(62966003)(77156002)(122386002)(101416001)(59896002)(93886004)(105586002)(76176999)(54356999)(66066001)(46102003)(50986999)(5001920100001)(189998001)(106356001)(53416004)(4001350100001)(47776003)(5001860100001)(64706001)(110136002)(97736004)(65806001)(5001960100002)(4001540100001)(87266999)(5001830100001)(81156007)(23746002)(65956001)(64126003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0701MB1717;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;BN3PR0701MB1717;23:FWNpe5gHlaODzg836/z0FdB0bspIbEK5gGM?=
 =?Windows-1252?Q?fbnJZsJRsnoJ2QPGVHTx0sH1mb/m3Re793t22pWPz6fzHSmZ/wo41Ett?=
 =?Windows-1252?Q?a3QAIRRdZyaexWlOLU1kvjjfrPEYEca632ipinJB7rthV9YbTK/HsGez?=
 =?Windows-1252?Q?l50crSV1xhMeDSUstVnw6KKTf6jB7kYswXqcZXp5I1EyZ6KeKoTVlh3o?=
 =?Windows-1252?Q?GzhVHEO9CUpMScSveyRuwVkgPHW43DxQ7SZaEdY+Num64cSTer0k5ZsH?=
 =?Windows-1252?Q?/XwD9g8snokNnBxZJPvdHj5BbWhFL3k4ZIDAdX77V9VutsYTMt8M3z7T?=
 =?Windows-1252?Q?GVXFYLPnfA58zc13pN347P99DyWYna1HCotRfZhROh8B3FwRetBJOZTy?=
 =?Windows-1252?Q?LrAbdP44lNDlFfOa9/pDNpMawxFOWQA6On+Y6Mkruc7G2iPIA77kV5og?=
 =?Windows-1252?Q?asLuaTiHgGlDg3z9ZHjs2XZ+3NdZMuO08uxWIWjEJRRvzuuzQ44h6PpA?=
 =?Windows-1252?Q?wjkFfJqSLQA6Yo1f5p6Nu/gT9Nsf7SlL0+pRdEfF3/QERvMNPs92Y2gy?=
 =?Windows-1252?Q?kEh80LfrPkMz7vjFpbcSGEleaZkIwQJfTbfKb47vwjbvS6PO4rnaHjrl?=
 =?Windows-1252?Q?N+DUrZIe5PXQ6cGehmB6d4jhccJbqufA9lcsg266JBNeKxXzQoaf2ihj?=
 =?Windows-1252?Q?4CVAQOzRciaaErxOkdrPfsoOjag22uw/7eYMWd2DmLqclm28YJfBliO+?=
 =?Windows-1252?Q?6LvYWxACNJdMqn2P6ZyC1IlzWcvz3D0qw4dfLQGuBYKqYd9A10tJiCog?=
 =?Windows-1252?Q?IYstTUm+7LdVZwcva4Tyvr0xlU/tOsOm2ToQnWjrSQu+V6BjHrqKmQNS?=
 =?Windows-1252?Q?TprS5zUWxJ10J4sa85veAjJ1XgpopYhfudh5v26yVMBtTIScDauF7Kfv?=
 =?Windows-1252?Q?B7jREd19nrh+qobxmIJb5YlPoFUGtJILsRZpsUj6v9Iy2aekvPfOkY3d?=
 =?Windows-1252?Q?8dYzIjIgjXlyS6PaXk5WPm/tfUdBQopFbvMu7M1w3L1GSSx3yzLQxaSS?=
 =?Windows-1252?Q?+7WTXl8RK8at0mb9PkGHiJpDywV9vy/+YQs6+v8GpXvWk1dkkt+BPh1O?=
 =?Windows-1252?Q?vYAqGprggayfP2B2zMauurIWhkPu9411GTmralv0MvBmOC8j1NbZCGhY?=
 =?Windows-1252?Q?rUHd0a6fcftDPXylGf2eiWRNqaUbnG+mpj+nbbpu5OPo+acY59aDFSMW?=
 =?Windows-1252?Q?25wxW4BocItd+SM+qgiwE2k3wpxkJFM1bUmZ4tl9EhlrADgNTb+yIM19?=
 =?Windows-1252?Q?+vPfaS1Xez8CiwPxFG+kilD89mbriVqtmxuzQpFwxmgo7/qrmZ+PLiuD?=
 =?Windows-1252?Q?fOCNIvY5n1hywCc4dFmJ48rLsyymqpmDVZ+J/1QBw+nHTtHqFw+gD2Lc?=
 =?Windows-1252?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1717;5:EM6m/SvC2kPMjKeuBnMSptCh5T4eFlnFAqJ9uSyluRhccSWXbNYQte4akyffDjV89ZLfJo65Xh6k6dEsWwSPt6VqlpnbEQlAmxR5hXmP89KvwQU3gZKYf4Ve6THvbFBoaAi/OxZ2S2aZC2jrr9hjfQ==;24:9xe79Rtx4OtdSVFRSP58U2pT7zEIS+tdwl9UmSZhWO0hO+QvevEQMFpgYwIx555hC5nMgXsV21HQ7S87za6lDBhcAUIZahUXWRBl/OgE5ho=;20:TsajsvYq9tZXRXJdaO12V5SZhO/uqdrgY1r2meV7AlOofbW4Y86zcb4gS7+HLFD4C/vTPu6dvC9w0zIxEEoO4Q==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2015 16:40:57.0894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0701MB1717
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48722
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

On 08/07/2015 05:42 AM, Tomasz Nowicki wrote:
> On 07.08.2015 13:56, Robert Richter wrote:
>> On 07.08.15 12:52:41, Tomasz Nowicki wrote:
[...]

>>>>
>>>> I would not pollute bgx_probe() with acpi and dt specifics, and instead
>>>> keep bgx_init_phy(). The typical design pattern for this is:
>>>>
>>>> static int bgx_init_phy(struct bgx *bgx)
>>>> {
>>>> #ifdef CONFIG_ACPI
>>>>          if (!acpi_disabled)
>>>>                  return bgx_init_acpi_phy(bgx);
>>>> #endif
>>>>          return bgx_init_of_phy(bgx);
>>>> }
>>>>
>>>> This adds acpi runtime detection (acpi=no), does not call dt code in
>>>> case of acpi, and saves the #else for bgx_init_acpi_phy().
>>>>
>>>
>>> I am fine with keeping it in bgx_init_phy(), however we can drop there
>>> #ifdefs since both of bgx_init_{acpi,of}_phy calls have empty stub
>>> for !ACPI
>>> and !OF case. Like that:
>>>
>>> static int bgx_init_phy(struct bgx *bgx)
>>> {
>>>
>>>          if (!acpi_disabled)
>>>                  return bgx_init_acpi_phy(bgx);
>>>     else
>>>              return bgx_init_of_phy(bgx);
>>> }
>>
>> As said, keeping it in #ifdefs makes the empty stub function for !acpi
>> obsolete, which makes the code smaller and better readable. This style
>> is common practice in the kernel. Apart from that, the 'else' should
>> be dropped as it is useless.
>>
>
> I would't say the code is better readable (bgx_init_of_phy has still two
> stubs) but this is just cosmetic, my point was to use run time detection
> using acpi_disabled.
>

Thanks Tomasz and Robert for the input.  Because of this, it seems that 
another version of the patch will be necessary.  In the interests of 
code clarity and asthetics, we will go with the code without the 
#ifdefs, and rely on the compiler to optimize away any dead code.

David Daney

> Tomasz
