Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Feb 2017 22:41:30 +0100 (CET)
Received: from mail-co1nam03on0055.outbound.protection.outlook.com ([104.47.40.55]:51376
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991960AbdB0VlWhOpp9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Feb 2017 22:41:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=zwZYk+08LIsG4Tiw5zZRbSiSm1LJqDXZ0uropadIvjc=;
 b=ogFlpDh13Cbobw8QJevwCyF8BaxmZ0tgg945hxm5R7A1UQo+Cj3xI8XUL505iAVzSFwcZ600xQY3ASOKHMB7wQgxJ4Av88nJ57DiULFBBkmeOC9PzfKvFoEi6CMZP3z2C5jmuPtFo5sy61FDqgRTqtWLh5AuP9ptep1GzfHmS7s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 BY2PR07MB2421.namprd07.prod.outlook.com (10.166.115.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.933.12; Mon, 27 Feb 2017 21:41:14 +0000
Subject: Re: [PATCH] jump_label: align jump_entry table to at least 4-bytes
To:     Steven Rostedt <rostedt@goodmis.org>
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
 <f7532548-7007-1a32-f669-4520792805b3@caviumnetworks.com>
 <93219edf-0f6d-5cc7-309c-c998f16fe7ac@akamai.com>
 <aa139c18-1b04-2c20-2e22-89d74503b3cf@caviumnetworks.com>
 <20170227160601.5b79a1fe@gandalf.local.home>
Cc:     Jason Baron <jbaron@akamai.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
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
Message-ID: <6db89a8d-6053-51d1-5fd4-bae0179a5ebd@caviumnetworks.com>
Date:   Mon, 27 Feb 2017 13:41:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170227160601.5b79a1fe@gandalf.local.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BY2PR07CA0089.namprd07.prod.outlook.com (10.166.107.42) To
 BY2PR07MB2421.namprd07.prod.outlook.com (10.166.115.13)
X-MS-Office365-Filtering-Correlation-Id: 72aab29c-1b17-4dd9-67ec-08d45f595b08
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:BY2PR07MB2421;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2421;3:dEcgLYpdewx6LB3SyL4xZYvHbf/AfPaTcATXlb6i0+AoniFoY/rsXedAupaMgE1+sB6ncvbyM0TJXHJo5x4X6LzL+CICU7RTAs7+E1DAes2maMNXTbbSkGOtSbMJzAN8JXNno5j+50KBxjWt1Le7qes0vZdnb+2U1Hhs/zSEYloR8jJ+zG4HIzb7rTquBcmEN5r70m4XyHvFrPjqQXjBEWXxNmtlhqVgblgscXqZzvwFcsM5sgje/sUT1gTDMt/d9HI4vTvEJsAt//RoBWEzaw==;25:PhG1JBtE18KGcG+BclTJuIdUoyfQSlBOu/dcenf36EZ+15uMMmxscvFqdYqQM8INxlz/vDpGjzksfaY7kn6Tq3gD8uueO0F+n7bGyiAPFHzcBVS0ii4kRMslbnfgt3WusDuz1C9D0nrvc3lfmaWOIoag14eU4I39+oTCJk5Z4oPkPHvryAWRQQhc/fauFKsaShqwC41WjVjDR8kzS++YtxojSocH1XpxKh2FbnU/VVB9lzPs17c2nnXFtFfzSyWqxD9qVmG4tYfpQpa/2Z4qpT0+yKZY66MI/K+Ler+60/rwTg49X9rNUQOndFRC1gfBtBAYRefD1TTf7WcjZMmjWGfiLZHlZ5LZKsFRwTlOWvzN4bGW6Bory46QUtLU2nKDdpXogneyB11roAGcjVUghWA0UKBv+s3lclK0GzlO8FFetXTePu6JfO/yXlOUyAf2edV8hZjHGnR37lNjW3C7/w==
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2421;31:XhIW9iG7lxpU70J36Bzt4XP6OIkNfM1YzV4SnjWTZ78xKLNQXJMs4RzLc8rloQzIpGKfnPjWMa14zX2Nu8qAcs1L/hdYJjKWQL9+lhoDsueTVg86P6gRrerRkH6J+4se7E/+5WDhzq2hjIS7jqN8/lbC4YPDcApkwXcJMn5MdAShFabo+hvRW+RZzfjlTofCJoGbSXOvev5dXoN1a5dK6s9YTALpJDSsJg4O+AzMAaXMBa2YXi0VXIk2mFxNMt2EOHFPl8hWvKEmLPLCiIBv+A==;20:28Y38OX1P1EeLMYIP7XJ5zk0UMk9vm056IYgvR0Yajbg8W/dczYo6n1YWtWgvvu7LKr7BTqAzrzX6Sa42zcht029w94ocl7hyrxJCS1uYSmSflOUkApef3beAOeK1TZKTOohF34TEcDdkWnMdE02b5ljneH3hBn5wl69IBQHPIeo6IFJ/e4OcaKF/vQMHp1LykbDvrIjcwSl095XuXN3yQedjjrUWcET32y2xlqN1P5uNoyXj0isyWgSlqDS5cJkzJrsLH0brgXCWV9avIWbpnfnpTrAXHKu+QHdYT0rBmIuNS1XB9LnymX82cUdZSm7uZKKw693XhdjwqewnnDao0VNZsok6hHCYC6Gt0DdAGs0411KQ0BZUueuQ/6nE/2QhBGq2pVPYLzc8oW2NHHicVcOLtC9YDvSW+i79AS8/alqiqp/dn/jfMRMTcpJATlNuec9pQif41uRBaH06C354v3bjLOOmLLsDMwRDg8qZ9yyZqNqfE8riFnIoDOES/iUKm/rCe18cBBSFlRNTJYEjR0u1ItnqivnwqSvcZXmAtSiRlZ9L74OeydQR9DkzKWU55U+aB0MhglI0XKG1H6IOIC7ZqGMMVC90IEU2CGHX5A=
X-Microsoft-Antispam-PRVS: <BY2PR07MB24218C311DD94809C2FEB4A797570@BY2PR07MB2421.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046)(6041248)(20161123558025)(20161123564025)(20161123562025)(20161123555025)(20161123560025)(6072148);SRVR:BY2PR07MB2421;BCL:0;PCL:0;RULEID:;SRVR:BY2PR07MB2421;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2421;4:W1PoG1FUduAKpUFkyvQnf/fPT4e00xy0gVsE3GJBoswWPtSYI2BQiWZhokaIqVbYjiLE6Ma4A6vpg4F8y8KxBhvk+Rl/BAhneXZN8qJTau4lVlIndl9QDY5PQFPOjSuO0lKXqxUB1tyt6xla0cLY3RXEujD1PJQacq/MEcfswy8FyEt71CIe0c6A5UmQ2VzfPzW+99718LyeQPXRMnRpWfGQof9pq60ozR60h06IBjlzJ+WC8SCsjH7ZSMzs4/+EF8tqAoErdFTyI2DIL7j/I08U7e4Hwwf1dcdyfqBwxWoCQgt/CNyH3hysAivYhQlx03PHNthto4ucgjiD7xJ6zVVGlOuXLfcZ8MJFiewoJ77Pi06KE2pMdiYF+05BmwnNCTtLdzHqr6q9lXKAIYkG+qXBEnTZwl+GVuULjg/lN0JsJ/EvHBy7EogcAjkajFsfz1kdsQBAykCaxqAe14povn7C+IH1nN88oQo5yLw/w46atbK6l8eQtNkFwJxZKpq4Lf0CsbPfRY/e/iE/qHceh5TPOrJrlzZwusN1rxdJyS/6XegZDrWWF3D/xmomAZ//KGJzGNpakRY6IIDeLKN31hZsAb9eWEtOrWQcEqNosajTSrAL4Nuw1WpUuKvskdZ83yLjSa9VZAdSGGC4pvQbBQ==
X-Forefront-PRVS: 02318D10FB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(39450400003)(189002)(199003)(377454003)(24454002)(38730400002)(50466002)(110136004)(6246003)(53416004)(53546006)(4001350100001)(42186005)(97736004)(31686004)(4326007)(33646002)(31696002)(189998001)(83506001)(101416001)(53936002)(229853002)(81166006)(106356001)(92566002)(76176999)(105586002)(5660300001)(2950100002)(8676002)(81156014)(65826007)(42882006)(50986999)(6916009)(54356999)(25786008)(7416002)(64126003)(65806001)(69596002)(93886004)(54906002)(6116002)(3846002)(6512007)(47776003)(230700001)(36756003)(6506006)(65956001)(66066001)(305945005)(6486002)(68736007)(7736002)(2906002)(23746002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR07MB2421;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;BY2PR07MB2421;23:yJX6+JaHYNHv+nHMpPMKW+ToHjKV8+6UOrBsw?=
 =?Windows-1252?Q?f02hnK+wAfDlrJHonUcPSsvavNyZ3L5Fh7ssdgU6hxbSVX80bi2AVfZR?=
 =?Windows-1252?Q?mv4W2eN+lR1z7mXWEfi2PfWXOI7ajMrIvfkJx3IBwP/ghhLZoTjb7guU?=
 =?Windows-1252?Q?UdVlYlS7bCuEYhLjPKuDqg+P38wJNNddmt9kUHgtR9u/u6zSb4L5X+T3?=
 =?Windows-1252?Q?zGTgxFPCUQ1gEeojmr1dMI5y6QVzHCODu5rn+z1rOlIXWljGF2mFSUU1?=
 =?Windows-1252?Q?ptCbDnRxFv6eTKcNTMR7Af0PI9LwcshaQfJB5OedsTmo7o+CBNMXI1zQ?=
 =?Windows-1252?Q?+HDDbVgNxDSF2qR6sIw778Am34Ni7dsm4ZBLxt1Sky8NSOpgdhyd5ykI?=
 =?Windows-1252?Q?zy7RmPdimNXvBjZnJRL1Mxeiog0cPMvDiEreq9LGDX6zoAfWqoVQvgm7?=
 =?Windows-1252?Q?IvR2B8r1U5OE3K956uOZPogm8ycqKVnVQmCiFZ85LYPAr5oxNegnwhrq?=
 =?Windows-1252?Q?b64N6HkwiqxJllmqSqbDk5YnRVF7YEMN8MgFo32gC56n5Bu/P5wfGk/3?=
 =?Windows-1252?Q?WB1hziT4i8ra3KRyTeyQqVMekxe+wGhof1Rri69UFudiv2O/xCSMwlwy?=
 =?Windows-1252?Q?McPR/aPKk1OAZQ81apWQ388UpPpJr3EHO/r3+b/a/oHUX1EWZod5Brdk?=
 =?Windows-1252?Q?IoACV1Zuad5AKdO80c3VbdkDf+iOm1g0XEAY+EPs7s6F0Smg47g8G68b?=
 =?Windows-1252?Q?BDKRNZjkZR8mBqZixE/NUa+5CWG8Dck0pDJmoWsFbtadDLMMvUN+h3K1?=
 =?Windows-1252?Q?TFWtUbkvZV6u/5ZJhfgtgMtfrUG/IwBP+r5FYniUmc6cqWi+V//ZxNpX?=
 =?Windows-1252?Q?XF0rqtULFRkk16wLkR/4LZLf6Ezf8pkgjjBaQFbagKYTCSCL13GFZSp6?=
 =?Windows-1252?Q?DZt0JNCAMh8wiXw+VNBHiLyqOuyrLrVtM7wAERaqYKceMyY/D15LL3NY?=
 =?Windows-1252?Q?iwSebwJT+OMhKJSKyunYc66xWH8o/aNuBlNQL3ABVjeXmmguWd0lqLjM?=
 =?Windows-1252?Q?utUdSfLg2yZjENb00dIORhlDZJLkcCPFuPqG1Pb32a2GfVUXmLDkLlbl?=
 =?Windows-1252?Q?sp1KMLkaQiiNDuFMfN7WGRt19C4Qy9/ZSPAt2afHQVgR5vmh/4XoRRnt?=
 =?Windows-1252?Q?0CgDMJg5Te8s95A+3ZPGImdvleiASbEGcMTwA0ym2/1/Dt1xOpCgBvbb?=
 =?Windows-1252?Q?ltSj8EiLmOYgzMlKHpKUG0GYor9+o/CHe37TX8sXGv5IgiWbYLmIgjLE?=
 =?Windows-1252?Q?LYsFwXViI8x62VUN0v6Uo/Q+GKHJH9/kcv7sUmzPWiGeLGatG0j5Y4k/?=
 =?Windows-1252?Q?lFMQKKdAZb/9ks0EoOU1WUTpQknd0ZvhcdOrgiu1tWVZyw0dN5dQhlmQ?=
 =?Windows-1252?Q?9nxJhWGE5iyNYn/ql7e5jvlq1yTCax3F3C2KRX63g+tZYndDJRWUAnXB?=
 =?Windows-1252?Q?1nmvUdJoJU/HbYPoYiR9P20barvW2PhBcKRW0eYBANC0XPnwQscCfmAM?=
 =?Windows-1252?Q?tMjviIa0Pnp3W73OF+UZUqOfbMkDChlnUff?=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2421;6:JLfngjE+xzsM1naSqZG27iMDa3L3NLTN2UveBONrMEMOCo7MRWtWFrahijxQmnly/ubz8xTwLCybtGSXfRwDU02yadegOCuz4BRgoXvBBMBKRPtmBDKMgzZcta2B40TfYHgaDt1msn84K6/avYTj7+Gf9FzphpXSLt13EEcnAWRCkdU4tL4AG+FCd9f2gsiFY4t4T8Fxgn51e0W+ZiwPEXWiFFPQW96OChvdSQOixR1p7DA/4gvgwm/tH+MGpRWvypT5OSIqLwe0nipsqDJZKl5NotqgB9bCQRxoOXSkTXp2f9J8rPGaZJ8VOIqU4e2fyOti8xtURP2fMzQg8wz50S8p16AKeuri143ioNXuSTc2eRjbN1TALs8ZcMhqiepOdh9iDEFHLdCL21yVZJDb3Q==;5:dJCBBdl4DoMYr1aXkuuBJWUUu5U+EYcCRenQVL5gVQPy7tmsfLpwn5C5vsQzJYMXYtjs93977dqP+TkZqMRxWGMoMAT/F9DjNV0ROvjWDP2w5OM6+XDBAVoa5IdBYMvFeBpIJD0uJtrCdRP4ecm9KA==;24:pAw3J4FCJjsS09OdKZbZVQAEfatIexzmxKbAjNv5Po5QiSn7uRgJNmegj39NMlvp8Hs+7ddYSZvGpJ4LZ0RZRqBl50Rh8puwwlGSqrFtFms=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2421;7:NnIHrtjlG/bxZXVLf/Jb6ZBSW842faLdTm9wd5Kb4fi4SZ8f7LnIcxZiBB2YkZQ71Hc5R7YHl6Qr5BFAme6Lv1WFD2IxzmvfrSLNpb5Wa1Uu/sFTY4hlfti892WHKyCE/RnGMQEWPkmEUFT006DZPpQDnKFsDka+uI8Rv9VcZlu/6dIjxBnL5sbzoYrWjZ0xoS5wGNskrF4dJwmuSEHi/1SkrKlImRIJxax0t4RxHSMmQfmxaEeYcvbiiRkLuxyu8Lpn5YkNZgYMJUcQDDf+3SGrznjy2ZzV7XLQIISitYapb7domRQVv9ip+zc3hiGBilJC5BC3i5McKO4wCLG3jQ==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2017 21:41:14.9306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR07MB2421
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56908
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

On 02/27/2017 01:06 PM, Steven Rostedt wrote:
> On Mon, 27 Feb 2017 11:59:50 -0800
> David Daney <ddaney@caviumnetworks.com> wrote:
>
>> For me the size is not the important issue, it is the alignment of the
>> struct jump_entry entries in the table.  I don't understand how your
>> patch helps, and I cannot Acked-by unless I understand what is being
>> done and can see that it is both correct and necessary.
>
> You brought up a very good point and I'm glad that I had Jason Cc all
> the arch maintainers in one patch.
>
> I think jump_labels may be much more broken than we think, and Jason's
> fix doesn't fix anything. We had this same issues with tracepoints.
>
> I'm looking at jump_label_init, and how we iterate over an array of
> struct jump_entry's that was put together by the linker. The problem is
> that jump_entry is not a power of 2 in size.
>

ELF sections may have an ENTSIZE property exactly for arrays.  Since 
each jump_entry will have a unique value they cannot be merged, but we 
can tell the assembler they are an array and get them properly packed. 
Perhaps something like (untested):

    .pushsection __jump_table,  \"awM\",@progbits,24
    FOO
    .popsection


> struct jump_entry {
> 	jump_label_t code;
> 	jump_label_t target;
> 	jump_label_t key;
> };
>
> When putting together arrays of this kind, the linker is in its right
> to add padding for alignment, in the middle of the array! It has no
> idea that this is an array, and there's nothing stopping the linker
> from messing it up.
>
> For those structs that are a power of 2 in size, there's no reason for
> the linker to do anything else, and it "just works". There's plenty of
> instances in the kernel that depend on this.
>
> I'm thinking that the sort algorithm either hid the problem or fixed it
> somehow (I'm guessing it hid the problem).
>
> I hit the same issue with trace event structures. The solution was to
> create the array of pointers to each structure, and dereference the
> structures from the array.
>
> See commit e4a9ea5ee ("tracing: Replace trace_event struct array with
> pointer array")
>
> -- Steve
>
