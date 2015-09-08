Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Sep 2015 19:17:21 +0200 (CEST)
Received: from mail-bl2on0063.outbound.protection.outlook.com ([65.55.169.63]:35552
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013641AbbIHRRTOKxpO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Sep 2015 19:17:19 +0200
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@caviumnetworks.com; 
Received: from dl.caveonetworks.com (64.2.3.194) by
 BN3PR0701MB1719.namprd07.prod.outlook.com (10.163.39.18) with Microsoft SMTP
 Server (TLS) id 15.1.262.15; Tue, 8 Sep 2015 17:17:07 +0000
Message-ID: <55EF1810.40300@caviumnetworks.com>
Date:   Tue, 8 Sep 2015 10:17:04 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Jon Masters <jcm@redhat.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Daney <ddaney.cavm@gmail.com>,
        "grant.likely@linaro.org" <grant.likely@linaro.org>,
        "rob.herring@linaro.org" <rob.herring@linaro.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Tomasz Nowicki <tomasz.nowicki@linaro.org>,
        Robert Richter <rrichter@cavium.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Sunil Goutham <sgoutham@cavium.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: _DSD standardization note (WAS: Re: [PATCH 2/2] net, thunder,
 bgx: Add support for ACPI binding.)
References: <1438907590-29649-1-git-send-email-ddaney.cavm@gmail.com>   <1438907590-29649-3-git-send-email-ddaney.cavm@gmail.com>       <20150807140106.GE7646@leverpostej>     <55C4ECC6.7050908@caviumnetworks.com>   <20150807175127.GB12013@leverpostej>    <CAJZ5v0gc=bo3ayO7aWq19Hh_205YC52wqXGbbM5vxR1atXm+oA@mail.gmail.com>    <55C5494D.5010903@caviumnetworks.com> <CAJZ5v0iNqRsrpwzWY5o97R1S+Dr-CzRPg3Cymt1q4v5gvABCQA@mail.gmail.com> <55EB49E5.5040206@redhat.com>
In-Reply-To: <55EB49E5.5040206@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: BN1PR07CA0039.namprd07.prod.outlook.com (10.255.193.14) To
 BN3PR0701MB1719.namprd07.prod.outlook.com (25.163.39.18)
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1719;2:pEPd1nUwucdaGhTvnuu4IWVg6GZNJfO0o3Bv4DjNTQx7mfy/0IphvPmxM/HoPhYErK2yc0X9A2ebX4X2Eu3Blcbwtva/KZ97VLzYOQxwkIyWgIYzLBGnkpaNLk1CjpOROi5X5xoLJ2mFZYMJgpq4EOCoZP+s6SzpuoP2VmUNYqs=;3:eZAbMzNJjKyOHaKbKnPFqdtNCEXbmeF4SBsGy6IjKP2GFM6rInn64SIpFsI24JHe1vaYoHgOj/UK778+uIMnxw0LeeJUbLRGKNXFAOhz3PgGVIMEka0GOEabh7S49/H0opawGwvfqww2MkZZgA61FA==;25:oXg8AXursLPcmgR/AfPdNYtp8VrKq/6LmfviBSyt1rXl+lTw3Pkk4oK8dWSR2m5h8Vv0hUypo9Y9xKdsuHjbeFrIvx2wlh5+oB466pQ80CKWY75z0RXXe0tbIOHBfOD+MoBvR/0slaufZr4nzuhOBoE2sVSrEeKb+NZUN/7gL2rDm2eRDIZMVCQQYoxuGeAK/jBtRcRrpEbxJJHQTLqNAPGN2bYss68VL8uXCQm2W9moul0qLgCrrrskamf/KrKrXK5mktsTyrX+10f/D2Qe1A==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1719;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1719;20:YkSN2ilAnYKc2Qp36shtgEHAO91R5sotGabYCtvx52VsnMl+AxiBSEZXRxHNCSZIz7tWa0wWNRkWaIgHh3WlBHApwX+9jjUrXes3rFMwfkdNxsEeirD5FJucZv7scrk4Rb9nqAHqlcP+cSzhPtWh1sGdmqjACq1tXvRjBKJ/s5OCtVPRU2cbzHUaqc9T16LhYDhdpd7zzAjll2reiSaLb7h6riLIB2Z4+IQc1WAENQTvwB8J7eMVTcHPTjbFoP7jEKNvNboUTu18dx9FyaqHL3K7QYYVS/elH7OzlDXRNbrDkhHg0qBlA9ggNCmirI0pf4VUHzDcK1inzzFO12x9xsxMt9X3WWkX0RjxoYkPhLBYtmEk2YlPFdOXP6tRdzDGA9rZIiGm3NfbfemPxKTLiGurQBdYnE87+L4rfvcVfwf0dQ9EJ2qsTFCsiQb3s6qStglV/ohW0KHC7bkYa9udv9wo/pa3bM5AveUWKOm0P+Axboa3W8S1O6cvJSvvS/0u5MeKZT+BliYhIJ6BfbLwSeYnR7j31LiB5TqeipEWBxE3rDXMQGtZ75jYgqi6bbdBrNtg51sKJNXInyzFPcI3b1pNKC0OYe4NBGJyqnb7nO8=;4:m/vNNECGULQ77mfNHOcCv5D/x3Z3ZmPghosf/y8e6RJqIYAj5skwC5kMl7jtfUBXnzqp9twCVku5bkwkq6qgQtB8Css/zgKEmCWFotlfyb2ZCjgkKaWq/omWmzdoiXCTtzM3lOZChBi48Efj1VuzPPadMJzWu19hUg9snVCZRteByxEZICaquPE+jT7PSPEqk3DFIljfO3I1fcsJzM5rkqknC9TR/aW1hLE6ngQV6XO1K5YlaHi7pQtodX78Yg6VgHnamZul6dH+vpDzAWZ4W7V8YZEq0O+oYQ8GTUOzTwPZOQzhsFYisbvwHlFvQrim6/hgwx+eMzUqCeN+A71J0Q==
X-Microsoft-Antispam-PRVS: <BN3PR0701MB1719541647BBB6627027C87C9A530@BN3PR0701MB1719.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(5005006)(8121501046)(3002001);SRVR:BN3PR0701MB1719;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1719;
X-Forefront-PRVS: 069373DFB6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(479174004)(199003)(24454002)(189002)(377454003)(5004730100002)(62966003)(5007970100001)(23676002)(19580395003)(106356001)(87976001)(40100003)(66066001)(122386002)(69596002)(42186005)(65806001)(65956001)(19580405001)(64706001)(83506001)(47776003)(33656002)(50986999)(76176999)(54356999)(65816999)(93886004)(53416004)(101416001)(77156002)(2950100001)(92566002)(46102003)(64126003)(36756003)(77096005)(5001830100001)(5001960100002)(110136002)(105586002)(5001860100001)(50466002)(5001920100001)(189998001)(68736005)(4001350100001)(81156007)(97736004)(4001540100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0701MB1719;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:3;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjNQUjA3MDFNQjE3MTk7MjM6M09tbFVhQ2ZSMjcyMS9nenlsVnZGMWRL?=
 =?utf-8?B?cm5zOGdCbUtFWVl3RGxaWjQ1WmFMV0ZtclR3NGNLMXBGb1NqYmZmbXBPYU01?=
 =?utf-8?B?VlZ4c0NtN2grTVVnZXFiWEU4clNLMG5HOElXcWtnQThVMFl3bk5PMVZTMjdr?=
 =?utf-8?B?NDl6NFR6RlNaa1lCaTNBNUVsbnJJbStzTSt5bU9HakVFNHl1LzBWRExvMEdj?=
 =?utf-8?B?MjRzS1BBaG9hOHpqRi9UcS92VURQTWVLeHdhVGdwaEFMVmFLMWYzWTcyU2Rh?=
 =?utf-8?B?WTRFOVJzNzZlenRQTnkxTTNCRXl5bG8xRWpGSTRsSEhWUFRURGZnbzRrQjY3?=
 =?utf-8?B?WGtySHRFK2ovNzBzV2RGRmExTWdqTHZtSi96dFlHODNxdzdkZS9QV1Z5aWVv?=
 =?utf-8?B?c2QrSmdpYjNlZVdETjd2NllKWGdzUVQ3NkxrVWtCVlhZc1paTU1MazJ0a0ta?=
 =?utf-8?B?dGJsUjZ0eEFEWGdzVXVJNVJ6TlhadkVPTW5id3paUDd2SHpoRmJGVmM5Mmcw?=
 =?utf-8?B?SmpmWkNiRDhDYTBxS3loUzBsaE9zZEEva0Zmb28vMjZXRWRvbEZJTXFsT1lp?=
 =?utf-8?B?VzBhTXNQdzlQeng3bm0rLzhibktRRkplVXNFMEJ3M0VqMFNTSE5oaXh0NTdh?=
 =?utf-8?B?bjJEeGZWbE1RenN3ZVFLTGUvOHlaUG90UmRWcVlCWkxaQ2FvZU1WT092aHNu?=
 =?utf-8?B?bDc5M2xBZkJSMk5hV2pIK215TDhwQ0JjT2dCZFM4V01hMnY0RHVBRmxKS1NY?=
 =?utf-8?B?NUV5REZ6YzJ0cEovQVY4Um1LNTZWMWtmeWdmbTBPUWkxQWhZS1JWQ3VGaFZV?=
 =?utf-8?B?RmgzTmw1YWlKa3crOEJUckR4TldpUnlzdWhQMDlobC9SUmdoMU5pYmk2ZHdt?=
 =?utf-8?B?R2VRVGNJUmJXZGNIV0FiMlpUeVVpYnRQd0hvNld0TGxyL3RuS0FiWVJGTy9R?=
 =?utf-8?B?ajRVVDR3c1VaVGJzWnVLZVd6THUvbXF0dlIzNjJBdDZ6ZDlwY3poT0RoRE91?=
 =?utf-8?B?bVZnSEMxZ2Y4RWlXd2xMMGZsWU9ISTlnWGdlaTJqVGoyaUVyT0RTQkl3NWtC?=
 =?utf-8?B?OWpVWHlubStjTmVtaTRTN1BmL05nR2Q5ZUEwS2pPNnNJajgxMTFHcTZQRlI0?=
 =?utf-8?B?QlVDczdOVXcyOVJVTHRxUEZJcWFZemZkQmJiblJtU1JtK3hvaHY2Yi85alNM?=
 =?utf-8?B?Mkw2RFJHK2lvWGs0MUlEdkhwMGo4aG9Dc2x5NlQxNjdyNkx6bis3b0xReTBv?=
 =?utf-8?B?L0wyYWFIS3lXZS83bG9EdW1yOVBvdXBKbTFpWWNWYUpHWEE2UW9ZZXZ0d3Uw?=
 =?utf-8?B?MGdXNHVndjJUMk9FMnpUMjlnc0FkSTBiL1VPK2ExbkhQWG9aK2UwRnA5ODRG?=
 =?utf-8?B?Tkg5RW5wUGo0VWM4Y3hrTC9JQUlHeEhIRHY5L1dDZWVqWUVBSVNVRHhtRitV?=
 =?utf-8?B?WHIvUE1yZFpST09sSFF1S3psSmRuVHdVbDhTalcxd3NoSVRwdFpoZ2JuTnBw?=
 =?utf-8?B?RDRsUlBMMEZqWCtoSEhucTVKa1ZXYzJqQlAwSkZNQXJaVGhpazJQUjdraGhi?=
 =?utf-8?B?ZDUvMUUxbWlEeUFFU0hHM2RuR2swOWtBSk9jRnlCWkd4WmFhV2NkNjJPcWtu?=
 =?utf-8?B?MmxBaG5TOUg5bndsUjN0bmNtTlZaU29EWTc0S1pNbjVjcTlQU2w5WkNaTUxK?=
 =?utf-8?B?c1B0bTU0MUF3SU5sS2tjOEtlblpVN3kvRmZ2b0dDOExmT1VMK2k1cnN2eEtH?=
 =?utf-8?B?N0Zrb25nZlk2YnVWbytSQW1hejE3RmNDaFFySDY5SFZCbWx0SkFUYVV1T1hY?=
 =?utf-8?B?VjUrdmFXdW02eXdDRzZJZjhrNzZvUnNhcDQrODQ4dHU3RktobWlQeGZjYWlO?=
 =?utf-8?Q?tCAhiR61TXTdY=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1719;5:GfOWXFyQ1+PcXO5ETLLmrCvC22T3A77DCq61rQnKivcznmda9D+XSg2uFTw++yOnBPTPiB65JWqe4bDfM+hgscPzYeLO+AZosk6Ojtseci57e+oMER2yN9KQmGw+dGvxXwF1KeY1Yhf0D3I1z5SYaw==;24:7zFRXfgQ8jJExSLEXi34sYkQQK0/AaOjOXaPaoqX//TKKGcRkY+kKx2elw5TehaDywxbXdGbFY3mZEt4pJRE2S5rB6jyTLsPtHDerk4LiGE=;20:iOQ0HJ3H5x6+MFuk5BOe8mYEcIyZm46ek5Xi7haj9Sjnj+RPeFylfvLc0TVwXtUIK0HdjkAFa7PN2bhioDnTKw==
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2015 17:17:07.2114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0701MB1719
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49139
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

On 09/05/2015 01:00 PM, Jon Masters wrote:
> Following up on this thread after finally seeing it...figured I would
> send something just for the archive mainly (we discussed this in person
> recently at a few different events and I think are aligned already).
>
> On 08/07/2015 08:28 PM, Rafael J. Wysocki wrote:
>> Hi David,
>>
>> On Sat, Aug 8, 2015 at 2:11 AM, David Daney <ddaney@caviumnetworks.com> wrote:
>>> On 08/07/2015 05:05 PM, Rafael J. Wysocki wrote:
>>
>> [cut]
>>
>>>>
>>>> It is actually useful to people as far as I can say.
>>>>
>>>> Also, if somebody is going to use properties with ACPI, why whould
>>>> they use a different set of properties with DT?
>
> Generally speaking, if there's a net new thing to handle, there is of
> course no particular problem with using DT as an inspiration, but we
> need to be conscious of the fact that Linux isn't the only Operating
> System that may need to support these bindings, so the correct thing (as
> stated by many of you, and below, and in person also recently - so we
> are aligned) is to get this (the MAC address binding for _DSD in ACPI)
> standardized properly through UEFI where everyone who has a vest OS
> interest beyond Linux can also have their own involvement as well. As
> discussed, that doesn't make it part of ACPI6.0, just a binding.
>
> FWIW I made a decision on the Red Hat end that in our guidelines to
> partners for ARM RHEL(SA - Server for ARM) builds we would not generally
> endorse any use of _DSD, with the exception of the MAC address binding
> being discussed here. In that case, I realized I had not been fully
> prescriptive enough with the vendors building early hw in that I should
> have realized this would happen and have required that they do this the
> right way. MAC IP should be more sophisticated such that it can handle
> being reset even after the firmware has loaded its MAC address(es).
> Platform flash storage separate from UEFI variable storage (which is
> being abused to contain too much now that DXE drivers then load into the
> ACPI tables prior to exiting Boot Services, etc.) should contain the
> actual MAC address(es), as it is done on other arches, and it should not
> be necessary to communicate this via ACPI tables to begin with (that's a
> cost saving embedded concept that should not happen on server systems in
> the general case). I have already had several unannounced future designs
> adjusted in light of this _DSD usage.
>
> In the case of providing MAC address information (only) by _DSD, I
> connected the initial ARMv8 SoC silicon vendors who needed to use such a
> hack to ensure they were using the same properties, and will followup
> off list to ensure Cavium are looped into that. But, we do need to get
> the _DSD property for MAC address provision standardized through UEFI
> properly as an official binding rather than just a link on the website,
> and then we need to be extremely careful not to grow any further
> dependence upon _DSD elsewhere. Generally, if you're using that approach
> on a server system (other than for this MAC case), your firmware or
> design (or both) need to be modified to not use _DSD.

I think we need to be cognizant of the fact that ARMv8 SoCs do contain, 
and in the future will still contain, many different hardware bus 
interface devices.  These include I2C, MDIO, GPIO, xMII (x in {,SG,RGM, 
etc} network MAC interfaces).  In the context of network interfaces 
these are often used in conjunction with stand-alone PHY devices.

A network driver on such a system must know several things that cannot 
be probed, and thus must be communicated by the firmware:

  - PHY type/model-number.

  - PHY management channel (MDIO/I2C + management bus address)

  - PHY interrupt connection, if any, (Often a GPIO pin).

  - SFP eeprom location (Which I2C bus is it on).

On x86 systems, all those things were placed on a PCI NIC, and the 
configuration could be identified in a stand alone manner by the NIC 
driver, so everything was simple.

For SoC based systems, I don't see a better alternative than to expose 
the topology via firmware tables.  In the case of OF device-tree, this 
is done in a standard manner with "phy-handle" and "interrupts" 
properties utilizing phandle links to traverse branches of the device tree.

I am not an ACPI guru, so I don't know for certain the best way to 
express this in ACPI, but it seems like _DSD may have to be involved.

David Daney
