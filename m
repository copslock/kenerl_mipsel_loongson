Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Mar 2017 18:30:50 +0100 (CET)
Received: from mail-bl2nam02on0040.outbound.protection.outlook.com ([104.47.38.40]:14416
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992209AbdCHRanfPCki (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Mar 2017 18:30:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=qinWocAJ13bfxEB16krCBgRZ0ksZD5sh53XVdVfNslM=;
 b=ZBp6G2iDz6zvJz1Vnye43XpiS+gThaxNxQfrzmynWPwNAtr0x7C5JJ/J5ycZg6xjJZvHDczqE+x2vAQefldBCS792jPxRuuQwQ8msAL8ckEGpc/VPWo8rB4/vbsYKAaedQkJTEAHdZoFCOcOu0L3tpRZ1zwkDfbfT+5rjShJmmc=
Authentication-Results: linux-mips.org; dkim=none (message not signed)
 header.d=none;linux-mips.org; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY1PR07MB2426.namprd07.prod.outlook.com (10.166.195.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.947.12; Wed, 8 Mar 2017 17:30:35 +0000
Subject: Re: mach-cavium-octeon/cpu-feature-overrides.h
To:     Petar Jovanovic <Petar.Jovanovic@imgtec.com>,
        "Hill, Steven" <Steven.Hill@caviumnetworks.com>,
        linux-mips <linux-mips@linux-mips.org>
References: <56EA75BA695AE044ACFB41322F6D2BF4013D0287AD@BADAG02.ba.imgtec.org>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <4eea4d98-1ea3-0d44-353b-deefe085db31@caviumnetworks.com>
Date:   Wed, 8 Mar 2017 09:30:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <56EA75BA695AE044ACFB41322F6D2BF4013D0287AD@BADAG02.ba.imgtec.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BLUPR07CA0036.namprd07.prod.outlook.com (10.255.223.149) To
 CY1PR07MB2426.namprd07.prod.outlook.com (10.166.195.15)
X-MS-Office365-Filtering-Correlation-Id: 6bb8ce48-f654-4ecd-be18-08d46648d4e5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:CY1PR07MB2426;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2426;3:BKUa7E2yXKcPhWZy4yMDzcPSja88KOEOfmV1vom7/gd1DZz7kfXy5ol/zNVqRKB9tOhNDZEAFENvbNDHIU+pc7TeKVOZ92+Yoh1BDqrOF5yygExhbXc7zLf1ulhOdUOx27PgSFkMV146c1xcaBizChZdXG0o0ZjWdTg2nCsmdeEyamaYBKoMxqbkrwKmacw1Yx4nRYXIuPJHty0HhJpTqj33GKIcxs1V55int4noBFEKftIPSI/qsRoYSjrBm4fubWouFi3o0+c92JdHdnlhlg==;25:SXmcswk9Uaw5EuuIdY9pNaCW17j2gwjB7wWNvLZbMLYe1iPnP21y1bStIT9M5KA+1bympCEyBbvn0d3gw6iM0x9IE1p8IeR/9PHgp43p8EnCt+1wRQf6kHY9qZpWZQMcdzB5qcCqqBzPDXp1qpcYxBfIaugw9bmFzJYxwsZUrqcgCSyv2mJlRmFxi4pxN5e5tA3OcrvL4fQiJmL2W2ZpPumd4wCC/EH4oi7nbEbhnOD9HRst2ujGJ/4swRf+dgkw9n9GqvWdEMPA+HLlfkYebdNKM7QOQa0pkIuksgagAa6Wwb7vOP4sKYTHB3zLQMkXCX53VUHUxBcz0TNyHyvlw4rcSpV8w4FWB1uVUQsniPtREGuiD14y//QdIRh4bKeGvPWmQ5sOqLKcLkbagAURKdI0MUX8mPloacH3WpejpgtiRhMY08FoWN+mdM9GJNO/La+bjQ8Jqs7O7iO4KjM1fg==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2426;31:dY/DK08RRcTFkbEGB8I8Ssxr1OXmr/KSRN9xfLidy367dIcH7fvDZjOn74mf/FL9bDKcCM5ISrpeo9NCuhtwY8dHzEck+9YhAz3SBQTaWy09ql8TfEeEIP+Z3e6XPuNm7VcgMxpAvF/SUZAu2mrlCFD9CRfCoHZk1aXFme3kOdgWJCyCxqf45FQFk9sbnQb0nCAVMj+C4E/O3dLmqTzF2cnNMZgMJv+yrIMcjtQQaoE=;20:Z2PWLjCqAK7Rb8CHltM6Tymhk6SocUCdlGQLkbRIm63WO44HfnFjebQPPpmSc17N/n1//A4VEexCZpiBGK/DWeQasQKDmSF+qaD86ReNyoyxcwBUWUd5AcFnsYzv+d9myWEh7nX8+SDVcm213JipA48F19H+0wbRRMkl92PxU5ft2kXBKRsWwTE33Jq9qmRUqHMxyOEn+fHJCInKqouc7SfIBcpOeeIHSRst7/mIVe1fjrK/+CWFXaVunoSIQZCGXNXpAcldxYv6C6KJ/ols4fezR85QF9aaa1CfeVrHzjVLjTQI1LuJbZzgzMPecb6Qod1Fa4A8aC71PutvhFEzByPcg9aBHZ9mnxepRA0fNkMkAtkk3euIUwx2UmmCGMsR3t5+GA0DhudGBa4EHjsr/T37cWYXMOKu8g4rpXUhE+0XTZu2qsP4iv98IGVLZEMV/S0g5Qds46MuF0+C6n/CKhMYD2t1dTek7P8QCfFJQR33qhtf42jzguIfZb4YU6ma3Hn5IdgFGQD1I+k7KJ27oW5ihRilJpOTLITh8j98E9FyzhlmPyNXPaQhNgE4vlrnE4AcB5tp+j883GJUKGGMoDD7IuG5kYFQaBdVwOvCb2E=
X-Microsoft-Antispam-PRVS: <CY1PR07MB24265BCF943EE74CDF1A680B972E0@CY1PR07MB2426.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046)(6041248)(20161123558025)(20161123560025)(20161123555025)(20161123562025)(20161123564025)(6072148);SRVR:CY1PR07MB2426;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2426;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2426;4:6KOp5SWxPmroqVguf4U3/slt+DQ8gM0CpSI/w0XtlrXQ2gpb/TZeG4rH3PADM8+bOJgGW952FNHb8qvNrvf2ZjLJQ2gW4ltw0+bS56pze7iBG+2L+INQdJNY5B66MMj4K4rK+DQ7MWXEDo2nQOtWdrcOUfRI/km5W+eqBlPuqmWGrb6ERoILbPxxa97cc7BeT1kaxjsr+5CvZhGg4TjvCwqeDW8/9yXbAT1JTK+a5NVNcT1RNv84idJrbGScMWEqNJx4i6rg9Q5yQFIcMJej0PL3O/V0m8Q/HxlbCpO4OP2fE8lt7TDahOFaE1JWy5tP0HPkvese7eI3rTeVmcYCKYVDMMCsJOTBycyT8LLnmmJdvl5E/JX7FQUL/ovNX5ZTHfL28YfGM39KHB5nq+xNvz4tXnOBonRfYhkPRKBcDyl5jqU4pzIg4dQ98uutiZCXzVuzBjJLhZJ6043mWpbz7wXh+kJAJkMISb4bJM/9dbLchbInm6rDKKHsAxmnxTWh9s2L2bdSsCU1262C2OgyQ7V5notS/iHBmhvYTL3Oqs2mm351pOX34cMo2PyAlIcOl768lw+b01mh5fQYc9tgv/e+4FbmRRznh1BA8YOlaWw=
X-Forefront-PRVS: 02408926C4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39830400002)(39410400002)(39450400003)(377454003)(76104003)(24454002)(42882006)(6486002)(2950100002)(6506006)(81166006)(50466002)(36756003)(53376002)(6666003)(38730400002)(966004)(229853002)(6246003)(230700001)(53416004)(23746002)(7736002)(31686004)(42186005)(31696002)(305945005)(53546006)(8676002)(53936002)(33646002)(3846002)(6116002)(50986999)(76176999)(54356999)(2906002)(64126003)(65826007)(5660300001)(230783001)(6306002)(189998001)(65806001)(66066001)(4001350100001)(47776003)(65956001)(25786008)(83506001)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2426;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;CY1PR07MB2426;23:sVNP6aT/Bs7AkRuyrmo76iyVeXga3bpdDUg2u?=
 =?Windows-1252?Q?l1D2ZaMQnJDsbN5JiWyxM79em1iTa6lnxefqJcA+RsT81Cgajl9aoNaO?=
 =?Windows-1252?Q?8RlLBd5mWHsEMhzcFLbDgfbKBMrgOCrqX1TK9zMsdxsZGVxzEe3VfEpD?=
 =?Windows-1252?Q?ig8b19eX5XS/2HA20fHjbRQbTGYjCxh7GtxcI/ySxVLh8ejEHWqAmnJn?=
 =?Windows-1252?Q?9DLhEACATzWlQi/3H6EFuL2egl9QHdl5OWNg6mQKIBLQsE0Cy4SulB6i?=
 =?Windows-1252?Q?o2C5HPaiBmAGBLX0NaIhHt45QQKMexIhKpquofzAYDMZS2B9N7YeVC+M?=
 =?Windows-1252?Q?AAwKH2bn5N6EFHvAFAsqzt1qz8TJS379z8U72H2CrlJt5BgaLWpdfnkE?=
 =?Windows-1252?Q?IgU/FAhMQ16UYAHZ4PIVKkbW51CqNUKPuiOqQptzW4TZbeKBlzexff/n?=
 =?Windows-1252?Q?TM8c8XIinxXX+MiMURR1u5oSVo/lXFfzCdhPDQBQQF9txY3yLEsZwZcZ?=
 =?Windows-1252?Q?MB52OI89K/+Is8wb3lOD/mLY9J11j93NuSJCCG+pZh81yNpmwLfoT2Ll?=
 =?Windows-1252?Q?o64ItSAA5oYxsO9NCThUDO4nculEErZAvaQB+DYClWzOWhqQ94xqka3i?=
 =?Windows-1252?Q?95zAz6hBR1HUVN2IalIMFDUFNRPBagX1RS8d0d+jNYGpHQ3PxfCGmc8N?=
 =?Windows-1252?Q?3NgqmeM7R7qcwXcov21oIP+PoIZ84kWkTjaklCLXxf9BwOtEi2/YUlEt?=
 =?Windows-1252?Q?iokT4y7ybfP/B4nYFjFwt4kMxqi2LbakSXwZKCvUALhKiWvOUd1L2E+Z?=
 =?Windows-1252?Q?9k9vtbeOY7zuuZ9LGW3HQ0X1w2V9e+YK0JGMwj/M/X/kS2WbmcuWE2Y2?=
 =?Windows-1252?Q?2YLX4L2O7a8HzVXHfodtxp911ToDzYOXW7aM7kcOdDAGmWvd6RbEpiED?=
 =?Windows-1252?Q?Caxw+ncINV1mlN6sVnB/h/n3PpRR4jSeA69lCq7N0fl800rKb/U8v8+l?=
 =?Windows-1252?Q?KLZjTLGdTt0/GWR59UxfdlYxXIfCL+knrJ8dMNoKBlbGVP/80kBeLw4p?=
 =?Windows-1252?Q?N0aZGQ4/HkrDN9IEIvYt8dgfpeSWuEJAan2CzZ7PXxrHfU1vdnizRwtu?=
 =?Windows-1252?Q?9UxySBSyzVfrT8wKgb7VquDmEQwx5ueAEMX8t1VmKG4V9kFBEdCIiO8N?=
 =?Windows-1252?Q?MGyqsW+8Ydu8f0QIbb1pGDJx+eH4ItSXZOja/5pUd/vdtp2uZGeDynK4?=
 =?Windows-1252?Q?79LlgDEf130k+c1fg72sfNjeV7EZTSNbinRYB/NQ5RBFo9PySYVOdjnV?=
 =?Windows-1252?Q?558tqOkvLyYRy3uRac65azItaEGe/cbKOJop4aINvQMWQaRY27Pvw3Dl?=
 =?Windows-1252?Q?oJrEHyadgJuxrb+tqoB/XG2jpxHcEnLoA=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2426;6:K/CQNntfaRyTd15b7ntTPnV4JeO/tN25CIyLkLMQy/7V3pKdCSbPMmGi7xg5V+qiFiVFwNwQYibTksZbpkwaLiC/CeNEWSrFeEkTCZWFcxNmfaBHQWGaptGmBxY1wI0T5/RUsLo4IHYJCSWZNMUO4FdPBTo7zfh7J77WgmZ193Eq0UbK9DXeOvbYcERxjUF0P92GHEk8LnR/RH/AQIaRegwAFadFrHK6vML6SSplon0yTgX+IZmg8XoZhMlZp+akv9roWdvsnxxBXHT0P/q+6jL6XnjSc3IepjNsfXhonKVPykXqvok8H38/8dkV+2UrqMBPwAot3AW2icB/A8mgJmW0VoY0EsnTurL0/c+amBGV5aokT0GfUu9kjDcDa5FIjzKRtoy46GaS65+GnZjNjw==;5:YCbwqtvSigtE1y9cQAzw8JrZgtFDwPCWtQsvBuuHn+esiLkx2OHxGTS6ytgI/6JXXhyUdcfh0E3CQKOuqXy9/hQPMxKykbhDHSSRWWbuxamSTIXyerskOV1q+UEcjZc7NXJrkHLnhYkkaGzx4B5Ebeg2v+i/pdDAf6naAGCcYgk=;24:on55eCkHBFUINHiWReJGX+icRCO8aKVHkmv4SwVNABoTZPi9xXjNTHew/whlL4qIKkoDTO4QGMIQTjWW7hWSsHm6F5nQi6fN4zr54DubcUw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2426;7:KMa9tAZlHRuAMPlIPftXmHH2QSpcpqnVyRUpFrFhCeJYKZpSXdLLdGwV79tyJguRHVnd7rI7t3eCvCIcBJZbufT+8Fxs5VB5pHIQTD46a3cxdm/qoHn4RbQ7t5p8e+2ohjX0ajd9hYr77e8qMrU9Ui81cjt6Fcm/whHREqw/2yXezE6ZCVIEMvVEdHlGf5Qt7qAvSH/J+flFCSO6WR4XLcvoHQx2qvmE24LJWmLUQL7XWRu1MDpkYlJitoLkoghA/24toA0L7bPNpXYp3KrEgOEJ3VGhQfcQ28cGtRjHF1dAdOVs6FBMdIPFn6RVdodxp8Li+BT88WWoYMgMV/HvMQ==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2017 17:30:35.5649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2426
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57086
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

On 03/08/2017 08:16 AM, Petar Jovanovic wrote:
> Hi David,
>
> Cavium overrides [1] cpu_has_mips32r1, cpu_has_mips32r2,
> cpu_has_mips64r1 with zeros in kernel.
>
> #define cpu_has_mips32r1        0
> #define cpu_has_mips32r2        0
> #define cpu_has_mips64r1        0
> #define cpu_has_mips64r2        1
>
> Is there a reason to do this, and can we change that to '1' like it is
> done, for instance, for Netlogic XLP [2]?
>
> I have looked at the linux mailing list when those changes [3] were
> added and I have not seen explanations for it (I might have missed it if
> it was in a different thread though).
>

That was added with:
commit a96102be700f ("MIPS: Add printing of ISA version in cpuinfo.")

The problem with this whole thing is that it conflates two different things:

1) Which instructions can be used in userspace programs.

2) What CP0 features are available to the kernel, and how to best 
optimize kernel exception handling.


When we initially wrote 
arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h there 
were sites in the kernel where setting "r1" or "mips32" was the wrong 
thing to do for OCTEON.  There is actually a reason that we did these 
overrides, although I cannot recall exactly what the issues were.


> The reason why I am bringing this to you is that some userspace software
> relies on what gets written after "isa\t\t\t: " in /proc/cpuinfo.
> See show_cpuinfo() in kernel code [4].
>
> As support for MIPS32R1/R2 and MIPS64R1 is not exposed on Cavium boards,
> this will incorrectly lead software to believe the boards do not
> support these ISAs, and may prevent code to be executed or raise
> exceptions. One example for that would be Valgrind [5].
>
> A change like this one:
>
> --- a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
> +++ b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
> @@ -46,9 +46,9 @@
>  #define cpu_has_64bits         1
>  #define cpu_has_octeon_cache   1
>  #define cpu_has_saa            octeon_has_saa()
> -#define cpu_has_mips32r1       0
> -#define cpu_has_mips32r2       0
> -#define cpu_has_mips64r1       0
> +#define cpu_has_mips32r1       1
> +#define cpu_has_mips32r2       1
> +#define cpu_has_mips64r1       1
>  #define cpu_has_mips64r2       1
>  #define cpu_has_dsp            0
>  #define cpu_has_dsp2           0
>

Really, I think you need to cleanly separate the concepts of userspace 
instruction availability and CP0 structure.

At a minimum, you should audit all the usage sites reported by:

$ git grep cpu_has_mips

to see if anything would change with your suggested patch.


> would be sufficient to solve issues like that one.
> Let me know what you think. Thanks.
>
> Regards,
> Petar
>
> [1] ./arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
> [2] ./arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h
> [3] https://www.linux-mips.org/archives/linux-mips/2008-12/msg00185.html
> [4] ./arch/mips/kernel/proc.c
> [5] http://valgrind.org/
>
