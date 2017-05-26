Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 May 2017 20:25:35 +0200 (CEST)
Received: from mail-sn1nam01on0064.outbound.protection.outlook.com ([104.47.32.64]:62176
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993459AbdEZSZ3CbJcZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 26 May 2017 20:25:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=LpXcZa9tfkC/CLWtOIqVaowBVyIZ2PkIqccabor9lf4=;
 b=AKk7NuGm9I/CvuHWAkYNOG58mK3uMTq69i3mpsn6e83cSMgltlPcbOgoFMK7ifqQLC7l+aQgxPb9O4Q6HsO/8yJJuzgY02sVGX1nfA184JBav9qxzbIyI4dx4AcAUpYp9nq0Spz3XRMg0EA9KHE0+px64OUR0GNlSBPqulYdv8g=
Authentication-Results: linux-mips.org; dkim=none (message not signed)
 header.d=none;linux-mips.org; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 DM5PR07MB3497.namprd07.prod.outlook.com (10.164.153.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1124.9; Fri, 26 May 2017 18:25:22 +0000
Subject: Re: [PATCH 1/5] MIPS: Optimize uasm insn lookup.
To:     Matt Redfearn <matt.redfearn@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org
References: <20170526003826.10834-1-david.daney@cavium.com>
 <20170526003826.10834-2-david.daney@cavium.com>
 <c8d6691a-0c17-eab7-ac34-efc4e18589b9@imgtec.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <f4472a45-a67b-763f-fffc-26fdc9fa27b4@caviumnetworks.com>
Date:   Fri, 26 May 2017 11:25:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <c8d6691a-0c17-eab7-ac34-efc4e18589b9@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM2PR07CA0037.namprd07.prod.outlook.com (10.141.52.165) To
 DM5PR07MB3497.namprd07.prod.outlook.com (10.164.153.28)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR07MB3497:
X-MS-Office365-Filtering-Correlation-Id: 00fa9b48-6d25-4784-18d8-08d4a4649258
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:DM5PR07MB3497;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3497;3:eF/CgEuHDMRH/zjh+G0it4gvn6bLxvP4lQukxpuGnjsvdwe52qfa93gpSxh8SNKGir5ljaNDzRTyHYNWu/T+8b2QeKN22GaFcVFoupW88A+BplK8O247mfZYFQAGEw/AgDIWE+/UTQFzepF3NzC0gi2PDCZHnlSFzt5MyQ/Od73QAxIaLVVZTj4FLca2S6MIqQS1VVNClDZQkkAcceJCvGyeitYIHr4fLuOHe222JTeCuF5POLku13mmxe0hkYIU7gg3KfkqwetJSIAJMmp+5BMrB5JMn1NywxKAkfxWFsWlLMqkgxNavBpts9zeiQTQFnLhWg0fLqi0NC+fZWTkvQ==;25:sW77/6Sb2BYRz/4QsUonJ58sVdpjf1ezZ4xFjS2/xM6jyKZLVZ3WDnJlFrL/ecPLC6PCG9W6MzIfK0iSoxfZ3EzsCjsHhMrqj2EbpcmPb5zi49zip5lrQ3ie5bHNA4NvBXSjdUCEcoT9rmvxDUXSvdIihmFIB6M3dH978nttbqwu9DZED2+dVynmG/R85FG8O3s8V8xQuZI66r1L0ea+R5CYxMNDulDZfHfOwyCUGDGsfXodF3J6YKFjUe0FcAqlN5bPkwy0r0i18jF/btBHSFsXD66Wpj8vVAvqxNYqJozFaIU7rA3yMkTg/RiT/tx24jsnUlkO8cQZh5TyKH2XV15l8R1c7rEFb7cr+TAN08olpTZnqzcoI9bWXKlcsB9ibFNgV/ApXoujwB1XSb/rb5gErtPkoxYKlK2imoOEkl7pZnyVjM2xHwDCAcr4h15z7EwACWYSDkH/H5a1hPgyxZjzOQzMYOcU9aSKwkxdRu0=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3497;31:PX6Z8YhxPWGPjAdxskD/o7djKjGU3B2TMKeoIkKEIq9L5Qtl9zfVLXxe5F9ho7Oh9SVUUtDMCFD4y16wKnnlzNk2aoYPpxBW0EyiDFmBPgv09MNi7rf9TU45dS1MZldvYhfUStbmU8k1HgkUtvS3L+EuRDLwv0l01PG1VIbcg2CSmY6UCuT9OsqPIi5yoUanjbYHpHfQ2cr7mAK3kRJTAFYbIKh5bTzMDwFcKYNsqHI=;20:4zp2iaPOH2UnVA/FHSzom+XdhUWktjmwJFHKM6neASjN2OkBOdfIYleETT/WcvH867c/PADn+iRSNJP/Dn9Wg+HG06+QzSFucXyjSDDFnuLvIyHYI+zoXz0WWJSNcEH5vqK7kO+DuMNdJ+ViujXvemVoGHmzi6/C3+mBt6jWcVaP5upkwJiEFqd12rwZoRoWlz/5pVbgowGmnYRY/+PdYSkHzJy8xIgelC9DrYCnDW2sqakOkyufC/sAYaD6SsNpM7jL7m+E9RReMnvVDVoin6dsm4N5XUsMgcMGDr3zF4P+0CvPqSScNh+jbvWIlWWzKXXLBZtK0rR6IaKT5n7ti6RZa/99+BK02KJOCa1vIRLQtzAupI0JeXTVp5MNWtNK+dXkYPC+O29eLkXG9Ux05yVsAIYXgitkBwcq1G/9phvh5N/mLRDsONqzqu1OxQ5ZYSchkSJKnuq6pLet6pszPXmfJmLhH4PDMZzzK9F0P5MJaxl97QO1nTgVQBqNhJqeAKmO2OHRTyLI1cHFGaXjhLGWK38zheFB8B3WzsUcgGE1Hxn+6FNfX/UjFxw5iT8yF80OjFjeUfjoKYrAQY7UQhvqByUXh9Ta7v/egKGM2SQ=
X-Microsoft-Antispam-PRVS: <DM5PR07MB3497482C6DE50C5C477C75E397FC0@DM5PR07MB3497.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(601004)(2401047)(5005006)(8121501046)(10201501046)(93006095)(3002001)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123558100)(20161123555025)(20161123564025)(20161123562025)(6072148);SRVR:DM5PR07MB3497;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3497;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3497;4:bzm//wa5r1X8EmDnZcwGJaKfryxYjyAE8zWoncwGkPDnN3cryGKtCTQK8GrwA2H2XrCFnbhZJB0wr3pd5b+dLh4slXkjnjCti8jQlrMLcZHy4ex4EeJvVDGg9WjObiH/uJerYWzuMGUUaB712QSe7hA3oZtAl6jGKQ2AM24aR8HytGE0ZSxRs5SFIwlZfnpIvisM2eM4QZI/I3LGkxio1DgflOg2Uj7q8MHNZNpAaE4xqxNNks8sxNfxpWUWF+0I+USgJVKXV4ATXIIr7nTDgzZtVna1+wNHjvCPK8/2BYiir+4aay38NR24A7Hid7/khqs3KvMqXFU7TReAwpmmdn16eeRTpSwa8G1gKl4vNpkHeZBy4g7mwLl5/h6hefhFTcSajcXOt+kfoFVC9ouZtsI3qyit4Kj5oFU9i76QggX6nS55UC0oZ0BnN//vMmLQTan1ywm9jmIzDilMIzcTvMCQxEiyw7zzezLQn76axqBz1ql4aaCSXyX77CbvRAME9DGtwc1bvsQSj2kMbGuTpQBE98fn/nJbMfGDC1MFfmJL5Rhi4W+RaxXE+y9wMuu2vXMxkSAE66u4IQxJjBQKt/7KYJUACvooCZk32Y0oU53J+Uiw2i8WSL4PNmsRNlrWzF/0ouKkoG3a6WFr4oOUBNBMep0lue2/t5E5uQ/tINd9uohxA9TI3yaNetbUxxIEYnBLKuF5pwXqQKoJtu2scvgNRkYgv8KXBbzEWXO2029Ipiu9paU33RyJXmCAPg0onUzb3Iri8RPetbAM84nRnw==
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39850400002)(39400400002)(39410400002)(39450400003)(39840400002)(377454003)(24454002)(6486002)(229853002)(81166006)(6506006)(2906002)(42882006)(189998001)(2950100002)(6666003)(50466002)(66066001)(23746002)(53936002)(64126003)(6116002)(3846002)(8676002)(47776003)(230700001)(5660300001)(76176999)(54356999)(42186005)(31686004)(7736002)(305945005)(50986999)(33646002)(53416004)(31696002)(6512007)(53546009)(6246003)(38730400002)(25786009)(478600001)(72206003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3497;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;DM5PR07MB3497;23:vrGa7elixyVyRyrxE5kAp+Fz4KlNjuajKF2kL?=
 =?Windows-1252?Q?S5iWbkNiAqCxBwjhQjWQIn+N5on7LZpJ5zDyYbmaQ3fHwjLIqeQc/qoF?=
 =?Windows-1252?Q?ofyGQCIaer4qJy9eQVUQE72RdzC5WT5te/Oiyq5kVZxy8aEyUMQ4SEpq?=
 =?Windows-1252?Q?vD+C42znYKPsWhrzOd4WjVmrZzWmJZ6JGooK70yx+cZ/1eq9kV7RuvJv?=
 =?Windows-1252?Q?NIm1uCwJf/35CjeWPBO6bhk/cYFQXCl3qknnQ8ryqJh73/lFNrS1fRyH?=
 =?Windows-1252?Q?PUnx2SWj0TUPO+zRI/3ASl90EkFxyPXPOBH4oskHjZdbaBHM0SI6cnN/?=
 =?Windows-1252?Q?PsPRoiWjz+dSm+inJ49tE0rXrMYlf7GDq69upj2y5YkykcABmwE2ktcR?=
 =?Windows-1252?Q?uxSko6KAgsMSxvzpMZyhfeUXzr6JNJKyqA38nB8B/MihSeOgJy9X7/D1?=
 =?Windows-1252?Q?c7h4hIkHrX/NFqjPW6cltjPNin0zyOwePk0SKqYr7hOu5TIMjfNGmaaQ?=
 =?Windows-1252?Q?AEeVjFJX1n5sDrGnJ/yfApVQq3eS+6vbW1j0pNb79hghAZuk631x1CpR?=
 =?Windows-1252?Q?sd6wLo+M11aew1Ccha9GUDWkrH1VTFzFhjfQ98fdLgBZoQTtPOvK5pvQ?=
 =?Windows-1252?Q?ZqaR1I/DSwSiLjO25BpRmkuAaHhS/G9rDkgSfPjn5e6jcCJ4pHiwa7yn?=
 =?Windows-1252?Q?0Yb8fBcptoP3nzIwfzheaTWVhh202iP2EaRtD+Iez8L4jYv6mY/QWwrL?=
 =?Windows-1252?Q?BdrH8bxkP71TjJkfEnMOFxGfh5XbKCEz+/XBEUUf7DokmiXxUXKuA99/?=
 =?Windows-1252?Q?Rd+PD0Jm7KTcQ9IDBcZ+og9tURTsDO0ccUGPZaIO+JEsqGICN1cr9E15?=
 =?Windows-1252?Q?s6yhlxiUV4Y6eb7bRmD4bp8YiwgJ9dtLO6CbFYM9IGq5SSBZIO2yKFRu?=
 =?Windows-1252?Q?Xa/vchTrCP+IR2PZDbPhCJ9DyOzJPmX/hByGon0clJarvI5kOl5jsjur?=
 =?Windows-1252?Q?P9AfAerpBk44asXOGyz9VFUKPz8YFtsSE3l2SgMCJaavHZkBgVVAf4VA?=
 =?Windows-1252?Q?Tr1lFciBIlCwe8BINfkGNEXCgmnNy9q72GBw1W5Z1RNpVZTN8M7pyOE8?=
 =?Windows-1252?Q?yU5IJqeKq/bTrn8plM82eS4aJpNlPzvsGkcVkTpkGBReMW7RFmn6hWGs?=
 =?Windows-1252?Q?OMyiDMT9oNeXk0FEzt1zFqOUmVZ9AZaYzb1r3hwDcSCDqQoKCxSTZOZL?=
 =?Windows-1252?Q?3A1uoqDYDgzaVUPUQ=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3497;6:Nflo26mTDXMFc0IkvMyI/wjncaFoq+c1441A5TwS0WLKW7GKxnzyUUEnxkW28hsX+rqcFKAqV3euiPt353Z+7Vu/WUUJC0P4D6knHjWmw1xL11hNYtML0nDyIuCOeceWWlpL+a1dD3f1YheiyW8+intOZySd5AQytvKKqnatxEj+jUcgmXyCi6qwIXI3AZM8vweQdXykx4DrE+hki6PSAFaBIlSIA83Zaj9YyK95N4285I6fJgTfq+EyZnhbmjeeQERtvY+lJh6ETmLtXAqWr/MlKxTOv+O37Ai5Da2Wj571Y/bcicIa/+JEb67UHMMM2yxLHWITKJtxOMv+lcWwRxke/GdeRRzqeSyZfcephRsi2PdFqQ7KVY+htb2KC2p5BgyuSEQ7ZUrFeK7Su43605UO8uZx1mAU/4i6y/H579qp3qk/zVPXOdEbjSkYzPY80zU1p5TQUzt93gRdd+cSo3yi4gKftWZyid0VeP24BPqKnnTfC5G9gdMnY/hHTnKsc2xC8JOTxSdLgJfYMfb+pA==;5:8iqjH+r/Sv2LqMC4M6JB1Bmbkl9yYGhu13ZC+/rm4n1HEkJV4joIKrNEMO2Ge5sZTLzxo7oKqbwgIy8pjW9dSVQbpiJI/t2WZI+QPPU/fvDvrtE2AV9XcsWhcJKZ/veiIS8lFtP56M8BO7azhi+6CA==;24:CiWYCVUHhvemriBd+Ocyv3jMjbIjnlwQOldA5LCW+wSK/HkDWIQdI6hgG6rUMK/MhFMF7Opnd6H+MbgLVNM20yLUSKUOyryn7oZoHWiZIao=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3497;7:aoTTVFMPpb2hWEL4tvPfY23pHLR/3jBhWJeJGpkWT5QHfdQPqWnYDk/qKbeLkxL/L5vTZyTccKh/+4U4b+vBswrEBif7VzZga8clGbDUR8iiD3bAQLl/BKkKb8YDxLcSWn+pZR473Ssm4PZbZ/JP6YGncK2tq6fWh5pBBO1+c8ByMqlz/rKFzXJhLn4IRsZSq/dn5zRxkwI5vECtBrbTrfNhNWPyy1nKXTjyDPttlAA4A47dHalMnUV1sVShXZiafEstdk/JV2MCQn37Lg19wimOUzm0vHHzn8+A+roG7ruBSJWZ8VAoOnuHWnw+dW0IGky+077sF1xAztz8dvSM6g==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2017 18:25:22.0014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3497
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58023
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

On 05/26/2017 01:07 AM, Matt Redfearn wrote:
[...]
>> -    { insn_lwx, 0, 0 },
>> -    { insn_ldx, 0, 0 },
>> -    { insn_invalid, 0, 0 }
>> +static struct insn insn_table_MM[insn_invalid] = {
> 
> ^ You could make this const too, like you have the one in uasm-mips.c.
> 

Good catch.  I meant to do that.

I will fix it for the next revision of the patch set.



> Thanks,
> Matt
> 
