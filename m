Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Nov 2017 00:05:16 +0100 (CET)
Received: from mail-sn1nam02on0041.outbound.protection.outlook.com ([104.47.36.41]:13776
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990490AbdK2XFJ1GN83 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Nov 2017 00:05:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=j3nYMxNNhnSYynoQaT8yaDaBFziu3Hb2zjUejOffGYY=;
 b=QMyqgP7tUpDZHRIsq1nBPZMN639XhjGnmj6BEZTSj71gRL2Xjx9ZEqIKB6V2WVHHUTw74GRoW2t5FMM2L9Z2XXqIhER0TtSYS0tx7xEOt5pgrAvzrH/JQWn5r2nMBQkh+sGSaKIcG+6LVJla3u/FEFii/oPiMq4pYI1zbLb/uTo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 BN6PR07MB3492.namprd07.prod.outlook.com (10.161.153.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.260.4; Wed, 29 Nov 2017 23:04:56 +0000
Subject: Re: [PATCH v4 7/8] netdev: octeon-ethernet: Add Cavium Octeon III
 support.
To:     Andrew Lunn <andrew@lunn.ch>, David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Carlos Munoz <cmunoz@cavium.com>
References: <20171129005540.28829-1-david.daney@cavium.com>
 <20171129005540.28829-8-david.daney@cavium.com>
 <20171129225609.GE1706@lunn.ch>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <d7fadd2f-3478-6db4-2c57-e6f441631ee2@caviumnetworks.com>
Date:   Wed, 29 Nov 2017 15:04:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171129225609.GE1706@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BY2PR07CA0025.namprd07.prod.outlook.com (10.166.107.20) To
 BN6PR07MB3492.namprd07.prod.outlook.com (10.161.153.31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b7ec90e-00dd-4348-1579-08d5377d9c88
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603277);SRVR:BN6PR07MB3492;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3492;3:MbJi5N1Ecrfbnf6n7ss9Vc4PikauN0TOSL5jMSSG+p265eCClrzqKISByDYVOiqmH8wM4D53YqqsSEHXYsGZeMJAiklW+hTquOgZR3Vk+ewXyI6bby95Wronfv2TwL/RHLmbEXOqyAjKR1CNOttQQ3blCaScapa3WyVuFnkcrlGyC1R3mqRhwu9KDcROpjU2FOg0tPAikbPA/vn8e48U/BqGBsq4ZvufDYGI+UzAKYe4B1NUKW1ausmGnjQ7CZzZ;25:5lNzWya7Azy2XEUX4lEkrZ8W83kCS8fVt/nkclPwMLX9VfVujcmwOeDGD+OYfqf5ECET9Nd3pCzpeHbViy8fTdv5La8PjZOM/U/NBqX/z4u0Vpt4LOFf9IIIA50ldaSySegCe6lTdUxOp5SJ9jJOYtH7dP1PnqniOwCisALOWEXUJ6sFNHEMjq9Jj+wtANqVFVZuhKytuwVT6l1GxlGREvmV8LnnKSzigakJscYXyLoQVNuSBkYq0TKLh7vwGVt6u8QbFR2OmdIcumjGPVPNW0m1gh1nJeyCiVojauyBr8pee4ASn9o6xhR5DHOFrB9E7WoGXRBPoC5hNgrMQCBq0Q==;31:CTwhkITSifkT44dzWZOq9DErxcFAloXEv/Hv6+m4IQvlwsDBbMzWbAr6thjFmGINFpvBi5RgCS64xpaK/cMn1o4wPqrnCTe3pPGs3ebNBmblZQEh1QNOcTTlBtQAIOhsiLa7w7ZlLLNkibNkeIXTSkuEePoXhn8nK/JsUMTYuGsJYN+2/Fv4Ib7kHDS83yRkH9uTTZyUm9Df7dvgZ+gmR8+uUPEjBprGpG6NHIuQwKw=
X-MS-TrafficTypeDiagnostic: BN6PR07MB3492:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3492;20:b+mM6BT2BRC0gURNe2XuZIXnjtKMB0Z2TA/+jyRq2d1LRQvGVuyDYTdQd4iMqpq5D+8DnIk13Luk2D+dYGQdKBzE8HYa8f8ReF/1mXkkcuMGdmGIgx2QXFez8XkQGrxU/vq2xF4roeuTSIJWI+6/ec/Vt0eywhFWMfxOD6Wlja/dOea0vpFgLWUMRGQjXfFlo9Uk4Tk1gSBiGoOhLvXveIYda3wADgkjPB6HArATJLUGsXRkqvsgRlj7t+1msotOESf+DT9F+fiO0pKjKoKCkeWmU8Hv8QBE3AVnOIEqFMJmbzmAuRG/K7WX0NfCrWqlvjE5h6WXPhmnCp/C2rqnJ8RaOkhOJd58G9vLktOhGm+x0OzQGH243mGCMmpa2a9XuvtgdonWCcv+EszVBVYfBwUqw4660U36/B05jE7XaSJBVUK2g17XGWX4OvggPmGYDRVjGCLI3gOYRrvK96B7qhv8d92D+dCRG84+4ROyKMiv5qMydG1cy8vsoxCM6ESPN/nLIVzEgwGa/5G+tCHVwpjnwjg74eQqAYoMRxxT/XmUGefI7BB0alyN7HCnRbA4D4Phy2mBNMqtPW8q2Rtc0eY80Ur26ad6MkI+yha+424=;4:A3FhnytmqwXku0v0T3cTxKzpwAyJnlA2eCcNgbXE9pLicUVd/T6xqkFb+KnRGmOnEslAGHdQo4OmjF0nlX1UiUcCAU+/pf4OuUNBFxwWpbT1x05VjyABDJWZLXUtC31v/iUbfSa4fhwm3NeobSLheIWRb7uwXw61fXp8X3LMvcvbs5eEtbNZunfkOZN8yIUQO0GhLVRBNNlfYr9jv3Um9fM91h/gnWOENPQEZJbWlmYhzb1zJbnQFCWOhMmajQrNws4aa3ZDqKPPP3kLny3yihwwifPrkXhK9zTvpY8cNIZwZBt1tLapv/eahUBwPTDz
X-Microsoft-Antispam-PRVS: <BN6PR07MB3492548F70DDADA00A0B2BD9973B0@BN6PR07MB3492.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(21532816269658);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(5005006)(8121501046)(3231022)(3002001)(10201501046)(93006095)(6041248)(20161123560025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123562025)(20161123564025)(6072148)(201708071742011);SRVR:BN6PR07MB3492;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:BN6PR07MB3492;
X-Forefront-PRVS: 05066DEDBB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(366004)(376002)(346002)(24454002)(199003)(189002)(23676004)(6666003)(25786009)(68736007)(2906002)(5660300001)(33646002)(8936002)(39060400002)(64126003)(65826007)(42882006)(2950100002)(31686004)(36756003)(230700001)(53936002)(105586002)(6512007)(6306002)(6116002)(106356001)(3846002)(110136005)(54356010)(76176010)(50986010)(53546010)(6246003)(101416001)(107886003)(7416002)(83506002)(6486002)(47776003)(65806001)(81156014)(53416004)(81166006)(67846002)(50466002)(65956001)(4326008)(7736002)(66066001)(8676002)(189998001)(305945005)(54906003)(2486003)(72206003)(966005)(6506006)(69596002)(316002)(478600001)(97736004)(16526018)(229853002)(58126008)(52146003)(31696002)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB3492;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjA3TUIzNDkyOzIzOmk4SGxvZGRxTGJzajlZb0RuUHZUMFNKWmF2?=
 =?utf-8?B?MWNpQk8waFUyeUNWSnJ5WkdUNTlndlVXb1VLQS9YR0NyWnUvT0QxTDNLb2tJ?=
 =?utf-8?B?b0ZjdUdwcHcxUW5nbkRCcWtpQjBqQnk4QzVlZ2FGU1pMV011Y0dFZjBGbzRh?=
 =?utf-8?B?SWNQcGJLWXpaQ0RqVE1XRkZLS3Z0UFhncWpPQmFNc2kwMXhuZTJ0SjVjbWdj?=
 =?utf-8?B?Z1RHMVR5SklDWG03RC9aOXJaSW5pU2JIbXRvaVVkTFFpd2duUWp1ZSswcFRB?=
 =?utf-8?B?Z0tkRllRREtVK3ZHWjBVT0FYRHhWdVk0c2JwQzVvR1psSVludnQvUFgzNGtP?=
 =?utf-8?B?NlF6RjUxYUd0S0NNUEFuT2lWRHg1TEx3NlZjUVpUL0FCY2U0MXNzL3RGSjMx?=
 =?utf-8?B?cWJvbFVpT2pBSXJmeS9hcmYraGRTVEc2Tm5tVW9KUDBsbDRNcXh6bjhnNEZ0?=
 =?utf-8?B?WlkvVXNhZnlpcFZtQlcrU29qU01YSWFYcEFlTlNsTWxEZWdGMXVUTWJudmR2?=
 =?utf-8?B?YkIzSEdDbUV0MnF5bXRiZS90NDJONlZNSjgxR2x0alZvd2NjUDM0QXdrbHVX?=
 =?utf-8?B?SWZid3BzTVE4R3g1YTBnLzBFUkJNNFQ1aXVLamNRK2FtNjl3NjBiZzdMeVZI?=
 =?utf-8?B?MEQyMjZaWGphZ2x2bm1LOG5NTFlkdUdIQTc4dHRCL2gzMFhyNzcrUVdpdEw4?=
 =?utf-8?B?YVcvTGpVbDV1ZmVyK2lMSDZLb2hUUkxuWWFmdm5BdzRQM29hQkl1Z1o4VW9r?=
 =?utf-8?B?b1RWdnpFRy9JNjhFeFVTTkZlN1YrVHZRcDNTNEhuam04eDRoTU0vRm1McnI5?=
 =?utf-8?B?alVjMFdZRHBzZkkwSEVOMUFwS2hwWTAvYjlINmFQbnJ6Qjdlemo2cUxqOXZ2?=
 =?utf-8?B?L2l3ckxTaTJGZU55TTRUcGFrVDlabXdWV3BmQ3d1cTZ6N2NFQ3JaTlpQVlgz?=
 =?utf-8?B?MHVPVHZUV2VmUW5BRE4vZ2VndmhPdzdQR1RFbTVTSjV3RjRKY3dHVnNhN0hj?=
 =?utf-8?B?RTBaNnlOVzBReFlrQUo0OW1VdDUwSUtCK0hPNnY4ZmoyMGpaS1JLN1ZyOUN2?=
 =?utf-8?B?THpvY0RGMmVRRGtPclNEK2NsdThyWEJtdURoZERPbElBM0xTRUIzL0g2UGJ6?=
 =?utf-8?B?WGdTWXZXaDBJWUVDeGhxZ3k3Zk82ZzRhNnd2UDNSeE9mSW5hMURPMkdtVVpT?=
 =?utf-8?B?QmpFQm53UnhBUi9UZ1IwZzN1dXk2SXJ4QXB0eEFpZTRmRGlWcWpBVXlGRTFh?=
 =?utf-8?B?NGdBMHdXaDVXc0RQYUFvemZTaWV2diswWkNEbzJhRzF1R3VnQVpwWkVoUmRk?=
 =?utf-8?B?NHl5WWNCNFhGODh3RjRUTHhqV1BKM2gxckxSUlVlWm03T3R1WDVVSzN2WW9Z?=
 =?utf-8?B?Vkt3Wk1oMEFXTXNBdmw3d0hxcjJyUjZTY0xxSnI4L2xwQWR4R0F6cG9lLzNG?=
 =?utf-8?B?SUU0OHIyUmI1VG1zSlNGSmZFbk90aWhYbm1LSWFyK3Zwam5ibXAzcGo0aGRU?=
 =?utf-8?B?MUMyVVd6dXV5UmM0bWtaeVluWDFUN2EyWC91VmM2MUVuNWpmQUlnSU9ZYzVF?=
 =?utf-8?B?NlZ5RWpRaUdtdTBKN0lza2xYeWY1ZEkvdkIwWFplZktoaTRIellZbTduTlJQ?=
 =?utf-8?B?Y2krOHBPdUJFV3o2d2U0bEsrdFByWG96eEV1d05tS2FrMjNHVmhIWDBYd1d4?=
 =?utf-8?B?Wm1NYXVwdno2YWV5bEFrcmhPeWcya01aNndFTW5pSUhrUk9hUjJ3d3FkL3lm?=
 =?utf-8?B?d1VWNGorTXJCNy9tQjYrV1JleFVCTmdhejZKMGorY0p0aTBNTWdZNzhRRW1B?=
 =?utf-8?B?eTRaTlpCU1RYRU1vUWJHNXVlNThBZ0tYcEdYZGJyMFpYRlJPT0dFK2M4c2dz?=
 =?utf-8?B?OThvQkpLVnFobko3a1Q1NHN5TzJiSjYvL1JJbVI1K1pJcWlTV1V1K29PaW1k?=
 =?utf-8?B?aGZEdTRKZFNlU21maTJBZFpQN3hmSjB2TGIvRVdLVXJkamVkcjJQYko1YWhC?=
 =?utf-8?B?SStZSy9zVjB2ZlJ4bTVINUU5Mk5zM29LVVRUcTFLWGJscXJtSW5ZVHFLd2xQ?=
 =?utf-8?B?Vkpyc1F6V0RtbDhpRVNnUG90ci9VV0FoUU95UjB3bEkrWUR6enVZTjJWaEtY?=
 =?utf-8?Q?8HFd63sMKYpSDEnF2n2r+kY=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3492;6:/AGTLEfd/f1wnBhMr0CiTijqu2eFISTu1UpY/zqUsJBbF8xzjpCQaNirCc8mMxv+V50DWHYmdrDokKAcA5As6v3Z2FXIGX3ejF4057+6OvBPA/TsYqY8Drl7KolVR51k0eTr2eAbvLAX+BFeDdi1ipgxgu9h8d+raJ5CMpktSiEr9BkuPJaHOnPR43ft27bAc3eIeN0He1m4Si+GQN/vrm2R5GWOCq15PZ74kTDDC8P/d2B1A6LLZRGy423Qn3AvOi8cyY5eIP712WxvAMnfHuB/eQ46TeJhwz0w5E+k1Yq2giPco3b/JJ1HuowvQGgIl5h1hMLDBt4Zf6ehfWfk+lPU0ZubJM4HWX2CpWR/AyU=;5:x495Deg8yUgYX2TyNc/ddPdhjLl826tGoZSlW2o0dtdBgNk3zxaMMUHfn0bHQRk/lq0E26LjT53mGmLKMMVDu9wd8xQ1A/KEILG5hafEK34adEGbqIRzpoOhNU/kIIPpV8KLzmE2ztazkihbJSWNpAjQd6krmMqkYmJw2PM0Yro=;24:TwfGo3cvv2Ifast5v0xc9nKukeYp7QzefeJ1DjjHxvr7dZEHbIOpKWf0IX2rgEl6JEx5+8shQG816BMId8b4pshprni1LxO97e2hXqAk30g=;7:WOXxT4YC9ZW0vMPzXEOD4zbX3UCKf0pXESK1S6vbv9ttdlvjP+ktIwWzCPuWzLk5NdqtjSld7rzhnJW9nkmhY6bxXJlpRGxtA6g3G5XSn9uN8l0+P4C2i59lESbR3xTs2fZrV5R7xwTJC5NQp4TKJ6lmEl3bbGRfIBIdCnGDvI2ZGZkmLsM8yIQqlzFq3pRRTox//Kd0mVIaEtwXcwbM4wBGfNKkc9bvN4SDm77VwhdKNtK4iBF6StghbF4A+HJX
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2017 23:04:56.6271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7ec90e-00dd-4348-1579-08d5377d9c88
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB3492
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61230
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

On 11/29/2017 02:56 PM, Andrew Lunn wrote:
> On Tue, Nov 28, 2017 at 04:55:39PM -0800, David Daney wrote:
>> +static int bgx_probe(struct platform_device *pdev)
>> +{
>> +	struct mac_platform_data platform_data;
>> +	const __be32 *reg;
>> +	u32 port;
>> +	u64 addr;
>> +	struct device_node *child;
>> +	struct platform_device *new_dev;
>> +	struct platform_device *pki_dev;
>> +	int numa_node, interface;
>> +	int i;
>> +	int r = 0;
>> +	char id[64];
>> +	u64 data;
>> +
>> +	reg = of_get_property(pdev->dev.of_node, "reg", NULL);
>> +	addr = of_translate_address(pdev->dev.of_node, reg);
>> +	interface = (addr >> 24) & 0xf;
>> +	numa_node = (addr >> 36) & 0x7;
> 
> Hi David
> 
> You have these two a few times in the code. Maybe add a helper to do
> it? The NUMA one i assume could go somewhere in the SoC code?
> 

Thanks for looking at it, I will try with helpers.


The rest of your comments below raise valid points, I will fix those too.




>> +static int bgx_mix_init_from_fdt(void)
>> +{
>> +	struct device_node	*node;
>> +	struct device_node	*parent = NULL;
>> +	int			mix = 0;
> 
>> +		/* Get the lmac index */
>> +		reg = of_get_property(lmac_fdt_node, "reg", NULL);
>> +		if (!reg)
>> +			goto err;
>> +
>> +		mix_port_lmacs[mix].lmac = *reg;
> 
> I don't think of_get_property() deals with endianness. Is there any
> danger of this driver being used on hardware with the other endianness
> to what you have tested?
> 
>> +/**
>> + * bgx_pki_init_from_param - Initialize the list of lmacs that connect to the
>> + *			     pki from information in the "pki_port" parameter.
>> + *
>> + *			     The pki_port parameter format is as follows:
>> + *			     pki_port=nbl
>> + *			     where:
>> + *				n = node
>> + *				b = bgx
>> + *				l = lmac
>> + *
>> + *			     Commas must be used to separate multiple lmacs:
>> + *			     pki_port=000,100,110
>> + *
>> + *			     Asterisks (*) specify all possible characters in
>> + *			     the subset:
>> + *			     pki_port=00* (all lmacs of node0 bgx0).
>> + *
>> + *			     Missing lmacs identifiers default to all
>> + *			     possible characters in the subset:
>> + *			     pki_port=00 (all lmacs on node0 bgx0)
>> + *
>> + *			     Brackets ('[' and ']') specify the valid
>> + *			     characters in the subset:
>> + *			     pki_port=00[01] (lmac0 and lmac1 of node0 bgx0).
>> + *
>> + * Returns 0 if successful.
>> + * Returns <0 for error codes.
> 
> I've not used kerneldoc much, but i suspect this is wrongly formated:
> 
> https://www.kernel.org/doc/html/v4.9/kernel-documentation.html#function-documentation
> 
>> +int bgx_port_ethtool_set_settings(struct net_device	*netdev,
>> +				  struct ethtool_cmd	*cmd)
>> +{
>> +	struct bgx_port_priv *p = bgx_port_netdev2priv(netdev);
>> +
>> +	if (!capable(CAP_NET_ADMIN))
>> +		return -EPERM;
> 
> Not required. The enforces this. See dev_ethtool()
> 
>> +
>> +	if (p->phydev)
>> +		return phy_ethtool_sset(p->phydev, cmd);
>> +
>> +	return -EOPNOTSUPP;
>> +}
>> +EXPORT_SYMBOL(bgx_port_ethtool_set_settings);
>> +
>> +int bgx_port_ethtool_nway_reset(struct net_device *netdev)
>> +{
>> +	struct bgx_port_priv *p = bgx_port_netdev2priv(netdev);
>> +
>> +	if (!capable(CAP_NET_ADMIN))
>> +		return -EPERM;
> 
> Also not needed.
> 
>> +static void bgx_port_adjust_link(struct net_device *netdev)
>> +{
>> +	struct bgx_port_priv	*priv = bgx_port_netdev2priv(netdev);
>> +	bool			link_changed = false;
>> +	unsigned int		link;
>> +	unsigned int		speed;
>> +	unsigned int		duplex;
>> +
>> +	mutex_lock(&priv->lock);
>> +
>> +	if (!priv->phydev->link && priv->last_status.link)
>> +		link_changed = true;
>> +
>> +	if (priv->phydev->link &&
>> +	    (priv->last_status.link != priv->phydev->link ||
>> +	     priv->last_status.duplex != priv->phydev->duplex ||
>> +	     priv->last_status.speed != priv->phydev->speed))
>> +		link_changed = true;
>> +
>> +	link = priv->phydev->link;
>> +	priv->last_status.link = priv->phydev->link;
>> +
>> +	speed = priv->phydev->speed;
>> +	priv->last_status.speed = priv->phydev->speed;
>> +
>> +	duplex = priv->phydev->duplex;
>> +	priv->last_status.duplex = priv->phydev->duplex;
>> +
>> +	mutex_unlock(&priv->lock);
>> +
>> +	if (link_changed) {
>> +		struct port_status status;
>> +
>> +		phy_print_status(priv->phydev);
>> +
>> +		status.link = link ? 1 : 0;
>> +		status.duplex = duplex;
>> +		status.speed = speed;
>> +		if (!link) {
>> +			netif_carrier_off(netdev);
>> +			 /* Let TX drain. FIXME check that it is drained. */
>> +			mdelay(50);
>> +		}
>> +		priv->set_link(priv, status);
>> +		if (link)
>> +			netif_carrier_on(netdev);
> 
> The code should do netif_carrier_on/off for you. See phy_link_change()
> 
>> +static void bgx_port_check_state(struct work_struct *work)
>> +{
>> +	struct bgx_port_priv	*priv;
>> +	struct port_status	status;
>> +
>> +	priv = container_of(work, struct bgx_port_priv, dwork.work);
>> +
>> +	status = priv->get_link(priv);
>> +
>> +	if (!status.link &&
>> +	    priv->mode != PORT_MODE_SGMII && priv->mode != PORT_MODE_RGMII)
>> +		bgx_port_init_xaui_link(priv);
>> +
>> +	if (priv->last_status.link != status.link) {
>> +		priv->last_status.link = status.link;
>> +		if (status.link)
>> +			netdev_info(priv->netdev, "Link is up - %d/%s\n",
>> +				    status.speed,
>> +				    status.duplex == DUPLEX_FULL ? "Full" : "Half");
> 
> You already have phy_print_status() in bgx_port_adjust_link(). Do you need this here?
> 
>> +		else
>> +			netdev_info(priv->netdev, "Link is down\n");
>> +	}
>> +
>> +	mutex_lock(&priv->lock);
>> +	if (priv->work_queued)
>> +		queue_delayed_work(check_state_wq, &priv->dwork, HZ);
>> +	mutex_unlock(&priv->lock);
>> +}
>> +
>> +int bgx_port_enable(struct net_device *netdev)
>> +{
> 
> 
>> +	} else {
>> +		priv->phydev = of_phy_connect(netdev, priv->phy_np,
>> +					      bgx_port_adjust_link, 0, priv->phy_mode);
>> +		if (!priv->phydev)
>> +			return -ENODEV;
>> +
>> +		netif_carrier_off(netdev);
>> +
>> +		if (priv->phydev)
> 
> You already checked this above.
> 
>> +			phy_start_aneg(priv->phydev);
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(bgx_port_enable);
>> +
>> +int bgx_port_change_mtu(struct net_device *netdev, int new_mtu)
>> +{
>> +	struct bgx_port_priv *priv = bgx_port_netdev2priv(netdev);
>> +	int max_frame;
>> +
>> +	if (new_mtu < 60 || new_mtu > 65392) {
> 
> See dev_set_mtu(). If you have done your initialisation correctly, this
> won't happen.
> 
>> +static int bgx_port_probe(struct platform_device *pdev)
>> +{
>> +	switch (priv->mode) {
>> +	case PORT_MODE_SGMII:
>> +		if (priv->phy_np &&
>> +		    priv->phy_mode != PHY_INTERFACE_MODE_SGMII)
>> +			dev_warn(&pdev->dev, "SGMII phy mode mismatch.\n");
>> +		goto set_link_functions;
>> +	case PORT_MODE_RGMII:
>> +		if (priv->phy_np &&
>> +		    priv->phy_mode != PHY_INTERFACE_MODE_RGMII &&
>> +		    priv->phy_mode != PHY_INTERFACE_MODE_RGMII_ID &&
>> +		    priv->phy_mode != PHY_INTERFACE_MODE_RGMII_RXID &&
>> +		    priv->phy_mode != PHY_INTERFACE_MODE_RGMII_TXID)
> 
> phy_interface_mode_is_rgmii()
> 
> More later, maybe.
> 
>       Andrew
> 
