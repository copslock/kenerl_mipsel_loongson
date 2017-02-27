Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Feb 2017 23:45:57 +0100 (CET)
Received: from mail-by2nam01on0046.outbound.protection.outlook.com ([104.47.34.46]:12378
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992160AbdB0WpuSJYoB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Feb 2017 23:45:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=EgQRGbjB1NYGJLr02xK4c5efV797+FOEMkR/sgIUd5w=;
 b=AXwmNX9xa0cyeUDIlk7skmF82oHy6XrMHQRTv3DtGXe3RJiS812vtOrUJcnn6T6Vn7qeQ9VnHpuYwVh6NiM5cbQN5xbJKSvhO32V0e8aMy47SJ6cRuBPQu/ca7UkLF/I+ZPUAZW60/+M/su5T5yuqjCF+ewhTyDxbjaC3f/BVy4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY1PR07MB2428.namprd07.prod.outlook.com (10.166.195.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.933.12; Mon, 27 Feb 2017 22:45:40 +0000
Subject: Re: [PATCH] jump_label: align jump_entry table to at least 4-bytes
To:     Steven Rostedt <rostedt@goodmis.org>
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
 <f7532548-7007-1a32-f669-4520792805b3@caviumnetworks.com>
 <93219edf-0f6d-5cc7-309c-c998f16fe7ac@akamai.com>
 <aa139c18-1b04-2c20-2e22-89d74503b3cf@caviumnetworks.com>
 <20170227160601.5b79a1fe@gandalf.local.home>
 <6db89a8d-6053-51d1-5fd4-bae0179a5ebd@caviumnetworks.com>
 <20170227170911.2280ca3e@gandalf.local.home>
 <7fa95eea-20be-611c-2b63-fca600779465@caviumnetworks.com>
 <20170227173630.57fff459@gandalf.local.home>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Jason Baron <jbaron@akamai.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anton Blanchard <anton@samba.org>,
        Rabin Vincent <rabin@rab.in>,
        Russell King <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Zhigang Lu <zlu@ezchip.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <7bd72716-feea-073f-741c-04212ebd0802@caviumnetworks.com>
Date:   Mon, 27 Feb 2017 14:45:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170227173630.57fff459@gandalf.local.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BLUPR07CA070.namprd07.prod.outlook.com (10.160.24.25) To
 CY1PR07MB2428.namprd07.prod.outlook.com (10.166.195.17)
X-MS-Office365-Filtering-Correlation-Id: 9fd118c2-3dbc-4a91-b3af-08d45f625c71
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:CY1PR07MB2428;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2428;3:XRG9f0RcLNCgJ0+Nx59wB1U5pcsMd6MFLh+InVsc7rz0hSnCPfCi8kubcs01wgw5reLuGRiLr7UPPti0UPXVaZN/WcKsVAbSP1Vg1CmmjTtUq/5kOE9/JAaYXrQgo475pMsvYxLPHBvBiOktPeGhU2x4ZTPfr/DoUS4nxHbnJr21V527Ih200EXPGrNro0PzBdvedRUvyZ770vXEA382Z2bwIe8c/naIixZWNANunx0beNA62fl9NgbJppN4KuCDBvkweyYLgmdtbZJa0u0tKg==;25:kCiHFCyEy7509QIxTmRCdAak3FXRqWt8jNm09G7W6YbYvgp2M41+L6KoGc2rv9z65j/fEsc8dJ/Q+oRH6cgzKvY3xG5NhuzEW3MaP2czZKqeeDnSejEg2bxNMLWcXQ3e3R09K0jjix9C6hx+6muKfhk64HdpZMU9MAEcAiXShIPUNuVBnyPBbgmtYZA02/kxgDUtt3p7au/QDoja8wNTt4qx7eY3tzynNnKgiAgALKoceaIbSRd2uuSqHFT0DiOpqj2Qj4KrcPpV67OIhid0ZImUGgOyEBnki1JcQ3k+kQtyDDJ9/P903enoKBlhjauqt2Y5K61abv6J9ndrqxYTWSPb5eP8KzCWpWKoblAvxwX2Iq9znSCLQztWLGn6v9qoYH++5NXUQG3YWj3ccpr0ajPDwrtICKiju6AqZ2XGOuQCZwVIH4a/LHa83E89Tg04F8dE8oV78PI4vZifDhWD+A==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2428;31:nKpHgMzItByB3sCq6Y6QgUKLHH7RjR1iCINrmKOAdFxVmisZ7jvsP4Oa7sALVOwdbluyG5noM39SLPQaKCnxdclddwMJc8rB3zfMFwkhkaeLZCXNDFwKxlg4RfJ0hGQtR5B2lAH5tVI6vpo/MeiURNa6gE203KaV+pECBZMmJ444qkdnKh+E+1elgjFZZpTT5mgkHexyAt5rKzBYeXJ6PeFbmK8s8l0yWDcyzZ6h71NqYNFwuPB9uUdkUruFiPz4jxPXhKScm8bgV6PA7nvetQ==;20:53Iz207+jesF9MAFUxZ9W4L+GvKnVnLfWiOdyF+UlJjrR0HMJY0YNSI/3HtrlqXQWv9KY7tp5Hn3EcD95cFf7gmmXbyei7AStHs1sTWhw4C4O345skPuF9/BHO9kH42spvODvF2OWutKLVmcl39bkuuIoBt4gIBbcFkOxf4ZU5+MaWp1LUmEyGUanLLU+W9BmAyzjPQbqxvW8aOvSQkCt6vmCpWrXsFp2QmhZrk8rjqTtKshx/icSisnAF7xZ5mi8tFEuLDhNbheZ2F0EiUMQC918S9KmxwISVhdGmo/AkDGWZqOwi45TIgmewic31K1BfEAiOeTxfUX+ublCZmQVteW2n4L65Uhxyke4wSNzPZtbuJytidsvWxN0WAxNfDB9btqbUNhPN28X4PXhiazKSjJHG8wt8d65fl3uRPRwHjtpxHeM05qdGog8LkDmyFz5hSc9ihVU0/SJxcc1jh10p8KFFv320NH/Fd219VYJj+W33DzRzXHy8TwTdMwMknznYsSQJchcBB43ALiTDyUVec9PAGX5hvaTS3jMbFVKZFZWIVu2l5shneZHQOAoTWr/LNm9zZThJpvhOlVMgm2f2EH06H9WpsRWpv/aJz3lxE=
X-Microsoft-Antispam-PRVS: <CY1PR07MB24286B2D86B76A91650BF7B297570@CY1PR07MB2428.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046)(6041248)(20161123558025)(20161123564025)(20161123562025)(20161123555025)(20161123560025)(6072148);SRVR:CY1PR07MB2428;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2428;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2428;4:fyR83YGztl0WK80gx4JldDYabGnwIl/2QqY+xhFE+RTsnb0AFWcJP0ew5h6f9/85BRZ3QBuh+jnTgP6PBDbilFznmywKrcw1vnGL94LI9hfu9/scAD6GoXkbQr69xGl8+MeZ5s6yWIwQdu7hZIU/c0nI7xETGKYYVxAW6TOjQg8nGwO/5VHm+vff9sEXfGZpxDyRbsU5dhLeBl6SnHH1JxgJrPatyv3dSLg9fYjWVrWe66VQjtueI0XWHQRGm06sRSvtgBOdb/4T7tpIDa21ZZCqtl/Oe74qCfstd9yx8jcKeN3xtBD4TOXk+pgxasW6MpjMuyAuXDowLjaI2eftfrwjtx1qR4mWVgNx2RwAIi9LRseSDSJPO15fZwkQ4GRCFMRNtic/KM7CxK2HbUxyjILEgXjYWiT4dPzaSSXN0XzbkINC1WhcxeGPrzhR15FT7h6ge/oSlkd64gJ68Gc3AnvOysB0XwdrEslDIYYst0tNlDUiuO3xk++e3u/zvyI8gPo5JuNcc0REKZ1JGqqaj+IPV2Ub+aQ5KOLHJNHG558U9j9zmbnyOYnhEdhycgVP0b+I6xDcLj/JNPvIGuuY7eeMUDpqnXd1pqMtbr2X0Pk=
X-Forefront-PRVS: 02318D10FB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(39450400003)(377454003)(199003)(24454002)(189002)(53416004)(105586002)(6666003)(6246003)(53936002)(42186005)(47776003)(31686004)(42882006)(54356999)(97736004)(50986999)(38730400002)(110136004)(2950100002)(6916009)(5890100001)(53546006)(101416001)(92566002)(7416002)(4001350100001)(76176999)(31696002)(36756003)(106356001)(65826007)(5660300001)(33646002)(81166006)(50466002)(23746002)(305945005)(6506006)(8676002)(229853002)(81156014)(69596002)(25786008)(65956001)(93886004)(65806001)(64126003)(6486002)(66066001)(230700001)(54906002)(6512007)(7736002)(189998001)(68736007)(3846002)(6116002)(83506001)(4326007)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2428;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;CY1PR07MB2428;23:P4mZoZ3k60IYqlpOqCUor6+oIU7/dflAvpRgl?=
 =?Windows-1252?Q?+c8KOZXwE9x0fK+8ON9x8BUrvALMy7nQVfm5FDCXreULkJT7aQDcxZ1k?=
 =?Windows-1252?Q?ROxEmuO6QbDHfeIakUZtmV6eu5uYByI5EcmCDxwgXqnaSrpvd7xu52ao?=
 =?Windows-1252?Q?O4FNJW1O667CKISKyUEQ+fHxW5Rnm7kD/sZlXRCF7h7Qk4ixKFv0wTGg?=
 =?Windows-1252?Q?5hTlA4ErGuThdWqVKEGi+kac5686qlI3SSt82bhq+KoFmiJiB3Xk8ucJ?=
 =?Windows-1252?Q?cStu/hfVzflAL52Ep5f8uRmDVgR2T1Fw9iftJPNUAr+vhoamYRVT3HhX?=
 =?Windows-1252?Q?wycqQom92zXzOqAVYItnSJ9ZgR84qWO0Pm8hDHnXW4KE2Rk7kz7qNy8F?=
 =?Windows-1252?Q?eW3IngDlDHHyewwpsgwdXVZBKhppTmJ4UalqUubEfznjhLtrwbm4uPlm?=
 =?Windows-1252?Q?lo48qbZRUzj/EsPXCyBd151eef6UaCToNWHbw5Y12imredL68szXhliA?=
 =?Windows-1252?Q?8BmxaXK09CFX9g+07giFHd8xvc7AYroN9FzH6DFWqhrenWistPUiXVKb?=
 =?Windows-1252?Q?WYy8Fc4gIrf3BUFE9s54388DAGHa0KjaKFLXDkP9hf0Oh7TcADQSYAgF?=
 =?Windows-1252?Q?ZwngraiTJlq09DLc9eOwLxZxTSYVTeDNMNtED7wPg5xgvbU3snEd5ifx?=
 =?Windows-1252?Q?V8RQQScpYqrxOjjksOjhIpIrxA7A7vYIOKadCu4qZFnjikMoMCrR0a7M?=
 =?Windows-1252?Q?tVtI9h8ZpFcHX6KnIl7m8ngO7J68hKOM1GkxeU/wQ3ihYyUAKQzusm5h?=
 =?Windows-1252?Q?4HrSNwgVBdDKawEIOVLeGP5CMHTJW3iONRwq+2PiQmj66CkoY11wk9Pz?=
 =?Windows-1252?Q?U/88SC4e6fdm2hxu4wrM6327HVyLUadMViJ0COtL1VaIA0EmYNxVRdr7?=
 =?Windows-1252?Q?ZI498YMtIsjqYqIztYB2tymiF+RsFtl6JS09+ewFwjXBek0rIvwO8vXr?=
 =?Windows-1252?Q?Gwv+7SDB6/n7fRZ/y1lKRj0Gyh9dbD6Jv4yswNDyEGuNZqUhzPOiGjiW?=
 =?Windows-1252?Q?wEhimTuf81sJoIgzvVN8peOHQC91gaWezJbXoRehCyi/2H3AaUFpBUl7?=
 =?Windows-1252?Q?3mk+fGbXmjwhRpqdIsElRvME3+1rFItpO7lsgs9Ynr0O6KwWGscoUHwH?=
 =?Windows-1252?Q?1oXxp+5C3upfSYCbtoWD1S5PckW9OPDSa7w1osuKCUPgPVZuY88jx48/?=
 =?Windows-1252?Q?2BvLuJPWCbLUKJZCIz6B0bryyr83y0siKBspjgFjkf1PYhgSstW7Dll5?=
 =?Windows-1252?Q?M4aETCM5+HY+2KtoQnytPOiQvZY8wH8bCNz0ZJQjHk/v/39a3LZh59pU?=
 =?Windows-1252?Q?CD7b9kZcVuXJ80QLYtWP49C8+qiBMYEgE0PfV+ujOwtIrgXuQKo106O1?=
 =?Windows-1252?Q?fnAq0FUUK7jqBB+rubPpWvZAyPRuUw1apTsL+zZHtPp7eJ5VO+GBTOyo?=
 =?Windows-1252?Q?zp04h0EpEXgrTWRV2ozd8HgXedOOAoEPxRKVsaOrh/nqgKLAaIXzCLZr?=
 =?Windows-1252?Q?PjAwNTgvDNsFPISs0INparUnjsqo2ufY6qpfGeA+3CNmymXpR6onIbKt?=
 =?Windows-1252?Q?jHRI7jweTrSvAT4pJKQ55U=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2428;6:cDl79f41dt8QxV/WjmsxamREfE4WZyPUtxN86wdHUXEHF0WZg7WwDoz/SUBjlpXYUFuHjuAhoYtoXuLjoXHRbIjHvTFcs8wKRZU5K1A/OHxrF9JDDM5j/yWtqIDeaHEJf+QeoZWTjNrER3kgMtm9BQ3GFAR89ztjc0RYtQSFnQ0z32O4q1kIy/Hcw2avs78LrjeIrbMngpnO80OVYt3/kC3BoJbh24St/aiWRhAciTi6LzyX2/pa9nU2rneRlv1p/MSk6M9JYIjQOg9R0/bpDuvYjW3rc1D6Yj3CE9J7jCWglbtj9h74Kn46Kodiq9T3KLOmxxMjcE36y8p5uqVFg1fDO1ooPFkk6LfOlWNxV2b9MRFDAj/4ZjIjFyKYtufB8c787EoFsgyZ/wS3NErhvA==;5:PFxGNNTdsYb6FHHqWbvi1NxivScAS7bob3WRmMMv8m31dFk4okaWQB45/JGHv5+0RaeTEUqswlhpMGKkNvsPPkfzoIumOnE3YnEODbEORVYrAi2F8AmAFElaiqW1MsR3TlbniJBpOOSL/orEJ2PflQ==;24:/yZcYvdQumYAu/LtkxwTAgHQxianfvGSHFSfpRM73hrrr1UvpOjALHfunDz7m/MYPkT6pvTgKMpcqJXsu31JydaAYOqNsOJS/VQRhxpSWFc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2428;7:nAs8t6HAehWWZ49hP8d2ToDl07eECHnLLky5eesqi+0NloOVV08N6/apMHifYIeJeQKlJa7iBSHTCXxJVrWp252d3V3RsZmDJV9rZlJd+9HzPIrYIflvAjUrbRxhsRsjv5bN1ICuWVr/MbeG05AYKrR2Q0wPKMYJ9In/Kp8pwvZKbWLJ6eF3beUjCMV9IhD/1SYkTbgFa0+5ZJ2C0DNfkm5zMCij16h9UNNwdDsNKnBnUht+48ifnowJgs4B634K00RXskjSNvXwGiIfbibyqsYWeepe7mUWhhfeDeJh/08xdNFuIAzHKRBmFcHXPtnk771arbEgp3C8CzThWGdsZg==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2017 22:45:40.6752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2428
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56912
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

On 02/27/2017 02:36 PM, Steven Rostedt wrote:
> On Mon, 27 Feb 2017 14:21:21 -0800
> David Daney <ddaney@caviumnetworks.com> wrote:
>
>> See attached for mips.  It seems to do the right thing.
>>
>> I leave it as an exercise to the reader to fix the other architectures.
>>
>> Consult your own  binutils experts to verify that what I say is true.
>
> It may still just be safer to do the pointers instead. That way we
> don't need to worry about some strange arch or off by one binutils
> messing it up.

Obviously it is your choice, but this is bog standard ELF linking.  In 
theory even the arrays of power-of-2 sized objects should also supply an 
entity size.  Think __ex_table and its ilk.


The benefit of supplying an entsize is that you don't have to change the 
structure of the existing code and risk breaking something in the process.

David Daney
