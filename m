Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 23:36:18 +0100 (CET)
Received: from mail-by2nam01on0061.outbound.protection.outlook.com ([104.47.34.61]:4537
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993201AbdCNWgLhXSDu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Mar 2017 23:36:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=qvni8KMLTNo7HaklkTkSG2y8cgeprJ5heCu3Qbef75M=;
 b=GUiqxnaNorilr7YUvRINwWz5kRngDZTGE2koe+y2Ek7XFeZby7V0FnMkLW5ZLGZ46DN+22nxc+jVvJAgPAslXGkxUDM7QeZQGqwlNjPvNUYkwQUtidFucJVxG4MIKrQL/gQMo+7cY+QFhVAKvyOkPnPxx2/3Thb8m7rPmCr4CzU=
Authentication-Results: cavium.com; dkim=none (message not signed)
 header.d=none;cavium.com; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 SN1PR07MB2430.namprd07.prod.outlook.com (10.169.127.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.961.17; Tue, 14 Mar 2017 22:36:03 +0000
Subject: Re: [PATCH v2 0/5] MIPS: BPF: JIT fixes and improvements.
To:     Daniel Borkmann <daniel@iogearbox.net>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@imgtec.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org
References: <20170314212144.29988-1-david.daney@cavium.com>
 <58C86EC3.9010406@iogearbox.net>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <2d6881a7-9a1d-f018-f0dc-62a5a61020bc@caviumnetworks.com>
Date:   Tue, 14 Mar 2017 15:35:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <58C86EC3.9010406@iogearbox.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0033.namprd07.prod.outlook.com (10.141.194.171) To
 SN1PR07MB2430.namprd07.prod.outlook.com (10.169.127.142)
X-MS-Office365-Filtering-Correlation-Id: e72d3d84-8fe4-481b-ab08-08d46b2a7f88
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:SN1PR07MB2430;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2430;3:qaAwkHBwQWtWfmut8UYpJK03WFNJCl6FtyxXru+1/ZK+VDWFLaJH5DiH/s7GkyikSXkaggT/J+B+ZMbx401Mh7OTsVTs3QRRHW+/pEk9Ex7Opz23E+XPbUBWwPeBeaz9flUJUNPk1mTXz5CYHo/sl6EKvDzS6QXne8B2vPFSoR8ZGmqitIayu1A6aGgq0uIeCrjVRKHvltlmrpq0YbJpv66Q9a2EAyC3i2EEqEZjPp6njAOmV+JJmJbmYvy10uBXFNptLES4IYWrBVNiJ/HO6w==;25:f++m/4mITTTejqlXO0I7rpk9sAh4pxNwsOC1bPe4+tifodMBeqJyR/uHtSl4kUbfgl3EPlErtpD8RPj2s6NZK0dj39udobXerJtQ/jfyonoxanoTli6/IiicX8ko+DgNsSXNCj3M6Qo5P2C3p9Eh2awTlUICC8RvcRrL2i7058SclTcGgV6OIP0pQo83G8RC6mf4SwLmNtmX6YCo+4c/NNPq+7ZZj8ui1HCzZ3EgLFmruhtz8peEaNLcKJI8C1sdw6vuLZ2muiak/Ze8Ww+g4g98j1VuH7gaUXjJ0DknUPvM/d7Ixs6TwqFtmXov6r1AzvKLA35rcn7JVabjZW9QJNN2XUhcL82jsVHxeWoOhI4BOd57GpFgCBTUO527jL+eIzfCL9ct0pMIV13fiBVvQQWaDM9SFFhUbNAW93pYSIeJALyJE5SVG7glDCu7lpcgql8drCIyeWSvQ3e8tnVbZA==
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2430;31:k4HRHjbOP7AxZ3A9NEttVnMIxBIP3IBdPBRQqWpqW/Kv2a7fLlCTBFRpN/9PKxHBhgioSkcX4/n/394rpvkdbYxrmA6NW7YAgTMMM0dSgNx6mXBdLWLglO4UB2VVJcI7UnLmqJHp0q65lZmlw/Y7ENdPk8WNqQ5402UOcV7yzqM09/DYG6VLSzSfBoDtdWOMr6zCISVvy0cUs5x9wJvmM4g74XSzIBPJsPTzfYJ/jUo=;20:0tXNfNiN9htcCNWFXAkkOYIb9nErsVc3G75PevE19mAu6vZf8VlJx+so5Z/RRPmA2vzdjazem1y2vxhz2KYebiLh/9QM/WrnQ7dG6Si+ElCu1H/di1DTpAHCudN9FLgkel43GovPcilR8hJmecwFnnlSsoneJxg0AXGOEL248bFt89vAX29LM9S1mUU55c/v/Mu0prI8kRl4tfNvAGLRbIYFXUL33Dg1Lmkw7a90XjeYI3P1fOgc6IbZOlEv1DPIBsDgS7bHCKRvvywCs1+q9GK0Pc0UwBVyUYmfMHiTXzMomZMuvPFuB0PMWbArEEOMelCYT0VaAfy0adQUonecfVWuTpX/2bIbsc4CDsxHtfiQwDAM2H3Xg2tLLhKC8UvlRW0nMqVxQQmHP1GMbHmGI6ppoUTAhzABy5shjCzpbO68f6IjJelrch729mQUvPqLskAd1dqKug+9iFLLi9j2AIr2zaQpMm1WL4sRANZM/VfD7s9gDQKTT+i2gh6NWOqZFWv9Qw3RdQUIxAw0IySoBsd6pSBIwxXP59aUhjfMSL+RdXeVVW8JiLYznz53mCEyzvMUImJK0q4t5/R3W8Pq1+NRAf4AFls5kXCkvoET9k8=
X-Microsoft-Antispam-PRVS: <SN1PR07MB24306504C86FC7819F8333E497240@SN1PR07MB2430.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(6041248)(20161123558025)(20161123564025)(20161123560025)(20161123555025)(20161123562025)(6072148);SRVR:SN1PR07MB2430;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2430;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2430;4:YnsEnnxUcViqaI/ei4mHr/7S7LkqYqkdhj5422keV/w0YxmCfZQYmsqvNxyqmJCLj5lVrsU4lEzofOo4MjRxKn+1MT9kWyUi/l2KAe6aaQpbdQrzsVCv3L1qDJcvDIXyzfSdbQirCBLQiRFjf7QqVhLUImKnSu86PJmb1uCDWEJLvQ0GGURAgGNi6BNO7zWJMKg8hXfvM8MDawEvqDD+6Xaekc/PrsJFnyWRgJynayFFofWi3+blPD+GnCC9xuUxl4/gK3LlZnpQkgFxSieqjb5YeBU1ei8lw8lhsJZKH/9EvMPON42ctqBCtkQDM5pPg3593rg6Y0yccGa+jW/QyNM+nR4lg7L6s1Ae5OXNfcjnBTQgd17qbXB+pyKwRUuaGpm4SEAfLVk7kdoNNxFeS/vcOqPFwyBCn8Rduls9ZYYE1n3poHC8yH9xH0iXmo9fGOejXYD8ElhpbVi4axNRIYEfMIau0v5+E/VxLI44YxRn/StvzrbwJUdgyMNfD4PNYuiK0wyAyjkB19eQa34hdEfk2wXGl2VKQWTTZC4ikwhDFAHxv7A4feZRb9fL8Ha9N1Ie/ePhHu5rICN8sY6evbLyxO4V/8R0GJQsNztGr+c=
X-Forefront-PRVS: 02462830BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39450400003)(24454002)(377454003)(8676002)(6512007)(54356999)(230700001)(36756003)(38730400002)(6116002)(53546007)(107886003)(53416004)(83506001)(31686004)(3846002)(2906002)(81166006)(4326008)(42186005)(6246003)(31696002)(23746002)(76176999)(189998001)(42882006)(2950100002)(6666003)(53936002)(6486002)(47776003)(65956001)(66066001)(5660300001)(305945005)(50466002)(65826007)(25786008)(7736002)(33646002)(6506006)(229853002)(50986999);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2430;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;SN1PR07MB2430;23:h1sTlViSDfPtImMRrzAkjUO4d8taKpFHbdVrB?=
 =?Windows-1252?Q?23KrloP2pbSu2Ha6FhJ1Cxm4Ly64EKJi8PNkDWiSya/Hht0Zk6ltTP7c?=
 =?Windows-1252?Q?gB70g3N4rdcj+g2nkCNegrhpwGm5yKL+Kewm0p6IYibI/WUCkWj/rsoW?=
 =?Windows-1252?Q?1PPFgySlHBHzwMWgAY+w6KqMNrp9TcizAULRigOtAO85DvBZWcRuRDo+?=
 =?Windows-1252?Q?6obXrZQT52qbXyEuXN5FxdM5OoHorfgre8HNGgTtXqz1ZNoQd0m75MdJ?=
 =?Windows-1252?Q?JqwAbL7l/h1eczlCMaACsG3WywwHEQ/RLbMl4aCxrnwgMHG0twqiosKm?=
 =?Windows-1252?Q?Xf5OEyaoo9IAfbWrY5eJrRH9lNdy/Ebm57EnIzVsoELpoGVERu4ehSk+?=
 =?Windows-1252?Q?fN2Oim6Zv+TIaoiK0lo5D4Vw99VU2qDMIiGpzhMNkbhx2nxsKBBU/3FM?=
 =?Windows-1252?Q?IAEOypN2r3bliv/7XaYk4IfZlvf7PWbkpjfNWffzOTbdEexriuFeFdN+?=
 =?Windows-1252?Q?p4PXo6UDob1Nb3cqb9ItcMpXYoD5RbtPqc00L8LBjdlYr8hOXbiIvnLk?=
 =?Windows-1252?Q?LrvnxEMI7BPn3Y+1uTOHhNKE1ilMbXDyWDOcVIUkJHJIkW8+2CFMwfQD?=
 =?Windows-1252?Q?E1XBI2CdXz2EMThkAT7MNpaAYdu63QsVXYWz8qptmOGITv8O6h6QRqof?=
 =?Windows-1252?Q?BXXV7VtJdCys/Y1GXHg6INKo46t1jsn34D7MMnIBSO58oaly8OfDpw+m?=
 =?Windows-1252?Q?e095bfP95gJ/SfJzy7G/upVc6fmTtY09y7RYxFgLtJGomh7TAHbc2fh9?=
 =?Windows-1252?Q?JuAc0IjaU27sN+HD9A0P58DYEp/Vy9pEv/tW58tfJjendYzrH1gyomVD?=
 =?Windows-1252?Q?LWRFuvVdj99gkrfWUjXlFzICJj59KsLVovvf9IODI2zY1oeWqd428IoG?=
 =?Windows-1252?Q?61/5HY9DT+uI36vCVfj+DKFhSTln29nuLkBYu87S1VkJPIPLkYZ7NlMl?=
 =?Windows-1252?Q?mRmgPBGrdnLPymjm4C+Ch+4qVQ6VHO4+EDV56yRPnUIQLf8UipSxhgIG?=
 =?Windows-1252?Q?TxWEQ0fHUWwnhtrryZ/kYeikT1I/Vd983sbAIHZOJel5Y8L4NQ95CQgS?=
 =?Windows-1252?Q?RcBzYF8VjUCylLHHmoWmb5i4M0i7Z/YnOTs3UntkyizlgCPDtU4uWGC6?=
 =?Windows-1252?Q?qZfgZNXeg=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2430;6:tDESoD9aH9Q3RF1Q5VSlyUC9L3FSnkkZ36uSj+7wYUFntOVD3G1e9FooezZEYJhxxYcxtxR27UrMYr7FBKmVHJU52D4oHBdTG3EbViUu/wnO8s2AeUbFPULy5ZomWC2wwNEgZEy5fsRu+8V+8oXx+xj0q3M+eRAdz8J8hDYjdh6EHlGH1fXoBuOXiqsy8nvx5q0LCNa3WXBtCSZnogK0zok7+4O5Obp/xZj6yK5uSHrMdB/ZK5yms3YrmsFhjEO4vQQtQ6R3N/EquhQpo1VqDbL4CVOw7K+fLCd0dptEbXRCx+fhsr+iMJPgwvMQRsCg3dZU/aWMdSG2L0LC5Qhu8jfIPhP/NLHb9r6sVdtmdmnYsuyKhdLSVIt0hEE3EaSv+JScQgYzcp9cjI2+gtVMNw==;5:PrmCztRU+O1yKxACMFOFE29AXyu27OmNcZ9HpCN8Wg6dtxEUV6SYtrjvC8e/tCi+O2JOtBxtTsLb//7Hjunt7Z+NVbSyTGwnGzTq0CHU7pls5taoRZiLD3cIVjW0wwXBgK/EucpZVxSK9ne08llEQQ==;24:lVbehwyqSkljexrKRu7DMO0UEwxc1o/wVMT7rWK1M+Gpa3L4bKVvXHPvbOedldGz1hcp7Wuw5qlmanwjWMPbbmnJSjtzMxIlTgZx+wXXBac=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2430;7:pt+MNmknEHKGil2NG+wXTlbZ7V9DGNABrH2oYEo+/F9p2Y4QWf6KeoXeyq4gi9AlFcIgqo/5ZMxDndDgieqgf2P7r378bvkVLTnxj+ubBtaYGhNvAUzZHuJR9Qj0o50FoMrgWftOnyEij0c4MLUIbBDrMnp+nlVkU5/u1SQ5gjeX7eVmoz2ZpS9YJqrYj+MzpD/rUKaUQ8hJOTK3e7TNp8Bybi4STS2R7NSf6bvTb5c/bQgTWD5+nq8tbPXfJ2ZyX0Pr2vIvDY7exVdU3ddpFaB0hNKNKBUe3/UD5QxOx6Xi/VSRRZi7h9ZMqRgwohXKR5rJJIAf2I3UgSEsiZaGog==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2017 22:36:03.0575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2430
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57269
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

On 03/14/2017 03:29 PM, Daniel Borkmann wrote:
> On 03/14/2017 10:21 PM, David Daney wrote:
>> Changes from v1:
>>
>>    - Use unsigned access for SKF_AD_HATYPE
>>
>>    - Added three more patches for other problems found.
>>
>>
>> Testing the BPF JIT on Cavium OCTEON (mips64) with the test-bpf module
>> identified some failures and unimplemented features.
>
> Nice, thanks for working on this! If you see specific test
> cases for the JIT missing, please also feel free to extend
> the test_bpf suite, so this gets exposed further to other
> JITs, too.
>
>> With this patch set we get:
>>
>>       test_bpf: Summary: 305 PASSED, 0 FAILED, [85/297 JIT'ed]
>>
>> Both big and little endian tested.
>>
>> We still lack eBPF support, but this is better than nothing.
>
> Any future plans on this one?

Yes, my plan is to fully implement eBPF support for 64-bit MIPS, let's 
see if I get enough time to do it.

David.
