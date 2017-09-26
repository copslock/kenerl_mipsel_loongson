Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2017 18:08:35 +0200 (CEST)
Received: from mail-bl2nam02on0044.outbound.protection.outlook.com ([104.47.38.44]:61243
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992078AbdIZQI2yh8uy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Sep 2017 18:08:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3zmlIE/Rk3Bwyr1Gn98ZXXAOdW9ZrU6cTid944U4j4w=;
 b=UEtotQUtVR3FsQp9LK+gYVBTkXVzJDATGD+Y3oNzn8PIHzL0fWqAkESUFL7sfu5BqSgf8R/394XJPTeWAvncmp6XWoKyvtkQcPtkR+UCz1C8yB3Ts0M/6+4UuGOpUaN5N8mUTA3W5WNUQfjQNlj6bVoEKDiduMg7gl7vvxoAWRA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3502.namprd07.prod.outlook.com (10.164.192.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.77.7; Tue, 26 Sep 2017 16:08:18 +0000
Subject: =?UTF-8?Q?Re:_error:_=e2=80=98target=e2=80=99_may_be_used_uninitial?=
 =?UTF-8?Q?ized_in_arch/mips/net/ebpf=5fjit.c?=
To:     Matt Redfearn <matt.redfearn@imgtec.com>,
        David Daney <david.daney@cavium.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
References: <31051d4e-95a1-ec81-7e9e-5cf0f3d752df@imgtec.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <a84de98e-0af2-cba2-3370-b4acde0a4729@caviumnetworks.com>
Date:   Tue, 26 Sep 2017 09:08:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <31051d4e-95a1-ec81-7e9e-5cf0f3d752df@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0014.namprd07.prod.outlook.com (10.162.96.24) To
 MWHPR07MB3502.namprd07.prod.outlook.com (10.164.192.29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 933a1d58-0c82-470f-3fb6-08d504f8cd98
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254152)(2017052603199)(201703131423075)(201703031133081)(201702281549075);SRVR:MWHPR07MB3502;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3502;3:XfJhJeJYdP4XsF0JIh2eChasSKBzLvlZ1dYgrPmuQzOsNvoN+GSjw3P4m1ulNgkDoxHUlKXizr8lWY/xiE5dO48P30CnoHNSJ4rR2uICegabU+24/u+DQ5+ZBqejbqhbePymYkRh4x7ANfq/pZ8SWYXx+3CQIddEo4rL85yi7PTMuvbau08BUWbOqm3tcktrUEnXBMjV/iSjLKnwpSpatQLWsSAzx2hhnqWA8LHDEYX1H9GmUOkt+DOeBX1KP5py;25:MDaSAAv2b1DESvuov9T7+3x3gHrPaZYrZY7VMt2ZRo0oByrMn5gNNSNpLTK+D8f5LLQOI7D9zDic6ZXmLbWNovwjRDTQ3umbQdJlO+0KYgD62TzvqDMx+mhcmOkHh9icVasf3Djt2d8Ow42Bi+m9Jpc3Ouscc+02mfqTEgAX/9EQwf3eAKcegRQ7mMjnAKp81Sp2AOEcIS6uYjYNKV7VQjQwSb9RYFHNarj4kEGOEG0Z0GHAC2FABB4iGmIYKA8LuNwoHoorlTSF+1i4/CsdwJ5csWLfnZDI3MWzzi52JOA24lZOBHjpH+s0vbSMPv+Ki+t2GYaycxBfERJt+ghRSQ==;31:qz0N3d1jWQIgJzgwiZ5Aq3QvOlpd1vFegGt+YIvk3yaSw5lRz/iUtH4KEsrr8iFBH1nuzrRViPEe9XHe8t8a0vxKsQsJp12ftkdUIgRPHtu7KCqtl5jBTztO2A/XvL6e8ifA1GKbZErWyj8XHTjU/yw6nYYVLC9CTxClNLRLE9L76p4Q0yuLhLwxVLWx2+eofRMaAEUGyltToWzZJipCZux5+Jmvw8s/F8BuDofclJw=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3502:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3502;20:cjS/q/WRSOPqm/FtF01tGpP9wlak+05IY1j7BxOOduQUJvsz0VMBOjBhsK9AzG9cRWEkqDluFZvDtAyuj1EmLkEaeqXfd8F/uL8zK1hwjloSwtGHD0T59yEJPj+s1QOFstsfAdzVv1mIYv7QhOjaBs09tixTJ7lh+6gmM8rRetZKi8ztq1+VKiSJL2TZ6kIT+vO4eb81/ih7gWmENPO/BkjsfrMSFtkHk+GD1ydYsuic9333nnI1PSnNldjXDYZjQRLVwQMXWNmqK7jZjb4UUGALocNlROw0Rn5SCBI8FyqZgYMu8HT74yhUqGmfvVMMzCVujIL744JUK6a+UDqeo/xSy9HpHplaQreHAwfM7u8p0VIs+e6w7A0twibNq3cxb49zjdHgyz6oQxhszFpjH5eKsXFi+WlH9pa19ZQuGtQGYoCmbrHY/a3wzcUhFNHF1hMZ9BLjNMkFnufMI9R9DkQbcsjZXwFFg2Ab64Wk1wbCC3pibexxD+OVUSbDin784JzPFP//P8X/9fiLeV8MHd7BWfiZeQGz14M+oDQVr490UvJImgJ4JeSErr29Q/riB/yovXJOzopEM3b8Ok2JX9Il1Lh4XC7cRLxbhTqWHl4=;4:zRz1ISQqJjXTIyJVp6Ho5VOdWJtYrrSkOwwD/4fHfosZ0djdySwjE8EL9TZaI92hvBPtgDQrioGE5y+CAGH8dES82I/ugRzFgRBXO66qnkCq5Ve64rKZePl06/+rSO59yQF1ax1NCjfDcWSQzeGqcF2el4Adv1OUctStr3haZePQY+BgxZC1OGTPMUtxaOmmweP/uF1PXpNNE8d7FaICkQRnoaHmGFIQs35UxmQArvwMK/23LrrNmG/xWy+qQkcf
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <MWHPR07MB3502688A48D6ACF3A56F6307977B0@MWHPR07MB3502.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(10201501046)(3002001)(100000703101)(100105400095)(93006095)(6041248)(20161123555025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123558100)(20161123562025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR07MB3502;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR07MB3502;
X-Forefront-PRVS: 0442E569BC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(346002)(189002)(199003)(377454003)(24454002)(6486002)(110136005)(47776003)(316002)(305945005)(36756003)(25786009)(65826007)(2906002)(65956001)(31686004)(4326008)(68736007)(6506006)(53936002)(101416001)(66066001)(6512007)(53546010)(31696002)(6246003)(229853002)(3846002)(2950100002)(69596002)(42882006)(97736004)(23676002)(2870700001)(6116002)(64126003)(65806001)(83506001)(16526017)(8936002)(5660300001)(7736002)(81166006)(81156014)(478600001)(72206003)(58126008)(33646002)(53416004)(76176999)(105586002)(50986999)(106356001)(50466002)(189998001)(54356999)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3502;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjA3TUIzNTAyOzIzOjhaMGFLQ3ZmcjRpMXVrSURRUmR2ZnVIUEQ4?=
 =?utf-8?B?SkU4bUtLVlU5anNmdnl4ZFdIa01UazhZUWNqZ2ZLa2F2aDdhWUpGOXl4RFdP?=
 =?utf-8?B?SkpPNDdIdU1XZUp4K0UvaHphYngyV0NlV0RBak5GaTBNMEpMK0hra3dYRHZq?=
 =?utf-8?B?TjJpNFNtalh3Y3poOGtSV01USXZPWGNELzlQVWRPL05IRDB4Nmt5MDAxbU50?=
 =?utf-8?B?LzVURmRsN0lXQlR5RkRYd3ZhbnBZWUV3L3pwYUUvRmJkUmVYdExOL05KeEFB?=
 =?utf-8?B?TEx6dEM2dW9xcktIOGpxSkZkeFJ0L0ptSjJIZDM0MnEwRTFVQUxSMGN1TmlQ?=
 =?utf-8?B?MTFmb0dxRVVlbWtkY2E2cWx5S1YzMEVIbHVYS05xbElSbmNRWUVjV0IzbjBI?=
 =?utf-8?B?d0pBSWZjT0pxL0tZR3l0SFc1L3dDTE5LT0lYcVlUemNlSHllbzdpbHdZN3hX?=
 =?utf-8?B?TWlQR2o0NGtISXhGVXQyNTEzQXpTMVRwb0o5Qmo4N2hBSGVDanFiN0pVbXRD?=
 =?utf-8?B?Y3hIVU5QVCtmSkg0K1JVV1FUYUtmSzBMZkUvckJmV0lvTXFkdWNxLzJtSlB4?=
 =?utf-8?B?anRmU2cxeHMxbVhvaGFrR3dTbCtVcVc5Z1F3OTBXandzbXhRb2dWQ1JML1ky?=
 =?utf-8?B?TERUQlJrK1hEQ0dTS1paS1JDQVZXbjE0ZGhnNUpMRnpuS0VkQytVWXl2ekZ1?=
 =?utf-8?B?K0JPblVaOExBNjljVlVPZWVLTHFiU25kV2h6VytkdHJQa3pYa2NHakFQNktG?=
 =?utf-8?B?Y2w3QVhyZk1RcU5YcTZvMnZrNENXQXB3eU0xYldoS01ZVTRlalRuYzZESnpB?=
 =?utf-8?B?SHZSTWpGd1VJdlc3QlNzUlN4TS9HU0pzcDlxSVZEdmtSVExPeGh4c1Y4cHNS?=
 =?utf-8?B?dEJVOFBsZjBLeElQUXppQlBmM0gzU0FlZEhsUkJSTzcybGJFbi94aXJMdk91?=
 =?utf-8?B?NmxXYlJHVENBd2lFeFc0THFSU0s0Y3ZwRGQ3UVZxQVVET0Z3NXhPUEN4R2F6?=
 =?utf-8?B?UGhKVHFBeFZCWXdFM29xMTU5K0JtNnlHS2RwaE01TVFLZEd1Z1BvMk92bTdp?=
 =?utf-8?B?K3ZrWVdnSDZZWTNzMzdpaHdPYUNjUGxHNEE1K2Fyb0RWTmhJUXEvNWZDOWNB?=
 =?utf-8?B?c3RROFhnMmI0M3pYazRqRTRaTXloZ3dLVkgvV2M3Uk1FdzdzYmlHcWY4T2pH?=
 =?utf-8?B?Z2pKNStBZVVBVXZXd3F5WUV5Q2wrenBGaDI4dit4UFJnaWJNdUlWaE04WTBy?=
 =?utf-8?B?K0NpYXFKREpOeVV2ekFjSWdDVTdUcWJNYTNrTkNrNm9BSzJrRTViNDJkdlpI?=
 =?utf-8?B?S2ZsWnkxLzdXOGhZNWFFK2oxNzdZUTAwa2tPM0ljamQxRER0dzhuN281YjFn?=
 =?utf-8?B?ZC9RdDBlYlMrL3lTeHFIV1lmSUx0V0hCdGYwTkQzcTFkMWJBK3VsTVdJMUNu?=
 =?utf-8?B?RVUrRldlNjJjR2pRUThmaHBvdGdmM1lRV1RZWno3WCtNcHJaeFlva3c1bkc4?=
 =?utf-8?B?VVphVHBCcE9BWURWTzIxUGc4LzlwOGt1ZytjcXVVU056a1JLZDIxQXVyamtI?=
 =?utf-8?B?TzEzMnFyQ0Y3eTdSUXRyWmJaNHljeE1DZVBsODdtR3FRcGI5MmErN1l0aEkr?=
 =?utf-8?B?am1BdXMvYURBcU1rUFZsUmFacjJLcS9vY0UyRzBLK0RYWHdYU1FzWjkrbDZQ?=
 =?utf-8?B?Vm9GNWg4cC9SUnpTR0U5dVU2WE5PUXlFNXIrUmxQZjRXWTkrMEQyUkFtWXBl?=
 =?utf-8?B?QWpVWkFJRENOMkdBQW1LUndrQ1I0U0UrUGtjclhpR1pjT3l3RnNzWTI4OVBZ?=
 =?utf-8?B?R3I2UEV5RWVQTHY0eU1HSk5QZWUzeG9sV3g2eDhab2dublE9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3502;6:ejLUE5bJOAAfSgXHdrVzG0AIcPQa0Lh+VXhETr+m8bUdCeUxjQtNI5jjAt6vlEbBD9bRiikbI1jORJLiQbOmzKQTamP+gQL6kBSL1GHe0Xy9PyFZnqAcyCJnkI1LntuaBlWbQ2uD0pjTGzv8lVxaQU3h3MpM0sP1q9MrNAIco61bAA8BRRrsZAvQ2L1cT/wTPKeM6r9q8xZha69LCRqOk20cnFr9UpV9Y/CU6wRfB39/sBTCPj0H5IyOnoG3EW04fDwUduNjkud/LgagjvtvP18lUfzPDGPf+gtIxGHT3wELpONACaO5TsoyG4IwYGEKuh2yCZEwEykRhdxq+8z+NA==;5:ggkD0zcqr/WwCftPui21g4nc1/X5RhwEYO0hfzTVYSufXwp2KxYJZuQD0QKw3s7hsTQMYYxRRS5Ar2bymTPagqHOl6gZk/MiDFfVoaOvANk3dVo/eznKkAJ+A/xpbgwqpQvjeLvuSKmz6eLw+EuI5w==;24:KJi8BDqdBuOrjqvvRUdOK23eWNzzMbVeMc643jHhOEXdjt03jG1RXSaNpPruXaUGzB7DLTimyNrJjZdXXoOrBmAACxqzo+yID3cJ2j9efUY=;7:lWLLRvzIcWoZh0s4iC7RpTdq01uOtJvloaaMb7n4wp2WGl3rc/VuY77Blwmu5PgRfzg0WUK5Ex8ZR3j281Kt1hS8v1a28cOXe39EUZmTXKTJAL8nBBhlDQrES7p+dgT2h1v4uXaNrHYncWwfCeJJMN5S+fBr3xRmEjF11qz4cojQjnsbBbr2L1OH8NeWHWGQTEl47ZD8Zide9D3vRKcE3syvlPkLE0Jz9HFrKIcR4Uc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2017 16:08:18.3781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3502
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60162
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

On 09/26/2017 08:13 AM, Matt Redfearn wrote:
> Hi David,
> 
> I see the following compiler error when I turn on CONFIG_MIPS_EBPF_JIT 
> with v4.13 and v4.14-rc1 (cavium_octeon_defconfig based)
> 
> This is with gcc:
> 
> gcc version 4.9.2 (Codescape GNU Tools 2016.05-03 for MIPS MTI Linux)
> 
> 

I am using a 4.7 based toolchain, and don't see this.

I think it really is initialized, but if you like you could add an 
initializer at the top of the function to quiet the compiler.


> arch/mips/net/ebpf_jit.c: In function ‘build_one_insn’:
> arch/mips/net/ebpf_jit.c:1119:80: error: ‘target’ may be used 
> uninitialized in this function [-Werror=maybe-uninitialized]
>      emit_instr(ctx, j, target);
> ^
> cc1: all warnings being treated as errors
> 
> 
> This appears to have been the case since the ebpf_jit was merged in 
> b6bd53f9c4e825fca82fe1392157c78443c814ab.
> 
> Thanks,
> 
> Matt
> 
