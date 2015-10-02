Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Oct 2015 18:53:33 +0200 (CEST)
Received: from mail-bl2on0066.outbound.protection.outlook.com ([65.55.169.66]:6208
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009143AbbJBQxaSpwCR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Oct 2015 18:53:30 +0200
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@caviumnetworks.com; 
Received: from dl.caveonetworks.com (64.2.3.194) by
 CY1PR07MB2136.namprd07.prod.outlook.com (10.164.112.14) with Microsoft SMTP
 Server (TLS) id 15.1.280.20; Fri, 2 Oct 2015 16:53:21 +0000
Message-ID: <560EB67E.4070401@caviumnetworks.com>
Date:   Fri, 2 Oct 2015 09:53:18 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Matt Bennett <matt.bennett@alliedtelesis.co.nz>,
        <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <aleksey.makarov@auriga.com>,
        <david.daney@cavium.com>
Subject: Re: [PATCH] MIPS: Octeon: Fix kernel panic on startup from memory
 corruption
References: <1443588042-21496-1-git-send-email-matt.bennett@alliedtelesis.co.nz>
In-Reply-To: <1443588042-21496-1-git-send-email-matt.bennett@alliedtelesis.co.nz>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: DM2PR07CA0026.namprd07.prod.outlook.com (10.141.52.154) To
 CY1PR07MB2136.namprd07.prod.outlook.com (25.164.112.14)
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2136;2:iBzyXDUPpRSF8pOrkkTdsWSM03ZDXJD7pl78qB1TnDILmp7rMjUX8pyEStifmGdCQO2NXnyEG3hkFUXFzgygiLr97q0opLsuBtzsnJUfnlCfVj3RB5j7fff4a7MiLXNm31GvwxTormc+OrnML4LwwZJiESrXQ7gIlUKZntAbsaI=;3:XCPCHFj9sb455pNi69gO4EKwpk9AUSmfLvkDwy7lPwHwIPA/D+dxI1Dim7zjfOqgxD+Uw8GET0c46+j3Y+otz8EHoaULFIlgfF1nZ/rT4gEdf0hJp7tncrOIZo/Z+tZ6rQD4089u3jlu4uqvw9hcpw==;25:R7m/a0urlery6o3RxJKReeoag9FZ74mLxFc04qMH4XuRYZNJrYBXp81eR7rz3QD3pU5Y4ADBh8ndkUoGZlaJfy7oeWvY+sVhSZCEnQJvSBF1PlCd+ImjQOFms4fYf481T4cklDffoXfhnj0Aay/fX1Cw6wkazZ7tATZPwwuK37pTnPVw8F+c/LxmUXaBBeWzY2jnuta5LBDmyPuL+NYN1GEBj1uIXumv4CvwGe9wGoHGiNqWlYWaacSBUqRCrQ5LcC4LRH8KnVf4BWGc+MwtBA==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2136;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2136;20:Yo+UoRHzF7qa9w1UyS50aIBD09MxcuRwgU7b27lzXzRtFWZvWpgqcZW3jEpO58F8PQMA1nEdDxFAZPgCrm56/w+z8NBIkDxYGY4nskHF9/Uy5k5lzmzCAHetboKk0ZVMlTuviVdNJW30rNiCNCkrKs3DnE4vOGM8eDdhxW89tSe0f8mWSxCboADksGdDb+4WyiUGrjdfB7OU6Duepp1D0eZG/Mpkw1I4fwayAjXElUzN4rPVOGKxfgfTafMhbWxb63pHcD3vBwegHXcL3qm672DqCvBkrcaP3malX5IkaEFfTKpbrbFr9o8Di33PpuSp29QRCHvvbnBtyidKT5XVgvBapvk3bVcE4KFW1PJxLPhdzkF3lGh3Rn9fREaI194LnbFqFBLgKg6Y4SfCWwAvfC2UuWBR/BM2R37mwuvc3RIF9D0AXCuWlXqn4MQ7phEUx283IPss6FA49nyeFX/UO5RykBKh9zb/0hBO42C0uS0G3u0fiJjNQZFZcf08k9DBzYOyJoOP+/M8GWqa/1WozkR+H4BRpc45RIwNB7bNlWqmu9+DxJ5en/YRdlIfasdnEXegvLana3xhTILy0thbricOwetmkrg0Dj+aMlb1wWA=
X-Microsoft-Antispam-PRVS: <CY1PR07MB21364DD51DA1516B99CA54BC9A4B0@CY1PR07MB2136.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(8121501046)(520078)(5005006)(3002001);SRVR:CY1PR07MB2136;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2136;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2136;4:ySamq4+/FX46bhpmEg35Ub8zMod65mJNtAuIZJKwPkXlsJ6743m1UkJM7gvWxktqjvww1nHeD48MuciE312Feffhc2Y22TJEBbRSyhiebqvKDSJ826gBim6Q2cy8g3TWCJzQEp1tnDpgGsbPQTmjKecTENOQpyt8fVFpizasYDBUhwIVAGihX1QpOpUV8+TLRwRsZb7s6SwKK8ybzZebjnwtbbMccMaOp9NZ0SZ4rkjATgT6K0aO88hxilUv1Ugi9kC4W5dSTwHmArA5V8VIMzVh9ceUd/D9fDfssgbaaGsQ50Jk2J1V54rSVyuEhdFZumYUeJ1efVOG6v4DGq3xZ6hdzl5jv+G76EQpERB/IkQ=
X-Forefront-PRVS: 0717E25089
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(479174004)(189002)(199003)(377454003)(24454002)(50986999)(5004730100002)(54356999)(97736004)(5001830100001)(65806001)(50466002)(122386002)(19580405001)(46102003)(68736005)(47776003)(65956001)(4001540100001)(62966003)(4001350100001)(77156002)(23756003)(66066001)(33656002)(64126003)(81156007)(64706001)(36756003)(5001770100001)(5001860100001)(83506001)(92566002)(40100003)(80316001)(87976001)(42186005)(53416004)(5001960100002)(106356001)(59896002)(77096005)(19580395003)(105586002)(5008740100001)(189998001)(87266999)(76176999)(2950100001)(69596002)(101416001)(5007970100001)(65816999);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2136;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;CY1PR07MB2136;23:AMjt3za9tWOjTK0KOW/TB+sl8/68JsFMNsouqRF?=
 =?iso-8859-1?Q?oFDey+Vhi9oiHcW0Lkngduf4Df3X94M9z8HXUbQ1dHjgQ6cCiTHZa49Oks?=
 =?iso-8859-1?Q?q9EGGYqwYqsrrxmLZCP/A5a6SHKFZSmD3iB51ShrAw55M04Y7pU7ozBqSa?=
 =?iso-8859-1?Q?bt9pqSn4CJLb3Gm4LQWaAyVeXXxmQnUGfqywy3tCRF1YYQONfZ2VKd9I/+?=
 =?iso-8859-1?Q?T/SLtPF/Mb3tD72vmnaicr3VGedFBra5DngydRNAjbYUKjRC57AQyUfW3l?=
 =?iso-8859-1?Q?A+FfzTFM/RiLsEuEbc8Iefq8snfXUgkMakbS7R2m8VGtVNUrNtjoGUtxlr?=
 =?iso-8859-1?Q?SxMs4CvYaNGDrmmHOBl3A4pMo7dPte/BM11F7/dMpSpVX5DW00FbkAr/8N?=
 =?iso-8859-1?Q?T7RRgbXETRQCek8fUbrFsSpa9quT57/drtpRO44DMzb7FbSACwxc3OF9gt?=
 =?iso-8859-1?Q?UQRVEBfobpJ90TR1NQTqFyy2sswmtbl5VK1+LJJfnuPOhKwLocaz2VtIPE?=
 =?iso-8859-1?Q?aJLsq25KtZ0yuwbZKIgwF/vnaLt0BsQHhoZnNIuCz33YkLUe9eVxOvoB8R?=
 =?iso-8859-1?Q?3eglyY44TM/M4aq9YJcwjs8WMXyREZzPfMh1vOpB+JBdQ/3B0O8oFlt8OO?=
 =?iso-8859-1?Q?v9P5ezCHCBCxvvOxhMMpnZXTygB3vRkokEwWgIAt6Q7Cva46TUH4h9aYhf?=
 =?iso-8859-1?Q?fxUNZyuABxkFh2lFufM0U3y5XcsEzJQu43bM+ewikIslAaGdtSm2fNFzKU?=
 =?iso-8859-1?Q?mY8b08/MbMgnMYN3+FWekMWBvGEH8yO8Fwe8qFnqGHI8X+Sw0NTFGGcQGh?=
 =?iso-8859-1?Q?W20ns3t4A90xIxOlpG7o3f1XzF+G28nm8W2olxcrP7HIDcNq6oStMglN2o?=
 =?iso-8859-1?Q?bqW/Q2jrAo2AjHnvxpNstlcs2Va0oCbHO6ZmxAgFgSBWsBn38llx23zaP7?=
 =?iso-8859-1?Q?3M1p+OFUAyyZftQAcrY7qTR23s3x1ys7nGbh+OrrTiMxYb4+iZwA+AtStH?=
 =?iso-8859-1?Q?qcnZCYCrRKW5dFMoSH4Bd4GPqqaTG7ARzQWRbKjErH1844JrenOhwEHiK6?=
 =?iso-8859-1?Q?JzVHLu2JSWx7is5B4dSb4hIhuFwaYgplMIySUZv0H/4+aAlpRIMU+2FaGc?=
 =?iso-8859-1?Q?dWbOb4PppfywoNSUOXuJgR+li2fpETdxEfdJVDOIQRgj/9JPydmxtR8b6R?=
 =?iso-8859-1?Q?2a8JFPGKRnDbi5MUatLaqEPKAOAEr62R/IGDN5L5a3HiOvCKPzYLBwPfEn?=
 =?iso-8859-1?Q?i1bOJT5NZ778fOL/2n2I0s8h39mD7CDjaEhUFymHK1XhaBmzgWmGSon/Ve?=
 =?iso-8859-1?Q?EpPFvLMuqR6UmStKzKKFa8wN1KjEYHd3++dGfkDxAY/GdrMnAd/rP+u0qu?=
 =?iso-8859-1?Q?AaTVphrHFv5OK2pWIfaek6fbTnK86fEEUUgzwql/zDlLn7KChnGAGZZAhF?=
 =?iso-8859-1?Q?jndI4N69q0pt6IcKCSd5+iLrGiTE6ZGUzsg0qQvZoTbNuOcZMUmRWvwecY?=
 =?iso-8859-1?Q?4Wt9/xyuYVFZP6nNYdXM=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2136;5:ErBj4FrdaftCCbJyyn/QU5TnxkWktMGMvU9dycdBaA4P4GULF8Q/yDI7v2bP+tnso+Mhrn+wxIJwOI1b7JYtKKGikNnXZJbsfuPvb4TGM38oKEZ0DdyHlRDoVKEOdjVnIAJNyIJ2RTbJrLMCck2+sg==;24:l4szAjRmVzbiEId+D/Qal3v1sGbW26kvRW8iJaidntenB1lT9pBbOWB8kecE9CLC73bhcL30GPRU/AguiU9SQ24Gs0xkY6Ic29TgLmWXmY0=;20:ZtXF8Sl1AkvIvdbsGArqZyuZwCGUtfBfU+8jl8SHgx/AAZKg3DDxONDRb74KaL/P/GSAoT2nNcdkJx16suxc8g==
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2015 16:53:21.5426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2136
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49414
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

On 09/29/2015 09:40 PM, Matt Bennett wrote:
> During development it was found that a number of builds would panic
> during the kernel init process, more specifically in 'delayed_fput()'.
> The panic showed the kernel trying to access a memory address of
> '0xb7fdc00' while traversing the 'delayed_fput_list' structure.
> Comparing this memory address to the value of the pointer used on
> builds that did not panic confirmed that the pointer on crashing
> builds must have been corrupted at some stage earlier in the init
> process.
>
> By traversing the list earlier and earlier in the code it was found
> that 'plat_mem_setup()' was responsible for corrupting the list.
> Specifically the line:
>
>      memory = cvmx_bootmem_phy_alloc(mem_alloc_size,
> 			__pa_symbol(&__init_end), -1,
> 			0x100000,
> 			CVMX_BOOTMEM_FLAG_NO_LOCKING);
>
> Which would eventually call:
>
>      cvmx_bootmem_phy_set_size(new_ent_addr,
> 		cvmx_bootmem_phy_get_size
> 		(ent_addr) -
> 		(desired_min_addr -
> 			ent_addr));
>
> Where 'new_ent_addr'=0x4800000 (the address of 'delayed_fput_list')
> and the second argument (size)=0xb7fdc00 (the address causing the
> kernel panic). The job of this part of 'plat_mem_setup()' is to
> allocate chunks of memory for the kernel to use. At the start of
> each chunk of memory the size of the chunk is written, hence the
> value 0xb7fdc00 is written onto memory at 0x4800000, therefore the
> kernel panics when it goes back to access 'delayed_fput_list' later
> on in the initialisation process.
>
> On builds that were not crashing it was found that the compiler had
> placed 'delayed_fput_list' at 0x4800008, meaning it wasn't corrupted
> (but something else in memory was overwritten).
>
> As can be seen in the first function call above the code begins to
> allocate chunks of memory beginning from the symbol '__init_end'.
> The MIPS linker script (vmlinux.lds.S) however defines the .bss
> section to begin after '__init_end'. Therefore memory within the
> .bss section is allocated to the kernel to use (System.map shows
> 'delayed_fput_list' and other kernel structures to be in .bss).
>
> To stop the kernel panic (and the .bss section being corrupted)
> memory should begin being allocated from the symbol '_end'.
>
> Signed-off-by: Matt Bennett <matt.bennett@alliedtelesis.co.nz>


This is obviously correct.  I wonder how it was able to work for so long 
without failing for someone.

Acked-by: David Daney <david.daney@cavium.com>

It is probably suitable for stable as well.

David Daney


> ---
>   arch/mips/cavium-octeon/setup.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
> index 89a6284..bd63425 100644
> --- a/arch/mips/cavium-octeon/setup.c
> +++ b/arch/mips/cavium-octeon/setup.c
> @@ -933,7 +933,7 @@ void __init plat_mem_setup(void)
>   	while ((boot_mem_map.nr_map < BOOT_MEM_MAP_MAX)
>   		&& (total < MAX_MEMORY)) {
>   		memory = cvmx_bootmem_phy_alloc(mem_alloc_size,
> -						__pa_symbol(&__init_end), -1,
> +						__pa_symbol(&_end), -1,
>   						0x100000,
>   						CVMX_BOOTMEM_FLAG_NO_LOCKING);
>   		if (memory >= 0) {
>
