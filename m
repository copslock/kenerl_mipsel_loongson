Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2017 19:17:07 +0100 (CET)
Received: from mail-co1nam03on0085.outbound.protection.outlook.com ([104.47.40.85]:50080
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992127AbdB1SRAL30qj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Feb 2017 19:17:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Lw5rtCYb7qTRQE1TZ8ME7RvF/CRnqstydFl+7oxoNkw=;
 b=RsF4RFGL362G/YjNLy5R/pPGN7o1+o0/i3Lu2Xt/CziPsVurZn0RY5IThaZNIeC9sAT9EuVlsfu26Q6dw2xJ3g1lzAysVdCMQw8+sWqOV4VphUkAGTHXWrhStuhGUQycQSfpKq8LTVDUCpMy/drhF7cqiPecxicwYx9zY85Wf0Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 BY2PR07MB2421.namprd07.prod.outlook.com (10.166.115.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.933.12; Tue, 28 Feb 2017 18:16:48 +0000
Subject: Re: [PATCH] jump_label: align jump_entry table to at least 4-bytes
To:     Steven Rostedt <rostedt@goodmis.org>,
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
Cc:     Jason Baron <jbaron@akamai.com>, linux-mips@linux-mips.org,
        Chris Metcalf <cmetcalf@mellanox.com>,
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
Message-ID: <cdf98840-8d43-2c58-e2f9-75ae8fb8a600@caviumnetworks.com>
Date:   Tue, 28 Feb 2017 10:16:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170228112144.65455de5@gandalf.local.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BY2PR07CA073.namprd07.prod.outlook.com (10.141.251.48) To
 BY2PR07MB2421.namprd07.prod.outlook.com (10.166.115.13)
X-MS-Office365-Filtering-Correlation-Id: d239d755-bbef-4c6f-fd17-08d46005f5ef
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:BY2PR07MB2421;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2421;3:xbNqOULq2L1E6MaZ0yvYk71pCLMjtyDbG9TRPwBbN5VDoCqtHcrku1V3lmJic+EC0rpCi+8dXUtCa60sdzD52nl+OtJvjJgQQvY6B98SMO2pwLfTEJcPN+841apN4eFuOe8F8ITJYu1mQUPRUkQka08qdwf6FZ9R7ZdsbqAfOmFC9LF7mimpe+rdIpawmvpwv8zUilnEtcy3B2HLDxQLqKLN+UVwYNuEaw0p0F9x024++9AWpkbQl1Eg94Kcuallt0lR1OLR0YqV81gQmqF/Dw==;25:CaLe/yBo/6svND2G8g+dS2jH6AJcnLCC4j8g+6xRmDbxyX4oL+nc2u7sRAO+VI06fHH8G+HmsmVo27HB0swM0R9weQUKiBu7r2pLo7aPLSfnOLq+QjI30jg+VCWjY5oQ6tVVFfCs2US/YnQaTMHMK0/IicpmkD0cRJPwb7xM5gBhCCZiD32OcmNZeMbRDAc4XYCxWI3DP+IBzjl1nnEjNHiGENAk82kdlqwezt8aQTkN5Wfo1BgBIk3Xhz8DlF9RV7ccJvDgPBpCUaZtBjwgATiTUqQAf0WB6TnVSX7XE1n27hm459idaX9bxowHsTv0aP3H/CIdKZY7+Va6LwKvXHpF2sNOuoYv2+yDOfR/fj4gbnEnDSu9hPf8hOAhhGqDw1nkTZ3SzYFKC2dhLrmVxmntTkor5dR4kT/CDh1VZVXltBh62T4XyNtRO+/UDrNESiBQEIyCecfYRHMydLAZsg==
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2421;31:u6gCVprAJHMLnpkIpVTjWS050w21mMw0q0pMnTUBZM03KHAWFfxNZ4HesK1f9PtaGWaSeDcku5capX5pqO08yhzY9z+rlgsBaPcLRIWmXz30HtxRKC4r05cXEnibavdEMFcdiS6npoqPGKiRZQX2sm4AQvStLW0h3DH9g333u8UNqkLw6HGgX2nOafLjs0/gY7Dvn3kto7wvc2i6t5Uqd3godzW3YWMgu8suT+T8p3XI6KoAztySlMa/eNAy4HoX;20:VlDaY+t52H45HShWViyfxSgzqy8ozCOzFQzfesEQmcVWgfROoFRETmHAW1UD4pOd1PnKY9s8Bx5n9QT766uOFvLSpftDUDWP9E2JDogH6khYIJ999blZ0tDOeOUvRseqZKEqQBNWS/e022t7Vjya+FRf36LdtpKszKMBkZRC/4FvKygQ0YXBOEVwXixn5xkultR4+IUBXwRzq4bkxx3WxXvpxhvVFvRWkbE9/NWPRFqo/CGl7aa1qt4Yh8CM518fJB2EZi//p0S7i1WhITqdX+qNOUb23gzDGXNHRsK2v+UreAAR5DpK6YUilhWbH6RwaVVy9Awyb11CSOZs9WQ9GjRu4SAmkPEloNPhlHkiwbj7xb0FyJvQkEeQX+5khAZYAA7crUY1t2VflMRmatB3Z26qFjaWxdY40a9+R/POtsNuM19GeAMaRaKsM7VXC/b7++NYVeNGddGOnmoro6QAiRtcQovImNrVllBCYyDx+HlcqLt0bUVWPhHZJq4ENyTow50X9W+B1zMM/vB/J1cGsPw3zFgSkRbdW+sdbb8ZUpRWRgxcdanRiLFwRr187sVGHTmZgGF2KQTJsotVpFjOVAebCVkR1xm3mXflrOs6oTI=
X-Microsoft-Antispam-PRVS: <BY2PR07MB2421B68DCB27912E95AAADC097560@BY2PR07MB2421.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(104084551191319);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046)(6041248)(20161123558025)(20161123564025)(20161123562025)(20161123555025)(20161123560025)(6072148);SRVR:BY2PR07MB2421;BCL:0;PCL:0;RULEID:;SRVR:BY2PR07MB2421;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2421;4:aL3fitsAzDWJwFGiKZaC2y7kVZo2Pf8Pe5wDVq0q9oVT96xeoiKez+xLMEg87dFRkNatl9XrpbQSGxkkCw8o232kmPx7c+HNcFmnNWXbjO1KOsylO6Vn06EULBjMeRNtVnjRKF8FH40M01ZXBXa+75twODIuxucm5IuK7qt1tyBk+LNcdZiJUb/naEHsWRukQ72PVyifnJYKY9eN6JBx0kjvbylPmbFs4aIB1Nsu2VrQ8nU3LVGPb4O0anH8m/g3cLCSxKvSWboOmYUpNxAx4AnsCxFMsV7rlZnOYbRkaCTmQ298aFJ/jwtFojRrvHw63uR3LnOUoSFNX5+T0ir+5I+GzeDKJ2swjvA/yFBiKRRxX902R5jw6VBT9HA86qZ5ejarHp9b5izfHlJQJHPQIDs9cwb9bMSYx8ihRqxnBd6/MgbiqSk+YeoXYLLbvq46BcMVRkg+0UoABzKAsR01D1awwuIlFvRQmSQeztIKngGH1e2YfslXOwrg36uWXO8XHz+fdm2vjZAyCX6v1q87m1tOgvZfPOg5fmPCx01b1fZNETzRfg/7bm7m5e9dPP1tARRtdGnHlPZMfvmya7TqnIjK+okacgXozSyn2/6Sbm0ci+BaLfAxFYUFaiH0Tna8kkOdhBOilMtd9vuRGVoppQ==
X-Forefront-PRVS: 0232B30BBC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(39450400003)(199003)(24454002)(189002)(377454003)(53546006)(3846002)(50466002)(7416002)(106356001)(83506001)(38730400002)(36756003)(6116002)(6486002)(65826007)(31696002)(230700001)(229853002)(23746002)(64126003)(97736004)(93886004)(7736002)(4326008)(305945005)(5660300001)(33646002)(105586002)(53416004)(42186005)(31686004)(101416001)(6246003)(92566002)(6666003)(81166006)(189998001)(81156014)(69596002)(65806001)(25786008)(4001350100001)(6512007)(66066001)(6506006)(42882006)(53936002)(2906002)(68736007)(54906002)(50986999)(47776003)(2950100002)(8676002)(54356999)(76176999)(65956001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR07MB2421;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;BY2PR07MB2421;23:z86/9tX45hgCsofBdmXu+dAT3WPZmj83U2nLN?=
 =?Windows-1252?Q?RlDAhO4vlwQVM65TjmRDLrFPlYJUm6ck7SHn3W8dhAWBt0QBJJsljl7p?=
 =?Windows-1252?Q?1q5tEBSseqvqiaWxIhMlDwkNv3v6PX6x0m2r9ACw8f1TsEgVwBEa2vp6?=
 =?Windows-1252?Q?60DrdRRopVWxI34Yh6/6LF5/rGsT7uTypyTlvSTG27xgAMnVx77IxJYV?=
 =?Windows-1252?Q?QquYsPQs7L4YQNcZ6iP7R2nbbDJ3QkMd74F5XGzR9v+IN9CqxRzufvUD?=
 =?Windows-1252?Q?a+/NpiXyBoDwQQdHn2Mly7GCoOYGYJwVtEYsAfOasfqtJyoyArGPT8wa?=
 =?Windows-1252?Q?oh7snkRscViA1ouHm+eA5D7KpkKKHjWX4uzpcGdF7bTWS4V1rK7rzYIr?=
 =?Windows-1252?Q?x0jn8XYX1jL4rbaWy8GPaiWqSZYJywS8MgE1ExdXxkWhfCT7Yb95d0oA?=
 =?Windows-1252?Q?nK5l7KUo4T2tpwnlUvpKVrqwgh5bV9sCnDTbrOZjsFDle7zwPjS2B6Ji?=
 =?Windows-1252?Q?D66HVHRFaFaioBc7jw+byW/ZOnXSqnyjY6mkLwj+M8Udl3abFWp/z7JG?=
 =?Windows-1252?Q?wHR+L8DbQ4O0hNmRfzdRV5yHJZqi2ODztErT8i415EiCYJdBjMtJfptf?=
 =?Windows-1252?Q?4z4juFImc8oPLh1n3Oo3ZSxNRTHa0g021/cOTRjyenurOnvQqTxLFYhL?=
 =?Windows-1252?Q?8rA9020pMmi0vDS2E1w3qiu3KFV+e8LCMIXgE+AjAOYNl8O7cwzpZddG?=
 =?Windows-1252?Q?U6sxDpjkTMvnzTB0EvwFocR8p6LTA2ygAr/OgVysBcxaDppEHU4FYerB?=
 =?Windows-1252?Q?YNV05FEx9prc92g0xtrhA2Ul5h5Rvm/UQ1Cr6ZZZDARO/d8XVGnR6DYO?=
 =?Windows-1252?Q?qxN0plmeZasN4o5sgFdtCO4MsO3qnm2halD2X+mOV8yIUNRrGxd5P3IY?=
 =?Windows-1252?Q?pqcoIoGWudyqystm2yvi7NNU1U+Bgr6iLUDOVJv8OP59znU8VSx2icEE?=
 =?Windows-1252?Q?iWtUvueGzR101yUfoy52CSz3I8g8ucanC+gjzu0gr2cMQfq14jWsMmMS?=
 =?Windows-1252?Q?/Y7cdp53/oMsMIFBdlm40TEzx20WM74IAae1F1rIRYUzWbsWp0XBjIxN?=
 =?Windows-1252?Q?Y/UmBq9KDwkNNpCZJYNAQ2Ag1nCjq+rIOkrtoR49dB80lcPKm8eDwtlG?=
 =?Windows-1252?Q?kU27FaWI2BC4P3RdQrL3asUsLiHqdeyw4mBCZVwusmpXtWoHnoCB3OPW?=
 =?Windows-1252?Q?vFKw0egIj4Z3ZWje8314kwBr9zEesGk2ZRKxGJZKarnokOelJ6afJ4Vq?=
 =?Windows-1252?Q?6B6lVnlsn09TdblUhh94fSGFFz8rcCy9m17BpHKvUJfXMrb4SqdpJRDB?=
 =?Windows-1252?Q?IQu5jOHU/ASfceaX5ryfInrMcZQ0ul+maARU/5bxDI+htihKnMCszlx+?=
 =?Windows-1252?Q?UJPkQF1AAu9ICJ8lwhP9vVPNOWDmBAegkG6pP0buVrWntB6kABgnA6Mr?=
 =?Windows-1252?Q?kjWjDozl+pjYfq/9JSC46A+isEApMhzq1pwzRgPGZOX77xw8yKPuDxk1?=
 =?Windows-1252?Q?d9L8h0VoQsx4cU=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2421;6:Dlb9pqaMjH1VUEIzVLyenwj7fX8CXYMUofy/t50B0UJ9Ss3S2lkrXz+iRvjJobAa3NiitYlhQZYuRxKeCCUQ2veWNhGwbNZqf72iCQI6vkSlWSAwmNIUHgId4W/GLRKWlpXz9JIVUkn2C5JvnBwjoT0H9YUq7kWjQlkqIvHTjZ7eH//DmW5vBe/jrFd/3U4CtJL+lQQDBtuwNSMZ2k11jwickYM+CD+WTQnqvoNLJjFVh/ilxfrSF9Nq9cD88HqUdIjariKMkhLx8Fp78HCi3eqZZT/dno/8QvMgoZTaBH35LoVjpzYkGyBKG3FhjKvW7E7N2tVtzixBG9b0l5UmnDFxkfmN5H8SoNTkd9O5gbY+eFw7lfIuhGsdGpWwarLquIKdorD/H5Klz4T0a9ur8A==;5:6h900P+JF4+CfGNmN1P64EiwyKZ2u3XiNjPBCJBnzWQbXOGkNzZc8LAd8okBYNFFrIT0qCFt+EjC/cUwLsfMJTEbkY0hDUqdfnlQfh0cdqlpv6A2JhM/IvCC8DswNK2tWvTiILDUAsfb3xuVugrmgw==;24:+D/BmOCFUH1YIfX6SV0l9n8fBsLJGBuqV25KRzSzoOxI13QYQicrhZf2OR1+StuED0lOsTbwnTILvBlGJhl/QFq4pVD8jbO2mIM83PH/Fcs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2421;7:xQDdpWdJCu/qUKPKTOCtgo4v1b6jA1YKba022uunT/osj5TNsPnOrDMHiH8ghCPv2vT9fUElAKoAD6OMLIxbj9OhxO/UZcMd114OKGRFxiR0iQ8aa4mbFkOMfZZ1x3QcAnXWnoBRwxxgnqN4Yvpfv9F3yerC5a57GOVL+9gawGgR/UgqAht3rATvmBTyqLKtlWQW2e1J7o5lEWOFfkfO6u7vg7VQm4Ro/xGjDEVVT1c5+F8YuvndhxXqAR2WlUvmHr4azZ9g4eAhmWjZ0+0IjwgVHgRXjLG05sGjjPBsnlfgUfaA6bhOD1rdgWIh9w+5hKCmaVk5p9rO4xuSqJB93w==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2017 18:16:48.2550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR07MB2421
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56927
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

On 02/28/2017 08:21 AM, Steven Rostedt wrote:
> On Tue, 28 Feb 2017 10:25:46 +0530
> Sachin Sant <sachinp@linux.vnet.ibm.com> wrote:
>
>> File: ./net/ipv4/xfrm4_input.o
>>   [12] __jump_table      PROGBITS        0000000000000000 000639 000018 18 WAM  0   0  1
>> File: ./net/ipv4/udplite.o
>> File: ./net/ipv4/xfrm4_output.o
>>   [ 9] __jump_table      PROGBITS        0000000000000000 000481 000018 18 WAM  0   0  1
>
> Looks like there's some issues right there.

Those look good to me 18/18 = 1 with no remainder.  The odd numbers are 
the offset of the section in the ELF file.

If you look at the stack trace, it seems that it is during module loading.

Are the primitives for generating the tables doing something different 
for the module case?  I am not familiar enough with the powerpc ABIs to 
know.

Try this:

$ perl -n -e 's/\[ /\[/; my @f = split " "; print hex($f[5]) % 0x18 if 
$#f > 5; print $_' <~/jump_table.log


There are no entries with size that is not a multiple of 0x18.

I think my patch to add the ENTSIZE is not doing anything here.

I suspect that the alignment of the __jump_table section in the .ko 
files is not correct, and you are seeing some sort of problem due to that.




>
> -- Steve
>
