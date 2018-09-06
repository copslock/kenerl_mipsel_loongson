Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2018 21:20:11 +0200 (CEST)
Received: from mail-eopbgr680105.outbound.protection.outlook.com ([40.107.68.105]:31138
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994644AbeIFTUGQbO0I (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Sep 2018 21:20:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4L0qiH6CD+bLZIYMkpdwRnSxBctNLoCQhjX2R93bfmo=;
 b=LrnB2mtWOmRJTJNanpK88uZXNEhiui1t0LKT2eekNdUkYDzSR5PBKcnovb8SaI+dos0sFjSaxrrTP0oIqy9P0AZI/DYF8AG6vb6C6OxvUgP9jSkHJt1GRm+hw1pvs1imYYsm3pqt+Bh3ogJKgx/ssdQ14sWPTD+6/nH0h+dpN0I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from [10.20.2.221] (4.16.204.77) by
 BN3PR0801MB2146.namprd08.prod.outlook.com (2a01:111:e400:7bb5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.18; Thu, 6 Sep
 2018 19:19:52 +0000
Message-ID: <5B917DD5.6020009@wavecomp.com>
Date:   Thu, 06 Sep 2018 12:19:49 -0700
From:   Dengcheng Zhu <dzhu@wavecomp.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@mips.com>
CC:     pburton@wavecomp.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org, rachel.mozes@intel.com
Subject: Re: [PATCH v4 0/6] MIPS: kexec/kdump: Fix smp reboot and other issues
References: <20180905155909.30454-1-dzhu@wavecomp.com> <20180905225455.luh32536uei5je6m@pburton-laptop>
In-Reply-To: <20180905225455.luh32536uei5je6m@pburton-laptop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BN6PR10CA0043.namprd10.prod.outlook.com
 (2603:10b6:404:109::29) To BN3PR0801MB2146.namprd08.prod.outlook.com
 (2a01:111:e400:7bb5::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2032dff9-e048-409f-533a-08d6142db8f5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN3PR0801MB2146;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2146;3:DxSm+acHVXGyDY4eYeGb9JK88fJO5F+LZcYuI9tssyHkmkH8JXzZ1SGt2BhBOw8AXRC3lVdbACfYErDvovPa+PAtXeDSW6VPUXrM88ARNC+U36dpiwGOgzg+2EY4Baw0IZuvRkl9329BTOtsFVNM4VaQJPsO7Ju55JuVt6tXnGtm2Np1vrUYufbk23kmr1qI9bw5dM7u1hIgU06NAMbngQY+7gA3EchZWjrVwy67JlWydy5J5XD3ZckOTDQeXMji;25:r2UnERyxwFzEgR5fMJnhijwRO54ndmi4cqmEMZStTDkE4oLrqZ8Xn8t+pMYtL4F+Vvej39BXINJ1h+VlzMo05Z/arnndIOi5JVjJpF2FkP4bVr38pY+q9uadAT7IMsf/lZjnaelszmmZutG3EyDTE1wqkJiUHTjma740zPXaQRjX2iJ+2gs2xQQcPVON1MIk1fp9twWTRIxfxa3mjdtH7vN644vR9iuQyDJb4sGo4fPca8ojjI7vKqbOiQHBeZKIPadWHSlnNWI3qIQPwZcNzTeZ/9gWhUZQnS3Lhy6IOcd4GCm7JydhbNMRhRy6S90N0IgIehkGJW9Vk1ahtI5OFg==;31:ypDw0wHn3MKyJXmF9fGfdRFUzRp20N1WOeA2jmMWw6mywFJkAuFZTs0vKJOk+1s4SDRiXlfg/LdR78zC8g6GcbRmgpHmm8Z81kuj5Jr9IaK97PycNPJrdDHEqsiLlnDsgkveg2goZQ0rUifsdTyWJQtWq1yc/nEw/EVhiWI4uZ2OGgcNLjK3lUYn2O2hWlzq+Dmy33wdaCzvadYfPJXk3PkMBdrACIS7tWmJ4YpHiTg=
X-MS-TrafficTypeDiagnostic: BN3PR0801MB2146:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2146;20:rJ2xgDKFf9gB1YFHgXu1vjOFhv3T+s7i6sywubthHQpoKamjfE4vMGQ82f5wxyqdgnwHoVw4Ymx5LEuljrmsdW21hc01+dmcn102TrTpr/ulerGV9vmDudDDakryZnEtY1QGojxvPUvw6x1BHH+VattxZS8w7+KYjnKCqVhMOZKs9txy53sSxGq2D/GYY9DMHWUGH283Gz0ZVNPqjCHDUKt9VQfVgE1H7WUUk5xIsq1ENM4iEW9fzGiNhr92W20b;4:p8Uo8leuJGO1v3uLjIGdF7uE4wV10NOziH5anuK6r8PKIXxuejEhZIRmMKwJxd8StyvgloUAdYkh3FhaAjzmE4KqAllBIowVEyFTgtpOWypK930Kep6nQnf3DTubHNlHIa3GCTDe5k4rD4b63t4fcMackcG+xSdtp8CnUuQzhV4aeDLTulrPE7LR/4MzemKBNspW5TH2a92LxStFuNi1JJccOdFD2dwRNRMb1VHSalbeF87GF/c34KPgfLmOabCMU5YLulml78nNv8tR+9NOo5VMbtTfU8mkFD3qWU9DzTre70iUpQffR9FqLUUYyvwA4aX/lg999w10cw1mrnl3h/NXuQoxMcRJFU6/49EjlpU=
X-Microsoft-Antispam-PRVS: <BN3PR0801MB2146B391AE25C67F9958C2C4A2010@BN3PR0801MB2146.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699016);SRVR:BN3PR0801MB2146;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0801MB2146;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(396003)(376002)(366004)(346002)(136003)(199004)(189003)(43544003)(16526019)(59896002)(81156014)(478600001)(5660300001)(106356001)(4326008)(65806001)(25786009)(66066001)(65956001)(6862004)(8676002)(105586002)(33656002)(47776003)(6666003)(230700001)(23756003)(36756003)(3846002)(81166006)(52116002)(65816011)(80316001)(87266011)(76176011)(67846002)(6116002)(16576012)(316002)(966005)(2906002)(58126008)(50466002)(77096007)(53936002)(64126003)(229853002)(6306002)(476003)(446003)(86362001)(11346002)(956004)(2616005)(486006)(97736004)(6246003)(26005)(14444005)(8936002)(68736007)(53546011)(7736002)(305945005)(386003)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR0801MB2146;H:[10.20.2.221];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;BN3PR0801MB2146;23:UxNhnKmcLBQg89jMYDhqmrJ17XlKIeXRhGPLI?=
 =?iso-8859-1?Q?gfocNIakXIxJXkiWpm3bkkXL2+27Au+q/MulrGOowMapd9nnNbsT89bK9R?=
 =?iso-8859-1?Q?WgrcDo6KVlISc9/hwJRN/AlbKzuWi4u8WDyWrhFZA0GAaG+F7Av/Ij5t35?=
 =?iso-8859-1?Q?dywH8LgNX5oa07/FOATuP2VM39z+viOYy3pwxoJI2i2Y9AnsEkO8mD5ZB5?=
 =?iso-8859-1?Q?aD8DMfeKR03xt7VERzwqlfuj6pECYAwt9U7SHRGmtTm+1LuaD9+MhVlrYB?=
 =?iso-8859-1?Q?zsvciVj2oJjbhQiUSqiWdcbUrWbW3ArRi1FTUtrNeFOT0fTiCLazoFgNn8?=
 =?iso-8859-1?Q?WKlqyeXvD30ufgFRyAVWXdImYa51Hqe4giL5Qb30NKHiP0laiUEYLXxTuZ?=
 =?iso-8859-1?Q?xD/vMDNxVawfLY6qNUREEyE0lxKT8Ok04w4In7s5NTU5HOtVt4N8MERpon?=
 =?iso-8859-1?Q?e2Q5UDNJYEIHk/y5RBec9N+ZI9E5EWLNh0NdpDQwazaro6M2h3CVpjRoo0?=
 =?iso-8859-1?Q?9Z8GU4XvnTH18P44OU33dcS3993y78P37mqWvaDc0dc/e6KvrW6IkHj4hi?=
 =?iso-8859-1?Q?w8HX/zYLjQ/QxhfTil4Z8+3W/ZUKz1f2DkI6EpeRm0uy/X0OWJtzoCRNJb?=
 =?iso-8859-1?Q?2VlXfc/Lpo2UWMPdOcThjSNa44G/j2vIBvpAeODO6nzbsxZXxhcRsFvuZW?=
 =?iso-8859-1?Q?Nl4tHVekyg4gTM/20KDHeqC2Aqu/L0lMHy7314wi3wdQnYsoXx+bN6jBp5?=
 =?iso-8859-1?Q?jIctTyX4wBWvZfgmSIAvzCLcaT0ZfnRL1wz+XjAqjiDo5hHr959feZZ59s?=
 =?iso-8859-1?Q?otY7EviNzRz8DIWlGcT8j1BbAuXvT8MJPeOlzqEHQ5oQ10R3Lu1qWfcyP/?=
 =?iso-8859-1?Q?xPplb+g/KcXhaV3IZn1kPqeLxEgSHRhEM5fQn0cG9k4gjns17ArreSYpEE?=
 =?iso-8859-1?Q?PJ6BkRXBYLb1/5IZexYSGwC99pw06V4je0i3pxaMh/5jXQ6oklteqVrobB?=
 =?iso-8859-1?Q?RTiwqxhSsiKS/TgMySNHlmhRHo9Js/H54eohPR/UZYMrElaljLxLj9+MBr?=
 =?iso-8859-1?Q?a5iAHRY8sN1owSvg4fyqtUI3lTg5WxWtQa8zjxFHnOQjOCR7SSoiAzkJDs?=
 =?iso-8859-1?Q?K50XhkEi2S4qSjkECoStV7biBEOCbs4HmQ2k0yKV4ABDOpqDBU3FL43Lr5?=
 =?iso-8859-1?Q?S1sDi4RnfNIU/+KCzKA1VDRA8eYBDAuXo5oP7EZCKwc0jJ2jmfDjSDF2Qc?=
 =?iso-8859-1?Q?gu+IU1O7vwqkiQSbODhqXcG3PsuOTsK7WY7HteUfsO5iFNq4H9+dt4QMZf?=
 =?iso-8859-1?Q?S2ohw5Jq4mhDaFrYNwvjEYKSM9+3C22yMM/xKAro2zUd4KBqEKEXFRetKD?=
 =?iso-8859-1?Q?ooy7Rmm/5FK0RK3a/Q0Ft9UQKm3RtwzIqhaaG/qvbaL4+7gXGlM0a/Nb4E?=
 =?iso-8859-1?Q?qzaEOp1OVaa+M4wRMTnVzUD2Zb42zmUF83RdyShUykmHz6P+BAC6hwcI8z?=
 =?iso-8859-1?Q?3t4BwGmHmfDN98kJWnyRO/SIoCK2IEUgZCheGySGYu8ECnQZRKzgLET1qI?=
 =?iso-8859-1?Q?iR+GNCA=3D=3D?=
X-Microsoft-Antispam-Message-Info: sI6DjolQ2g3ChDuvq5NjQ58adHzF4NV8k4bN8BwqV1VqLjuEDQDIg2yskDl05FxdZ3rBosLdX14HbJXN5DZBUpDp9pLnX/bLywkE4W/vFwvAHfUZdB9M2v4PTaFS5qC7bHw7Mq4IgR8o/lXsbCObgY3gPSSzq63gmaJOieLbPXADiH1yNqaFfHPhBwLt00PitukavNckGv4D6h4ZtJ+4H9xLlt17qipoBO1Eb4uAXHwxbELApZGQABvv9VNbAoWdgCixed+qs7JQ8YK2LQaFSceul+dDQJaWMGzKjPnF00+p9NnMxfrIdlZyGC16rWxSsKo/urBmY1SKLMSJT3uR1fR38lGaphD+OhSLZTaQQio=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2146;6:8T1sLjTZW8vUXex46Ys+MSCdKZjSrlAXy8UUMbNAn9bhW6Y7mKiozc5D6jzAC3IM8YFlg7TBT2HRwfEsGy1NSFLmvflSZXW9MzfQDYJs/mfUU3Op9AEgKf8NiN3AB4/dXB9GYijZiWq8lv7PYwppAbAJwFbT54xSK22S60wezR9W/Nr+6/ujMN8leXoB2sTMvn7PJTw8YufNqfh2T2rBfT2rvcC446QQhn+oLXIhiate6Ab1KGEdVrezNrwwaCfJUxyPbRjX0I7Wr6PXIPa9K1Ta8eFyAXQpP0a5NoxG+/UnM4lHxg33o+ZqWv1cvrX8H+PLvAXS8bmQc3BH+sW+rPYyJ8L/rmaJBGj+gYTKC2HoPndy0xFiCONPvWdJHjAMeD1BoCeC/MqsbdblSfdG8+HvcLAxu1C4L7CoPFimvOf7EjexlPxbU4a/Uu4ZxZy+3Ur2qT6bAcmyhxj6BcBzeQ==;5:j5Dw22vFXbCaBqZOrfq0P3YTfxw7eMMH024itqvL2VKfGH9vlC3TtzBNVYsxEnJ0AY3IMsAWeMXuqCTSsN6PkLZat3as8YAOvtrPRr7BK0+xH2UMcg3Ina5EDYA6tgfBy5sm+24N3KeJFDtQcft+mBVKkBK8iOgAKEtEpOVDMuY=;7:B0Q7bDO0p2itPepxmxc2ZiktJ5uyZf4JbSSo/HQGMKFMeUXsUdwjqTTpZN0VN3idRMFvp5nVsdu7MswL+Lzg8tHYfhKEhgOWPCMXPh2Z5sNZYdcCpUTLvdotjTXaRF7LxPVwf9ak7p8pCbZLVh+CJi6MEEItfH3sUMa1OiGmSW+6I8dgU0aIaW3yflKqUv1+rFyIGnHELXuHEr5gexe7TWaGUX8RkfdLEk8DkJVgtctQMRaMYmfKtiCKjU+BygQT
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 19:19:52.3829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2032dff9-e048-409f-533a-08d6142db8f5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0801MB2146
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66074
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

On 09/05/2018 03:54 PM, Paul Burton wrote:
> Hi Dengcheng,
>
> On Wed, Sep 05, 2018 at 08:59:03AM -0700, Dengcheng Zhu wrote:
>> The issues are mentioned in patches 1/4/5/6. I will update kdump
>> documentation for MIPS if the series gets accepted. Testing has been done
>> on single core i6500/Boston with IOCU, dual core i6500 without IOCU, and
>> dual core interAptiv without IOCU.
>>
>> Changes:
>>
>> v4 - v3:
>> * In patch #1, idle_task_exit() is moved out from play_dead() to its sole
>>    caller arch_cpu_idle_dead(). So no interface change of play_dead().
>> * In patch #6, the kexec_prepare method for the Generic platform is defined
>>    as uhi_machine_kexec_prepare() for all platforms using UHI boot protocol.
> Thanks! I've applied patches 1,2,3,5 to a test branch with a few
> changes:
>
>      git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git test-kexec
>
>      https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/log/?h=test-kexec
>
> I didn't apply patch 4 because I'm not sure it's correct & I believe the
> changes in the branch above should take care of it - CPUs that reach
> kexec_this_cpu() are maked offline, so they shouldn't be IPI'd by
> __flush_cache_all().

I believe patch 4 is necessary. As mentioned in the code comment and patch
comment of that patch, machine_crash_shutdown() is called prior to
machine_kexec() in the kdump sequence. So other CPUs have disabled local
IRQs waiting for the reboot signal.

In fact, in kexec_this_cpu() [you renamed and modified kexec_smp_reboot()],
the added marking CPU offline will cause system hang (tested). This is
because it will change how play_dead() will work.

> The CPU that runs machine_kexec() should still
> flush its dcache (& the L2), and then CPU 0 invalidates its icache in
> kexec_this_cpu() prior to jumping into reboot_code_buffer.
>
> I'm also still not sure about patch 6 - since no platforms besides the
> arch/mips/generic/ make use of the UHI boot code yet I think it'd be
> best to leave as-is. If we do ever need to use it from another platform
> then we can deal with the problem then. If an out of tree platform needs
> to use it then for now it could copy generic_kexec_prepare() and deal
> with removing the duplication when it heads upstream.

Understood. It really depends on how this problem is viewed. If patch #6
is considered creating a framework for future UHI platforms, then it has
the following facts:

* It doesn't create code redundancy. I mean, it does not add unnecessary
   code to the kernel.

* Out of tree platforms will get access to this functionality by a simple
   "select UHI_BOOT". When the kernel developer of an out-of-tree platform
   wants to make kexec work, they will naturally look at machine_kexec.c,
   where they will find this UHI stuff, obviously telling them to do
   "select UHI_BOOT". Otherwise, unless they google onto this discussion
   thread, it's harder to know the solution to the kexec_args related
   problem hides in the code of another platform (Generic).

* It simplifies work if the out of tree platform wants to upstream.

>
> Could you take a look & let me know if you see any problems?
>
> Thanks,
>      Paul

Thanks,

Dengcheng

---------------------------------------------------------------------------

*From:* Paul Burton <mailto:paul.burton@mips.com>
*Sent:* Wednesday, September 05, 2018 3:54PM
*To:* Dengcheng Zhu <mailto:dzhu@wavecomp.com>
*Cc:* Pburton <mailto:pburton@wavecomp.com>, Ralf 
<mailto:ralf@linux-mips.org>, Linux-mips 
<mailto:linux-mips@linux-mips.org>, Rachel.mozes 
<mailto:rachel.mozes@intel.com>
*Subject:* Re: [PATCH v4 0/6] MIPS: kexec/kdump: Fix smp reboot and other 
issues

Hi Dengcheng,

On Wed, Sep 05, 2018 at 08:59:03AM -0700, Dengcheng Zhu wrote:

> The issues are mentioned in patches 1/4/5/6. I will update kdump
> documentation for MIPS if the series gets accepted. Testing has been done
> on single core i6500/Boston with IOCU, dual core i6500 without IOCU, and
> dual core interAptiv without IOCU.
>
> Changes:
>
> v4 - v3:
> * In patch #1, idle_task_exit() is moved out from play_dead() to its sole
>    caller arch_cpu_idle_dead(). So no interface change of play_dead().
> * In patch #6, the kexec_prepare method for the Generic platform is defined
>    as uhi_machine_kexec_prepare() for all platforms using UHI boot protocol.

Thanks! I've applied patches 1,2,3,5 to a test branch with a few
changes:

     git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git test-kexec

     https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/log/?h=test-kexec

I didn't apply patch 4 because I'm not sure it's correct & I believe the
changes in the branch above should take care of it - CPUs that reach
kexec_this_cpu() are maked offline, so they shouldn't be IPI'd by
__flush_cache_all(). The CPU that runs machine_kexec() should still
flush its dcache (& the L2), and then CPU 0 invalidates its icache in
kexec_this_cpu() prior to jumping into reboot_code_buffer.

I'm also still not sure about patch 6 - since no platforms besides the
arch/mips/generic/ make use of the UHI boot code yet I think it'd be
best to leave as-is. If we do ever need to use it from another platform
then we can deal with the problem then. If an out of tree platform needs
to use it then for now it could copy generic_kexec_prepare() and deal
with removing the duplication when it heads upstream.

Could you take a look & let me know if you see any problems?

Thanks,
     Paul
