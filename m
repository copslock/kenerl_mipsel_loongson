Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 20:54:25 +0100 (CET)
Received: from mail-he1eur01on0064.outbound.protection.outlook.com ([104.47.0.64]:56512
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990845AbdCNTyPSRT3i (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Mar 2017 20:54:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Kp1sMh0Mvi3tOfjeIxtxOZO8nrcM1upgj+BJCQYWxzY=;
 b=SlbTCnozA838p3KzR3m3rvpZfXbLPgZxdXL+yTbvl0116qR4Tp1qtFA1EgsrRS1RWJ+ns6/gXiL3s7NN/3L7iUVfFZhRXCJDQxsEK+tMPcEWhkE3kezNd0XWCLIo1J9m3YsBLBP9K9BVSWHXXlLrW0EHhgx6TeAfQx93kp3sbDg=
Authentication-Results: alsa-project.org; dkim=none (message not signed)
 header.d=none;alsa-project.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from [192.168.1.167] (108.49.53.64) by
 DB6PR0501MB2757.eurprd05.prod.outlook.com (10.172.226.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.961.17; Tue, 14 Mar 2017 19:53:47 +0000
Subject: Re: [RFC PATCH 00/13] Introduce first class virtual address spaces
To:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Till Smejkal <till.smejkal@googlemail.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Steven Miao <realmz6@gmail.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <pawel@osciak.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@atmel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Nadia Yvette Chambers <nyc@holomorphy.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <linux-alpha@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        <adi-buildroot-devel@lists.sourceforge.net>,
        <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        <linux-metag@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        <sparclinux@vger.kernel.org>, <linux-xtensa@linux-xtensa.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        <linux-aio@kvack.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>
References: <20170314161229.tl6hsmian2gdep47@arch-dev>
From:   Chris Metcalf <cmetcalf@mellanox.com>
Message-ID: <8d9333d6-2f81-a9de-484e-e1d655e1d3c3@mellanox.com>
Date:   Tue, 14 Mar 2017 15:53:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170314161229.tl6hsmian2gdep47@arch-dev>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [108.49.53.64]
X-ClientProxiedBy: DM5PR08CA0013.namprd08.prod.outlook.com (10.175.218.23) To
 DB6PR0501MB2757.eurprd05.prod.outlook.com (10.172.226.9)
X-MS-Office365-Filtering-Correlation-Id: a85b9fa4-87cf-4bc0-3a5f-08d46b13dcae
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(48565401081);SRVR:DB6PR0501MB2757;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2757;3:osxY8RjM0hElWcDXwFFM1KiK9kH8gcRxPtULOFEFX6ZB3sl9py1Ud/CxPGNNv+oSOz3Zz0M7TX433RYvJoB25aTOHfc6SbpKRgo+OjKSZqZi+SgeW4nLKCji81q/uBCUAQQNPM1+piY5t2AUMkZsS3XCusR/TWlf0iUtWnUAzE4yTsOMLElYx43SLiZ2RUgYB4LspQ8jPVLuge48ZShd8TvGHoEBLaEitpQHQFM++dSdikUmIqf0NZBEmCtzyg4shUePD1hsR0uDIm1EBp1i4ocubYDWr1DBbjGrmmQ8dvU=;25:9mVs2Gtf4ESUjKam+J1f4A+VxlQESSQfG9U+7Kx3IAfQ3sOEiNHxHPHWo/vdRz6WX0Y6AHrwkNuZ6ERB4EBS/UzGsekT/oxzdm7rrqEWLOOW4LIUQzUXPox2ZLPPBFkozrTjeoN/YRjzMprBf8kKtbbUL2AqsWF8hPrfUMwdaRS6PcLk4bdW9+BgSJLWQ9as097czfVNr8IoozpPNRkZ+bNQjzq+Czuyk6PDJnWMWn5aRtyHMiET0dXAqkZ+eyf3l6oC1mhUXFDBBmqy/gT2yJO2hCWHQFbbbktR+7x18V6DZAje/EGe1linwB3qOza0vRbGe7iquUdICNBwVHd0+5eVYKj9ZwRj3ThSepL1EGgRy3FOfy8CUPRKah5WjvSi0I+k40eAarRCuIokUXnQexI4u1X4xACamf/yrC4UjWsdZAy78gr3KZRJr4uLpbx9rfczDLtwZguoIC1kQNURvA==
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2757;31:/NgYaJ1ABmB3uUdWsMpQMbGEGKlhaWFvaEbjD5kLcBjJYzFe9iBhvVa0KTZG8NxzRJI3CfGrN8STWLfEM0gp5XPv2q1VCGrVcmUiI1Qzm74Dqd8Su05Z10FcjfiJ65/F98DJWmmHU+EHv+RCAeg23YDq+PkE+QYZX2AjHAlD1PLbp3f3RDqx13faOWYllkTuzwo4/88qCEomFM5jRbqb6VxTrWtpPhDBPUxnm62hf2XTix0W3GL9yzVURQUNGJCASaTvzvfbzd9bo5/H4Ue3qg==;20:7p9WgPtJOH3WdY2S8eMCP/7FPg40saqMhGITmcVZkr6XlpSxMZZgpmXuWhLekgU+xy5STaMyPiFNZ984gt0WSd3saHxPp3HqFzc4o1v3SQfbAfAu42Da2s/cTqgDHEe7+V0sbKXlC8iKBWjKUJ2T8aQMklo5M+blg6mGNNc1KvwNb9YhBHW9EEuKXzTRpkLnQfR9KG7EFbVZHHontcK6xmignCvTz7kpGUJJrn/rAqXvqWNRNK5hCbcdns+NLXYj2J/cClUhTlIOaj+1Z/3zUASikk4bgByfrqvZzGbiwkAx41lS3FDIbY1aUY3wt0JCjVSnL1i8GTihQ06JVAzBNc+ocR4O1sXQffy48iubBb/buGrlvAcn4pkZbtwKf3ARMFWdPRPJqn2j5tD/hGgSwDfqUmZv4Fpt4RnXe1yBvSktyjZwoScyZ18h3OE1pZUWTnJMoJlIXrfLkJ1CeIT6kntPZlmZ50HF/c4obyv6s20MGdom8f9BUVnfzqTqcqh9
X-Microsoft-Antispam-PRVS: <DB6PR0501MB27577C4A3B1EE7F7A768DCE1B2240@DB6PR0501MB2757.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(278428928389397)(171992500451332)(8415204561270);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(6055026)(6041248)(20161123562025)(20161123558025)(20161123555025)(20161123560025)(20161123564025)(6072148);SRVR:DB6PR0501MB2757;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0501MB2757;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2757;4:WyZsNcVV7uXZC/cHzyyBNp9fC5hEzvkNUhkal645UHZxr3yf3kaZz5jnE5T+sl9aWf+otDg7V2xlBxmB9uH6HtCQe/XtOWNRuyqyaY1Cu8LRSE7Noua+C+0wihWMLPicCcUymIi4fYYlQN6a/hXeZ9wyLz2tMwYAqv9UHprAlWFT404GiWZa3Ea+PcVq91its/39Y14oqwz1cUDZOgrFZ+P8/pBI8beP+vaW3oHP5OX1xGxnnsdgNQ5ROBKQ+mUCLj8Js+0o4yhoIO/b7la2LZ7v/PFqEerjUhGDGgEYKfSUCP1NVTDDgtAaHcjs8cz/hHzsf8BDJv1a7x+gagV1v8kSaYOAi4nj59kk84EOnZoB4Yumoh5WB1hasX0W1Rm5cs0Kx0ZFzDdAHYpqvWp+vfSpJI8cMR5f3dWpEpX8rH10Ss6KrxBi4p8Je5p7aKbp0iEE18kLpMgD9QOJ6izQ2Ehom/ekW2YuEGB6cf02ythvIex4hTEHHvYiEkC5UTwOyPepaY5aBxxYINR4ruY/C748XnODUHqF7ecYkGBTSyX+56snI1e+C9A3mdppZMBwca+glZHuM0PnffHgbaLoAHNWFm48x193SRIJ+j2qgjFsJ+IKXYTFmDcVzZ5lw94CyTJxcpu8IK9N8BJsxO4vrzRywQ5492zffN39e3Fl2+5JWIHD4kAGEj8z6z79pZcR3mFCIAAaLh5HFO/EYFFqwnf4nLrBYee1EGfXGoQNus0=
X-Forefront-PRVS: 02462830BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(6049001)(39840400002)(39860400002)(39450400003)(39410400002)(39850400002)(377454003)(24454002)(3846002)(83506001)(2950100002)(6246003)(6486002)(6116002)(90366009)(25786008)(38730400002)(8676002)(50986999)(77096006)(42186005)(966004)(117156001)(229853002)(6666003)(65806001)(66066001)(8666007)(76176999)(65956001)(2441003)(97736004)(54356999)(81166006)(53936002)(189998001)(2501003)(64126003)(2201001)(36756003)(2906002)(33646002)(65826007)(305945005)(7736002)(86362001)(5660300001)(50466002)(31686004)(7406005)(6306002)(31696002)(7336002)(7416002)(7366002)(23676002)(53546007)(4001350100001)(47776003)(230700001)(1191002)(921003)(217873001)(83996005)(1121003)(2101003)(84006005)(18886065003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2757;H:[192.168.1.167];FPR:;SPF:None;MLV:nov;PTR:InfoNoRecords;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA1MDFNQjI3NTc7MjM6VHpoRlNUVENOVTNybTRIU0xtUzFRUXFV?=
 =?utf-8?B?ZjVsV25IUDBKK2toK3BmaXhwR0tHczRNODRhYlV2L3IyMjFTNzNzSTZNVkdr?=
 =?utf-8?B?b2tuV08vV0xnYkhKcUZIWC93aU1TK2xOSmFiVnJoWHl6RnBlaU5IZktkRFVv?=
 =?utf-8?B?YjdTbjZET1BOM3NDNjYxcG13T1Vsa0pyc1pkdDA4WDAzRHpWVkQ1eUVlYnFQ?=
 =?utf-8?B?anF1UzVUcVdlcTRwSmg3YVAvSU12Ym5yN3pZNTRoWkR0NXpSc2wvcVNmUEtD?=
 =?utf-8?B?ZHV4OFV6MlF5cXZsUGJ1YlFFVzg2Tmw4bWtSYVNLQnRuWmgzQi9EcGhXa2Vm?=
 =?utf-8?B?ZHdnSWRYTWRnSitxV01CNkdKV2swaDF0dEQranNVYzIyN1hDNXVTN0VKRWxF?=
 =?utf-8?B?em5JV1c4aXoyOC9NcDV2b3owVkpBQVVnWnVSY25uV2VhT2ZyYXVxOC8xUDlY?=
 =?utf-8?B?eUtwb3o1RDFZTWw4bTFqeGNhZnMwQU12Q3l1RVJaaGo4aXpYOVlsWUtmT0xV?=
 =?utf-8?B?MC9ISDZLVGhSYmVJUVQ4ei9NRE96cVdlZHM4SkhaeG10NVB0VFVtM1FhSDFV?=
 =?utf-8?B?VDJVZVpLb2RPTzZ6TmNiaEJrL1o3aWoxWFBSMHNabXJqUjhnMWcvOStjZFJV?=
 =?utf-8?B?ZnBxdTZRemlzN1pFUkptRXBDcTl2QjlBdXBpWFM2alZNYS9KQWFRaEVGMGlH?=
 =?utf-8?B?c2hKMVBEN0UvNVNtZFN3aFQ3YUZRM0QrNWgxcDZJM3VoMFNsdVZSWFFJdHN4?=
 =?utf-8?B?c3dYV0U2WVV2OTRlNFVUQUNld0MzUzNMY3pwRzRTaTJ2eWU0RlVMaTdzRWpL?=
 =?utf-8?B?aHFXYkYvaFNEbGlGVUt6UWZXMENYUEJnZHBnK09NS2FDRCtQanlLam1JZll1?=
 =?utf-8?B?QUMzUW9UcmFhS2NFdXA0aG9ocWNaWDZ6dDBNOWc4T0pkejhEVmZPYmlNV29u?=
 =?utf-8?B?M2wwSUxTV3ZDcUxqQzhYd2toaDRuc1Nzd1dHOWRMQzVnTXJjdGdKNjBtZnBo?=
 =?utf-8?B?NHkxWnVjV0V6S0VyREprN0ordEZwdGRPbnJRaFZtbFBVeWFaa3hDRkZua0hz?=
 =?utf-8?B?UGRkZnVnT0pidy9RSVNlYTdaelhuMUtmL2JFbUUzRGxLSEQ2cExBRVVxWlY3?=
 =?utf-8?B?RjFpSFVxWU5abXJObkVIc0J6TDdwQkN5VHFYZm52OE9wSEd1Y0tHQkF1dnZM?=
 =?utf-8?B?K0MrOXQyS1A2c2dxUmNMWFJiZzZ1dXpvdk1VZjVRYjhvVE9sM1Z3N0x1RmVs?=
 =?utf-8?B?d3g3TEJ3YlAxL3pROVZsSHQ1UU1kUUZ5T21NY2NISEp2MU1sczRDdSthQmZT?=
 =?utf-8?B?aTdFVHVkQ1JiZEY2bk8wYnAyeFJ5QnpzbTBuU3FIOHYvTVltc243UXRFWldQ?=
 =?utf-8?B?WmkyN3VhQUZjTXBndS9pTHdIYXFhT1BVc0dZLzJ6cmJHMTBBMTdSak9peDU1?=
 =?utf-8?B?STd0K1MvMHloUmVscHhNckNRV3kzZGRmZ2JKdjFOb3dNTHRCOGJvWmhoaTI5?=
 =?utf-8?B?TndMaGRncTVsZDIzSmFZRDdWaVFCWmIxTno1TmZkZlVEdUxUbkk0THA0cFZs?=
 =?utf-8?B?aU56RVZZdm5hZGJEbUtUTDUzQzI4SzdSNUZTakwvUXhsVEdadnY0WmphK0lY?=
 =?utf-8?B?dUdnMzQyY1ZnM1FTL0pYL3dmV1NrZ0VTUy94YlpvRzRQNWh6akFaQlRFTGZX?=
 =?utf-8?B?RXBMM0FMRUViMGNjWENPeXZUSk5YS295MTlraDErOUs0NVRxdnFLZ3h6TTVz?=
 =?utf-8?B?aUIxalE4R2dwSXB4dDA3SlNJbFJFTk9Hb2d2Q0l5N0J6dkY0cFJFL25GRzVo?=
 =?utf-8?B?dXB1Y1UveHQvQUxBczJZakFPTll2Z2szK2o1MjdqODNjZG5TVnVOOVR4QlRp?=
 =?utf-8?B?NUlWWW42NlF5WVk0aWw5cjlsZk9XekhINTJBWU5rTVZKaFAzd050M0ZFYzJR?=
 =?utf-8?B?UVRJZzlhdlM2bkR0dDJ1aUxMNVBOOG5OalVxSlJ4WlkzL0RVMGppRzNHemx6?=
 =?utf-8?B?aU0ydFlGb3M3Z3pkSEJvU0hWUTZNVWYzb1drOE5WeitIRG02TTEyQmFVUEtu?=
 =?utf-8?B?WDh5RHI5cjJ6eTVBem5mWFEvQzk4NHF4NTBmZlJ0alZKYXk5c1g3cWcrVklY?=
 =?utf-8?B?aGM2WHVmd1FDcE83NlRqRFRuRzBSdGhLRVFnT0xlNjEyNTJGdllNdFNqVmt3?=
 =?utf-8?Q?SE49SToAxheU19qlALgtKT9XqcA6eG6C9LtEGINl3CG0=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2757;6:UVOZP5lFNh/ooTly9Wc4mZNXsGOi+irGzi75NKMVA01nKXTUy1arA0P/ku4CpIHkt5opH+fwQV/IwtmLe2ksepasZsU4wuhpTXO9uCpZu1NSgnnToVVXPIW5iISL3f3IO2wdXyYfdW4nf7QeUAWeZtk3JXl8pMTO1Pk2A1nW3T8dUeEVgtVY9m264rgj2LiYVt+z3L7w+Rf5JinbrgUVDdg/eS6OjmYs5W5I5ajQd00Z7kTdClS5beoqdi3dKk5IYsBU9KrgnbPJnlv4UAqyueRIk7MFO5t//0NSM8U9gMI98Mi4Z2biB9PQsX1Yt9EGHINzoRkNkdY4kmvWe/zQEdCmJuQljGN8Gk5A0XHFeo5O+Z7kdW9hXGqVdc045mUdST3SZlV9rDXpV4qvasAxRQT6Ju/GKQv/M4PAx/H0AIU=;5:dwCy761RbXcr2xfevnC5wBcNt8v4/sKUtTY/smF2CGniboyQ3aiXse8zBLrkMaeYNTH7HsMZjFZI3N8jEgf073tWnvmiTGueTkAvNrW8fuk9hfGyTJYMGOP/l4VJEKjcvYitrnKULEZ3a4fTcahhTw==;24:DFxgZzbKZVMWDgNxuI4FdPA91GlArBquzrk4qVUjIaVEa7LMysEudHANgKu/9SndD6HcrCgONKi7AV7qEu2YDCYADiDcpnHPgF/qou7UhNc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2757;7:BNUt7LyxiBZr8W48huQ0c0DFa8ncr4qwdvTiXjxjxlIj7A1W+QLyjThA6OpTwcMMLBJXtV/9fAfsoEkY7WkHFyVcbzF76vJdxFWcdEawpUtNn/j8jICUpy19Qpt+4VmjbfmDihAr0QxU/8a1HxnpDAiWdOaw5mMj0uvObGb3fM5JS3oHaJbDS3K98eyY/XOMqnL8mPQD6gEDAwnqyT08dD4jPrONiUI52wjezWP0kKuQPGIddcTNiMpqOQwfXb5mnO8NYokDYxnufmaNG2B6l4r2Yj4z2kmgQfpEZ0nDSonF9nxUoYLxDCFQR3LrG60o86ubH2dRmjfIOwQ9EZQOrw==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2017 19:53:47.8273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2757
Return-Path: <cmetcalf@mellanox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57259
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cmetcalf@mellanox.com
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

On 3/14/2017 12:12 PM, Till Smejkal wrote:
> On Mon, 13 Mar 2017, Andy Lutomirski wrote:
>> On Mon, Mar 13, 2017 at 7:07 PM, Till Smejkal
>> <till.smejkal@googlemail.com> wrote:
>>> On Mon, 13 Mar 2017, Andy Lutomirski wrote:
>>>> This sounds rather complicated.  Getting TLB flushing right seems
>>>> tricky.  Why not just map the same thing into multiple mms?
>>> This is exactly what happens at the end. The memory region that is described by the
>>> VAS segment will be mapped in the ASes that use the segment.
>> So why is this kernel feature better than just doing MAP_SHARED
>> manually in userspace?
> One advantage of VAS segments is that they can be globally queried by user programs
> which means that VAS segments can be shared by applications that not necessarily have
> to be related. If I am not mistaken, MAP_SHARED of pure in memory data will only work
> if the tasks that share the memory region are related (aka. have a common parent that
> initialized the shared mapping). Otherwise, the shared mapping have to be backed by a
> file.

True, but why is this bad?  The shared mapping will be memory resident
regardless, even if backed by a file (unless swapped out under heavy
memory pressure, but arguably that's a feature anyway).  More importantly,
having a file name is a simple and consistent way of identifying such
shared memory segments.

With a little work, you can also arrange to map such files into memory
at a fixed address in all participating processes, thus making internal
pointers work correctly.

> VAS segments on the other side allow sharing of pure in memory data by
> arbitrary related tasks without the need of a file. This becomes especially
> interesting if one combines VAS segments with non-volatile memory since one can keep
> data structures in the NVM and still be able to share them between multiple tasks.

I am not fully up to speed on NV/pmem stuff, but isn't that exactly what
the DAX mode is supposed to allow you to do?  If so, isn't sharing a
mapped file on a DAX filesystem on top of pmem equivalent to what
you're proposing?

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
