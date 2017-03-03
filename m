Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Mar 2017 15:49:27 +0100 (CET)
Received: from mail-eopbgr10059.outbound.protection.outlook.com ([40.107.1.59]:62432
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993419AbdCCOtUDYQhJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 3 Mar 2017 15:49:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=huf8WtPH72S9HMHy7eI/WbmGGgqG70EhFkuGooPEtzw=;
 b=iRof2TDaTyb/xlMNfz2/HjpOZmSrR9tYTp01seNbFuLEgzFLk15V+h11x+Jk/0XU+NF3huGmlcx/HbRZktmuf8TJjpjxQj58XOR11YaLC+MrULaqNhSEa6TP4HiHSgloT9LpghShIGqzCGKtsVtoENNghh2XkkwqYpVqZGZLbJ4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from [10.15.7.185] (12.216.194.146) by
 VI1PR0501MB2766.eurprd05.prod.outlook.com (10.172.11.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.933.12; Fri, 3 Mar 2017 14:49:00 +0000
Subject: Re: [PATCH 1/3] futex: remove duplicated code
To:     Jiri Slaby <jslaby@suse.cz>, <akpm@linux-foundation.org>
References: <20170303122712.13353-1-jslaby@suse.cz>
CC:     <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
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
        "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, <x86@kernel.org>,
        <linux-alpha@vger.kernel.org>,
        <linux-snps-arc@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-hexagon@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <openrisc@lists.librecores.org>,
        <linux-parisc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-s390@vger.kernel.org>, <linux-sh@vger.kernel.org>,
        <sparclinux@vger.kernel.org>, <linux-xtensa@linux-xtensa.org>,
        <linux-arch@vger.kernel.org>
From:   Chris Metcalf <cmetcalf@mellanox.com>
Message-ID: <8d435487-62a6-ebab-f45f-567d79237e9a@mellanox.com>
Date:   Fri, 3 Mar 2017 09:48:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20170303122712.13353-1-jslaby@suse.cz>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [12.216.194.146]
X-ClientProxiedBy: BN6PR07CA0030.namprd07.prod.outlook.com (10.172.104.16) To
 VI1PR0501MB2766.eurprd05.prod.outlook.com (10.172.11.16)
X-MS-Office365-Filtering-Correlation-Id: 5066cc5d-654a-45f8-a6d5-08d4624471dc
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(48565401081);SRVR:VI1PR0501MB2766;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2766;3:INHRNM2s02ZJu/LVMjP8fdM4mNtrhsK4AyaO3HdALS6aAGU/Gpg0cC2VrJm898OHFYtpnntdJT+PVEumOjpq4agHGTeiBRLaoScdR9r4jRwRPGLUt6Z6K9ynjnGt64aQWxqdIWUwHOPsZUDVFjlCATnYYzA5Wzdwto8zoHQreI+K0fsKgAeW8h4RkPXQRwKN9hAytFNkJhu+0SCKcAlbx9HNxW73BvTZvA9DFRcW/P5M7NsAqWpq+fkaAMadKtEFOCmyWImc+1O24xRlzy8zE85SmR5dqAa3RyisEQII8SY=;25:O1bEkbdpYYbieOXsNsGziBlCdYUnctrnHFgxH3yt3EqXJ4ydpyl6/x1mUq//H2Ixhpw81NLKHAwOaQoP/7W7hOeRfWDW6e8HZuzYsja1fBPlT4lOqVDTZ36csYUE0SATH0vaXUnxl/IdfppqgTwr+8IPQlf8ZY9GoxhEXuSQwjcvcH0zdUI6GfPY4uJo5Sy18p/2UGklXx1A+CrET1IcGA19HmXv6FtrmcXMNN8i65UvNymUzldIYQuX2AbdCJNON3aqIcXrSTpxRgTt/JdyU2f+pjWT5H0wARIwCD24ixRvqV8CErJRMxUYt3Djr6kyNlcHGowQ+ovZDgJqBco1eSLHxq40bJQFM/fT3djfXY17uh3NfT5Inlipp5GAvDfJZPomXPnnndgc50sCAZ6OmnWCqEby4OWDSXhtMcBZdKnXpzg8AaW4qWWZblTrPG1UBLpCsxe+cYcCbJdqeE9BAQ==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2766;31:AiO2BL74mVA2YqVrEsh1rdcc0WHAoG2LTbuHHLaXZ8uA6dMz7yu6A0K27TSiD/ebm+aMh+jNKt0NAQZUdr111Fbq3uQPrXGDz9Hvg6cYSxzUNvRD2IMTiViHysEv+yOmx88iLeGFwkYDp4yKKwRAESokENt6+A9kNjZ+7d7gGGDW0r6g3bDF2MCz1R5nGm7KBvKr3vih4FH7JUXaLGBfChaA9s0bm/7HboqOgTU0hgASppqn9X0lYrS69G8uU1uhtvGWM1dkJdpKSwnX4bz9jyKox0qrHhBEl6D3xGWfA/0=;20:whUTUlttP1BgnZeFSycRAw+gFQjjGKG3eFu4Fp1JQGKWfh9j7suuxPdhHsJbGRG9GPYYRAeNUVbpXNhKyZ9rflAZxOIYSVjllkfPqxY3iNj79FDAa1pijsd+c1rOWqBRjBt1G2NSobI7jinBKN0N0jpmBJ0BN6ZfaIcpvOwCxc1Q3HyG7cGEVd2gItxaWmDysLh3hBuB4jMliDiBzg5VKHp+M/OUlQ5XnFlEydrtdQ9P170L4sc5pfFU4slfs4U1WsMHT4gu9Pl1QPMH3fTdL+b96SHc1kIUQlzQ+gbikqVSNU675uOVqjpAoQxY3e13oJ/uDVRgfaW7DAFszj0RKq7FRucSg1tjd7k+X8F3TNua0lfF5xK1Utk9JAVXy0Nz+OdbqjJ0ugQppCTuLxefGISIpxQIPombacTtBjxUok2tWGyewBBrYnux2sE59b/IoyFUzTzcBKr1WqaNyLVSp84gBaEp7WngSKQ5kwrsw4ZwyerRjgy1vaSNzkoB8Mfq
X-Microsoft-Antispam-PRVS: <VI1PR0501MB27667B6E5F7FF31D4577BEBCB22B0@VI1PR0501MB2766.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(171992500451332);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6055026)(6041248)(20161123558025)(20161123555025)(20161123562025)(20161123564025)(20161123560025)(6072148);SRVR:VI1PR0501MB2766;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2766;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2766;4:nRPx2Z+m9DH3pm8Wrp5Uw/YKL4gDqHNsa7KeSsSzaBDmtpMtkopxrCJKWqYh6PFHu4U8GFE1m9T2r6RsPj4qhGwZ90vqG8EhoEvctV9hdDjoQa5LID22x3g7gCEYjL5EDqykynjHNMQU0J6gRGk1oFU0xHnOvA1ErW9G3hF9Pm1eob/B2iTa171i/rSi5AG3rIHWIQIczmyzfZairxd/v/ySgrsRkSUy8HbsenKVfqdRabx1wGVl3bQASo5ury5GfVaBFkkoklRPj9nty1TkZKAAva+9SUKqVsuKubSiGFp3W9UtxUMKPFzVla7o2e9mIjj/MMXmBGABDl6gPsaXAfj1ihbNbUsHRmhpffmRzONb30f/Uv3xi8SlD4EKi1TFCrFTLxaZHdef5usrdKb7vkbuYz5DkDNA+lXsyyPjZi0K+5zOgvtObv7xISetqVDLGLN1cyBQ31h0EDAxJtPjxLOP8CSj926Makc0WjTve1Nkgm70ohz0u+UqcQrwrq1+z0G6wkpInMyhQcF+C/kojev9p0K271DdMX3QWqLeFpAElAvZueGG8vemAwBpwUXR4IZaUzfPAr4nSCNS8QmB1D+5cdrKgL2YQxdS9icNv3pAMc0E2bhBISpjzrec2/O2oRCZSnxXCgO9d7ZXJgjt0uvXI5TS8vcmnrnE0lY8zLg=
X-Forefront-PRVS: 0235CBE7D0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(6049001)(7916002)(39450400003)(39860400002)(39840400002)(39850400002)(39410400002)(24454002)(377454003)(31686004)(3846002)(42186005)(6116002)(5660300001)(4001350100001)(230700001)(189998001)(6306002)(64126003)(76176999)(50986999)(54356999)(54906002)(8666007)(77096006)(2950100002)(6666003)(50466002)(6486002)(25786008)(229853002)(36756003)(23746002)(83506001)(47776003)(2906002)(81166006)(66066001)(65806001)(65956001)(8676002)(53936002)(4326008)(33646002)(31696002)(86362001)(53546006)(966004)(7416002)(305945005)(38730400002)(7406005)(7736002)(92566002)(6246003)(18886065003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2766;H:[10.15.7.185];FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;VI1PR0501MB2766;23:ZUzMFwY8RzWaub9RFS8dA5k22PLiYqVUit2?=
 =?Windows-1252?Q?kijw0YY9SK/Fo+0teMofgt7CRDhZiWEk3tLF9Xc3n3BDlMtfgo8VVp9t?=
 =?Windows-1252?Q?DcGE1WvfJS95DK/djfvV4jd4OgyMzfXM9CfnLpyfqHWF57qRjsPaqL3d?=
 =?Windows-1252?Q?+UPPUhA/LS6uN3QFencKo8X4x3ItEbw5Gh8oL2xYZp5tewnZKv0Va7oo?=
 =?Windows-1252?Q?vvmwTkQXFQ/p69qajFPE2P1shdSQU/gKB+L37uguBKJM4fhf6mY1mtCa?=
 =?Windows-1252?Q?rLsyLqXeEUOYiNnLDd3cERU0xdfhHxGiYhfWl0DQpicoGw8OfWaFbRgA?=
 =?Windows-1252?Q?x4lDHF9lz5riEjM2EULMW9cRh9iOlN8wBH/KvpRwyRa8GQehbXFwIps2?=
 =?Windows-1252?Q?fHhuZRsdst/sg1ezb0iOX8z63Nk+XU3qdUGIDRp9Cxt/8OUZK4jR/j/i?=
 =?Windows-1252?Q?TksEZgM3B627gPMeQ8rkTcVX/I2TN47s1NExh0Bb1r0ttDj8s2yYFjwc?=
 =?Windows-1252?Q?/JKlaDOQrFLuKFzztC+eNXts31bhzaS1K9oXZTln3c6PQJfmdNvdyQLA?=
 =?Windows-1252?Q?D900QspLD5UkSCZGsHxX3v10M4MgarqZdz6EVKW5zNqiHYpYc8oAh5Eq?=
 =?Windows-1252?Q?C/v9CdC4NxupJyp+cw1QucXBZR993g85A4K8+WNE0Hwoi+KqolE9aYbl?=
 =?Windows-1252?Q?RQVzbdHY0AMuD/JUItvYq+97N8Y8pCPpmmEKCtFpgP3sCExy/Ln8dSkI?=
 =?Windows-1252?Q?7gJ8P+74UJ9WXP7f1OvUR/65iIroAoX02poUwmkCqRh1gxqYZJGnW9qH?=
 =?Windows-1252?Q?VJkPQRsSKwHolSunhsplDBF5EWkK9oa1fwP8EeLuf8ngsSpXijz4cZnZ?=
 =?Windows-1252?Q?S0noGAiaoC3VNAuwQNjWvn8BdcwcsYz997xDJPcO1yv5SOMDWZ/zZkGV?=
 =?Windows-1252?Q?6TPNiqzhYsCzXFpcWoWj6FVrS/rVD9iIizgN194WNjkdPzH7jNIOFOIt?=
 =?Windows-1252?Q?djEmDjqotmDqSltHoNjpAWXbVVV/2nt6UaFmRrGhjWQ9Y3XVVL5dOH6e?=
 =?Windows-1252?Q?fG5yPBqojlrjoz7PZI8B04IIXI/3+ZpLL7g1pibYYiCsq+TArFAesofb?=
 =?Windows-1252?Q?dp8F+1M9S6ZBfYcPEdTDmm0d9lNq+VxH/RUK+a5YyN1A4op3Qf9I7Ur4?=
 =?Windows-1252?Q?oxuXMN/0j+vRwxbusn41vMUZBc5U81wxwY34u/58zFa30qdK/jlkCFWQ?=
 =?Windows-1252?Q?f5Onwfg2c8P86tGScSNXonznMt0kV9wvhojtGkD0nSmY5U65Pzcu3jVx?=
 =?Windows-1252?Q?DdzyqmQFT98W9pATpH9h2oCpPlTyZToDR3cytDO+ZFU499Kp5r7AWZAU?=
 =?Windows-1252?Q?xMDsXp1azYt8f1bIwoAQbkgVdcKPv59U+vqCdxkAbJAEu05PohvUFqsT?=
 =?Windows-1252?Q?7KeQVUAFGPjL8T3q8Zvm4WW3wiwC2lK84zEY3vDCZTUiCj+7jNlGkqUi?=
 =?Windows-1252?Q?4Mrn4snJ1HGVT/uLKYA2rYVbUrNvr?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2766;6:zmwubilPVlli8LVs19VdiurWRmG3yqnYqDiX4S/PhY84sqV9Cpi5RtK7ndb8jXF5NBu/0jzip9LL2cAYNHkC3mGRuhgCUATzrg3+ubCw1nb1XNpjbFfga2C99v0uyBllNOO8FQ4KQ9EIFXrDyTsApgA5fJWjFo2s0a1A/hK832aVsGRrscwZFeT40i23iZSYEgKkAXyI4WaguF94IQqoJUulLCTyGHBwIXYBfCbSp0gL4LPFooPHFyiEydBP3AzXKPVJTRxRsXo3JiAvXMs40Ila5H0Q5+Ka23MxMr/3sVl90ELyNdGopnTvKKwdkH0lE2aErv7lXdyHhHGI3393cjatEK70QDFeUXZZ/t3kcWi7BPoNUTd6sQiZUCJPSsT7wMOaQsQvTxoiCOjhdL8H16KtY9rWDfr8t/zU6rCXHj8=;5:jcpKBeKSxAvRAbNkyeWXC0qZ8l8zuW2SN6MHt/wXMhii0bIPNXy8UZsoHMSQvs/REdE+Xp3vVvgmwI7Elii83vuFbNFXA6KAV9tzAsidrfDdKmSRJiEasqEJKESJ+Qo+0WDvVaqR0sa3LcunHi8RU8ByfvSrfmxId44475uX0Fs=;24:pTV7k0odGURONqt4St9YyINBFHUxbau1RTRTAvcZDkff6B3l7mWGOmONa6br97oX+2MQ7aj2BFcS31lq/eWuuRigx5AGobV7wD2qDSuJxOo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2766;7:A5wgTaKKztwdWsKpjcsxsS8xHQDar3d19N8qDzbgxbxjqbO3+jEzQ6ObLV7fQJ9MadE9mnKnx1TU2a86EBL3iYLQJzyWb2IurjCIyKV1Pu6036BqWPwAUU6Wdil7habVgG1I8ULo87qm/6lej1AqZHnac+UUr4vyOVtsNOZSeADmHoacr79MOQ523PymUn+CMKNKlniFWZvtI8FpWaPIktXI7GrVXJQV6c6xdiNbmbFi2awJUF6zidbTMmDps5j5L03h0GDRcFbFDOt+pzvHFHoBIGAkPPL5hlmtNlmdY01Z7JEbGrCxJL8CwUfnBaLtuqiTUJQD9wu2JkYV01d6gA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2017 14:49:00.7885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2766
Return-Path: <cmetcalf@mellanox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57019
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

On 3/3/2017 7:27 AM, Jiri Slaby wrote:
> There is code duplicated over all architecture's headers for
> futex_atomic_op_inuser. Namely op decoding, access_ok check for uaddr,
> and comparison of the result.
>
> Remove this duplication and leave up to the arches only the needed
> assembly which is now in arch_futex_atomic_op_inuser.
>
> Note that s390 removed access_ok check in d12a29703 ("s390/uaccess:
> remove pointless access_ok() checks") as access_ok there returns true.
> We introduce it back to the helper for the sake of simplicity (it gets
> optimized away anyway).
>
> Signed-off-by: Jiri Slaby<jslaby@suse.cz>

Acked-by: Chris Metcalf <cmetcalf@mellanox.com> [for tile]

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
