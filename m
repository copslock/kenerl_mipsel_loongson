Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Sep 2015 22:39:19 +0200 (CEST)
Received: from mail-bl2on0073.outbound.protection.outlook.com ([65.55.169.73]:37696
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008536AbbI0UjRSxYKS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 27 Sep 2015 22:39:17 +0200
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@caviumnetworks.com; 
Received: from dl.caveonetworks.com (64.2.3.194) by
 CY1PR0701MB1727.namprd07.prod.outlook.com (10.163.21.141) with Microsoft SMTP
 Server (TLS) id 15.1.280.20; Sun, 27 Sep 2015 20:39:07 +0000
Message-ID: <560853E6.7050902@caviumnetworks.com>
Date:   Sun, 27 Sep 2015 13:39:02 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Rabin Vincent <rabin@rab.in>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        <linux-mips@linux-mips.org>, Jiri Olsa <jolsa@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [PATCH 0/2] perf tools: Add MIPS userspace DWARF callchains.
References: <cover.1428450297.git.ralf@linux-mips.org> <20150927160419.GA8529@debian>
In-Reply-To: <20150927160419.GA8529@debian>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: DM2PR07CA0046.namprd07.prod.outlook.com (10.141.52.174) To
 CY1PR0701MB1727.namprd07.prod.outlook.com (25.163.21.141)
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1727;2:Ovn854veA8eZwyenThRNbMSqQA2NKSFkFTztMXYUNRUQyLsEeSVrLfCetTTyZFe6jus627FMOKBP63/YCSk79quHHuahXHWE4lBWaODn4a8ORb6/wQ2ckgAjrsZmuL8ShAPAsJhbPCh17cVgnMYQJTVdYd06HaOJ+hdUESMt2fc=;3:wpO1dzaqOGnhATzOh0VQhxL1nns0PJ8/jKDxUxfh86geTX3VMPFMPaVc2x9xlZ3FNB5PdSkPZ9w65YC2oJFRVHwNpCRgoY6qrjgIFmyJoZQ3A839Lqw+KXuzxGdhgxEKa3m7SjtKUldEqNBGjQc+cA==;25:p0mSNA5gzZnH2aBHdwHsdvcZi7+PBixE+qhF1DmvSpEN1ArevQIt1feisoJw9dKRw23/8P7ALFEgdVCgxRejFDzw40Oueo4zRHg3Qxc4mHN1iM0dP4jvecjZihh6cSwYpcF4J0767llJTnzGBPJo0spKBs+oCBEf9kNzXSTUB5NCVTF8jEaZpdxj+dVt/3GwXH0LIu3OeKdKBjBk69MAZ4yTHskbwjoaoJhgvHTQk8o3/0xfadZy/ZI2lnWw/2I2XWNJZDlgtPSz2SmIlmmnPw==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1727;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1727;20:zQjVwrxwj8eSQBzYwZs5QxsL2Hb05S59GPsbTLx16uJux0rG5Yc2uEims9aE1+b1NM0hsc+siTQf5ZIgQDhLzLOfJNTBPXDg4S84FmbYdFVxWpa8eFu5DbKz+2QynMNmWzP2p7G/SelTgDzvWVOuqzaAG+B3qNcu9I+jodm4MSenkoy5rhee7gVi7Gqbakvb3iXU640LuDLC2l8VrVPmiGqPMOdKm6NNPe79ek8GWbIqSgi0rasnWny2dTLouyxXqDEfSenT0dp0M5JvCwin06eU/FA/aZrSaUMW6Fngdd70KwgAfmHVQzREaMmTbyOFSCvQ5Wbswi8uQG4M+g5uhFuYj5BP0JJaTYA5anzm5jgDP57UftU+IqUReZIRsGydCgBNHFv34iHliwj5VBwkhO371Q2GXmJDaI24GBwhQRCub03HcbXH1MfbSxZVDdHUO3y2bdrCEF3j/IZRM8fnt90k70k6Dr/7Qi5NbmRIgpuIZvwUFZWBgA2KfMF8K95X6noou/R62/wzK+kIqNNdQk56F/EpvxO0eLSfGBO31SiD4uXRGCKC8a88dPkv6ejihXFu96OsM1LzGUfoizObSbWmSiRI0foaTgNKTEjc2qQ=
X-Microsoft-Antispam-PRVS: <CY1PR0701MB1727A00FEBC1FFFAC5BBB90F9A400@CY1PR0701MB1727.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(5005006)(520078)(8121501046)(3002001);SRVR:CY1PR0701MB1727;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1727;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1727;4:sureq12Wylm9V+/i8QhuzGG04zE5rZVkbhvQQNN2t7lHuTtey763+SK9qVCHMU9d2ObK0iNI1xdZ5vsFrhQ3WQfpLZ/BO1gQycXgF6KP035avMS2Apvj7I457bnCIKhshRW8FCJnvxLWsqsT/apjPEZILPAupW4yT5eRqDC503OyzG8eVoD0vKctuFUbuPMOTw7Qhnb2EvnGidXPg7ChDVWOYTxqv4stKm2zTvZRGe/aXAt0Jhq9hgga/QKLSnRZ9SGhyjJQ6AOPhuGuHTVSxdg72EoeJf9W8Mwsf5cea6yJfy1FJmYj/mY1P/c5jaZuzSlyMRGsueKca09TcTwpP+0Tk0tM0iLfRN6OdbjTxsw=
X-Forefront-PRVS: 07126E493C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(199003)(377454003)(189002)(164054003)(24454002)(479174004)(64706001)(33656002)(19580395003)(106356001)(101416001)(83506001)(87976001)(40100003)(50986999)(105586002)(69596002)(65816999)(80316001)(54356999)(87266999)(76176999)(59896002)(5004730100002)(5001960100002)(110136002)(122386002)(189998001)(5007970100001)(36756003)(92566002)(42186005)(99136001)(64126003)(23756003)(46102003)(77096005)(97736004)(68736005)(4001540100001)(15975445007)(5001860100001)(47776003)(65956001)(5001830100001)(65806001)(53416004)(2950100001)(50466002)(81156007)(4001350100001)(66066001)(62966003)(77156002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1727;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;CY1PR0701MB1727;23:1c9WR0V4hSa0mNxS6x2JGT024thMhN+rm6EHF?=
 =?iso-8859-1?Q?d9N5Uf0KObiVw4zMmwkGE3Y1A6xvkt+9G4tR8WXTdc3lZLfupEmKvepHih?=
 =?iso-8859-1?Q?0uTLbriDdoXYj/eIgHqig+BxqD3qrodBdG4MVU/eAp/K6qj9cS01TCawkp?=
 =?iso-8859-1?Q?UFkYTKKdlU/KUujPPXW0YsFKwhlu5pjcE7gBqw223SFI+BJiI0pUNxgnQ2?=
 =?iso-8859-1?Q?K3WMh9CZ0YZ7R4J03W/24/7wFcfpRQUKXG8/GFcRXKGQME7cVNGfxJkBPr?=
 =?iso-8859-1?Q?aOEzSaz/F4rGeo/XFTKwZsqIqSpZ0jz2lRRMrNvZwsXXvgzmMOPPFLQ9U9?=
 =?iso-8859-1?Q?ljnp6EjCK0PlX4Ssza5PVujjVFoAQUiEPaUD5K6kVVhvhXdw8aMmwXnVKk?=
 =?iso-8859-1?Q?NOYD6DoJleb/pbPCXv/SLxTa7E2Jfaur8AeaZ+BPYfgNaMKIJqPn7MX/LY?=
 =?iso-8859-1?Q?2Vh4F9oHsaBWGgNfwiQV4dep9F07TvY2Y1SSi1J7j4OTtArK4Yz63icp04?=
 =?iso-8859-1?Q?fCr3ZRBV/XSoA+hNj3KdZGqLbv4DNyuYVOQGhzbE7ihuQ+P0noRfHPmmoE?=
 =?iso-8859-1?Q?Vp1A2UBtLkRfXD7XHWDTKOqvuNHLzo8ZLtB9t/PL5lVSpUs/jRiAemPH7E?=
 =?iso-8859-1?Q?dyuxyWGevW4+ZOh6EnMyM+W6zC4GysKf4UkQrzhhgNCmaU0cqSqjEQqyYO?=
 =?iso-8859-1?Q?9IzS1hcLGlvdmDoJbYKr4nN/O9mZQz6OId/tSadYZ4RebivqDHFjax7Ktw?=
 =?iso-8859-1?Q?NGKqImpR/j2dNhfH9r5qzwdD0hd4TUuGKNtFpmTcXLV4ltD1PkXaOdtwOE?=
 =?iso-8859-1?Q?4U7hQ/QsQ8IlVtxopczSjblQfLr2EDp26MYrHp3cdc6dbDnJyL992lk9kf?=
 =?iso-8859-1?Q?MiMp9XYTqu2VcaGt+oPCc3kURUDZU2wwLIvqRbDFXvgjiOFCGsEUJwFhhr?=
 =?iso-8859-1?Q?5USjGTaGTAIdovWj7eMHsO2BpFXLRjC6Tzm8CTbo0zIsYIibfNvPp3BiCX?=
 =?iso-8859-1?Q?aUlvQfg78NW2NPhn8mt8t/vgAlYVis03PFZ7OwiYXw84lunmMhHh5KWK19?=
 =?iso-8859-1?Q?W8StskwGXDZ8GTiCD93ujsSBt7H36nukwFwr0NHmK1FXXxzYgK9L5UPnfE?=
 =?iso-8859-1?Q?aVZafpoHyfdlhQFiFqOwzm96tMGSTnyEhAAKVidKyMxPkzoDo1t5UbgABU?=
 =?iso-8859-1?Q?uNYYwsW2r+GdERcY+ro2mMrEaF7TxXyZXMa0H0GCUFzczR13FSENNe8MJw?=
 =?iso-8859-1?Q?JteVQUPo5Z93Px8ls0hPGfSonXfmr9OBrQQ/EmdvFFoSqYFoOY8gBLv0TM?=
 =?iso-8859-1?Q?0Ifmm8NH9N2fIsuyNRhnntA4LtcvnqDHIvAIeEeKik/Wv1cvN7taq2t1+o?=
 =?iso-8859-1?Q?i74MOoYitpalbwIlAc9SdUaZdRhiOJOIbpUHVnnnx5bLpXNcQoOjcb8EbA?=
 =?iso-8859-1?Q?SneQE6iId1fqi6gbN+HnZFsOCmuhY7cMENeAN21f9s6U9JTcJ4775paJc/?=
 =?iso-8859-1?Q?9BFxk1Z2xb+b+a5UBM4+nU=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1727;5:wTx8jbI5xL6gDTNqBTAhXgjf65GwzLZfoXRl/3U1i1BudCUykQkGAXDXa1OBDhP3jaldEFg/kRuxowcdfqjd7/NQdPL3CDJAvBsASbiw52TsOnZavO3wJei/9WzubXDZyFNbiP7LQ4jPIQtXNAMK2w==;24:haA8qx8WASpB/z8NsDtNfSxfOI3cpvLAAjgU+RKLpldyzoCaIAD68y5+0bMQbrPs7FWnB5AYM/+p5TEwh/Ba1FsKWt0n9E5Ze3gEGn2Xg0Y=;20:9/ctk8H04tE0AMHD/UnWKJ0cOj3VXLYaKFUXgmTAPLVRdfLgoQbJsvHlNFYKCx6JNmdsMRqolurikmN4MX5hCg==
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2015 20:39:07.5438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1727
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49380
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

On 09/27/2015 09:05 AM, Rabin Vincent wrote:
> On Wed, Apr 08, 2015 at 01:58:45AM +0200, Ralf Baechle wrote:
>> This is a refresh of a David Daney's patch set to implement MIPS support
>> for perf.  It has been posted before but not received any comments or
>> (N)Acks.
>>
>> This series depends on
>>
>>    http://patchwork.linux-mips.org/patch/5246/
>>
>> which currently is pending for 4.1 in the MIPS tree so I'd like to upstream
>> these two patches through the MIPS tree as well.
>
> Looks like this "MIPS: Add user stack and registers to perf" patch
> didn't get merged in 4.1?  Could it please be queued now?
>
>>
>> David's original patches are archived at:
>>
>>    http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=1368817238-11548-1-git-send-email-ddaney.cavm%40gmail.com
>>    http://patchwork.linux-mips.org/patch/5249/
>>    http://patchwork.linux-mips.org/patch/5250/
>
> I've taken these tools/perf patches and made them work with the latest
> mainline (this addresses the comments Jiri had) and can send them out if
> you'd like, but they need the arch/mips patch to build.
>

FWIW: I don't have time to work on these at the moment, but I still 
support merging them.  If anybody wants to take the time to get them 
into a mergable state, I would fully support, and bless, that effort.

Thanks,
David Daney
