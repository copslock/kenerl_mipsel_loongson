Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 21:07:34 +0100 (CET)
Received: from mail-by2on0058.outbound.protection.outlook.com ([207.46.100.58]:20335
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012112AbcBJUHcBrJCa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Feb 2016 21:07:32 +0100
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from dl.caveonetworks.com (64.2.3.194) by
 DM3PR07MB2138.namprd07.prod.outlook.com (10.164.4.144) with Microsoft SMTP
 Server (TLS) id 15.1.403.16; Wed, 10 Feb 2016 20:07:22 +0000
Message-ID: <56BB9877.9000305@caviumnetworks.com>
Date:   Wed, 10 Feb 2016 12:07:19 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>
CC:     linux-mmc <linux-mmc@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        <Zubair.Kakakhel@imgtec.com>,
        Aleksey Makarov <aleksey.makarov@caviumnetworks.com>,
        Chandrakala Chavva <cchavva@caviumnetworks.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Leonid Rosenboim <lrosenboim@caviumnetworks.com>,
        Peter Swain <pswain@cavium.com>,
        Aaron Williams <aaron.williams@cavium.com>
Subject: Re: [PATCH v5] mmc: OCTEON: Add host driver for OCTEON MMC controller
References: <1455125775-7245-1-git-send-email-matt.redfearn@imgtec.com> <CAPDyKFrMgt9snP2NLbQ6EQ5X7gjQLA+e+TEfqgjzLYTuH+G1OA@mail.gmail.com>
In-Reply-To: <CAPDyKFrMgt9snP2NLbQ6EQ5X7gjQLA+e+TEfqgjzLYTuH+G1OA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: SN1PR0701CA0035.namprd07.prod.outlook.com (25.162.96.45) To
 DM3PR07MB2138.namprd07.prod.outlook.com (25.164.4.144)
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2138;2:nM2ellLy7/LeMiU+3+PF+/PPreWqpYkR5B2pITxNKFdoTbUxfpjcIFSsrP4zSVfO/uyVnyKkTS3xyoEfoeiCR0+L65Ad/1b04bElQEjWljCKxn9+9tt1+h5EODoTcVsAYb95O6p0ELK7a/21prCvnw==;3:dLooLMEhYqNm4vyEfIHADjWaeMTKEGAhvn12Ln+YwMOTZKGwFDXOaVSOjjpIyyCbqWw1eRy+ZPb1zP5B4+UvZXcW3lbk+/OCuES8we/fa05GXHYMUWYN15Zm+fHcfQ2l;25:xkp+CRdQNm0UYT/NZO70l6bQyQTBsN0L1FLGXxyeTjfby+KDrAW6SZMoAgzgto1+68RhQwd/ykXjpQ7ISao6TNbLCesCRU9IdAV18mLcbyq8fp0hbcr1kQcCkMRbo/ycsC5nJ+Ej32PcI6bMzZMOF4p9iZKM3arSZaZb5xNcaQ+iOXW7yorW+SMcOU38gZUr85wE4VXH4KeqBqA0rnwbH2eUp/L+C6xaT6CD5b7RBY+vY+GJUAF3vPMS4zd2TeuzZavAk0NmOlD98wh4lpITroJxT/9SBYl7AV9IYqFZch4dcaWw/s1RIXDMvAa/hJUf
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:DM3PR07MB2138;
X-MS-Office365-Filtering-Correlation-Id: abafc2ce-5b43-44e0-0211-08d33255ca73
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2138;20:qGa1TlFNrrPotKFXEDGdoSrkj74/oeAlr9e6qJTWJvtiAbZUaA50JMwf12yI5otrjmkNSbedfvA4KO2QTDuD5E4fZWnYa0Uqg4DMF/2RsW7N7XLyr1mRK+fNNGG+ZjmselyYXHNF0NOKDKVm872m/4NTFdJi8eJuETtkgL4j62L7hKwV3sWH9yN6VQ6fTMf4iaMN2m60zwLGOxf7erBz4ZOvuRdNtf2ON5vIvRdMg0lRtYss5lmbv4VLuZbM4YL0prFweXsGQYJSQCzDoahoEYWfVPaHzNeiQ4kzAAqbGnMWkjDkLqvqgYG0Fz/fw+8pLHuV6boZ0oRdccytQkTnIlSncPBVMe9tALXCbBriBOlGK8snl0vQzJDwH9y/AGXDoWWsOBtV/BJd5elxqnESZGDzFVM82J6FGpTSM6gQIQVc20xptHJXNRNMZ4vyRecgsNT7kYk0O9ZSqkG6KqkNQAuzpfCXrbDALPrOR2pf7CQ0fIbP0SorxKqDL2TbzAen2qcLerw9Se3YCyEUHuZaQOfjpVfanbxpSFOHIFCPD2+AdmcxeBeKdPullYds8qKZBGiA3Bl9Zs3Z8E4+9czUi5mGb6/FBhDgQwTvNS89PEU=
X-Microsoft-Antispam-PRVS: <DM3PR07MB2138AA91B09871879834A7EB9AD70@DM3PR07MB2138.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046);SRVR:DM3PR07MB2138;BCL:0;PCL:0;RULEID:;SRVR:DM3PR07MB2138;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2138;4:Mv8qjz0syCmIOACrKKRsTs4muZoYqcw9dtuaOSSz1p9rKekDnpXQBpaDfA4g/P4gpDJLHEKbTgWyGLlgmq23nPntSZAzLHfLq/7crsIV6z/5AYTbDv6P8VLTelkrX2p9pmQTOqAZzfNG/PB0pqiGwD/2e3ssZ4uHMJs5iz4Anc9jLoPRUz5M85mbhKEJA7FnYhY9veXR2IsZP9k448psrXqqG2K3Zw4QeXBDeVORHZGT3/mM9CBtyG5vG3ndMMszMspcJjjxsWJjpWvgBLOC2+gVIu+qEWEqZRXR6bb1wfMp3qpZwmmkybJfZNCjN9itCaozw1Db/6riv82rZiwcdMp7uh3CZP51z+mPViHnS5PrW3sYeFPspRVDeQQSayly
X-Forefront-PRVS: 0848C1A6AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(479174004)(377454003)(24454002)(65816999)(50986999)(2950100001)(76176999)(54356999)(15975445007)(83506001)(122386002)(50466002)(92566002)(40100003)(77096005)(87976001)(4326007)(19580395003)(19580405001)(189998001)(80316001)(586003)(3846002)(23676002)(1096002)(6116002)(47776003)(53416004)(36756003)(64126003)(4001350100001)(5001960100002)(5001770100001)(5008740100001)(65806001)(5004730100002)(33656002)(42186005)(230700001)(65956001)(66066001)(2906002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM3PR07MB2138;H:dl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTNQUjA3TUIyMTM4OzIzOjE0ejgrVFYxNXl6VjRSQkpkbWZKeFRRK2VR?=
 =?utf-8?B?NWpLeWZycG1kaGdiVlFaVWxKMEc2bkxFRmlCNEk1dC9CT0NjcmxtVWoyOTF6?=
 =?utf-8?B?bDNuc2psMUR3bElKSW5FZWY2KzEzS2tnbk9QakdwUEV4aU1XWU9YTllXaTFU?=
 =?utf-8?B?U2NjZWlnYzRIQUVsV0w0RHlDZGJyalh5WjNtenIreUg5OVY1aEp3UThSaXg2?=
 =?utf-8?B?YkI4aEFSTWRqK0M4SEdyTmYyVkp5VFFrdHo1ZXI4VXVPMGtaRDYwcy9ZdE1h?=
 =?utf-8?B?SUNudEV1cmtHQTZOU3hsWWRweFN3dWx1dUpMK0x4d3lKWTY2QUxHMHQwYlh4?=
 =?utf-8?B?ZnlHWFM0ZVhiV1k5RDBodmdKUm1TaHIrU2RwY3FOTzljMjNncTNrWUVkZ0hu?=
 =?utf-8?B?MUlnYkhGSDhHK1g3ZFhmeE9iSkVER3ZZcXl1aTdMSzVOK1lTNmMveU4yQXVz?=
 =?utf-8?B?RFVrQ0ZaSFV6MFNUMVRZcTZKV0NrbUNjSXRJNXo0cXNjdjJ4UE5YR200eWVx?=
 =?utf-8?B?c2F4MnRHcnZNaTMwWUsxMncwZGlOcnVySGRKYmtPSXd4TjJyNTFtWUtwVUpa?=
 =?utf-8?B?eVh3TnFUS2lhMkNVRVB5MUhwRjhURHpoc1FFUjAzOFgwRU5LUDRzWktjQ3B3?=
 =?utf-8?B?UUxHNHZFVWxRRTd2NDVuQlRWdkFONkc1eURyQzU2d21IZzY4M05GYXU3UEpZ?=
 =?utf-8?B?MUVqSlJzM0d4c2p6cXF5R09jODhPb1V0Rm0zWE9MUUpwVVQ4YVM1cmZqbFRr?=
 =?utf-8?B?R1dUWUo1RWJhbFVlbG9sdTRpQ3RCVVYxTDhlbFEvWmdmUTlyL2ZPYW83Vlds?=
 =?utf-8?B?NTZpVVNycU82SUZ0bzFuODVSczhES3B3b0kyMVZEV3Ziay91T2RtQkxXTHZQ?=
 =?utf-8?B?Nnd6QTZreURHdDRsTjFiVElxN3ZPMVFXQzV6VHREUkcrWEFPUTBqYWRseDJZ?=
 =?utf-8?B?Qnc0R1ViL3orTE5mTzJIUTEwRnA3RUU3MGo2WjhycXhveUVFb3hWS2pHYXJU?=
 =?utf-8?B?UkV3QWZXRVgzZEFBeCtsQzJ5SkZuakhiTk82WHVCRzI4Wkk4RHBlMWZjT2hl?=
 =?utf-8?B?VFhRQzRsQ1FtRiswZmk3VmNlOVJuSjJjWXZ5a2Jia3N6Unh4U2ppaWFxYy9U?=
 =?utf-8?B?bzBpeXFOYWlZS05yQlFnZVVmRUJJeEdGRGdyZDVXdkJZeUhpT3hPaU9ibEcv?=
 =?utf-8?B?U3pPSWtyUzNYa3R2SWJaYUpVTks1K21BM0NCUkFYaGppRWgzd294aTFMVVNU?=
 =?utf-8?B?Y1VvUitCM0oxUGxUOHZPWWNDM29NeHArL0Z5SGlIZC9kWEF6WDV2SHFkOEow?=
 =?utf-8?B?cnVJWWFxU3hSR0tMZkd3UTNUTXlsdUJmM2ZRUVVzT09Dd0dDcnBMc09xdUdN?=
 =?utf-8?B?WjMraUZKZk5UdFlhNi9BVUViZk41aHlxcEFUbmxXTTFHbUdkcEJtMUYvZjdI?=
 =?utf-8?B?VndEUFRCdCtoRytYMDIwMDFJTzJaWkZ1ZmRQdUFEQmVqL25zdHRHSGtJZHNT?=
 =?utf-8?B?bW9lLzJyTjF6cU1SSG5RU1BiMjZ6QlErVG9laS9hbjVMRFhLRWUwbDk1WlpW?=
 =?utf-8?Q?eNDmvnLzjqknVXyXaQiDHuWlzsq3UZkPvTo0HFyUpR7s=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2138;5:XDoHB6VUOMW+JfCKH+l4bcXAEfJVaXfkUkwLsEGc6jqJhE6KVQeIp+/pY/an9bMk9FOPBeJg74Ha+QVTqGEfKq6p4irNOAj+XFzoG/NgAqZv85JYg9ys+mp9Vs5fpMGKodkacXHUq9zlta6vPWx8fg==;24:0NmV1wmxwbIhdq2WkK6MiEN5bR2KF8WRPB9b/aoewoMLbOsdgl2DQYvQV9LcrSAheZSxdC/QC5rJsmb3jwUKfJl/jz/10kxtVsVM+SW4DVU=
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2016 20:07:22.4515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR07MB2138
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51979
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

On 02/10/2016 11:01 AM, Ulf Hansson wrote:
> On 10 February 2016 at 18:36, Matt Redfearn <matt.redfearn@imgtec.com> wrote:
>> From: Aleksey Makarov <aleksey.makarov@caviumnetworks.com>
>>
>> The OCTEON MMC controller is currently found on cn61XX and cnf71XX
>> devices.  Device parameters are configured from device tree data.
>>
>> eMMC, MMC and SD devices are supported.
>>
>> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
>> Signed-off-by: Chandrakala Chavva <cchavva@caviumnetworks.com>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
>> Signed-off-by: Leonid Rosenboim <lrosenboim@caviumnetworks.com>
>> Signed-off-by: Peter Swain <pswain@cavium.com>
>> Signed-off-by: Aaron Williams <aaron.williams@cavium.com>
>> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
>> ---
>> v5:
>> Incoroprate comments from review
>> http://patchwork.linux-mips.org/patch/9558/
>> - Use standard <bus-width> property instead of <cavium,bus-max-width>.
>> - Use standard <max-frequency> property instead of <spi-max-frequency>.
>> - Add octeon_mmc_of_parse_legacy function to deal with the above
>>    properties, since many devices have shipped with those properties
>>    embedded in firmware.
>> - Allow the <vmmc-supply> binding in addition to the legacy
>>    <gpios-power>.
>> - Remove the secondary driver for each slot.
>> - Use core gpio cd/wp handling
>
> Seems like you decided to ignore most comments realted to the DT
> bindings from the earlier version.
> Although, let's discuss this one more time.

I think you may have misread the patch.  The DT bindings have been
changed based on the feedback we received on v4.

>
> Therefore I recomend you to split this patch. DT documentation should
> be a separate patch preceeding the actual mmc driver patch.

You may have missed it the first time it was posted, but the legacy DT
bindings have been around for a while.

See:

https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-May/015482.html


> The DT patch needs to be acked by the DT maintainers.

The legacy DT has been deployed in firmware for several years now.  We
are adding more "modern" bindings, and the DT maintainers are
encouraged to review that portion, but the legacy is what it is and it
isn't changing.

>
> Until we somewhat agreed on the DT parts, I am going to defer the
> in-depth review of the driver code as I have limited bandwidth.
>

As I stated above, the legacy DT bindings are not changing and must be
supported.  Waiting for legacy DT bindings to change is equivalent to
infinite deferral.

> Does that make sense to you?
>

I understand why you would say this.  However, I think it doesn't
fully take into account the need to support devices that have already
been deployed.

That said, Matt really needs to get the DT maintainers reviewing the new 
DT bindings.


David Daney
