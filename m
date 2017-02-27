Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Feb 2017 21:00:10 +0100 (CET)
Received: from mail-by2nam03on0084.outbound.protection.outlook.com ([104.47.42.84]:34230
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991960AbdB0UADpEUcz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Feb 2017 21:00:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=L6VhIkAq6ZYSnKvUmbjvPreqrVJ7EMm8uiJuBC7dDFU=;
 b=ApwZxtdI7IokfgC/HAs4eHYAyXcMgXCVfnHwTlqXddtbmAjn2A0Z8hr/+7qyuOe080BHR7mRxMKA2N07ndOR8Nph/Kwbp7WepVy45vPlH23FJMw91HiseLzXa98AyfDg0ClEq15+UbSpWGB434wZFal0cAUy8Ew1wie1Idx8PP0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 SN1PR07MB2431.namprd07.prod.outlook.com (10.169.127.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.933.12; Mon, 27 Feb 2017 19:59:53 +0000
Subject: Re: [PATCH] jump_label: align jump_entry table to at least 4-bytes
To:     Jason Baron <jbaron@akamai.com>, rostedt@goodmis.org
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
 <f7532548-7007-1a32-f669-4520792805b3@caviumnetworks.com>
 <93219edf-0f6d-5cc7-309c-c998f16fe7ac@akamai.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anton Blanchard <anton@samba.org>,
        Rabin Vincent <rabin@rab.in>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Zhigang Lu <zlu@ezchip.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <aa139c18-1b04-2c20-2e22-89d74503b3cf@caviumnetworks.com>
Date:   Mon, 27 Feb 2017 11:59:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <93219edf-0f6d-5cc7-309c-c998f16fe7ac@akamai.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BY2PR07CA0098.namprd07.prod.outlook.com (10.166.107.51) To
 SN1PR07MB2431.namprd07.prod.outlook.com (10.169.127.143)
X-MS-Office365-Filtering-Correlation-Id: 0497d328-eef4-45b4-9ed3-08d45f4b3258
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:SN1PR07MB2431;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2431;3:86ccBgCgpcDJgXaRiWDCxVqkXIAmYgPJ5Hc6IEfz77R8VkFw7V7NQfy5m7XxJYiPfkpZXY+y1NA0HlUCImD/XU/W0/Gyftslw55n1wlzE81fVvnD/nfjZIJM0M8o0WzTsCp+fBUXBVBHKJ6YI0YPIWhI7cp//2IN8PznUnSr8LdiI5/RU+2fw1zsiVZrnvkD2Bqkpf9mndDkJr8+PWR0dWeBqjPKkQE6Ly8h5a8x8wUouI5OWGNFU/0oEWuMQG5rV2nGt39C8AM7CtC3ITJ9Pg==;25:ZIxSQTjAEvxXrs6sfaAkjQYIWF89dUbTliCU0dfza+fivxrMphrAULcdKYyk0/BoCLY4JhpfKh2HJ/5gxpG7iuMLqKpxSF/sfkLAOuaaHTesXzIEg8UqLjJFJaov+0cbipK0pHJYCxi4pSWylEYZwAJq8aTRp+4WrzI2j7xCNsqFvckuSaud8ZDlNNMoG9BBgE8KhD2dVEAYzLYNaTYmWFu5BvbmKS2G/HM47NpGovJrHHcJpU4Q7iPIJlldKt87/fRvkm5iGr8EBG1CvQm2feMNVQbEZoYjD0+poKCbTJTzYKAecukO7vt5pvYfqwgUbIWxMVllc3l86CAVl0q9h4JfMC37d4pmpeH5JLNxTv750385uFiryV/HKwr9kEzbpLwc9E6LHnwv7vQWi3o1T6ghXbgzlWX4C13Lha8w37lK9oVI56HHUaHzzwjEypG2iGgNklNkvKPdh2FBtkJMiA==
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2431;31:nlee9EXEDo76/Rf66cIntREQyh1JW6hKkr0VZ0aOtUlyaHhLtazx3Xhxrc0d80K0Zel/035azry8mMbw8fDSV83Fxs2Iax67p3EYGwzTSKfb/yIIMX0q7kDRXcWJMh52h/m1YGKNlvWx1Rms1O5ZSNekF4gipj7pcgAJ1s296JLUinnGaijn/W2wkuSem+i4Lp7f6SNavZ0hS8VpyyXdPDdQJ9yklE1bTPq5SM6TXAgVPFdCPpoRKXubuPMtpnAkQUCWjgnU4apcxTjHrjRoUK2tZ4kenickNgkplSgF4PE=;20:dbU4cZKXjpiZ3PfVqh9+IkMu21D4UFaaAGAqCBukMtBGWbMh++kJXKizMLGptoJMCTXl/eqW+SIGZg/RdScdTBVp8mOAfoJvjV6c6FlaPiTSD37XSQsc3RRFuHX0n87ESAK/KUfKkEMQR77ZcBkyCm5PaC3OwxTJeLgY9Q/1H/KTfEJcBL/PbNhR4U+gTPKNQ3kQ3CEG8dusgx3nwW6Y6LV6DM21FpbTTwOKJBfjaBbcTJIEIAL3hLy3V6bFIL7pFXlyYXHEkM9A5HyWK6gSPk8VXo+TtrtHl4ymNy/zhHTYVG6FoGbhSjvbrSWD6VKQLrKeo3CIBjkzfZ0kYX6DAaW9MBb8FrRJpaZMInea0hxt7yoPgJ1VHs2cquQmkG1ku7BdwMGvrdPr3p2Y8bCNdD6qitneDmqdtds6n/D78xPbdlGLem14TDf3owOoO5o4CIWXWRJ8ZjRPU2snoVDTrmDXCq+orUEuRuLV0UlUmn+VXEaPWnQ01BzrdYNI9QU6r9/072y1yHBYMWbLwwV7dH64/hmS00mHHPimJkaxLyWDOyAMPi8m4ZzorirKsgJmYsMalytOGs7pjVFYDMzN6XI4FmQgmnJqAwwCKptsxzw=
X-Microsoft-Antispam-PRVS: <SN1PR07MB24311ED00507D060C59895FC97570@SN1PR07MB2431.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046)(6041248)(20161123558025)(20161123555025)(20161123560025)(20161123562025)(20161123564025)(6072148);SRVR:SN1PR07MB2431;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2431;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2431;4:EzAFifTqtfSNPxvbLfBznY9U3a4zCngZCqiIUavwl3vP77QDOxVRgdzr9y2VPxhB+WedEgEjrnxwIsYtuKDTfgRD2EjALklsBicgCVRUIcnl3MKkyLdx9mg/GPx1gkVWQd42HW7/I6ezXZGbVrRfV9nPd+Ox+LkjDpu0b5sIS/CKtcQ5wDqIBT6p8ZeGIvQfKUswYVKmbElGJojxumEtr8BqI2R/7DwF/A283KbytvSyv++0qYD6TGqn1RUrXzfMrdPi25irb9BpIcFNByU9aUmjoT6ewXth72UFaLxM4oy/bLzKOGAWuUj+nFZPbC7u+FwPztMVzHMkYV2mZf7IkSXvrVXdXWjhg8UdM8kpwgn5VRSC+GFQFI6ieNVHe0iw5Jo9Em2IhdtucSatmTfW6oymIc2Vj9YPelpyEeCmdokzBCFl+eR0pOYf6CAMUBq4CAIG+XlU8K1ekGhJQ/N+9JZRP2qzqKxM/q82c7V7v1bi9674lmoOm8Q0lRSLxu7WHs5ryLhNZaraSnNu5iL65CBLIllGazWXhE7qobTwSl2iM1QBFHLBu4pRhKXS7XrfmcIg0eKZ9Mrlp6pVcxGcmHzzCm2es+MGQGg2AnzQVu8=
X-Forefront-PRVS: 02318D10FB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(39450400003)(199003)(377454003)(24454002)(189002)(6246003)(54356999)(50986999)(3846002)(305945005)(76176999)(6116002)(7736002)(7416002)(229853002)(69596002)(230700001)(81156014)(81166006)(50466002)(38730400002)(101416001)(110136004)(64126003)(53546006)(8676002)(65826007)(106356001)(4001350100001)(53416004)(4326007)(42186005)(47776003)(5660300001)(53936002)(6512007)(54906002)(6306002)(36756003)(83506001)(2950100002)(31686004)(97736004)(189998001)(68736007)(42882006)(105586002)(25786008)(2906002)(23746002)(92566002)(66066001)(33646002)(31696002)(6506006)(65806001)(65956001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2431;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;SN1PR07MB2431;23:MQm6U3Fud5uOYUy4YTEUoiH3CLErSXlLzp7j5?=
 =?Windows-1252?Q?NdkAUoMGIvK5lNVbq3FLJeUaiFkDJGSdqTtsw2DlPTnIKVmby6Hj5ZLk?=
 =?Windows-1252?Q?vcLRBLAceD0K/maoxW3Os0dSpqWG5lE/fi4bQRvAD4xSX8EX875MsUNJ?=
 =?Windows-1252?Q?T00GuVVgjaev6Cso338eSXMyxcNgnUlVkmP4C0Et31osBVSPM5Q+vv1+?=
 =?Windows-1252?Q?+ifKgClQzCBsdW9ZM3arl/pfRcku2jO0HkmduICBhjgEjbxC7lpnr6c3?=
 =?Windows-1252?Q?AOThV92bR3/WdtksoS+X4RnMjXW5jifYPC9PLisyUv+1sbHKv9ihCm5k?=
 =?Windows-1252?Q?0yvOuKzqR/DAgEV9gRe/tXFh4FXTpI2Vv1goLSW3TdtBKy/Eqrak3mKp?=
 =?Windows-1252?Q?ycaGRvVZeCGVNe8k1Mcr+lPhNrxWA/JoU4NHSk+5YTkAyRKiS9Sndd9a?=
 =?Windows-1252?Q?16zcf4cZdi589uu2QosXpwjZ94qN7zBRITCF7X52VSsPTZtgj2B4J49q?=
 =?Windows-1252?Q?bWekoXaV7CjREtA2tFMUlbkN3bMtV1IqoUuFTqV/kjP2a4tLwvm3rsLc?=
 =?Windows-1252?Q?Q6lKPcKv4qNRMKiL2s+BHOSjOpGlXjTK40tPkDojPAnpvQZVLhjbOwDN?=
 =?Windows-1252?Q?gPLnDyUnpbr+mujhe3QJhVD4kzzKJoK8u3Jstbc0eJSeEsn/GLIzUASe?=
 =?Windows-1252?Q?/H0zoNXkz1dyxrjFx9s1fn6pWNogdCmievoshJg3KJ9QOplKoaG7qzLU?=
 =?Windows-1252?Q?J0kQYhdbpP87Kb4yCyxbZZ1vHu6h6LJia2PJpQWR2oqcE7njgwkbw3ZR?=
 =?Windows-1252?Q?qXchmRZ8LxiponXTa9d5bhRW86xSPpzgs++rj4aROv4L0EURJ/z2HEQ8?=
 =?Windows-1252?Q?0jxEumc6XY7SUz7/3HWZxuw2urmVFI4QiLVE9sGJ2kKyhBVXlrJW8Q3D?=
 =?Windows-1252?Q?8dwok7STQYo1jeJninVIerQMxBd5ILFbypq+0LVWBllqV1wehm3ezq2J?=
 =?Windows-1252?Q?CRlQcBDtYY4Enkgd5IlQ7e6HzmBD1qDxiigwmFWQZmY+46/1x0zDKV2y?=
 =?Windows-1252?Q?xaMrtzPVbBE3On0//d/5hBmYpCE64nau7SouSULPjPPPHkNZ2kZ6QwlQ?=
 =?Windows-1252?Q?IlNdQ8vGt4vuIOsjF5CbJuwnWFr5EJEg6rCAUx4UsdjdMNKDYOtV2Mr7?=
 =?Windows-1252?Q?3c8kRZLYfh6rinsFlUuKj0EQ8NKv/1/Mvz6kVbGA9DGrLaY2DYDhNB32?=
 =?Windows-1252?Q?/pqowGqDqKNt921hFMO8R18El4K9jE4wKiKGjnIdmWdGasUPNokjh9Gu?=
 =?Windows-1252?Q?8dM1jBNOpXYYHs01KDOz0EVBKy5CIsR6ENFLxK2T5DLfOpDcS4bvWDpJ?=
 =?Windows-1252?Q?I3JVQXKniL0MfVayjk460sYKQtmwMjdQj/hrwSveI2fAXCg/E3aNHL7t?=
 =?Windows-1252?Q?ETq+Fv4pofRNLitN4mstxC7hWXEtLRpTSDn0sOuB93OaDUcpbTBMRnR/?=
 =?Windows-1252?Q?nENilJZpSe1kIYxcNHZHoVtxE66hDCKde/2Fy4/gzCIV3EhN21hBRci5?=
 =?Windows-1252?Q?KhRVURCB3HJETQ=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2431;6:oJkBeTOFsQO30IGfybl8Lm9GBGP087ZUfoSvSYEw3WX8Kg2MT03BndTJdacRBqAw8Z8iiy6Zyk/yfeyS/ojczoWy/azGlvtnp5eH38sACIOOeMVp5m8KlqfdOQOeoSMeCNLXnLzdDPOs02S1QVDEBxOPN7wvLXGsnflpTIxwTH9M+j8t/Tmaku0RfHsJVNVZi+QZ81gcpXVzWnbPlD39OsfrkKP1y/hJPVt5KhMo2ofr6mq61LJEHrQmpvSEw64H01CZz5mCrkmw2i10YYKSOXRfTuI/fe8n+NmCj0eU9Hao8veQ1pioqchv17YPFFfAxIV1DdGV8C33mi1BTgmPr/a9NrmZ3DArLqbnn21Jur6AQi8Y7ZMIN30grSpteH8o6vIz8RU0Hlf/MZPWa9XI2w==;5:pBLTuOSAhO9lUD4IP0FXtw2nbY9djyj4rPDixsJqRHpYf9uKHlEpDBfYk/wqFMNpBxziSmuAhg8dcKMRsfv5Gf5jVC9nAsCrlVLAens8E6TBWZxoOAvoWEnK6xfaujjRHvt2BC7tGrfN+kpGuqErXw==;24:zQqK3JrEaB4Nv8WftQ2vT2UyLjnPJxuXTzY07XdxkNBHthW8iiBZhS2yJZpyV1ySr12NRoNGIU+4CE4MJd1GWBHBTF6YOUQSJ4dy0bJRmRM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2431;7:yFHPIg2KE2eW2BarTncfrKMG9d63v+nNKHbkM2w7fonBVx4rQPwaYzUiKPcT29sPQz920wN86TcdJBdpIhCOtdx5bhyAFoB4sxbbwk4DpPtFhUvbgKpw1fOlLm7WkuyGzsk8jnwbUNQ4d9JYDIenirQ7mHKXfHYOMSC1msRuLyTID3a31bZfPqqwDwXWV3UY8Lv4EYLcYt2Id9p2pM8h5W07vj4+/c+4hAi6RC9xrkFKrHMme/WmHgWBjdV3LFPQMRdTYigR8KqzY8oXEPR4fgllwDynpCFnLqbaFLdoQ+hhwtNWIMtyyejMrDhDgXcYQXWhZxW14v5SFsGVTSEMGA==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2017 19:59:53.1218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2431
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56906
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

On 02/27/2017 11:18 AM, Jason Baron wrote:
>
>
> On 02/27/2017 01:57 PM, David Daney wrote:
>> On 02/27/2017 10:49 AM, Jason Baron wrote:
>>> The core jump_label code makes use of the 2 lower bits of the
>>> static_key::[type|entries|next] field. Thus, ensure that the jump_entry
>>> table is at least 4-byte aligned.
>>>
>> [...]
>>> diff --git a/arch/mips/include/asm/jump_label.h
>>> b/arch/mips/include/asm/jump_label.h
>>> index e77672539e8e..243791f3ae71 100644
>>> --- a/arch/mips/include/asm/jump_label.h
>>> +++ b/arch/mips/include/asm/jump_label.h
>>> @@ -31,6 +31,7 @@ static __always_inline bool
>>> arch_static_branch(struct static_key *key, bool bran
>>>      asm_volatile_goto("1:\t" NOP_INSN "\n\t"
>>>          "nop\n\t"
>>>          ".pushsection __jump_table,  \"aw\"\n\t"
>>> +        ".balign 4\n\t"
>>>          WORD_INSN " 1b, %l[l_yes], %0\n\t"
>>>          ".popsection\n\t"
>>>          : :  "i" (&((char *)key)[branch]) : : l_yes);
>>> @@ -45,6 +46,7 @@ static __always_inline bool
>>> arch_static_branch_jump(struct static_key *key, bool
>>>      asm_volatile_goto("1:\tj %l[l_yes]\n\t"
>>>          "nop\n\t"
>>>          ".pushsection __jump_table,  \"aw\"\n\t"
>>> +        ".balign 4\n\t"
>>>          WORD_INSN " 1b, %l[l_yes], %0\n\t"
>>>          ".popsection\n\t"
>>>          : :  "i" (&((char *)key)[branch]) : : l_yes);
>>
>>
>> I will speak only for the MIPS part.
>>
>> If the section is not already properly aligned, this change will add
>> padding, which is probably not what we want.
>>
>> Have you ever seen a problem with misalignment in the real world?
>>
>
> Hi,
>
> Yes, there was a WARN_ON() reported on POWER here:
>
> https://lkml.org/lkml/2017/2/19/85
>
> The WARN_ON() triggers if either of the 2 lsb are set. More
> specifically, its coming from 'static_key_set_entries()' from the
> following patch, which was recently added to linux-next:
>
> https://lkml.org/lkml/2017/2/3/558
>
> So this was not seen on mips, but I included all arches in this patch
> that I though might be affected.
>
>> If so, I think a better approach might be to set properties on the
>> __jump_table section to force the proper alignment, or do something in
>> the linker script.
>>
>
> So in include/asm-generic/vmlinux.lds.h, we are already setting
> 'ALIGN(8)', but that does not appear to be sufficient for POWER...

Yes, I just looked at that.  The ALIGN(8), combined with the fact that 
on MIPS, WORD_INSN will always be of size 4 or 8 (32-bit vs. 64-bit 
kernel), seems to make any additional .balign completely unnecessary.


Really, I think you need to figure out why on powerpc the alignments are 
getting screwed up.  The struct jump_entry entries are on a stride of 12 
(for a 32-bit kernel) or 24 (for a 64-bit kernel), any alignment padding 
added by .balign 4 will surely screw that up.

This patch seems like it is papering over a bigger issue that is not 
understood.

I think a proper fix would be to fix whatever is causing the powerpc 
JUMP_ENTRY_TYPE to misbehave.


>
> Also, I checked the size of the vmlinux generated after this change on
> all 4 arches, and it was rather minimal. I think POWER increased the
> most, but the other arches increased by only a few bytes.

For me the size is not the important issue, it is the alignment of the 
struct jump_entry entries in the table.  I don't understand how your 
patch helps, and I cannot Acked-by unless I understand what is being 
done and can see that it is both correct and necessary.

David.
