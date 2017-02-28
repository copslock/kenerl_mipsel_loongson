Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2017 20:05:39 +0100 (CET)
Received: from mail-co1nam03on0085.outbound.protection.outlook.com ([104.47.40.85]:56512
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992214AbdB1TF31N0ti (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Feb 2017 20:05:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=XfXp3Ob4S3mNGFm+PWCDhKo3orlaGA2I4FpmOzMc7QM=;
 b=jiNir5LAqdTMfMmOJMdx6my/eOUiDfbgZ+cl0J0WiYlDoT/Uhfa2Td8lQ5ZC30wj5/EEq7E5vi6X5ouBSdWfUzCLioy6hn3Ay5RFmZOfHc2kimTjga0yQjpy7px4rCRWheltLsKe6S2Oze4gjytgzYrOYJ24ysUUKF2yH6QeoqA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 SN1PR07MB2429.namprd07.prod.outlook.com (10.169.127.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.933.12; Tue, 28 Feb 2017 19:05:16 +0000
Subject: Re: [PATCH] jump_label: align jump_entry table to at least 4-bytes
To:     Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
 <f7532548-7007-1a32-f669-4520792805b3@caviumnetworks.com>
 <93219edf-0f6d-5cc7-309c-c998f16fe7ac@akamai.com>
 <aa139c18-1b04-2c20-2e22-89d74503b3cf@caviumnetworks.com>
 <20170227160601.5b79a1fe@gandalf.local.home>
 <6db89a8d-6053-51d1-5fd4-bae0179a5ebd@caviumnetworks.com>
 <20170227170911.2280ca3e@gandalf.local.home>
 <7fa95eea-20be-611c-2b63-fca600779465@caviumnetworks.com>
 <20170227173630.57fff459@gandalf.local.home>
 <7bd72716-feea-073f-741c-04212ebd0802@caviumnetworks.com>
 <68fe24ea-7795-24d8-211b-9d8a50affe9f@akamai.com>
 <510FF566-011D-4199-86F7-2BB4DBF36434@linux.vnet.ibm.com>
 <20170228112144.65455de5@gandalf.local.home>
 <cdf98840-8d43-2c58-e2f9-75ae8fb8a600@caviumnetworks.com>
 <1de00727-de97-f887-78bd-dd49131cdf61@akamai.com>
Cc:     linux-mips@linux-mips.org, Chris Metcalf <cmetcalf@mellanox.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@armlinux.org.uk>,
        Rabin Vincent <rabin@rab.in>,
        Paul Mackerras <paulus@samba.org>,
        Anton Blanchard <anton@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, Zhigang Lu <zlu@ezchip.com>,
        Michael Ellerman <mpe@ellerman.id.au>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <999e2c3f-698c-703c-67a9-26aea3c97dc0@caviumnetworks.com>
Date:   Tue, 28 Feb 2017 11:05:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <1de00727-de97-f887-78bd-dd49131cdf61@akamai.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BLUPR07CA0046.namprd07.prod.outlook.com (10.255.223.159) To
 SN1PR07MB2429.namprd07.prod.outlook.com (10.169.127.141)
X-MS-Office365-Filtering-Correlation-Id: 9f8ab395-bac9-4fc0-d1ef-08d4600cbc88
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:SN1PR07MB2429;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2429;3:HOFSwXU1W7hvOurDg743C/w6ydpv43r9QB2d+Azga0YCLg7+j0TGqk/gcyPr1E+HYh9EmgWLE8/8gtBkGehmvLJe+IDPv2Q58rXahFXH3EHcj/XgqhN6I9gbbwWsZVOQy3P4oSh7erKbKcMdVJs+KoDkdyOAj0F0FOiZbqq8ZwPl/iqYnJgusJXV6kwwmiuWigwTvlPZTbmxTJDhAoJXJvVkIBabNg+l7x9V8pEbbSZIyJCVBvrS4o5rbuYJ/VXDG5HQEOnF0m0QA64nIeYbxA==;25:DCkd/ndVuwhiW08+Q/1ayYjuLoMQuK1/E45MDbAmz8HZYPjVoMvxfxe4JvKZ/K8jxeyL/uQeReiAfbS7qFDfvytzvdAohcrjsvhT5YT+84cgrko2pX3EeVTDfUIKeMkBCr2a+wHh3NzXFk3hAqV3aiTzBlXQ9ObYn2zuEdbPqv1vbM6KeHb+sZOuQS60mSWGmxnevEXfWmCdLLwfHyEyGqM6xDHrx0r0EqyRp/o+gnsrhWLOCFRU67s323o4UPszVPESssMS4BJkQTRjDdMZDFqMUqSgnVyJlIeFMl3+nPuVvOVMiYhJcwDsY4FddJ9zkBdlIRXbz5Z/jLMWRcgba5JrWAT/iQhspqNKSqmqcQNmLJivYJEfdqBemVj/vGMkvcLdxlRL9/Ki/pxtjgDseEre4OPyT/0NsRqE12bpY3yK6XVr4nFre3RrHkjYG+anB87d6inA3YL2I+EaqPxUbQ==
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2429;31:X+Ao8O92gOewS6z+4xd62vWNhAXuVg71Bv419TkXEbQotGwFkrVlBQskOQl4hywcbKQ0JSeuhikeSOrDOnAhROG8jpxkpIuIOH0dO7d3A3xPZmS2xMKxiGgy1sSEbCRLpEHEPQRMyTRLEw6z1pusiiJCNo4DDeIDJwZdV2cMBouJcPhCdkj2i9CtcVbwtseAO2USF/qtRz+HrZgRDDnWQf5AwT+RgoGTlmF8XZw137ln1RPTxXtJHUG/E3PzNzeBAveoX9niQgBZ3DeZyTS80NsakyJPhDWfDy3xnBERWA4=;20:AW6P2//z6dlIaYyNdkIgxBva+4+gywx28iFn167CYBHdi36bDzq8o32ZYSEkFK7lLoyVFFt3MqCtDnJTo+k9vcKlneRRGmWFJtWK3NRwbSM9GAhhxWJblH+LPV6Uzut4FB7cSbvcTHQ/QScztF+sFSxgixPgWiRWv42UazB9uvzFKI1pDZNUO6mBIPCR+QQ4Dmz0pJEXbqk1W/PLPHkPLjk6nuK/bUPy9J27adQKVoR17u+taSP5iuAr/jAeZg+G/Uiw1A4523sneIR6dyE/u7ezf/bdJPDYieqRb8iHl2C/yQZ1+vA4awxufwm+49iXAksDlRzc/iUnLdxM7akb0VRpytqQtRFul3YAlVzXI616CylvRvP48fBXGexrGRIk4cWs+2KSNQWa8mPtfGS4yErnXv+RBdTGnlcpj+0bJPg7DgEXCAkKkMzDr0JpuZk82GrDRIpWRcZZKgmn4FfLAnx/Kn0xhyQFspTOQ8imPLaFFf/2ftN2GRyEsk7/ea3lPQFPOd7H6bH9cYeMkO6BGUtdRc9ElYEcTxzTszaioY4j7Qhi8gwrrXFnoWhjpWVYBFaZKpBG1bYAUtUlNeCCWbrz8LVJ3dM9Xzo7tppAFQ4=
X-Microsoft-Antispam-PRVS: <SN1PR07MB24297FFED8066901E89ABB2E97560@SN1PR07MB2429.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(104084551191319);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046)(6041248)(20161123558025)(20161123555025)(20161123560025)(20161123562025)(20161123564025)(6072148);SRVR:SN1PR07MB2429;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2429;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2429;4:qNtE7YZAS39jxjW53l+T49JwlHGzUdEN4AE0c/5GeRhlfGctDyMBQBlrBGSNtESYbyRcE0D3VmZQGQZenqObgzDHTc3Xz7u1n+BtFg8ubHlaVgEEtYzfG6X70Op+fcCnrMLxjKEVSsZ5wHIC7O/O8AG3llKRUhKxv3ZsEhMm2unWMSZRuFERCSJ/X/fZUdqNNN/qVX/KnUWVKu/5qG8rBgtzj/zETme4RNj1egZLhddDiAbMXewvBmTJ9bZSJzdSeoOAG1Vxi8feBCm39CUan9Ug1dK2R/E4uWSIG+vGkPBqgam4GkFwKHU2ztLRm5hr0BKPVWtzyProMinggCOHhxkt+2zp1ZcaGa9ugB/4nTn/s0JBs45PrMLxWkl6pO1NyjcYbdqEeUCuA+ROhmfZYaOYolR3XKa8xPa9N6KngYXObAzDDNtHHTCXy5yuHlaa7iLRI7wvXSDapWw6jPHR/H7+EhQ2U66JtVQFNN5Gltule9+IdE+jt1FTadtz9xzoDNHwoyOgXIhkutEJINyvuhC+7EJVs1ICxFOy+FLa50zqHcK4lkjRXTST5uyLkcJWBto5K6+2FMWfqRa0mPDKqgZLSqt2ehzvGBSKYfv/8jd74A1lqoN4Be4sb4DAbjXJ+f3zmMtN44UOZb33DmUzog==
X-Forefront-PRVS: 0232B30BBC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(39450400003)(199003)(377454003)(24454002)(189002)(305945005)(65826007)(6506006)(50466002)(23746002)(105586002)(68736007)(6486002)(64126003)(5660300001)(229853002)(25786008)(53936002)(54906002)(6512007)(66066001)(33646002)(65956001)(31686004)(6666003)(7416002)(6246003)(97736004)(4001350100001)(7736002)(47776003)(65806001)(42882006)(189998001)(2950100002)(8676002)(53546006)(93886004)(2906002)(81166006)(92566002)(38730400002)(69596002)(106356001)(81156014)(83506001)(31696002)(36756003)(42186005)(3846002)(101416001)(54356999)(230700001)(6116002)(53416004)(76176999)(4326008)(50986999);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2429;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;SN1PR07MB2429;23:lsZTvlTdnVL5maWz59O197xw7iRcjJe+GD7HO?=
 =?Windows-1252?Q?pi10DUlYChe06qxaYS6squh1zCalOVX2qEHPBQvVwJyhnYOiN5mLjcru?=
 =?Windows-1252?Q?azCxdBEi8ih7QU/MrOIMKaDvJjNhqCj046TlpakVeaBoZzvbx/WfAUq6?=
 =?Windows-1252?Q?w/cDf2WE1eOnGfnIeF6YJzBoCiaBP26C0OEg+oV4gfgednWo1FPxzl3N?=
 =?Windows-1252?Q?JV5PNmzkUCRWqoVW0dXHLqRh2IHiFtyNriOSSSqlQ1+qK1OOBZ4BgpRt?=
 =?Windows-1252?Q?M/k7g4FgdQEqVffKrc0xLzFx5W5vgvOJFHoKf1pSSs+46DQGDqsHP7+r?=
 =?Windows-1252?Q?WJfdhksXpbyeEsoryKOg05ThpzSpfaf47jvOGMqUtI1iAsqPOyv1DRHG?=
 =?Windows-1252?Q?yFaaB2Oxm+CTWRYWd6hO8BGNhosrxhiy3+kU+uF0p0Rn6IfPWt1uEdSD?=
 =?Windows-1252?Q?3eOqegikVyw2wmZwXKwRalOIbVJvPe56nKgP0nR4Ip82DqNWGkq9a0IX?=
 =?Windows-1252?Q?osWRolOrH8HSPTI6LOH/jXSj9Y6WTeFbUSiXOQIZrsxnh08znLm+nhkZ?=
 =?Windows-1252?Q?rMTA9ieSCISMJmAIiQwQ3RZFea4akPElx19FQ1LAn3xa8zlP46PtofX3?=
 =?Windows-1252?Q?KkCNUhAe8sk4NKXJaa4BQptnD3CcqxpcCoHlianRWWmbCxgTYQsZfcGK?=
 =?Windows-1252?Q?URSptJhV46KdC+Nkm3dmDP6lBt6PL/Rv81k9hdQHWqCH3gqk0OVY/Zpt?=
 =?Windows-1252?Q?S+VxdMXgkUYcAmH6EY1TpKlj1pldrqo7BFOUX9Dmf4BpRNjZ0HOCdurJ?=
 =?Windows-1252?Q?jO3kl2mqLfNVy7e8ldKtTLYfkgSb83a3J868V2DY4FlGjmMTWRA4w4E4?=
 =?Windows-1252?Q?ZyRf1Sagkzpj2DlORkWmHnZLP0lF7t7FTIBmMrgC7p81DG/frQvhQfvV?=
 =?Windows-1252?Q?fhOrsPiZE/fOsmSr5rT622GLRWlj5TpSH9m6SlyFmbSXMLj63Dw4mi1G?=
 =?Windows-1252?Q?WU9BIzFRH6e+eCbimefZDZCY/wPTXLVFTOjpAwBH/mD6wZYcXn25r0yu?=
 =?Windows-1252?Q?GTTETnszdf+7sYY3OkiEyJMO+v2fYRAvPiRAPhiIKVnQZFyqf7DqKk88?=
 =?Windows-1252?Q?HmACyEPnEPhUYpVhfgNhNLBktnSOVd24DOGJJoHXh2WoN8a5YW+iDs4A?=
 =?Windows-1252?Q?xTxtk6mhSbIqvDHCWfLkYYpKCemxHhFoIW101aSr/xW9T0IBBN3cteW/?=
 =?Windows-1252?Q?wym0dgMmthawVUtTtSmgfRTlZrvRcJ+zUuGJzIiaNDrps0ojL1R6KAvy?=
 =?Windows-1252?Q?a+u6jTinBhEXx76IgB2cuBm/bm8hMMbh5AWGZkIf8u+EdSUh5nxUjS1U?=
 =?Windows-1252?Q?aYLbnOhLwuP4uhHq6jmpjtIgXrscf35gNUOIYNx/eguHu1n46l5QYBf2?=
 =?Windows-1252?Q?HYuLvweXcBBMRQdWsjn97+bQR4sfAG2rGZ0zg6KeLsrn/v+NzdHuI8W+?=
 =?Windows-1252?Q?CtuHVDxlzyCZgbfj9Qm0Vt/1jAHP+9xycaheKbUsygqmWj1D2qBKLiDu?=
 =?Windows-1252?Q?v9ywO1wYxTeuUo=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2429;6:hnrlxjR8J3UBi5nWFCb1+B1CXV6yqhprd9ToPquQkNZiDkvFR91r3dEEhNf7o897Pu4TYD1RZyVIhgfFaJeMn5twF1NhgG6QX+11BTpKD4YcylOgSS+7o3e/P6EfAyahpPr9rjdaPgb1a1jOPOksYVJqsPeEzYQfOn0zTyABUJesZusUS9XP+LqjZqtI/V4dlcyMM1uEzGR+xM/7C1BfSHfYDFHC4IuF0e80pHN67LR9ul7CD3xzGRYV1nFdDnL0ZWC3KeNfgAc0wiOD7lSddPjQu/fTI9BaOuMCsH6L6+I2FWRXwjvYTH7WKrl3OWr/aPvDXPUQNudBIgcjMkjyfS9wihHYBp23mAKepaMxu7GSEkm7sNfoVoG2vqB4/NBsagJiwTYbjCjJ5JuhuJf7vw==;5:KChB0eJUox4kkXgKa4u28vlazr7zG8O62/L2FHgG/aGrrK19n0OWyHyG03u3RLdSBpStHHVQCfKeoi7CKMFsbKoVcZyf7r9nRJZq7gbNiPqtV+N6vPrC1HOZrTKUMGbFItKsOCcbxQD9X9kc39hWwg==;24:66GWx2stB1o+ZTbn5UTX37TtksB40wqOQcI2NweuKzTpv1V9oea9hhQhYEqkGxewxa8L/muVnkssReeCkVNU+zebZmfI/avvoAdE1Hx9BnE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2429;7:KfZ19GR+c6RrTcYEtN1Rs5bUnDP42D/WcOpzdjsZjaMwSOlciKyZmdqzhNdJt60v9SJHdGyZ0dkO6ElbgUbvAAf6FaumB3akSJgyX1lhwrICvElys72EBMT+zjx4bTlub87iOuN/sL9jfFstOpiOoF3CUejD1+N+RMmT+rVjXkw/OTkHH1moTKXH3SAzLHMMwQeBsPWr35ETXiHc+v8Svz7LyAo/WFI/BSR8WqQowyeN5K/hyv6qUb2DB3tf1n1+Bq6n7NfdFvg5JmoFV9gutuiSITpXy4Y0d6O/rFUfzUWAgwyRndwB3xDDB6UcQr38tYediidx8eeXMKVXuPzrvg==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2017 19:05:16.6914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2429
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56929
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

On 02/28/2017 10:39 AM, Jason Baron wrote:
>
>
> On 02/28/2017 01:16 PM, David Daney wrote:
>> On 02/28/2017 08:21 AM, Steven Rostedt wrote:
>>> On Tue, 28 Feb 2017 10:25:46 +0530
>>> Sachin Sant <sachinp@linux.vnet.ibm.com> wrote:
>>>
>>>> File: ./net/ipv4/xfrm4_input.o
>>>>   [12] __jump_table      PROGBITS        0000000000000000 000639
>>>> 000018 18 WAM  0   0  1
>>>> File: ./net/ipv4/udplite.o
>>>> File: ./net/ipv4/xfrm4_output.o
>>>>   [ 9] __jump_table      PROGBITS        0000000000000000 000481
>>>> 000018 18 WAM  0   0  1
>>>
>>> Looks like there's some issues right there.
>>
>> Those look good to me 18/18 = 1 with no remainder.  The odd numbers are
>> the offset of the section in the ELF file.
>>
>> If you look at the stack trace, it seems that it is during module
>> loading.
>>
>> Are the primitives for generating the tables doing something different
>> for the module case?  I am not familiar enough with the powerpc ABIs to
>> know.
>>
>> Try this:
>>
>> $ perl -n -e 's/\[ /\[/; my @f = split " "; print hex($f[5]) % 0x18 if
>> $#f > 5; print $_' <~/jump_table.log
>>
>>
>> There are no entries with size that is not a multiple of 0x18.
>>
>> I think my patch to add the ENTSIZE is not doing anything here.
>>
>> I suspect that the alignment of the __jump_table section in the .ko
>> files is not correct, and you are seeing some sort of problem due to
>> that.
>>
>>
>
> Hi,
>
> Yes, if you look at the trace that Sachin sent the module being loaded
> that does the WARN_ON() is nfsd.ko.
>
> That module from Sachin's trace has:
>
>   [31] __jump_table      PROGBITS        0000000000000000 03fd77 0000c0
> 18 WAM  0   0  1

The problem is then the section alignment (last column) for power.

On mips with no patches applied, we get:

   [17] __jump_table      PROGBITS        0000000000000000 00d2c0 000048 
00  WA  0   0  8

Look, proper alignment!

The question I have is why do the power ".llong" and ".long" assembler 
directives not force section alignment?  Is there an alternative that 
could be used that would result in the proper alignment?  Would ".word" 
work?

If not, then I would say patch only power with your balign thing. 
8-byte alignment for 64-bit kernel, 4-byte alignment for 32-bit kernel


>
> So its not the size but rather the start offset '03fd77', that is the
> problem here. That is what the WARN_ON triggers on, that the start of
> the table is not 4-byte aligned.
>
> Using a ppc cross-compiler and the ENTSIZE patch that line does not
> change, however if I use the initial patch posted in this thread, the
> start does align to 4-bytes and thus the warning goes away, as Sachin
> verified. In fact, without the patch I found several modules that don't
> start at the proper alignment, however with the patch that started this
> thread they were all properly aligned.
>
> In terms of the '.balign' causing holes, we originally added the
> '_ASM_ALIGN' to x86 for precisely this reason. See commit:
> ef64789 jump label: Add _ASM_ALIGN for x86 and x86_64 and discussion.
>
> In addition, we have a lot of runtime with the .balign in the tree and
> I'm not aware of any holes in the table. I think the code would blow up
> pretty badly if there were.
>
> A number of arches were already using the '.balign', and the patch I
> proposed simply added it to remaining ones, now that we added a
> WARN_ON() to catch this condition.
>
> Thanks,
>
> -Jason
>
>
>
>
