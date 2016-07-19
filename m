Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jul 2016 20:31:29 +0200 (CEST)
Received: from mail-co1nam03on0053.outbound.protection.outlook.com ([104.47.40.53]:60110
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993082AbcGSSbWxuPOH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Jul 2016 20:31:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Xn6MMpnCH6hAnQ8UXZwKMVnOawM+Z5P3zHgquzL+MBo=;
 b=W8yFwGryepQ8UERTYPyXuokWL08dTMnnM4G5tyIGJyAkurxWweaYEXTouAIv6sOG3lcIwA2la4oV0dh7iIq9lDWrmiK+DGGZmTKrJbownHNFRcy2Lvmhd76BolAXORLdgiElbGKCHMNdFNEPToJwmu6dB+e12U23Fm8sHQ9rths=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.4] (173.22.116.65) by
 BN3PR0701MB1089.namprd07.prod.outlook.com (10.160.114.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.544.10; Tue, 19 Jul 2016 18:31:14 +0000
Subject: Re: [PATCH V8 2/2] mmc: OCTEON: Add host driver for OCTEON MMC
 controller.
To:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mips@linux-mips.org>
References: <57853474.9050108@cavium.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>
From:   "Steven J. Hill" <Steven.Hill@caviumnetworks.com>
Message-ID: <578E71E6.2020700@caviumnetworks.com>
Date:   Tue, 19 Jul 2016 13:31:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <57853474.9050108@cavium.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.22.116.65]
X-ClientProxiedBy: DM3PR18CA0030.namprd18.prod.outlook.com (10.164.243.40) To
 BN3PR0701MB1089.namprd07.prod.outlook.com (10.160.114.14)
X-MS-Office365-Filtering-Correlation-Id: 6214f4c8-e044-4d68-ad85-08d3b002ddd2
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1089;2:wTL4vmLS+OMesb6jxnQG2XfupKjLqgHjoM1Qjgv2nQbSFpvSqdKxsJBxXEVrokRdKLPkbzaORuNSczXv1kuWLBahGNivS7aVRzTUStSyDSuvWm9uayOHRcE2gM1zCq7W9I6I1X2DY5fTOcrtOvlxTuGlCoP5v1lobJSTheOvXyVWWSNtNrwFFWtxNg0mZscl;3:cpByNI/okD5IYz+fqctg7WFCaYOKwn8x/YGpoDA2CY5/4ZkF7MTLw0aN3Vsf1Zgb69bbIOMTULJfujYMGwxNwi33FHr8mAF32r7CoLIMAOnqXOJ6u9GkAv/507vzSSdB
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1089;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1089;25:an/p/NFH3upnYmp+U1aw5j0pCtu+p/Jx75wMaKFVGCt8jDct0bmhYCv9WlwpMlTHoGc/Y6uCyaFPQAk/UMvC3CM4WL7qHHVBtvnWjlEM57dZX+BcUWmQQ0g9JnNxC0fz6+eH2ZuMxr551XaY5kkeouiKYpbBsAhYoRyFSOx9sX9ZQ+1rlvekKYsEEyjD4YT3k9kt93uToYcqFjNQUzgLfsGmsR/NY4Em0SWwsO+PrCNt4usa27PDh+7vUzDxA5cQ2KREN54N8oIUWA3I13Eai5Bjuiv8qACv77XqmrGUpSVhlLZoJkahVEnKqTkkvXufMSMHNu1Hz3QOXX36A/EGz9IFf3zt/En1DadLyuA5Z4BQkDd6CeXd+30Xd7+gWt/ReFerfpDyiLWbsdfjssifElSQHSPaq25H54ofVkWBb2B/4RK7RZpMdUXbgBO5Eu2uEp6xHqcniYMkUYGeNdqVPL71+zvkBjevXvHNu9NQFRnEeBneTbNQrj/BSsLvwr+cldSpN099BKhpP9gp4TmC4Tbg1O24yoKe8Cnkn3+w11Ijv0UE+F9n8WecRFu8ogR86g0SGuwBheqqie825P+wLkJKRk99DsAW4MP0BrBnmtYKvNXhnCKKlycsVeNuMZb0YZZOXnmf+juu4XIRHOxdg0DOlNNBp865CjJUZ2ibjuHTyUc1WAmBy2vN8OjoHpMpqv14eQc7Zb2MKkWAU53wuXHe5VMh06/Lp/sT0MJBqU3AycvAqayzbb5Tk2TY3HXb
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1089;31:BaAsiXttlKZiaRQnDW9uu0SMLEsC6ziHkwCSaME/m+TQxlf9fMo5njRkprq+XPUDnbvk2QIELMwCK9uzkH0h54x9Et2bra3BSSXrA27ITnpTERcmXC97FjjYYf9XnGB9/vOW0XY3LX3kU4e/gQhE7Npykm84+zZ68trfYnDodXcoYG18cOsfCs7FS3VpghNbtNHLHbyDC8FfgmLXtwdDWw==;20:87q5DFrbde/dXGVtMocWDE9w6UUUNYL9sMH8og1jZ96LxtYwcGziYcQMhqcbyYzkKVhMfqup1YV8GfVTYfoLrvI06wiVEIDA4Mmjv69eecfXvTLACjrdD3wPw7WqR7GkpdjraDssRJP8zR5tot74LvvyB5XuXcKVbGqKdo4gg07QCoUXZzDjqB771/CIypLMPWZOMUdfvmVWGfYLEG5ean6YJZ23scJQk0s8y2IjoCsUShaKfzm0bZUH6CrHEQ6qHTN//3asW4yaSxzwM86H/Ovf91yxs0rGhyczA7uwNvjy8QFyCWTSUDWVhqsMJeqXQSlW2bIsMX8B6Sqde5zN3pXR45kA2Nwls4Y8jNdTzlPx4BaaeFbMKnVIBD6JRzjwk56wf2MAaD+ZCCWk6eZJalu9z4u+HRMH579Jp9RGv7Ag37crjA3Re5TmVyFs/9LupENnZTE5i+EfbFjWbt0ZR0aW/q8G85o04FAJo4R+enkLMefJaCZPU4yF9FohuK3HRHaJ0r6qEoerRWj+uVKh5CLjzFjyFDap1RsOmajK2UZGr6vflW8i7bVGEk+/3Lm876jCS+RbaVt8FDxPceJCKMtO1cJ82tO59aH/TJu/+BU=
X-Microsoft-Antispam-PRVS: <BN3PR0701MB108957678900A2CA99C44A7A80370@BN3PR0701MB1089.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001);SRVR:BN3PR0701MB1089;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1089;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1089;4:byMvo2uiCj0IFohPJIXwaRliB+j3U15Epav9P0A3wunzW+IaV0PF8xEw5uisNZ8KrGYnR64zTcq6d+HGLBX52QwIxiuGpkAdxOkv4KrZn+kkhPlKyisC4e6Vpe9v+Q0lqeo5fxDn2CtYK1Wf3J014LamtqGlcvmFQ+FlNPt4GiyG0NgC5H/egFT3wghHU2GF08Wt0DaXlen2FaPRpr8qEW1QsJNtNlbjf1lgpwu+/AvUNLldAZFhjM6rT9Bp5/6iOwOtc6QhyKODLAx99Qjpyve7BQg/8HTWAJn7YgpeUsb6UzsDwaY5pVc+fFWId4S6k5WZ/LskJg1nQiCmRAdq67Fn/9e/6B6kkTxmpISl8K/C5Mr2z4eB7/oUoq7FAXga
X-Forefront-PRVS: 000800954F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6049001)(6009001)(7916002)(199003)(377454003)(24454002)(189002)(36756003)(83506001)(105586002)(230700001)(3846002)(64126003)(50466002)(81156014)(81166006)(59896002)(23676002)(8676002)(2201001)(305945005)(92566002)(7846002)(33656002)(68736007)(7736002)(42186005)(47776003)(97736004)(5001770100001)(77096005)(66066001)(65806001)(65956001)(4001350100001)(2950100001)(6116002)(106356001)(80316001)(19580405001)(101416001)(19580395003)(189998001)(4326007)(586003)(50986999)(2906002)(76176999)(87266999)(54356999)(65816999)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0701MB1089;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjNQUjA3MDFNQjEwODk7MjM6NkNFKzhneEtuUjFJa08wWklFTzR5OXFN?=
 =?utf-8?B?VlNFUXJ4aVo0c3Q0Z240STRwTEkzdFBxaDNSNTE1b3k3a0IrNGZmQUQwK3dq?=
 =?utf-8?B?VFdyM0dHVVljWGNXWDNnbXBtNWwxczdVRVJSckcwbEhPdEZIbml6WG5oYWdj?=
 =?utf-8?B?eG5vSHQ4UStMRURkTXY1S3VVeVZiNlNxeDNNT1IzMUdmeUtvSWEwWjMvWjJr?=
 =?utf-8?B?TlcySU5wUUhhVFBBNTZwc2MxMExtbnZudS9aOEhjMHduSDI3cEpCbmExd2tF?=
 =?utf-8?B?VUNmQUhGSHY1YXFwODg1anRVWkcxMGJCS3haOVpVVGxkckVMaU1pa0wwOHF1?=
 =?utf-8?B?RWFvdS9LMFlQSTM5K3FUbVpHU0N3T0VrU1J4emM5cWlnTndKdXFOd3ZuNWZZ?=
 =?utf-8?B?akVsK01qUGZpZlVzV0tHenBWbjZWRDZ1VUVSWWdrWjh3M1krZ3lLWDNkbFRr?=
 =?utf-8?B?TEdBckJSTVRJVTdzOElJbWU0N3FHckZCdDRDTkFVZkNvMGMzNHdsY2g0VWlU?=
 =?utf-8?B?Vmo1YXl4WEIzWVRYVENPR0ZMOGRwbWVRV1NIdXZYWEpZM3RHbmFDRnE3QnRr?=
 =?utf-8?B?b1FwZkdGMUFKOEhSMUN6RjZEbHBISU1zRWtOeHpMbmx2SmdtdTBhSEpFaTFl?=
 =?utf-8?B?bmdQZmt5dXBqbWFSVmlweHJqU2xvUHR6Qld2MDdVcUEwMFJTaXBONmIrVkFw?=
 =?utf-8?B?QVQ1UHRzWmRmYTQ1dmhTT3ViSkVrL3Q3OGtOdnZJZzFZTzRnb3IwOUM5eUE2?=
 =?utf-8?B?Q2gyYi81czBiRkZIb1R6MmtBT2JHUC9FanpOZFZVdVJabmdpWjFwdjVqYmRL?=
 =?utf-8?B?cElFdXV4NitnN21ZOFdJc3lGazRPVXoyQjNvVzlFWjVUNm9aZDNrR25KdmFT?=
 =?utf-8?B?TVF5clB4eXJjUjdldkgzTVhKTGxzekxFWWI1Vy9yNTRhTytTTjdlL0YwakZI?=
 =?utf-8?B?SlRBUWdsb2E5VTNUQ25JS0J3RVkxY2xWTzhvVGJ3NGd0K2NrT2FDM0UrM2V4?=
 =?utf-8?B?TGxpSTZTMmJxM0NzVGtJSENKdWhsdGo3ZWw4QU90NjJYSXd1QTB1RHlSMCts?=
 =?utf-8?B?ZmtvK2VaaWJXdU1ndFkvS0VwNmJLU2hYOFFlU0FRTlhZVUxsTzRrSmxvWmFF?=
 =?utf-8?B?L1pOVkpuZHVkek1UTEQvd0JEWjVKWjNhYmJoMTJkK2JXMllSZldXWHhzZXlS?=
 =?utf-8?B?VHlnVXBDM0lscG5TVkd3MG1aOVd6dER6NXI3KzFpWXdQMW16dFVBcTBYK0R0?=
 =?utf-8?B?SGg3L3puOXo4R1pMUXdlcjJDaUtRTzduTy9RTzNzNWpaY3JYZnBKYXVFMmNU?=
 =?utf-8?B?YXpjTmxjc2JpL1hnOWhqUW9DdllwMWhNdnFlSkh1ZHJtaHF5YzF4VllhL0RH?=
 =?utf-8?B?cS9yd1V5K0JYSEd0eWhxOTU0RTdiQnRrYXNUa2dWWW9kTUZrT0orWGpGbURD?=
 =?utf-8?B?b0dtbGs4cnhzZjlKOWtFMjdlV05OU3AzdWxZaE0za2l3K2FpNS9ITk5zVnBH?=
 =?utf-8?B?UkpoOXRHSnhibzhUeTFLSkYwb2kvd0x6TkR3bTRoQzdxaDBwTXVxWFQrYWhi?=
 =?utf-8?B?MUlveDJZY3NaTG1iSGluVmZKeDRVem40UEZqQzI5YndFZTZUL3VGb0JPQ2JC?=
 =?utf-8?B?YkFaR3o1ZUQyUUNZOWFweWU2eTJYL25hOHduSUhoRmRmRFdTZ2RiaFZ2ampy?=
 =?utf-8?B?NEVYVHV0dkwrd0lZbmFYWHVFYkhubW1UV1kyMndDazF2RXJWZmM5bWxzZm10?=
 =?utf-8?Q?s8iiKrGDXC8WwFImXt8BeMGZzullzu/neMe4GIM=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1089;6:w9Anh8eNgmmpJJIm6x1aZHrq/uwJ4Q9BgYXgY7mOVls/y54eW/DzCEquOnBHLqIVHZbcuzhTWYcxoP2R1Ij7kPahuyszqN1o65gPPTQqYSsNzzSU0zju4GhGRZHxOwIz7qGebTBZh7snhmd0YoNFfiyv76Hv0JmC9MX+LwpFyJbCXcniwIEXSx3wwnQmfLx8O5QswELHUZBryx1A6xeJWvMyfPlZn/3uWZAC+Rd/HaYNXnV/5LgwmuMLt4kl+V14KJGbT8jbi3ixh73ZdquhxMALjwI82oPhx5dZsiBauh0=;5:02ej66TxJvfwtoglEpbiXZgnjTLnGhFRNEQjGyOslajfVMYTaZGfWVX5H5Mxh6FH0dgmdIPQ6AOwoGo3sAjd8UGRJSi4WKPFDuNyfMDclTWXDpiRNvvP5WIsFajVrwJWbqI+dZ90xZ72Vs0/dNPdOA==;24:kNGqbUD5dD/QOZUAwUwRX1XNYOwc1ALpQhuS/j03TaBbZwmavRoUQvPDQWB1CTLZkDQyIyF2a6NXzvwkrpS5t5KVKzKzBxLO1kXBBrdkTmQ=;7:OeCj6tSOt9eBpPQj9P/hwiwxmiY0f7zwgS+FaKJdIboQCOROf0Ndz0RdR83TKHmIaZCCWFv5XtJiwHcO3N2aZzes0gJ9jdFE2OjmZgj1/K1i5l1uMgmKBv/lUlbX9rFZobJ33CEUvgchDEz0pxLNjwwMLKxHUJfpCJPXUu/i639jhSoFxYefQbJqMfxx61dTlUS19oO1tlZQ1Xap9ylGCtPNNlxdWIPlvKUOEFznXQZ955Td975592Z5rt5OIE0k
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2016 18:31:14.0491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0701MB1089
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54348
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@caviumnetworks.com
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

On 07/12/2016 01:18 PM, Steven J. Hill wrote:
> The OCTEON MMC controller is currently found on cn61XX and cn71XX
> devices. Device parameters are configured from device tree data.
> eMMC, MMC and SD devices are supported. Tested on Rhino labs UTM8
> and Cavium CN7130 board.
>
> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> Acked-by: David Daney <david.daney@cavium.com>
>
Has anyone reviewed the driver or have any comments? Thanks.

Steve
