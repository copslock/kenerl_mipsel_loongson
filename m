Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Apr 2017 19:22:18 +0200 (CEST)
Received: from mail-sn1nam01on0075.outbound.protection.outlook.com ([104.47.32.75]:32776
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993915AbdDTRWLgcb-j (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Apr 2017 19:22:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ZgniCmozy/lqShCRH8BM52peVGFyFqbi2GaelcfajPw=;
 b=DsxzWpRFmXw9fIyhKuGZHyBnZtEijw+Oqix2mr15jUu5fpQogVwHrgdLGpiVIXOvjZsQiBbGOxNkf08hs3+MLo6AsnyKb55BwgIVja6Tzt6AtTatl4mXLpF5so/32kPA7sSHuWnYW2XsdiBO+gL0CL7eBxUN9x86VICuTbxBg78=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=cavium.com;
Received: from [10.0.0.4] (50.82.184.123) by
 MWHPR07MB3213.namprd07.prod.outlook.com (10.172.96.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1034.10; Thu, 20 Apr 2017 17:22:02 +0000
Subject: Re: next/master build: 206 builds: 2 failed, 204 passed, 9 errors, 10
 warnings (next-20170420)
To:     Ralf Baechle <ralf@linux-mips.org>, Arnd Bergmann <arnd@arndb.de>
References: <58f869bd.84a0df0a.dc1f9.4547@mx.google.com>
 <CAK8P3a2uZFGXhNq+nwDQmgzNL5WH0VejQmotUZp3=0fKwsU1=w@mail.gmail.com>
 <20170420093348.GD28041@linux-mips.org>
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        kernel-build-reports@lists.linaro.org,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, Al Viro <viro@zeniv.linux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Marc Zyngier <marc.zyngier@arm.com>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <421d0b9a-0008-528c-e615-fdc09023d822@cavium.com>
Date:   Thu, 20 Apr 2017 12:22:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170420093348.GD28041@linux-mips.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.82.184.123]
X-ClientProxiedBy: CY4PR21CA0045.namprd21.prod.outlook.com (10.175.113.159) To
 MWHPR07MB3213.namprd07.prod.outlook.com (10.172.96.147)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf0bca89-02cc-4f96-da68-08d48811c358
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:MWHPR07MB3213;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3213;3:CeH0C2rMv4ja00vwsa6H3bl+GR1mAjqICcknRjusEYPegjaBijPXtfPQNhkKuoUmOASNDqO+lxXOWbNmldZYItkFKqNhja0PZTtVhZtPviBGuxbqO19Bj6zXCciwgs8ZGuyRKKpT8+cJDGllOqcKt0XW9TLUVfQbQd88hla1TwVRLi3djkKeGuoUjCzmuEO8ou9fjKDXamzGFrL1zQVafxyzx3mICDno1VqTM3AH6qkpaSe1vhBiMwqhlr5V6niqwmINhkyb3tr22pQ9VVy0RZKysuqQjDpwsVRaeDqufptC8NSRX6v+BBf7tO1t4RuyG1NPJQyKOaS06GcMCL9f3A==;25:mqeXA7kHhQ85jI9wySqSzWW1hQ/mqCtj39w+TagVq88qfeSpCwUNaTaO7hP0aXWtvUXTy76KkIp++5PpzGKAXinKDwX8Y0R4AY0bf8Cxb5NSToSc6JPzJ8+QZVCM2M6kbny6q7HPa5Wmi6wVWU9cH1NCp6a7Bil4GRKrXTtjJvV+9CbTOghIl37cyuLrJ3NgUjMKJUwE2RBf4+AD2HdqpmQwNuYowLytwE2BDmKwxGmx0XAtVAq46swVqeDeiBz/isja4lixN4zM2O6pSrgvqzR56kbLXtn6o/qLm4T4yhXMUer9B6MmXw6tmdyouj1p1rz4QfTTrkQFrY8SNmguAAYCXqDy4kZHaZrFiwV6Lv+lhVoFcGxWeR5acchdDjAHIMVeM32zOfonASXhV177kEz6YUjhsIC1BtDNMS+YyUKNvHlDcm4zWZP8uC4kztxIz2F4HWKsLY2a1s8MzwBLlQ==
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3213;31:l9vS0Bc5NmvAs2dFcrDaA0YF6rapwgLqvDXLlOFZF5cNllZC4rtZvNA60EoulnMHXL/xWQg0cHXTU2yWEL1VcN9WtW0xEUqrCjLK38V5E/XI7m2SWM7nQme3+E7ay4V3D35/xX0wfR9wtSAs+a46hRupiRpBT0fGG5KLfTJQt7izqwCdKVyqXF8ydxMApp/lV+aIIMWO8AX6zZh85X6fFMXodQ/7Hrlv7GhPWdg3p0WI6oDrYjRkPpu/YPgybc/rEUsmn0a048Ww7NBMPhufBQ==;20:D6XdXub2SOlPSMOKIfT2sMZjGc3fk4U5+5Utb4qKRc8eBNchaPydqhTR1nQI6Ro54Lv4s8l+VcC8nWitXZr5t3zteRjA5w11X/+9BSVdf/tKjb3MdH19j8uJPTdKL+UVr1ETnrfmMy4y8HL7Au/fyJxg8JRpZhG7HSXOK27+KVPlal+gYCCGNX1SFjnaM3P9mxdIdso2SxiIpBUyq9Gi/eWW5Xz4hGNIqgGpyPolGObOIPuDVWwd1ydvkXRfGx8EUH+TY9CE1J7IdU4BUI7l6RnPq+6WBgPJXHe+XqOQxYIocG9Q/rkypqCq0tIRbM5xC4dhXi4sgGlKDdMUwKjtZEYzCUAwvoIvT+VJD34Ft58lHtuw1JfibLr/8lDJBn4+tUP4Eldilch5svDwvqtW1YNZSYR7S7lqa+r1vR0Fmoo4nP2xJa8P6tCO+k4MfFO4sfHbhdOxBobsVaa6qUPD+nRfqLNHuwonwPYLiG1ZF2cddWJ4wLzf+dZSRR+oMSFU
X-Microsoft-Antispam-PRVS: <MWHPR07MB3213DC98FFFAA690CCC02641801B0@MWHPR07MB3213.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(6041248)(201703131423075)(201702281528075)(201703061421075)(20161123562025)(20161123560025)(20161123555025)(20161123564025)(6072148);SRVR:MWHPR07MB3213;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB3213;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3213;4:IaaCbeFfiQCysx34SsPgXNiUTFGoaWbwrv7JwPIxl8iTxMIo9Sl7d6ipeEScr0X7QAS/JvsEnV9Ag+hSHU5sHmdZzJfo1FeL+MovlPgfDWmF8gJjsFQjytPAT0x9zgYBbmpcebJG6x+0FWYOopamV4vpZR5CNMo38XGzAB5MYQUK9YJOwcI+Thfkx7cSzkBnRAN6HdN6hiTnt9XzvBvuVFGOAQ5l5Zq+3F3KhIlynCcI9kJTK/cFU3bFZOoGzobVvX+HYxRK4l7RFtXM27S5dCAjsJt+YSx7kLGA+Cot76vp3cNLSonuzBjk7nCUAmP3RWawLkRMpBZD+3/b1NNPrUib7YKzi1sszfca8asKw4B9RrvksnXBwgOpxGggkiyep+++Evs44FizaoJv1Csd7TB5n002TrmI+np1xMjzgRiLh0AKk/PrJz37Hqh9qbpl1WYKC0XKOC1V+IyUjNM/WOdr08Kx2IUT/5U0FX4p1kOfm+9gOLOyU74JJoP22b70OAnGj3LhTw0HhyfoJRV0iIWpSzyLAD+2A8xPly4F+J/k3ZnE4n74UFufL5sTV/+vuJkJbuimGA1yQvQNmN/5aPAeE7qBYSY9K/3bdsIkVIlnt7kWbJ73ZkfGk5acv1M3MTZf8CvXVuboceYmHWoVc/u+I/hG5Pg+Y3QFw2bIUikCH8qUSzWBRF9FmoXhWC5zSRBj41yaYUZfQjOUImmiwg==
X-Forefront-PRVS: 02830F0362
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6049001)(6009001)(39850400002)(39400400002)(39410400002)(39450400003)(39840400002)(377454003)(24454002)(7736002)(2950100002)(77096006)(189998001)(6486002)(305945005)(50986999)(229853002)(54906002)(53546009)(53936002)(36756003)(4326008)(54356999)(42186005)(31686004)(38730400002)(76176999)(25786009)(6116002)(3846002)(33646002)(5660300001)(6246003)(50466002)(23676002)(47776003)(66066001)(230700001)(31696002)(86362001)(81166006)(65826007)(8676002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3213;H:[10.0.0.4];FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjA3TUIzMjEzOzIzOkYvOWN4RXVFOHlzYkNjcHZYOUwvK1lQNVQ0?=
 =?utf-8?B?SGhPMlVNOWtpbVJDKzV1UGVXN3QzamdnbTloSTdScnB0NEhJSmlIWlBXVDhm?=
 =?utf-8?B?elp1MXVmRHVCejU3Y21rT2ZtbXpEVUEvTXRRZi8yOFBBdDhmbmpMWk5ITVRo?=
 =?utf-8?B?bXhzQ0ZYelFaNngyV1BnUkFUeXdoWENNWjZ0bVlyRDU1QzVBcExmV3NVSThG?=
 =?utf-8?B?aExIcGhpRkg4bFcyRVZSUng3dFFJc2hBRVVHc25WYzhvZ1ptaU5Yc29BMTFR?=
 =?utf-8?B?ZXlYZ1M0R1JQOTNCOThHZ3h4SVBTT294ODEvOVhMY1d3Z2w3YVZLbTZ1NVZo?=
 =?utf-8?B?ZFNhaTNqTFBHQmZUb2NCYi9uSVBSTEVNY21xTS9HV09wUGJPMlFZNzJBcUlk?=
 =?utf-8?B?Y2lEWFBKMzFLa1hKZWt3eTJTOUUxZzExOVJuNG1Salk0L1dmdldVd0JnYnBh?=
 =?utf-8?B?dURQYmt5ck9TV1dzZXczZVRCS3FLNDZhbEN0NVBWejRoc1NqWlJyWWR3SmFn?=
 =?utf-8?B?UXhsZ20rZjIvTWtERkcrQzJaSkVWV0J4U29uY0RmUmlQZ1d5L1pNVm1KN1Jz?=
 =?utf-8?B?R0FsWEFWeVFXQ01od3pweUdKVTNzbnc4dThvUlRUSmxQeW8zMG9CY0JSUUdU?=
 =?utf-8?B?Mm9USzNVRUNOc1ZuYlpqTzZ0eWV1bVpkU1RXTkI3VG5seFpKeXdUbE9zTmsy?=
 =?utf-8?B?RkJWZSs1RzQxa2NpZitYZk90V1YvazNKMVVqeUVMOWxyVWRTVkRZaFR2d1J3?=
 =?utf-8?B?WERLdmViaHRkWWpvZkpEYUJUc0tkTzNpTnBuVHI0dCtEbXFZVDdXWHBZQ1RM?=
 =?utf-8?B?UWhuNXFQdjdBVjRhL21Hdkwza1RyQUszb2VMaVV2amM2UEtVc3RpbzJveVg0?=
 =?utf-8?B?R1pmTGg5TWJzeFhab3dvNlNDZ2RWSG0zd0VNTjJZTmo0Z0lvTzlXQmFPMmly?=
 =?utf-8?B?cDNaZ2xtZkcvNWxKaXRkclpyUldkbmRFWlJWMllkeG9SNzZ6Zzd3VVdrZXVN?=
 =?utf-8?B?YUlUZlBZTGVwS2JFbGxlZmIxdkZOYmJHTWE4eHdJNU9rb05qQXdJOUhOdWhL?=
 =?utf-8?B?OTFBVEhDZWJPQlRrdVB0YVZZYkgyZ2NvTjQ3TWFrRFJueXhmMWtCTklnbVNJ?=
 =?utf-8?B?azZGVDZ1ODQ0MTZWM3RaNHRsMjJrS0R2a3VnbFg2c3hTSVVFR0U5ZDdiREpt?=
 =?utf-8?B?VFQ5cXJJMWtwd3ZqbWJMMmovdEhuNk5tMFc2eUd4djJtYTh0UVdWWnpYdmdh?=
 =?utf-8?B?Y01oVVB1dzZSTUh0MWY4Z3drVzBOcWszMmMyS00wOWJ6ckJjSFlsVzU2QkI0?=
 =?utf-8?B?SVNaaWZqWHRYcHFRdnRnNCtjL1RwMFkyNVJVUkxJMlhtbnVxWDlVWGdlM1hH?=
 =?utf-8?B?Sms0QitHQ202OXpGY1lYQVVhc09RcTJjSDF1dWpSaUdNTFdNcGpsL2FoQkhG?=
 =?utf-8?B?ZUxJMC9FenlPbDNKK2gyWlI2OGZNS0Nyczc0cjVtWGJPd21tL0t6eFh2K2x0?=
 =?utf-8?Q?+X21COwTWqLFta3d03zuHrqBI=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3213;6:mwxZXDayIj18XzMMpaanV7cIvq+z3wnA87CmROJSRfnIynbgW94kBbbc1Gm9Wge3a5fi0Rg23U7qWqSGgEVkCpfzzOewF950YR0xcvmmerZh7D/SBd/eDTAEAlA9QELLWDIxufohI9il5KiRKcGry23hyHOdfq3oqRYvZnG0ozclhrZ+jBWPSsjHIQz4xqIRXVqZ7MMwWvCXUcoqz8Eo7HNWGEsKaMQwCfYchM3ScQ8UY8pIkM0SBhQ1n9BDhrKskr7NMB+X+UxNzD3qfsv/2fL3kfQYrkvd7opgjL/hrFSzAlfsvfCiUZl0Nom0L4BeGYNEEWVnTs7xC/Z9KExQ0/KbTK+xH3DTOnJcgiHjDKImKw8Za55lA78+eJtOkuM7VFGWTt/BXCq3UnBQiMIYzcp3eM2qiWr8BCoW15akM39K3oxinbAAYAM/CSWXV/oOCoxtCHGdaSjdP8rtSnFnuinqEOH0Lu3j5SySCWjLCJNFSdRBOgjKMVYGjMFXW/sc6BXsQoJOLnnJoP9lvY5UUg==;5:Hi//vkTwehd01+8eh/ZyWplv/z7uytPZ8sdtibXLIHFwrTl+FEG06S+L8y41GIgbs9TXDnrYu9dfR7M7CXJ0he2pcct1mxyEg7ZzdwwR6BzoKou0MDMBf6aERgGndtb9H44QvWVPXRYm0+PXfyco0A==;24:SUXyo36Kg+gWx+hYzyK9Jt3/41nGiWX4hCDtxXc8RocIGi5+o36wvBQP6ZJeppa46f6MvOBOWutTXJc0BxiFf1C/uukL4r3blyr4s8AukIc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3213;7:9pbcZt6sqfEbxPo1IMIewV+LcIHld3cb7rltmMKudPraDU3jurV7fDYVCB7hwH8858ZnuGZ6kwb2dbwpRxUJ8LGzE49j8Mp51Gm17oJmbNKdp5aEXEZQANgZRXwc6yolNlNE4Tl57MuwUHywWj+U2Fu4lAjj4hq57J+U0S+ZHyEebp91rI4PkTTbQkm0UOFTulWQpBj4E1IGxW7seP263o3wQb2flhgYVGKCK9+S70BfnDnGxWjxF8VoPi0bscfQcKujkvXhMZIy5SX95sqJ/PFBg/lfpO0mcPsR8xdlDxk76NMtxUUvxdTOf8Ww65/xLTqIRO7vUlVwD8/aivmhoA==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2017 17:22:02.9736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3213
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57750
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@cavium.com
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

On 04/20/2017 04:33 AM, Ralf Baechle wrote:
> On Thu, Apr 20, 2017 at 11:23:03AM +0200, Arnd Bergmann wrote:
> 
>> On Thu, Apr 20, 2017 at 9:56 AM, kernelci.org bot <bot@kernelci.org> wrote:
>>> next/master build: 206 builds: 2 failed, 204 passed, 9 errors, 10 warnings
>>
[...]
> 
> I've dropped both commits a few minutes ago.
> 
I have found flaws in my testing methodology that I have now
corrected, so these type of errors will be avoided going forward.
Sorry for errors. Cheers.

Steve
