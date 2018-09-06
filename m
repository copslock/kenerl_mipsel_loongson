Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Sep 2018 00:24:06 +0200 (CEST)
Received: from mail-by2nam05on0715.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe52::715]:2320
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994644AbeIFWYCtG0Cb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Sep 2018 00:24:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaGnjFZvyAH2q+0TudCrnLVXOtjMSTfRdFJSR7SQcKU=;
 b=ncbPvRXh354ztz7+pKQwo9iJ8IqKGUxixy6081UY+F/kKAPKOUdG8nSPghEo0TPBQjdpBqezHMA+j/6ALkOOiuLpPzbTwoqt1UGM7phxIzNwjhqNWzPv4C9ifvzVJ89z7m3LUePBfpxUEoqVEsdCYUFeM2GZqckE8fZEehkbzWo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from [10.20.2.221] (4.16.204.77) by
 CO2PR0801MB2151.namprd08.prod.outlook.com (2603:10b6:102:17::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.18; Thu, 6 Sep
 2018 22:23:16 +0000
Message-ID: <5B91A8D1.4060206@wavecomp.com>
Date:   Thu, 06 Sep 2018 15:23:13 -0700
From:   Dengcheng Zhu <dzhu@wavecomp.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@mips.com>
CC:     pburton@wavecomp.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org, rachel.mozes@intel.com
Subject: Re: [PATCH v4 0/6] MIPS: kexec/kdump: Fix smp reboot and other issues
References: <20180905155909.30454-1-dzhu@wavecomp.com> <20180905225455.luh32536uei5je6m@pburton-laptop> <5B917DD5.6020009@wavecomp.com> <20180906203455.pap7lh5itrbp7ed2@pburton-laptop>
In-Reply-To: <20180906203455.pap7lh5itrbp7ed2@pburton-laptop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BN6PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:404:23::34) To CO2PR0801MB2151.namprd08.prod.outlook.com
 (2603:10b6:102:17::6)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bd688de-44c6-4089-ea26-08d61447587f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR0801MB2151;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0801MB2151;3:tiBpCV34WsOOJvbJdpVir/5eN6hgWeKK8DH3ANkRTWOs8fcd48vpg+kblw1kcewz6Or62c4ZdZO2Jm/Q+983W1QqCIUSbRfkWyYW8DMLbh1otfxjodRlGu1uw2la5fMzojaTecoNG93h0LjqCEVZmtcBsE/mV+LFEXu4f0OEkUhsfPgVpG+QvhHAzKhI8OZlZmKOR8rsWqUzZ4ezIzdWmfW5Umu+c45ezMZuYluWEsh4YYQbt2DcTYgxLGQC+uZh;25:Vl7Q7mRPpqr4LXM/0SN8Rjv5P6i20TVe5iinWx3MpHPICdFyL0c41EvVBtYP4Xtmfef5C7Oso0e1BU3M89MDjlT0LcqnYC5/k0/Agw7qdMyV3Jil6JY5d2mNxGbEXFCEdtSARFU4w0zTpKs2QAbfHi30oOiYx6hwkllTUPIsVDEspOabq1hGdbZG+1izN7YLkdWqpnj3DOwUq9sVscLVbQl02RVTM0eb+zX946Rf1F7xidYu/1oSrn9Y3e2c9NWAdOn2mkRHI9dpqtKKLibqTEXxF312rFBT2+GbY/+xHyk6ys4xHJ+8Ik/Jfg6MpEWrItwQf9emAoOmTXszksUI0g==;31:0OEr/HvVfSWiYtZBoYrT4FA1ypQsrq7vLSRENQeXtevOYphhGErKATVhYzHHjOvtlsemAJb50INQuxTnAdo9/5rZ5RB6Vjr8F+N9cC0sT4yLL5k2VXJASf/sTttId2bG22tDDrIxFAMMU7Mf73Wpxe7H5kan6gj6ktcp32ualp2ZF+goKSBcSzNx++Fb5hxun5XovMO6Qiy4/L63OMYtBGhc/8kCPL85ZTeDJAfqeXs=
X-MS-TrafficTypeDiagnostic: CO2PR0801MB2151:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0801MB2151;20:0LL/16n9jRHXUO15CVbadqZ1rkHNY0ajwlX+4Z7N7mqHF91XVsgEclHkcTN7yTDIqrviIGCtLBZv9cDTSMUJv1WyAmf7vBsEDcvaMBLl2sB6QgsIFICocETwp8ERCdJVKs7A3uek3kksAUg0EuP1lG5A/obAwruspjXyi5NAgw4PIhT4xileoOS+38q2ER3kS1N0kjvEk2o8vu7EdYVEhjypXD+YumzQfhtlL0uLoyAMigI5jY8fW5SxTapy1pT0;4:kuNnS549HYHSLj67ofaXlBZzMV+6vQxTWP7KGLnQLF0vS1hJiTfJkYSXmocNL2hf8RRtZcP4+w6sDLOe4KGeUPCkmUFuV3TvC7ozkZLG3GG/Ique5aDieU1lRSTefwyRb5FUX6/deroNmBmHsGdr8GSn5L2WoQQo36b1D+0e/K5NKv9kDuZMMzTncxr0OorWH1BjDREW/hdsGYSsHxSOIJh+tpWIa7EbtzCSMKPnRTHgCq1WztiyrqZWbR8IY/jO4zBrkHsC7xM2YxHeAlVSSXfr0ZX2KlOIEESdZ3zhqAulGQ2e3nMCddMYeMgzMmHKZy3UxZGBfLR4EgqDma3S3aBjn7vfaD/6ZrZ15I8x+jXAB0/zGGxGUhkkOfjXJudi
X-Microsoft-Antispam-PRVS: <CO2PR0801MB21511FD82692B3A8285BFD4FA2010@CO2PR0801MB2151.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(190756311086443)(209352067349851)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699016);SRVR:CO2PR0801MB2151;BCL:0;PCL:0;RULEID:;SRVR:CO2PR0801MB2151;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(136003)(366004)(346002)(376002)(39850400004)(199004)(43544003)(52314003)(189003)(106356001)(59896002)(77096007)(26005)(105586002)(58126008)(64126003)(6862004)(4326008)(47776003)(25786009)(6486002)(446003)(53936002)(16526019)(23756003)(229853002)(53546011)(478600001)(316002)(81156014)(52116002)(87266011)(305945005)(36756003)(11346002)(2906002)(2616005)(67846002)(65956001)(476003)(76176011)(65816011)(65806001)(956004)(8676002)(68736007)(50466002)(81166006)(80316001)(14444005)(230700001)(3846002)(16576012)(66066001)(93886005)(33656002)(6246003)(8936002)(97736004)(6666003)(386003)(5660300001)(86362001)(6116002)(486006)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR0801MB2151;H:[10.20.2.221];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;CO2PR0801MB2151;23:8UcJN+jpbi3Feu1FEjBHZgY1inplEKXxG8tds?=
 =?iso-8859-1?Q?UwZHSLVYqYbfPDKYNVJ2Gr5d5jNkMqHvAOVz/28xlyJU5NisaSxpHOhoPe?=
 =?iso-8859-1?Q?/OWPFJrC/88zY2XvnmGERPYVfBEXdVmEuVfYgqZQKfYhCxxSxtONM8mKTH?=
 =?iso-8859-1?Q?co3vXneaSahryAISwlg2PjusXasoVDcypkTWGPA0a1hF4AVKQ4lFHeCqEB?=
 =?iso-8859-1?Q?m2ncby2cAfqHY5ctB1HbMC6+Rrq39i3Ow69HRzqkdFA11v2EhkAVBd+3/b?=
 =?iso-8859-1?Q?woUB+nENwjKgr6BBERK8y/ltQZIj4RluzsoaCtk8hw5XVwLo3bbr9xdwO6?=
 =?iso-8859-1?Q?4ifwfLY2wa/q0dYyuKJdFVhZTuOptFGc+rhLeKI3cJ9J2LQmjT3mQ3sR7t?=
 =?iso-8859-1?Q?4tVr9lnxJQ7dm4LIYLeuFTvQCJEeii6spSlaz2W5hZTjKeyveDNXp2ctXs?=
 =?iso-8859-1?Q?9SCXBxbqwToQHbyXVBZMcFFZfRRaVTP4EK0QBwbfzKIS9lF43HFJbZ87id?=
 =?iso-8859-1?Q?WXvxI/Ci18Mq2vEsUI+DBHpflUeVW+q56rVFm5mli3RbSTo+SKD4WyTMAI?=
 =?iso-8859-1?Q?XivfjRGVOu9SRSXqOL2oM3KndHkWVcP1VIopdMRcAjrvwcRg/ym7Ypi0zf?=
 =?iso-8859-1?Q?K3dcuStUIMly/730O0vs+eetD2YiBvUEVa9IAFsmg4h5GODv9C2wEPBTEf?=
 =?iso-8859-1?Q?wZ7DKtIeLTdnvYojxAze8waQQh+Y3fGMZdveOW+BJEm2BMKc9+mynPfk0Q?=
 =?iso-8859-1?Q?df16JQG3rw82ykD4G6DO1hJtsjRfc8hjY7FiNMeY2hsQWa3Y4+OKHWTALg?=
 =?iso-8859-1?Q?1H5QcjH5rYTH+xvh61SK3N/zy74Llk6uR5FK4q8BGvdRNOpL7NLQ8PV7yt?=
 =?iso-8859-1?Q?Wn03ghVBojpGnuL95PVnVD99cz575VVW7OzCR8SjRfTokz5PdNQxKWVIIf?=
 =?iso-8859-1?Q?o6ZLRzNuQ+GZ0gimKA+tId8JjW7jnnic+m5w6XxiHpFp5PJpuQ8fOMLv57?=
 =?iso-8859-1?Q?37pO/ue9i8RyR+e+ZfTqBP4yRB/kv16iqxvrGLy08/dniLHLH75sAi2Xta?=
 =?iso-8859-1?Q?Vf2loeEZEVU6XYErDDYNjMMzeM4gZqosluodgb9n9xNGrNlqeQJ5SDIIjK?=
 =?iso-8859-1?Q?1UCEPsuXcuzW0UEnZ7cX4Sz8qOosAX6CN1pOlFBDjO3WStR3ao8f2ojw9T?=
 =?iso-8859-1?Q?a8o2m6cXZ951V0f5FHwAdMGqLWB/7r6862evotWzB5nco/boXYKBA8lZkT?=
 =?iso-8859-1?Q?hgPhjnUtKfRaoMzXc+u00ICFV8xJzlwIXd2ihMsFwO4vcrKC5gu1hjIr6B?=
 =?iso-8859-1?Q?yPy1PuiOIhgOL8PjISgzisl/QgLptmOac4ayoOKXj0dR3BFhC4XpooW5C2?=
 =?iso-8859-1?Q?+xXetda4atFQa2j4egsKCEYvVWhuBbEKlgUHZSK3duTmbYFd+1ElPCaACL?=
 =?iso-8859-1?Q?+KIRT7Ql+kpw9uUQ3XSAQ5E3Mdwxi/IXJI6ZF17psHo0fZboUJ5zbSF0i6?=
 =?iso-8859-1?Q?iTOrcoeaQzwm088HLp5o0M3W/jZIgsj5i0CT2NRDNH55B3jmT5mpXcFf1K?=
 =?iso-8859-1?Q?YmhDdiQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: EKS3q/72ou8VsxOlhwhJQi6q1n1TPuF2lf6yZc4l1HSwzJMJuYNOKUWCBLLN67v89bWFv8tLNOGxpfDHVzTbs0aj9guDYhLcvmsiLL3RfeyIlf17x/06RXC3Cgd4FKtNabD0h7NJssj2oSK7l4NKZWQOhIS0CJHu1a9yAXAhOCjtH1pSIhieP5rPlKnvFbLBDSNWCra45lgxaTq82eaYtIOModV6nheOpXWBFOZZaJpVKeUkWb7UlrhheE9WZgLarzGo3pkQfjEDDfLLlZQfL6htbq3ZsHaNHxNuDPrYO0RJTRyg/CuqHlEyCUWp0ZC6UIwy5zW6gThACX8+SW5F0ygwLI+S/OQ3v85Nt66vcsY=
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0801MB2151;6:6MgoHy26pZ7AdCoMlsAztNsCRRW73rXr8kIk1DlhRkaDyXxZdCfBQDgJLQS52u8n6GuxYviZSWaSdR6GWE0IF92LtawPl3xCLNmUryzvYsSx78EFmabca1XBYHnLjIhmRLRKPxq3ys4Poi5UYFOb2MqDRA5VI5mkjvr7IpQgq1u9oqj18/mZMygO1MCSc0KUqIVz0ZL4/IOrgBC3G7x19Lvkue/ihnlrnNcjxu0JqL62pa9bOzTlLDj1D0MOL+iZnarxvSTCQhzhwL9YeCvkriOH+dKtanGKxXQiDakS3bCft4g6cyANav1xvGbwf/DM4boD78jkNuoKmKJ2djdmjwzs1VzWEEd7NjYub0pf4Su2xFKtpr55pl5lzGLMkkUIUTPIr622RIt2lF+jc2I+z4T5SPXkA89cTUtyvTbw19Yi+rLAMurI9n1vlT0ApsIw3zCopkf2VjfzxSKV/cofYw==;5:uYv7z8By2Y212Lcq9AEmwtEfY/Y9RhtLVGWpXjFTzhdtYpL/gOH/L56Q6CveTHi359ziPLrXjikCPXHYHBSl9N2lTeO6RinqM2snnx/hRcLpIEIBE95lHKdMoHFDp12h6VFzpb6isUV6kY6X+8kYKmUQeaDKKURGHjU+d8wEAB4=;7:YPDFJtCbx+ViTQrXBIOsjdgzgzpV1fADa7bCfqBqWj8vN+5zyfl4cX5V1cjg580rF2CAw348QvcXpuv6T5wP2tkXCQWONfcrj3m2nzzz24oGXwdsc0WT67g+2pmH0hR365MgMm6Bf7glYOC39G1MD1QODNZr1ISfKDlREDW/oJabxYtTu+5js4M46E0L1FfPfc5mVKp2vzFni40n3sCJx6bsYbO8oMpLRYOFq7ERflBN54ODbMFh3/FDKYbyOx64
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 22:23:16.9202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd688de-44c6-4089-ea26-08d61447587f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR0801MB2151
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dzhu@wavecomp.com
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

Hi Paul,


Regarding cache flushing in machine_kexec(), I recommend simply removing
__flush_cache_all() as CPU0 will do local icache flush before jumping to
reboot_code_buffer, and other CPUs don't jump at all.

Re: marking CPU offline in kexec_this_cpu(), it's probably good NOT doing
it either, as the system is going to reboot from CPU0 soon. HALT is good
enough, no need to gate core power. As to whether it's safe running
play_dead() in parallel, it shouldn't be a problem, as the loop is based
on cpu online mask (which we don't mark offline as mentioned above) -- The
CPU will simply halt itself. For non-MT CPUs, play_dead() does make sense
as well, as it's supposed to stop this CPU's execution, getting ready to
reboot from CPU0.

On UHI stuff, if it's true "future platforms will just use
arch/mips/generic", then certainly no need of getting code out of Generic.
My feeling is the customer is NOT doing so, according to "I fixed it by
moving the code to another file". Other MIPS systems may be like this as
well. I understand your "upstream-or-copy-code" point, but the only thing,
which IMO meaningfully justifies patch 6 *for_such_cases*, is already said:

-----------------

When the kernel developer of an out-of-tree platform
   wants to make kexec work, they will naturally look at machine_kexec.c,
   where they will find this UHI stuff, obviously telling them to do
   "select UHI_BOOT". Otherwise, unless they google onto this discussion
   thread, it's harder to know the solution to the kexec_args related
   problem hides in the code of another platform (Generic).

-----------------

In other words, it may take considerable efforts to realize "copying the
generic_kexec_prepare() function" can solve the problem. Copying code itself
is certainly not onerous.


Regards,

Dengcheng


On 09/06/2018 01:34 PM, Paul Burton wrote:
> Hi Dengcheng,
>
> On Thu, Sep 06, 2018 at 12:19:49PM -0700, Dengcheng Zhu wrote:
>>> I didn't apply patch 4 because I'm not sure it's correct & I believe the
>>> changes in the branch above should take care of it - CPUs that reach
>>> kexec_this_cpu() are maked offline, so they shouldn't be IPI'd by
>>> __flush_cache_all().
>> I believe patch 4 is necessary. As mentioned in the code comment and patch
>> comment of that patch, machine_crash_shutdown() is called prior to
>> machine_kexec() in the kdump sequence. So other CPUs have disabled local
>> IRQs waiting for the reboot signal.
>>
>> In fact, in kexec_this_cpu() [you renamed and modified kexec_smp_reboot()],
>> the added marking CPU offline will cause system hang (tested). This is
>> because it will change how play_dead() will work.
> So the problem is that patch 4 isn't really right either, and I suspect
> the hang you mention probably shows a problem with the whole play_dead()
> approach from patches 1 & 2 too.
>
> On the cache flushing, what we really need is for stores performed by
> the CPU running machine_kexec() via its dcache to be observed by the
> icache of the CPU that jumps into reboot_code_buffer, which is always
> CPU 0 after patch 2. Using local_flush_icache_range() will only ensure
> that the icache of the CPU running machine_kexec() observes the changes
> made by that same CPU, and does nothing with CPU 0 unless they happen to
> be the same CPU or siblings sharing caches.
>
> Consider I6x00 CPUs for example - patch 4 may *almost* work OK because
> both cpu_has_ic_fills_f_dc & cpu_icache_snoops_remote_store are true, so
> when the machine_kexec() CPU writes to reboot_code_buffer CPU 0's icache
> will observe that & will fill from dcache without needing it to be
> written back to L2. It's still not quite right because if CPU 0's icache
> already contained any valid lines within reboot_code_buffer (which could
> happen speculatively) then it'll execute stale/garbage code.
>
> The hang you mention is likely down to the fact that play_dead(), at
> least the smp-cps.c implementation of it, is written for the CPU hotplug
> infrastructure which will only operate on one CPU at a time. The loop
> looking for a sibling CPU just isn't going to be safe to run on multiple
> CPUs in parallel like patch 2 does. That's true of either your original
> patch or my modification - it's just that my modified patch will cause
> siblings to race towards powering off the core, whilst your original
> will cause them to all halt themselves & never power off the core.
>
> Which inclines me to return to my earlier thought that perhaps we
> shouldn't use play_dead() for this at all.
>
>>> The CPU that runs machine_kexec() should still
>>> flush its dcache (& the L2), and then CPU 0 invalidates its icache in
>>> kexec_this_cpu() prior to jumping into reboot_code_buffer.
>>>
>>> I'm also still not sure about patch 6 - since no platforms besides the
>>> arch/mips/generic/ make use of the UHI boot code yet I think it'd be
>>> best to leave as-is. If we do ever need to use it from another platform
>>> then we can deal with the problem then. If an out of tree platform needs
>>> to use it then for now it could copy generic_kexec_prepare() and deal
>>> with removing the duplication when it heads upstream.
>> Understood. It really depends on how this problem is viewed. If patch #6
>> is considered creating a framework for future UHI platforms, then it has
>> the following facts:
>>
>> * It doesn't create code redundancy. I mean, it does not add unnecessary
>>    code to the kernel.
>>
>> * Out of tree platforms will get access to this functionality by a simple
>>    "select UHI_BOOT". When the kernel developer of an out-of-tree platform
>>    wants to make kexec work, they will naturally look at machine_kexec.c,
>>    where they will find this UHI stuff, obviously telling them to do
>>    "select UHI_BOOT". Otherwise, unless they google onto this discussion
>>    thread, it's harder to know the solution to the kexec_args related
>>    problem hides in the code of another platform (Generic).
>>
>> * It simplifies work if the out of tree platform wants to upstream.
> Well, ideally future platforms will just use arch/mips/generic rather
> than adding more platform/board code at all. Right now the only reason
> not to is if a system has a memory map that doesn't fit nicely, which
> should be resolved at some point by mapping the kernel which will allow
> the generic kernel to better support differing physical address maps.
>
> So I hope we don't add more platform code anyway, which would make all
> this moot. I certainly don't want to encourage adding more by explicitly
> making it easier to do. And if there does come a point where we need to
> add more platform code for some good reason then we can deal with this
> at that point rather than speculating now.
>
> For out of tree platforms, I don't think that copying the
> generic_kexec_prepare() function is particularly onerous anyway, and
> should be trivial to remove if such code is submitted upstream. Whilst I
> wouldn't want to make submitting code upstream more difficult, it's
> likely to need some amount of rework if submitted upstream anyway so
> this doesn't seem like a big deal.
>
> I don't think upstream should be particularly concerned with making life
> easy for out of tree code - if one wants the benefit of their code being
> taken into account upstream, then one should submit one's code upstream.
> In the paraphrased words of my pastor at a marriage prep class - no
> benefits (except those already conferred by free access to open source
> software) without commitment.
>
> Thanks,
>      Paul




Dengcheng

---------------------------------------------------------------------------

*From:* Paul Burton <mailto:paul.burton@mips.com>
*Sent:* Thursday, September 06, 2018 1:34PM
*To:* Dengcheng Zhu <mailto:dzhu@wavecomp.com>
*Cc:* Pburton <mailto:pburton@wavecomp.com>, Ralf 
<mailto:ralf@linux-mips.org>, Linux-mips 
<mailto:linux-mips@linux-mips.org>, Rachel.mozes 
<mailto:rachel.mozes@intel.com>
*Subject:* Re: [PATCH v4 0/6] MIPS: kexec/kdump: Fix smp reboot and other 
issues

Hi Dengcheng,

On Thu, Sep 06, 2018 at 12:19:49PM -0700, Dengcheng Zhu wrote:

>> I didn't apply patch 4 because I'm not sure it's correct & I believe the
>> changes in the branch above should take care of it - CPUs that reach
>> kexec_this_cpu() are maked offline, so they shouldn't be IPI'd by
>> __flush_cache_all().
> I believe patch 4 is necessary. As mentioned in the code comment and patch
> comment of that patch, machine_crash_shutdown() is called prior to
> machine_kexec() in the kdump sequence. So other CPUs have disabled local
> IRQs waiting for the reboot signal.
>
> In fact, in kexec_this_cpu() [you renamed and modified kexec_smp_reboot()],
> the added marking CPU offline will cause system hang (tested). This is
> because it will change how play_dead() will work.

So the problem is that patch 4 isn't really right either, and I suspect
the hang you mention probably shows a problem with the whole play_dead()
approach from patches 1 & 2 too.

On the cache flushing, what we really need is for stores performed by
the CPU running machine_kexec() via its dcache to be observed by the
icache of the CPU that jumps into reboot_code_buffer, which is always
CPU 0 after patch 2. Using local_flush_icache_range() will only ensure
that the icache of the CPU running machine_kexec() observes the changes
made by that same CPU, and does nothing with CPU 0 unless they happen to
be the same CPU or siblings sharing caches.

Consider I6x00 CPUs for example - patch 4 may *almost* work OK because
both cpu_has_ic_fills_f_dc & cpu_icache_snoops_remote_store are true, so
when the machine_kexec() CPU writes to reboot_code_buffer CPU 0's icache
will observe that & will fill from dcache without needing it to be
written back to L2. It's still not quite right because if CPU 0's icache
already contained any valid lines within reboot_code_buffer (which could
happen speculatively) then it'll execute stale/garbage code.

The hang you mention is likely down to the fact that play_dead(), at
least the smp-cps.c implementation of it, is written for the CPU hotplug
infrastructure which will only operate on one CPU at a time. The loop
looking for a sibling CPU just isn't going to be safe to run on multiple
CPUs in parallel like patch 2 does. That's true of either your original
patch or my modification - it's just that my modified patch will cause
siblings to race towards powering off the core, whilst your original
will cause them to all halt themselves & never power off the core.

Which inclines me to return to my earlier thought that perhaps we
shouldn't use play_dead() for this at all.

>> The CPU that runs machine_kexec() should still
>> flush its dcache (& the L2), and then CPU 0 invalidates its icache in
>> kexec_this_cpu() prior to jumping into reboot_code_buffer.
>>
>> I'm also still not sure about patch 6 - since no platforms besides the
>> arch/mips/generic/ make use of the UHI boot code yet I think it'd be
>> best to leave as-is. If we do ever need to use it from another platform
>> then we can deal with the problem then. If an out of tree platform needs
>> to use it then for now it could copy generic_kexec_prepare() and deal
>> with removing the duplication when it heads upstream.
> Understood. It really depends on how this problem is viewed. If patch #6
> is considered creating a framework for future UHI platforms, then it has
> the following facts:
>
> * It doesn't create code redundancy. I mean, it does not add unnecessary
>    code to the kernel.
>
> * Out of tree platforms will get access to this functionality by a simple
>    "select UHI_BOOT". When the kernel developer of an out-of-tree platform
>    wants to make kexec work, they will naturally look at machine_kexec.c,
>    where they will find this UHI stuff, obviously telling them to do
>    "select UHI_BOOT". Otherwise, unless they google onto this discussion
>    thread, it's harder to know the solution to the kexec_args related
>    problem hides in the code of another platform (Generic).
>
> * It simplifies work if the out of tree platform wants to upstream.

Well, ideally future platforms will just use arch/mips/generic rather
than adding more platform/board code at all. Right now the only reason
not to is if a system has a memory map that doesn't fit nicely, which
should be resolved at some point by mapping the kernel which will allow
the generic kernel to better support differing physical address maps.

So I hope we don't add more platform code anyway, which would make all
this moot. I certainly don't want to encourage adding more by explicitly
making it easier to do. And if there does come a point where we need to
add more platform code for some good reason then we can deal with this
at that point rather than speculating now.

For out of tree platforms, I don't think that copying the
generic_kexec_prepare() function is particularly onerous anyway, and
should be trivial to remove if such code is submitted upstream. Whilst I
wouldn't want to make submitting code upstream more difficult, it's
likely to need some amount of rework if submitted upstream anyway so
this doesn't seem like a big deal.

I don't think upstream should be particularly concerned with making life
easy for out of tree code - if one wants the benefit of their code being
taken into account upstream, then one should submit one's code upstream.
In the paraphrased words of my pastor at a marriage prep class - no
benefits (except those already conferred by free access to open source
software) without commitment.

Thanks,
     Paul
