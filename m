Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2016 01:17:59 +0100 (CET)
Received: from mail-sn1nam02on0048.outbound.protection.outlook.com ([104.47.36.48]:61897
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993010AbcKJARuyRdM6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Nov 2016 01:17:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=o4wumIMDhoCfnxzP0HCMcNQ7fdTolhpPSAX3BoQOs+E=;
 b=ctvWDGusV0+80O+MXoS5aTtIxahiTSjVKz/wMbujppOHOeLOwCb0+7Ar5PpvCsqDQXVa+AKdWfwt4GPotFvG4RsUfA79FouM2lg+OsExZs/NvgYiT0gmdWq+37gVgLzM2TGhTJQeDVk21eRqSV+YHE6bCt494dJEgnDPEEO9Tig=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from dl.caveonetworks.com (50.233.148.156) by
 SN1PR07MB2141.namprd07.prod.outlook.com (10.164.47.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.707.6; Thu, 10 Nov 2016 00:17:42 +0000
Message-ID: <5823BCA3.2020202@caviumnetworks.com>
Date:   Wed, 9 Nov 2016 16:17:39 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     LKML <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-mm@kvack.org>, Thomas Gleixner <tglx@linutronix.de>,
        WireGuard mailing list <wireguard@lists.zx2c4.com>,
        <k@vodka.home.kg>
Subject: Re: Proposal: HAVE_SEPARATE_IRQ_STACK?
References: <CAHmME9oSUcAXVMhpLt0bqa9DKHE8rd3u+3JDb_wgviZnOpP7JA@mail.gmail.com>
In-Reply-To: <CAHmME9oSUcAXVMhpLt0bqa9DKHE8rd3u+3JDb_wgviZnOpP7JA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM2PR07CA0047.namprd07.prod.outlook.com (10.141.52.175) To
 SN1PR07MB2141.namprd07.prod.outlook.com (10.164.47.11)
X-MS-Office365-Filtering-Correlation-Id: d7405825-6838-4f31-f6d0-08d408fefd1d
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2141;2:MKbUvscoM6Bnyjo+Jqazg3NCkpifvXgpCpolR4CZrgYfpRoR2ZRLsY5UkVmDkcYPkR1xz1rqDeCfXeBqeOSCA6TYt1ZOuXd8NK/o9KdnZAqsJUkivfJWY8G9ZLsjYITF+2nnArw0l94VUJUzOdpsCM15e2c3wP3PdRpINXQV/0h8mb1LiTXGDDqWsPcpAuROIj15FcNDoHNO4yS72yZjBg==;3:qlcewDAMfLQ1qrPYzA8TxI7THtjSdG8ciPXN8pUSkG42itXefYcwecY91wmgyarkkubocTEauCLpyW98lL8fv3my1coo7c9p5RSmp1ZmGORHmPVsB1dtlKwQYmro49X7D3+P9muCKE0LEQJzA/NtpQ==;25:W+9+1aqtT4/0CmDmfUUt9gqhN1EepqhGIFh7C4OrOb3DMOycWPL24AqaaoTTABgHo8KOnuEib+cLm5rt7AYMGJlMWPOcpwkrWLDJrBmolRklWzCBeTrmw43o2aqIqr8724ex55aqZ7AWN9Ipgfue+WqUS95uacrLZWJMpP7iqOLBiIQUIxRbuMAuC2MA5CGtI6rZlci0Cbn9JSyO6rm1lskzgoj1hBb9gftVg1mEJER6sRy5bh/Khd99Y1nJ4GUkKwySRTrMIkJzJfNNw5++zdNS6+I1u9Ykc31rwINdgU0ar+Pwy/i4S3aswmZjrqfZQh1geUmE/s1loyw+qzB2VSBH5OsDvq+bKAWsebPvWBq9zSuradZ+n/2mFWhVp24teeQxEErjsGB0pcsvv2VdLB/TwhzVZkNOMQzoxr5BOUexz2OvuODiP2NFqDNU3YfZ
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2141;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2141;31:gBgSSKsPktqnt/LNMRYSdFNiCac3M5EdmzK9PW8h6MW4naJ0yj+lQBzXlqk7lQ7Wi1hSQnkQ+qr/AyzRPf/a8BkZ/QtkExhkHh2aFfJd4MeyADVjMNrxZKSH/IpRoRwyx3bS1ArbetRN4hhbWgsu3H2DscOyBc+93tOFqiN6/Wol94RZbvN9OdFAmUQJU9gbL4NtUtfglsRbZ7mDuSw8x3j4AvrXC/9PCTh+3TlM2ETRFfoUFynIZFBqkaDzEshsDVrn+MO1WZyTfnjTsOaxZA==;20:7GGT80nH2fsbf6WomQCD6yNc7MArkofM6Ty9+jBGQseC60oTL7M13PRBG4koOL0iH2FwZeXrImd8sszXwuX3KmNyboquyKxJ+zzcDS1q3Pww6NvzpYVSzP9eGgPUwDw0hHS4HBNG/oC8jvO6kBvi0DCtaqSxwoRiK6LSzjlogFh5OLSIj9FQZvdsWel5bXLzjUiYQl9N6MDBJzh1AGgz+zFDI7nQPObU7cWFv2y0BRPkdXG5lGLvxj+Eh08yUe8u1THdqmZmmxife4P4AYymiHXQcSa+ZB8RrjnXFRczfKmOs6bJe4iK5CNIWnIoeVPYWKWcywRD+2b5b621ZDgrtdtflDUpDKv4PLYPmvtUrLU6Uak7dfhb9jSgD3HQO9q/Iy/4eOFfWDSMFqWGpPrCskM/el63rZS0g5/0opOklBndS182q8f31WUvdnek7eZAicAXOTG3SejWym/aP0da8ACKnHj6Zpl13b/eaVZ8P4SiECrAvCDPrgwCeb9kIYjlvkCUxIdhdt0dgiBW+pwJ03xYEBhqf5zyI0fYVCgtFQES4crBbD6dp/C4AzI4dFV298a3qKXAUj8R+Kcg1sZk5Di6TX2t4PvJ4MzEkUoMfNg=
X-Microsoft-Antispam-PRVS: <SN1PR07MB21413074BC52E88ABDB97A6397B80@SN1PR07MB2141.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001);SRVR:SN1PR07MB2141;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2141;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2141;4:ez/eVUbNgta2BwxOYglZ1DjZ36MQeNCgas4x5UZ36OMojoo/LcK5w5YNA3484IWD+j6u4vnsRsz9ONkAdlpCbPhadrEkXuz+PW+HtiuuD0iaTQ4AemyXl4YwIT8CWN1KlhUw0GSQqF/hp5EMSlfPjUp/pgraNlZrgu7YdpFOBGFgM0qI87Ed4pygm0i8EV86+v7VIG3/kPGs284usNsa8hnMqoXasOqDCqJ+KDJCLUIIfHEUuFu7swwc8Tzq2nDj1DN/Au5r7N97DxCk8CEnqAz485d3dfssvTR1FL6FHJMGJ0WPkHnIzVypS6Oe7WngCrOH36mImRm6Sve+0MU3/JgvGZAntANw2kaZ5pnuBaJQLmNOn7t0ffeMLmq+2RCtlnACAe0mRA4jrfq44DgwGoIATnPW/XP0VrQoh5WJ1W39Rhq7G0ZFOwRiFdmdQNlq
X-Forefront-PRVS: 01221E3973
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(189002)(24454002)(51444003)(199003)(377454003)(80316001)(69596002)(50986999)(4326007)(2906002)(50466002)(65816999)(87266999)(76176999)(54356999)(4001350100001)(81166006)(42186005)(5660300001)(189998001)(8676002)(64126003)(106356001)(229853002)(66066001)(65956001)(65806001)(47776003)(83506001)(305945005)(7846002)(7736002)(105586002)(36756003)(101416001)(3846002)(586003)(6116002)(53416004)(68736007)(59896002)(110136003)(77096005)(97736004)(33656002)(6666003)(23676002)(6916009)(42882006)(2950100002)(92566002)(230700001)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2141;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjA3TUIyMTQxOzIzOnpSdTBJUzlENFN6NWVuYzk3V1Q1MlZLakU5?=
 =?utf-8?B?MThkVDMxY08xL1BORXl4UWF0eWhPU3hxZk1kcFRYamU1MnpZK3phWjkyc1hS?=
 =?utf-8?B?T091Vm9WRXRVZnFUWlBRQ2R4bldIL3A5VmF0T2daek5IbHBJMkY5aG9IaEs4?=
 =?utf-8?B?YW5QOWwxNnQ0QTVkTDN2T2lLSU9GYVVIUzBobTZsTEV0aHA1VXJ2MnBETzh4?=
 =?utf-8?B?dURoSlBCL2NqSGdjZ3RzRWd3blY4QU1YOFgybFd1bDl5WFVhcFVuMktGQ3JX?=
 =?utf-8?B?ZHN4R1N1RXBPTm55SVFMZHJMV3J1MTJ1bkJndEZXbDduTFNlc0xVSmRQazJB?=
 =?utf-8?B?c2xBRUtVaXk0b2lvZEpCSDBMdjFMc0Q5V1ZPQytCTDZpc2I4TStiWlhUNEJH?=
 =?utf-8?B?TkZENU1NeEtPd05UYnVlRzhtUWZTOW1Bd1M5UlFrNTVSWHZnY3BNMkZuN2hx?=
 =?utf-8?B?UXdkM21EbVlnYlNYUC9VRjgxdUlhckEyRHNkSkZLcVZPK2dTeW9XbzNXQTNC?=
 =?utf-8?B?WnVkUktnVGUycEJNRzZEcDE0bnRhZGhRd0xUV2tUZU5mMTZ1VU1wNGprYmV1?=
 =?utf-8?B?MGNUQThzQlNQUTdka2hLd1dKRFNYempTRUxvK0lmRFU0WEhDM1Q4czN2ZytE?=
 =?utf-8?B?V0UzdWg5RDlpZi9KTFN2Z1FtNWdQcHlsR0tBNEkxdnA1NjNuRDN4S1ZpcDhy?=
 =?utf-8?B?N25TR2JGaDRuWTBDNEZSNmlEcks0UlBqcWFzWEJPdmgzYXpwSkpndnZlbE9k?=
 =?utf-8?B?dlAwNHREWVNkejg3Z0pEdGZicEtnMTdOaDRteWVJYTg2R1FnTG8yejltZXl4?=
 =?utf-8?B?SEh6NFUzdDRYejdHWXhzOFdaaGRzeVdyTEUxU2ZwQXAyUXM5Q0twWkk1ZVJD?=
 =?utf-8?B?ZFlJbnFKM2gzZUNJb2Y0d1pJUURlS2xoSU1odGRvSDRwekd2bU5NR2JveWdm?=
 =?utf-8?B?ZE0xaVNpSlJ1aFB6MjNZbXlqOXNjVUJKVGVKV1ZiUWF5RlVvZFBzT1Rhbm10?=
 =?utf-8?B?bFJONDBZMytkS1NqZlVvUUp1Ync3eUl6VUlkc1dydnRFTlU5c2dYdGE0T0c0?=
 =?utf-8?B?ME9lNXdhMkFvbHBQcU5xQklRUkhVZkNvQ0VDYzZEWmFWSzNiS1F4Wkozd3BD?=
 =?utf-8?B?cjVaOE5sVzBMYVhxckxkQUVzaEJTM0RPeFlXNDdMc1NDVFM5R3I0ZEJsVmxQ?=
 =?utf-8?B?dldFUE5aekREYWF3RGJnTUV6T2lIQkpzWjNMTkNEa1R6KzMwcE56Y044T1hT?=
 =?utf-8?B?RTBUR0wvVkhQK1k5eks4dmRhbHE3U0c1R1hCWDJPWm9ZTldPZjNhakV0d2JL?=
 =?utf-8?B?eVEzVEtiNUtKWGRrVHp2ZGM5VzljUGZWaU5zclZ0WFFadWRIWGNEREhGblE3?=
 =?utf-8?B?WmJNa01Lbjg4TFdoK3ZyNDFla3RQWDRTU0ZRV2RWZktLbDFKQS9Uck41ZmdI?=
 =?utf-8?B?SW1VUkFZczlpMmZFRWZ5eG83ZU1hbWtsTHNkbUlXM2hlQUpSL1JIeEs2Tmda?=
 =?utf-8?B?UERUSDY5ZldaZVFTL3RHWDVQaGh2L1c2M2dDODAxbk1tejZsRUNWQUhCUDE2?=
 =?utf-8?B?SHJSSzdWMU5wSXM2TG9tMnJ0b0lYNHBZREI2ZStsWTBxRkpFT3B4L0o1T3lG?=
 =?utf-8?B?Zzh6eElBT0V3cm84K0hYUUZqMG1GclV2SEk3cE85WkVsRTlzYWVZYmh5VE9T?=
 =?utf-8?B?MC9IRW5nVVM2OUJ0ejg3bHVKeXBuU0JWM01IdnYxM01vNnRkOGlmcklZbDl3?=
 =?utf-8?B?b2Y5Z2xGQndvM1lVeEhCdHRwVm5rcU1UR1N0MVBuaE5jVjl3U0Z4YVFIWXcx?=
 =?utf-8?B?NkVmcXAwK2dGNUs0ZElPVG5ESEFTZlMxcDRmRFpsYWFraVE9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2141;6:Q1zT0UfvwnSxsZBhrVaT3kVwZd9IqNa4t2qVRp4Y+WfU5yvokxkLefDc439hHDRhW5aJBhRm8JxPf8cUf+aquqzCwu4qsrcf5vzSQC/1khlJqHD22A/hqpqdS+ckO34fZ8bTDQOGid/qSSSb0/cKPpijIOjfcMAFT/HpqTqAnZEA47bipEt78QhPUm8y2URBzd/s/7AXj8riAJYrd4WL1Hfke5f+EXxPoOcO55Z51o1IxsUnBAQeI9lmRPaK/qe+wyp/1P+GoBiOp7pgcdIatj9vC62Aeb/DvZ/om+FfSsgc28gXm1zbyI4WaO/Ky0vL;5:ahzYQ9XxdCdxSlaSVQ5RopgSQd25kpXNKUxLrjYLhcZnczFQVvbSPEh7T8BgXhqe6AxXAFSPdbRt7J3Z5QZ8BNP4r62xXZpO+/9Z9FDZDLUE6mZyE++1kYbEqn2/adodlEl19kkwEDXccpF605rLpQ==;24:CLazoE4huCi4onOv4FbbYd9fbBmr5FrAvziT91FE6LwEJbrn27vT/BKbsd4dAp7X7PK5U4YGyy0Uy1rx0BUQMLvTGyUv/5qrIS3mG0jGXT8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2141;7:6rFLj3b2hQ5vvX0Ch8NuvvgF0flH7CTnB+t26cCAWtCsI12qAkpxgGMAQbtvPpCqPTHf9PabvvK4nAhuNMDxeDpIHfJIqC6/wrcvffEZIooUms/D5+BlkJL5kwx4kG8emcM4NZV1L70QzDea8oxbQBRs0S3zhh080L/4hf0sjSEfRMlE0mSde9z3RaUiKj3BxLqqMd9IgTH1MNpbdYldM7Uu8gUkj/29loq49rdlTFJdQ+g+7YgQpPVUJqbLZBq5D7wsjXoAH14vbgb4gR1Sad2GhT18AYKdeO40VDfzItAz9Y1wmeqPjFVG0KjSEA8mNPIU8IpwmSVQeumfN98VP/KFJF1s5vgOogkz9Ci/zZs=
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2016 00:17:42.0990 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2141
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55765
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

On 11/09/2016 01:27 PM, Jason A. Donenfeld wrote:
> Hi folks,
>
> I do some ECC crypto in a kthread. A fast 32bit implementation usually
> uses around 2k - 3k bytes of stack. Since kernel threads get 8k, I
> figured this would be okay. And for the most part, it is. However,
> everything falls apart on architectures like MIPS, which do not use a
> separate irq stack.

Easiest thing to do would be to select 16K page size in your .config, I 
think that will give you a similar sized stack.

>
>>From what I can tell, on MIPS, the irq handler uses whichever stack
> was in current at the time of interruption. At the end of the irq
> handler, softirqs trigger if preemption hasn't been disabled. When the
> softirq handler runs, it will still use the same interrupted stack. So
> let's take some pathological case of huge softirq stack usage: wifi
> driver inside of l2tp inside of gre inside of ppp. Now, my ECC crypto
> is humming along happily in its kthread, when all of the sudden, a
> wifi packet arrives, triggering the interrupt. Or, perhaps instead,
> TCP sends an ack packet on softirq, using my kthread's stack. The
> interrupt is serviced, and at the end of it, softirq is serviced,
> using my kthread's stack, which was already half full. When this
> softirq is serviced, it goes through our 4 layers of network device
> drivers. Since we started with a half full stack, we very quickly blow
> it up, and everything explodes, and users write angry mailing list
> posts.
>
> It seems to me x86, ARM, SPARC, SH, ParisC, PPC, Metag, and UML all
> concluded that letting the interrupt handler use current's stack was a
> terrible idea, and instead have a per-cpu irq stack that gets used
> when the handler is service. Whew!
>
> But for the remaining platforms, such as MIPS, this is still a
> problem. In an effort to work around this in my code, rather than
> having to invoke kmalloc for what should be stack-based variables, I
> was thinking I'd just disable preemption for those functions that use
> a lot of stack, so that stack-hungry softirq handlers don't crush it.
> This is generally unsatisfactory, so I don't want to do this
> unconditionally. Instead, I'd like to do some cludge such as:
>
>      #ifndef CONFIG_HAVE_SEPARATE_IRQ_STACK
>      preempt_disable();
>      #endif
>
>      some_func_that_uses_lots_of_stack();
>
>      #ifndef CONFIG_HAVE_SEPARATE_IRQ_STACK
>      preempt_enable();
>      #endif
>
> However, for this to work, I actual need that config variable. Would
> you accept a patch that adds this config variable to the relavent
> platforms? If not, do you have a better solution for me (which doesn't
> involve using kmalloc or choosing a different crypto primitive)?
>
> Thanks,
> Jason
>
>
