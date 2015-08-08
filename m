Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Aug 2015 02:12:15 +0200 (CEST)
Received: from mail-bl2on0067.outbound.protection.outlook.com ([65.55.169.67]:11396
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012768AbbHHAMNhcmEV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 8 Aug 2015 02:12:13 +0200
Received: from BN3PR0701MB1719.namprd07.prod.outlook.com (10.163.39.18) by
 BN3PR0701MB1622.namprd07.prod.outlook.com (10.163.39.13) with Microsoft SMTP
 Server (TLS) id 15.1.225.19; Sat, 8 Aug 2015 00:12:05 +0000
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@caviumnetworks.com; 
Received: from dl.caveonetworks.com (64.2.3.194) by
 BN3PR0701MB1719.namprd07.prod.outlook.com (10.163.39.18) with Microsoft SMTP
 Server (TLS) id 15.1.225.19; Sat, 8 Aug 2015 00:12:01 +0000
Message-ID: <55C5494D.5010903@caviumnetworks.com>
Date:   Fri, 7 Aug 2015 17:11:57 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        David Daney <ddaney.cavm@gmail.com>,
        "grant.likely@linaro.org" <grant.likely@linaro.org>,
        "rob.herring@linaro.org" <rob.herring@linaro.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        "Tomasz Nowicki" <tomasz.nowicki@linaro.org>,
        Robert Richter <rrichter@cavium.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Sunil Goutham <sgoutham@cavium.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <deviectree@vger.kernel.org>
Subject: Re: [PATCH 2/2] net, thunder, bgx: Add support for ACPI binding.
References: <1438907590-29649-1-git-send-email-ddaney.cavm@gmail.com> <1438907590-29649-3-git-send-email-ddaney.cavm@gmail.com> <20150807140106.GE7646@leverpostej> <55C4ECC6.7050908@caviumnetworks.com> <20150807175127.GB12013@leverpostej> <CAJZ5v0gc=bo3ayO7aWq19Hh_205YC52wqXGbbM5vxR1atXm+oA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gc=bo3ayO7aWq19Hh_205YC52wqXGbbM5vxR1atXm+oA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: BLUPR07CA0108.namprd07.prod.outlook.com (10.255.223.179) To
 BN3PR0701MB1719.namprd07.prod.outlook.com (25.163.39.18)
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1719;2:gL9Flvi9Ar/hDzUBzF2/8yESKn9V9wdPRYTOzed9RXiQXZ9vwCkbGp7lkh5zqoAn4OM9TCRxnkOjTOx6Z9TWxAMdO6JRHaFvKDKKJE8QMxd7PJ3SEGrOEHLAfQNnWqEcViDkNcxlVMJFSLsoNEUkkBKAS4WFpMPOdN8ClmWejkw=;3:74Y5XNuKdGJykd624mvL6qWjXI6W+zX60LIBuftRml1JZiMybFDP9I2ChNfptmdAD55Q60Wf8sopjlIm6l0OntIU1QDB7+XddnWRFveVJGUyDVaIWuQ26hb40qRGP6MjsA9d09ZpI5E3C84GYl+Mjg==;25:srQsWUVjNPs0HBKblEFMz2XjQjBbv4kgmWfwCd2onCwNy+kBq2W6++ksoW2AEk43fbWxk/BubJJlzMikdOGtvvoaafFFc+refH39B5rhB+Pd26RhMmO7YMCqiLKVtpEzT4fTuRv60xhfG9Op5Sp/f2BKG1Am7X9vlTopjG+DS7fv89qISF6LcWZ2nwU5yHSqFjJDvRrSpMCMw9B6KrHXfYsr4jGfuOJnEUU23v3LYu38br7naaamAY4itZPfJdg6Re/ehITHTxnJym/shvmL5Q==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1719;UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1622;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1719;20:ERKXTJ0XBgqP+P1lPVBBnGm+4bskLg6NzxaV6O51nWrcEti84MAKydNbHIk6a6QLocwXhlEq1sNpyH+bSVNetfYZbxWz1Otpl89i7vUGLQqj/gFcVQ3bKksrmBCfA64YrVKH+HBcH6UMR+4WkRQo39JO5P5nOkuCqeALE5YmcmaJhJNuO03H4KeSKJ8jckRh2+Tfz6RQ5kU/QMRsLfKXXNU0QD3AmNCkcN7JPdo8IjxCXYQpTkCB/4IlJZqjIbx2/VID1adzg0KjqPKy42DjJRLUK01VRtxxijBlEmYozwJ40TAtTgHD2bo+DsenIrjbPq4LErehogbPYIRuIpMTJnfj6ujoAsyiWlks31Iwkv74jB9+7OGQgAfySXVNnRCQdT13Vyl3Xr1W2ZgE2AKY41RdmTOJXr6JHRONN4WS2qyQ8fMaBLMRplDGvuGfwOIlkAUSzC/+Oq7E9sQagKfspLXDulgKKhoHJ6skSzfrZgiNy+w2+QdMhqexDfm3ZSOOtsLnOHAfLcZ3b8GThHr1shY3cpwkOkYXdWypfoIzNV8DYcHKCJOqKiBCTURYO96oblg1hAV0Ne+IRNNuOPha4ERLsWJWY0p1YXXVb+MD/sg=;4:EEqsnz9jwBg22Jj9p/B4bheV4pDkrWsn0Sah8aqpUjTr4n505pesPNPXmKlAF31ZKexQRl6yQVUVimA46dDQoYwuYdnC36mDfau3IpccRpcmk5ZVU5hCwqq3XTnaMt5zGAymrRJwUC87/fNUTbH2q0uRrq6LV9Li5icGPuSMwiDy291QiTQtpjwIZs0M17NcaCwZoFNkWQOqX+ba/pNlMPb6RqAST4p2375OtcA45e3mzdEp3+4FT5kbB6YBoNSdDgkmXIPWXvxXujPI0hFWTvqxkT0+QyQ2HrP6dJYWpMQ=
X-Microsoft-Antispam-PRVS: <BN3PR0701MB1719FF78AB8C60D2486CBE2D9A720@BN3PR0701MB1719.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(5005006)(3002001);SRVR:BN3PR0701MB1719;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1719;
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(24454002)(243025005)(377454003)(164054003)(189002)(199003)(479174004)(87266999)(101416001)(54356999)(50986999)(76176999)(5001960100002)(23676002)(77156002)(15975445007)(69596002)(40100003)(122386002)(65956001)(92566002)(68736005)(47776003)(64706001)(83506001)(5001830100001)(65816999)(2950100001)(33656002)(5001860100001)(65806001)(64126003)(66066001)(93886004)(110136002)(81156007)(4001540100001)(19580395003)(97736004)(189998001)(62966003)(53416004)(42186005)(46102003)(50466002)(80316001)(77096005)(36756003)(105586002)(4001350100001)(19580405001)(106356001)(59896002)(87976001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0701MB1719;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjNQUjA3MDFNQjE3MTk7MjM6bXJsYjVYMmZOeDhVUThWczZqdmg4RHFz?=
 =?utf-8?B?OGRDVkJvakhPRVJLS0pZdGFYbnQvanptR1VwTWlhd2FzSXJUWG9qQ1JJcEhS?=
 =?utf-8?B?bWlqU1dlYnNBcURzbW1KL2dQTTN0Nm41K3ZOVVk1UEZFS0hwbjhaRnJRbjRv?=
 =?utf-8?B?MllucURZWmtZWitrZnRvWHNNK1Vpalc0WUkyODZ2WFA4bnZDaVNJL0hqWHZy?=
 =?utf-8?B?dmcwbzBPakFZTnJUUnJIS1ZMZSt6SUJTcE1LNFF2Tkp2cmJmS1ZtcUlxY0lC?=
 =?utf-8?B?RG1sNi9wNGxpU1N0N292SHgzRWpKQldESks5cnlDZjdHWmk1ODZva2tyazVv?=
 =?utf-8?B?Zmozc2F3Q3cxNEpmZkt5R0JHemNuNEVpRW8rY3RMSDJLVDVGOXNYRm5iZ3dz?=
 =?utf-8?B?b1hkSnRMRi9GbFRGUjQvdFlMMXh0V2Z3OVFCeGE0SGVGN0JEN0pZekN3QTVV?=
 =?utf-8?B?Ly9lTitHT2NGWWs0MUZFVFBCQXdNY3Vic0lTRGxCTmNZVWl2R25CeXBZaUpW?=
 =?utf-8?B?QlFqU0xGclhXeTdENk5xOGZlVHN1ZjJVa3lMTUNObnVacTY1L2hXZFozbUUw?=
 =?utf-8?B?WkRjd3l1M25WanlOTEdkQ2pGU1JFS2ZJUFFLV01zemdkbWxHdzR5Z1RwbE13?=
 =?utf-8?B?cFZGMm5jWTRwaHlRVmxqT1F2QktFb1o1bDlHMlRGTUJ6dUxOTE1XVFkwUmdu?=
 =?utf-8?B?V21HUTFKeXhma1RFUnJIOWRpZlpYV1VLNEtzVld0THFjdE9DR2hJYytsMkdV?=
 =?utf-8?B?WG5Ia3I2Zzc4Z1RTaVZ3Lzl0K0JOQ1I0NzVGdC9QRzExbkhNN2NlRXlsUFRY?=
 =?utf-8?B?TUVCK1ZBNjY5RnIrRC8rT3daajhid1NRNmVkR1V4S1lMb3Q2SnJJRFZXRTVM?=
 =?utf-8?B?N3NJZmNweWdzVlhQdW1zZXhoTlBqa3RKYnY0VmdacVpPdjVxMkNRa2lYaXQw?=
 =?utf-8?B?VkliZGN0M3VoeDdIZHNWSUJHeEZ2enFsdVlnMXgxRlJuekllVktJcTBoK0J4?=
 =?utf-8?B?NE5rajF0bmFYODM3RHdYdFlMNm1RSHdrUkNmOUFYNm05d0RJZ3hkdldIS1Nt?=
 =?utf-8?B?TThXM3k0WVJMU3RaTnNnYWVVakJMVjZDL0psSTMybTZ2ZFFzbG91N3dHbDBz?=
 =?utf-8?B?WWxJTkQ0Sm5qVWdIZUdlRjQ5OWEydWxSR0VraFNOMkM2RmFEM003V2xiZllP?=
 =?utf-8?B?NHdackxXNGUzK3hvQ2ZsaEhzZjJyNGp3Q09iZ2tzbUsrcTRZYVUrUVdqbms4?=
 =?utf-8?B?VWdwcThFS25WMmVuQzdadnFVdjdtOWRDUlJ3OTBXOS92T3VSRmNROGozQStq?=
 =?utf-8?B?MllZamdCeXN4YjhSbGtUcGZNZXFBdUZuZUVXOVg1Q21wbWdRa09yaHUwVHBx?=
 =?utf-8?B?M3pob0pUQ2Z5dW5mYnJQNmhiL0JOOVFnRWJxWFpxNnZ2Mk9ZU1BHZFdHdm5R?=
 =?utf-8?B?WXpQY3p4RFhOYzZJS2t4Sml4RnYwcjRQVnZMZ3ZqTHpQWk5xaDhxcEhnOFlv?=
 =?utf-8?B?bEwyN3hKb0V6aUFMY1IrNklOdXFpb1VoQWpPQWtnM1F6WjhrSVpaTzE1dlVW?=
 =?utf-8?B?SGhGSi96azRxYjhHRGZSYW8zbWpWcUFVNzYzRm8vTDU4djNOelBMQVltR1d0?=
 =?utf-8?B?bGxLYnBXN1hNM3dMaVNadytwQ255TGVqd2JIUTFadzJ6Ni91M3FtY2t6WUJ5?=
 =?utf-8?B?TnlGSGMzdFRrVnM2ZUtPcmFTeVFiV2xjTDdFejZ5K0VyUERTNjViakxFdTEv?=
 =?utf-8?B?L2NSQVlldlVaR2JCdXZLTWI4VVIrcHByUE9FenBxa0NFM2JSTjczMHZwR2Nu?=
 =?utf-8?B?ZXRTN2NtTkhmcGRURzNqcUZpWVE0dXV2U0Ywa0p0TDA1OXRkL3h4cEZkOVlI?=
 =?utf-8?Q?tEkUDcXi4w30Akd0sCN/dx0DY2eZxC9MqZ?=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1719;5:ldG9xueNIFKSoZkJf0UEMJxRd5+cm9euVl83x+1Us4dCI76aC8hRMHGXN6weg8+l8VQalUrYzcetrbH8wh6LzHd6qhL+DqOVviBA6H10uLsNRy9pznAgwnxQE2lf702ZDCPxeDEwIdIBJz6HAUFHhQ==;24:53KwcV5yGR7sUGOX1ehYqSeXgdCk8weNP/m+khm8gO51Uz3hQ/uSTqNY6KsjnC0GMM5raSIEBHItM6XVyJzQUCARNYs6Fq8+9Z/SVHdQ2QE=;20:dIQVUpM9AOh9vCYOLiErQHPZt9UiNZHrZx+cRQ+xtsPUG4eSUU4CW5BfpheKNWxPeckCxIDONOJYMoia6zTMlw==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2015 00:12:01.2601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0701MB1719
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1622;2:BDupwMi//m3S8uiJV4O5TTYm6aAl2U/6cnQRubBPLAD8Nvh1jsXD8lQ7UNY5APtH0GW51j0lFDYixCTmicEQkNy7GhlSjDxGdx6V27/GrkkP0VDBybOCF7DFpgEEumf5dSBk/HSzGjEeLt/8X7tjjk1LqJNURVIxivFhTSzGBeA=;3:Qj8ohOROQMDdv4LordYEwRwa0SMTwr73p8ZQMrEIN/6lqj3Qfo3aBxC3fe1WqOJjNIvl4vQnMimrK3JVE8hNqrfj60Vujs7q7VL4+lmbYlL7i9z3/+KtFQ4wQ2LtcMQQOd2fbcPuLFnjbI1FlSSUzA==;25:fGt7rbGm1ze4kapkt815CL+DbpGluF61x2lHJay9eUdrJRnsgNddWa8AMLfoHDLVhgP5IqNN4vKx2JcgavwPMmQUa4XhjKSSDeL4FCX5XZFdDweZmUaFEMjC1mvkiVm/gowwv3d2Fkf9pk0Xr/vmFbqIl4+MRCo6aX1N0vrHQI2Vn6soV6tS+fiEMVN4mplk3hifdttWa4p3T3UnLEGVof4y/rDbWXo1EoXab+L57Jw5mveTpYrTHY0vZt5B14SubRGx2o/VlKlLWSUb9Z4RFA==;23:2vl0bZhkllwBxZm0qi/88cmg1WFJB86zWuHCl2WBEtZc7M9Fph1xP7IuR/CTC4Q3gWTVML+OQoVFkzsUSYRaH3h4B9gTxFXLwK7BJHvg6blB77TkeCRtUpQA0ouCsGL5CeBqLhPbt6r3Cu3alnolF+gme6Cc7Q5h71u6NlQkdmAzOb1ezpGqvM2BvbWGhQUMG2bnRa13CsZNZbkW8n+QUbWQXMOZxmK/B6Gy7/KazCrJ0hAcH6gIak7XfeqNVklp
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48731
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

On 08/07/2015 05:05 PM, Rafael J. Wysocki wrote:
> Hi Mark,
>
> On Fri, Aug 7, 2015 at 7:51 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> [Correcting the devicetree list address, which I typo'd in my original
>> reply]
>>
>>>>> +static const char * const addr_propnames[] = {
>>>>> +  "mac-address",
>>>>> +  "local-mac-address",
>>>>> +  "address",
>>>>> +};
>>>>
>>>> If these are going to be generally necessary, then we should get them
>>>> adopted as standardised _DSD properties (ideally just one of them).
>>>
>>> As far as I can tell, and please correct me if I am wrong, ACPI-6.0
>>> doesn't contemplate MAC addresses.
>>>
>>> Today we are using "mac-address", which is an Integer containing the MAC
>>> address in its lowest order 48 bits in Little-Endian byte order.
>>>
>>> The hardware and ACPI tables are here today, and we would like to
>>> support it.  If some future ACPI specification specifies a standard way
>>> to do this, we will probably adapt the code to do this in a standard manner.
>>>
>>>
>>>>
>>>> [...]
>>>>
>>>>> +static acpi_status bgx_acpi_register_phy(acpi_handle handle,
>>>>> +                                   u32 lvl, void *context, void **rv)
>>>>> +{
>>>>> +  struct acpi_reference_args args;
>>>>> +  const union acpi_object *prop;
>>>>> +  struct bgx *bgx = context;
>>>>> +  struct acpi_device *adev;
>>>>> +  struct device *phy_dev;
>>>>> +  u32 phy_id;
>>>>> +
>>>>> +  if (acpi_bus_get_device(handle, &adev))
>>>>> +          goto out;
>>>>> +
>>>>> +  SET_NETDEV_DEV(&bgx->lmac[bgx->lmac_count].netdev, &bgx->pdev->dev);
>>>>> +
>>>>> +  acpi_get_mac_address(adev, bgx->lmac[bgx->lmac_count].mac);
>>>>> +
>>>>> +  bgx->lmac[bgx->lmac_count].lmacid = bgx->lmac_count;
>>>>> +
>>>>> +  if (acpi_dev_get_property_reference(adev, "phy-handle", 0, &args))
>>>>> +          goto out;
>>>>> +
>>>>> +  if (acpi_dev_get_property(args.adev, "phy-channel", ACPI_TYPE_INTEGER, &prop))
>>>>> +          goto out;
>>>>
>>>> Likewise for any inter-device properties, so that we can actually handle
>>>> them in a generic fashion, and avoid / learn from the mistakes we've
>>>> already handled with DT.
>>>
>>> This is the fallacy of the ACPI is superior to DT argument.  The
>>> specification of PHY topology and MAC addresses is well standardized in
>>> DT, there is no question about what the proper way to specify it is.
>>> Under ACPI, it is the Wild West, there is no specification, so each
>>> system design is forced to invent something, and everybody comes up with
>>> an incompatible implementation.
>>
>> Indeed.
>>
>> If ACPI is going to handle it, it should handle it properly. I really
>> don't see the point in bodging properties together in a less standard
>> manner than DT, especially for inter-device relationships.
>>
>> Doing so is painful for _everyone_, and it's extremely unlikely that
>> other ACPI-aware OSs will actually support these custom descriptions,
>> making this Linux-specific, and breaking the rationale for using ACPI in
>> the first place -- a standard that says "just do non-standard stuff" is
>> not a usable standard.
>>
>> For intra-device properties, we should standardise what we can, but
>> vendor-specific stuff is ok -- this can be self-contained within a
>> driver.
>>
>> For inter-device relationships ACPI _must_ gain a better model of
>> componentised devices. It's simply unworkable otherwise, and as you
>> point out it's fallacious to say that because ACPI is being used that
>> something is magically industry standard, portable, etc.
>>
>> This is not your problem in particular; the entire handling of _DSD so
>> far is a joke IMO.
>
> It is actually useful to people as far as I can say.
>
> Also, if somebody is going to use properties with ACPI, why whould
> they use a different set of properties with DT?
>
> Wouldn't it be more reasonable to use the same set in both cases?

Yes, but there is still quite a bit of leeway to screw things up.


FWIW:  http://www.uefi.org/sites/default/files/resources/nic-request-v2.pdf

This actually seems to have been adopted by the UEFI people as a
"Standard", I am not sure where a record of this is kept though.

So, we are changing our firmware to use this standard (which is quite
similar the the DT with respect to MAC addresses).

Thanks,
David Daney
