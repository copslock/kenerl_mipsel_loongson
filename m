Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Aug 2015 21:50:16 +0200 (CEST)
Received: from mail-bn1bon0091.outbound.protection.outlook.com ([157.56.111.91]:41984
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012080AbbHNTuO3KzG9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Aug 2015 21:50:14 +0200
Received: from BLUPR0701MB1716.namprd07.prod.outlook.com (10.163.85.142) by
 BLUPR0701MB1874.namprd07.prod.outlook.com (10.162.88.148) with Microsoft SMTP
 Server (TLS) id 15.1.225.19; Fri, 14 Aug 2015 19:50:06 +0000
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@caviumnetworks.com; 
Received: from dl.caveonetworks.com (64.2.3.194) by
 BLUPR0701MB1716.namprd07.prod.outlook.com (10.163.85.142) with Microsoft SMTP
 Server (TLS) id 15.1.225.19; Fri, 14 Aug 2015 19:50:01 +0000
Message-ID: <55CE4666.4050307@caviumnetworks.com>
Date:   Fri, 14 Aug 2015 12:49:58 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@nokia.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        "Janne Huttunen" <janne.huttunen@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
Subject: Re: [PATCH 00/14] MIPS/staging: OCTEON: enable ethernet/xaui on CN68XX
References: <1439472106-7750-1-git-send-email-aaro.koskinen@nokia.com> <55CCED1B.6030701@caviumnetworks.com> <20150814130912.GR1199@ak-desktop.emea.nsn-net.net>
In-Reply-To: <20150814130912.GR1199@ak-desktop.emea.nsn-net.net>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: SN2PR07CA009.namprd07.prod.outlook.com (10.255.174.26) To
 BLUPR0701MB1716.namprd07.prod.outlook.com (25.163.85.142)
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1716;2:NscUNGjXWrIn3wo1bdDNejn8YVM8PSV2IFYhbrI6vtqQggxa6F5lkSik3SLyAgjvchcyHt9sopTKOwnOQ5H7L7LhKEacRp0FvvJH2oL62OCyUQ0B71s38dPF70Kqz9INFUWrXe3caf6EwIvfotZif7JVsqCT+9sYYyCrwzCZHKg=;3:wmw5K7dXOLPhfqwkvihzjzUsmdbJXoEccByG+Hwzz0xiEEgLU7zF63dePMEAiRKDMaOuvWdl7uPvA9bVEkn5q5IUjhJYblIcByvH7+uovJvJ1gLaAH26Mjb1Augb3FkZ7k00E1WAyKKfqMfRED2Syg==;25:CjALBqqs7BUVS5yZGH3Pcj3QTDn6rMg2Nvl3Jr+HV3dNfavtn3Iw/A5crkXrQwevtk0gUSysnTYA5/T9rXzHcHuuQsa2+XmkNYG/a8O3vKo6ooWuPsTbTjzJ3EeybCO9f48voedp8k17y1EBL/0FVwv9WMKfZrDXJ0LV/1fOTNIlC5WGMRpt0iiApu8JebJ3B3TtKBxrN0PBtWGgAxeuwPN8JGN/jpWIuxGORhMkiufeF5FBdZug+Db7ROHR6Wmb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1716;UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1874;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1716;20:d6LhHBsLQJhppQ7HFDo7sOTjCHqwEt2l+otX5Qfxxx5BAJuVt1v9zMm7QDTDcRvWggyRsQpeCFvPlA97p5oRpqWfciNdw3YgcDE5w3X0diF15k9r6ZAjsq7vLFVoBa2G4KUJkvxCi/w6+3qT6XLWJMSOdwUeWDLBaB3tgdHAPYik1vLxyM3bP/w0pV2PgF+HfLvpDi49p+feqRrUfYTsiFInuvf6RfWRW0+XAa9j5od8sfL5KvUv7ZwkSnvdB3ovo3i8GadreOyLEpjCAeVnHv5RzEQBlqtDwHJOu2mKU/v049apz6RYeO0lPhLmtK4mK4sl2OrIPH+zRvGOcdpYlh1q50jLvsDyypp8c4DMihN6w2aTfzhkw2pnl3vFs02G+J7Ir3E2qxOw1QFF/4xShrql4NlBd0qGqozy9wSBioDPiUbkPIODvRd7Lb8xEFFD4xgGJopi1L8xUCeirVThuH1X6NeCnx+n3jDu4jwh0TG2Jfwb3ZU06QXQKUuN6MkOGSDYdQARH2UCzUJvjCXYf76CPzu9NQ6WIYpDTFaEUJ+VVpjDjH/rq4amSewxQ21PcMFtLtXOZsecJrmH+LKbYxsC+g3TQLD210Q+VrgS6d4=;4:0K7r5/USUUkyBWSwVqq3Uc9VbMklLAZ7zrp0MTQEjpsJqEWE5i2FCBp2eu/jLTfEDRvtKtYWrLsocWzHlDavGlAzBfeBSi8wBbtY0oObjhQ1nDxVx1G1liL8VK7ppZl6hmooqs+eEIO+QdAdagiIHfSsGc4pUokfC4wvfxFAEWdT2afiXhPnRb+2hj4hCu+9DmsWF5eBRkqJJ/5fasjlQexBmg9Tz9+pm4tOvwv+sXSJHxIq1Q6GFHxQjhWG8QFl+025XOjJoRzcQ+eJbu+GE4y0GBwhShurQxWixHxlzHA=
X-Microsoft-Antispam-PRVS: <BLUPR0701MB17168A925F72E26ED328E3169A7C0@BLUPR0701MB1716.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(5005006)(3002001);SRVR:BLUPR0701MB1716;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1716;
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(24454002)(377454003)(479174004)(199003)(189002)(92566002)(81156007)(2950100001)(97736004)(5001830100001)(36756003)(5001920100001)(110136002)(65816999)(33656002)(5001860100001)(101416001)(4001540100001)(4001350100001)(189998001)(106356001)(77096005)(68736005)(59896002)(40100003)(122386002)(62966003)(77156002)(64706001)(66066001)(65806001)(65956001)(47776003)(64126003)(42186005)(69596002)(105586002)(83506001)(53416004)(46102003)(50466002)(87976001)(5001960100002)(54356999)(19580395003)(50986999)(76176999)(87266999)(19580405001)(23756003)(80316001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0701MB1716;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:3;MX:3;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;BLUPR0701MB1716;23:VnAWLc3aOgEqLdKqblR+C6BzUMX8VtF/mTLM/?=
 =?iso-8859-1?Q?110FhkyKCZAT6ZaryqVNWgLD/YpjkFlP1yrRwXzt8TnmjxLmSR33q4VFCL?=
 =?iso-8859-1?Q?6z9w75h5Y7723w4k+IUAdhWDV6M7vwmy/5M7UYUdatBry0a37C64eGy9sj?=
 =?iso-8859-1?Q?2ORP25i3FVdG61DkXG8B3GWrWt4Vlm4yK9gvZf2xBQkuyyIS2DMAUAYxOT?=
 =?iso-8859-1?Q?e8MZYpM7D0fCH5bRoXEmf0V9gMbelZST/PWtXPD9C2LLzSEReatZRzikfW?=
 =?iso-8859-1?Q?TWGFZEdhegkOgYIMqTNfikAaKzpAw/Udq2x7/s9HNrMegUt2KmTHA1Adg1?=
 =?iso-8859-1?Q?GoU1VvBC2iGuidxS1tqwzcLQ6uYR4GVJYgDwX8V07/Kirp0TEwbRK/5BFD?=
 =?iso-8859-1?Q?i8s/TZ0hMa+qeQlORCbAFuNFcxQOPKG5zfFYFgTQssM6xFf46kdOIBRFEG?=
 =?iso-8859-1?Q?0Cmq0c0dw1ah3Bp6KwEnvg5w3ZfW1e0WulAq7ueufDRjktZXFD8t6ircyw?=
 =?iso-8859-1?Q?ANLlsxcFkm5QPLJCv3qZpbly8YVe0pq8jjIGETg3a2dO4D/tudJ8Nm+D4B?=
 =?iso-8859-1?Q?e56OhS9Qs4bmXJ883Sj8trytn5bos8ExJYqJ0bOQg1pQVDD8Yi68quWtWC?=
 =?iso-8859-1?Q?8NpvwhyiwO9novYlDBhxjB/EDuQMEPmnqNIVflPSBa4PiAP7tyDNVS5kQv?=
 =?iso-8859-1?Q?S1NWjGW9LmE3NSwI9yK/rvJTn2mG5Uqz8YVgnHqskxXAdY7LypWFv6ZPcR?=
 =?iso-8859-1?Q?EDYIc7i9L/5k+S3NiAyMqlcMxBKOQ5F8i6KwyE1ddYDSKRJxJI/NIj1HeS?=
 =?iso-8859-1?Q?0kaKq/495xhyM2Z4uoi+vqnb1g6wx+fgUyElmc6yC3Oktpoqh20ApTbZLL?=
 =?iso-8859-1?Q?PyW1oKF6svuuXc76fv3I233BLJmu0hM0KSbdMxYVZHL6hvkBwnQtGVptM0?=
 =?iso-8859-1?Q?vZ9SR0gdJJTIB9L4eM8cAntYzUiFRgZBDEvzu6dhrSh3spD6+MRr634cDs?=
 =?iso-8859-1?Q?JZ91rg0BgGfuAwPXOt40GitAZjigrX3AvI+OGvanAVimYu6MI0a09luRnU?=
 =?iso-8859-1?Q?yrIMG4OD74/+ajmyIvIUyxeVvjq0R5n/aLe+Kginw86dfcYtJb0BBOtAo8?=
 =?iso-8859-1?Q?8UKlPcZ9nD4o3ouzGarz+5lMNBfNa+QQA6mcHj5pmVkSabBpvYNJ6NhbRS?=
 =?iso-8859-1?Q?/P1abXDdXYgnXKK4S8TRopuqAPJUmN+wwieemkpJf/2ndAd8OF3oCuXOap?=
 =?iso-8859-1?Q?jwAemnV12MKhErwFC753axWbdo/E0xlnvtM/7yRu2CpAFSpIwtI+D+sdjJ?=
 =?iso-8859-1?Q?ieE0QEfKOliV1IOir+IlJwlPYwQaohLnh87uDaF7lI1NgjjFQ7vC1148+y?=
 =?iso-8859-1?Q?UnBcjpDqVgRKrV+gkHPjcjBDyx43FIqZR5YL1VRC9fKV5BOMAUu9g=3D?=
 =?iso-8859-1?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1716;5:mpNuoKTLTtO2w9xdZ67XyN5wHcLrYrXTQb29mXfA5QBrmbvDIpX5ydtAx/boOcYyk407QanYiiN8KW733jNy/bPOd+nvMWjXwh79fin8wOKGw9vAKKQmRMIQKeBXDk70/Bpy0hlzRqVvJqCUBPEKFA==;24:hcvEENkdyC+L9olAkg1Cz5IdkL05bC4ah9L5gmnJQ0P7/Y2aMkD/PgbytwUdpcHtN4qjpHOUj+29ryWDH9SMiHmSoGyMjls7D+1qjU/+Jws=;20:G3M701j9HSnQ5ReiPnsnRdM3xZplaggXhfxsLiHTJiMliqF7C+VBfj6y9KhsP3cuZGGUi0oLkSNQEKOiMk8rtA==
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2015 19:50:01.9288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0701MB1716
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1874;2:OeB4cIgrWcILzY8HtHnAdpTrgd3rG+2Pj21HWcyFAJj0qYpM1gzLOt45ml/IJSypYFlGa88EeUaFGBs4rPeJ5L/E6eveQUyzEvfqEzmbEH4csGjLbosZlqkjuVZZ2mbSEDVnSFcZyXwxHkh9riMPbVrBCkCse31KJ51eI1kOvD4=;3:WwGMoCYjtB6T8FfqXpWh/klFz1PfqmstmLW1VxKTD504yNAJB4gKZh+pogNtWxzY8T7NUPNDljOrakDxgBTMSdYXHcH0LQiyC5hXXjwIszlqXZmgwDADCLWCsLyGtHQ2cf3og9+v0bQeMK9HKX4zJA==;25:ispX5FTjLzwC1Cz2WKB/Uo/ooznvnQrOWmojssE0Yh85+eYbLlloqCMePJhGaU5rgpBa6qleaSl2MT5kybXjEfk2WOr8qMn3MbMblh7j+o2N31GuY/WXAHSmrHO8UG54/C9dZhuUH3EgwNdMxq2cL3in0eHt14IlV9S0WA7/FMb+nHBJ0ZkHSfaeCAV10hI5zK7rtLPw6ELhY+Ln2Ab4+EBL5kRGU56g8wqdmon5XbrHxpaMQarehS5WiVu1rg9I;23:6sO4ygNQWB7HcSTs+2xLqWah1O1Vzq76XyJd1HPJmIY62hGPDCuaapfGlLA2sl4XbhMdp3Cvxr4zl8nbhqgLni6hYTZMVHCNGsd4WtJ38XF17PenJq3ER/Zi+4rnhBA7MaKW9A5iJzgMjm+JYxXYL+nDFUIazjyZE2jtn8DsXEtRcVPSgHtYFQIHZxJtYX80v5LGfeDWAq2s5xqmV1+lbMrAfJPORJAJ3dCF4slgJyETe7kZBdSVoCqh6xV8j+rg
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48912
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

On 08/14/2015 06:09 AM, Aaro Koskinen wrote:
> Hi,
>
> On Thu, Aug 13, 2015 at 12:16:43PM -0700, David Daney wrote:
>> On 08/13/2015 06:21 AM, Aaro Koskinen wrote:
>>> Currently mainline Linux is unusable on OCTEON II CN68XX SOCs due to
>>> issues in Ethernet driver initialization. Some boards are hanging during
>>> init, and all the needed register differences compared to the older SOCs
>>> are not taken into account to make interrupts and packet delivery to work.
>>>
>>> This patch set provides a minimal support to get octeon-ethernet going
>>> on CN68XX. Tested on top of 4.2-rc6 with Cavium EBB6800 and Kontron
>>> S1901 boards by sending traffic over XAUI interface with busybox.
>>
>> You don't say how it was tested.
>>
>> Does OCTEON and OCTEON II networking continue to function?
>
> I tested today with EBH5600 (OCTEON+) as well and networking works
> as before.

Good, that is the main thing I was worried about.

>
>> There is no SSO provisioning, so there will be limited buffering on packet
>> ingress.  For low packet rates, it should be fine though.
>
> We are aware of limitations. However, I guess this should be added...
> I will take a look.
>

If what you have now works, I would merge this patch set, so:

Acked-by: David Daney <david.daney@cavium.com>


Follow-on improvements can be made with additional patches.

David Daney
